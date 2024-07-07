import csv
import logging
import shutil
from itertools import repeat
from typing import List

from confz import FileSource
from fastapi import FastAPI, File, UploadFile
import os
import pandas as pd
import torch
import numpy as np
from pathlib import Path

from fastapi.exceptions import RequestValidationError
from starlette.requests import Request
from starlette.responses import JSONResponse, FileResponse
from tqdm import tqdm
from configs.config import MainConfig
from main import predict_data
from utils.utils import load_detector, load_classificator, open_mapping, extract_crops

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

app = FastAPI()

# app.config['MAX_CONTENT_LENGTH'] = 100 * 1024 * 1024

config = MainConfig(config_sources=FileSource(file=os.path.join("configs", "config.yml")))


@app.post("/predict")
async def predict(files: List[UploadFile] = File(...)):
    print(config.src_dir)
    upload_folder = config.src_dir
    os.makedirs(config.src_dir, exist_ok=True)
    # os.makedirs(os.path.join(os.getcwd(), upload_folder), exist_ok=True)
    file_paths = []
    print(files)

    try:
        # Save uploaded files
        for file in files:
            file_location = os.path.join(upload_folder, file.filename)
            print(file_location)
            with open(file_location, "wb") as buffer:
                buffer.write(await file.read())
            file_paths.append(file_location)

        predict_data(config)

        # Parse the CSV file and create a list of objects
        result = []
        with open("./table_final.csv", mode="r") as csvfile:
            csv_reader = csv.DictReader(csvfile)
            for row in csv_reader:
                result.append({
                    "imageName": row["image_name"],
                    "className": row["class_name"],
                    "count": int(row["count"]),
                    "confidence": float(row["confidence"])
                })

        return JSONResponse(content=result)

        # return FileResponse("./table_final.csv", media_type='text/csv', filename="result.csv")
    except Exception as e:
        print(e)
    finally:
    #     # Cleanup: remove all files and the directory
        shutil.rmtree(upload_folder)
        # pass

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    logger.error(f"Validation error: {exc.errors()}")
    return JSONResponse(
        status_code=400,
        content={"message": "Validation error", "errors": exc.errors()},
    )

@app.exception_handler(413)
async def request_entity_too_large_handler(request: Request, exc: Exception):
    logger.error("File too large")
    return JSONResponse(
        status_code=413,
        content={"message": "File too large"},
    )


if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
# if __name__ == '__main__':
#     import uvicorn
#     uvicorn.run(app, host="0.0.0.0", port=8000)
