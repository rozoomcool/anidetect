import 'dart:io';

import 'package:anidetection/domain/data_cubit.dart';
import 'package:anidetection/presentation/component/custom_table_view.dart';
import 'package:anidetection/presentation/component/custom_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import '../../utils/my_tree_node.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget dataWidget(DataState state) {
    debugPrint(":::::$state");
    if (state is LoadingDataState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ErrorDataState) {
      return const Center(child: Text("ERROR"));
    } else if (state is DirectoryDataState) {
      return CustomTreeView(rootNode: state.rootNode);
    } else if (state is LoadedSubmissionDataState) {
      return CustomTableView(
        data: state.data,
      );
    } else if (state is ErrorDataState) {
      return const Center(child: Text("Error"));
    } else if (state is EmptyDataState) {
      return const Center(
        child: Text("No data"),
      );
    } else {
      return const Center(
        child: Text("No data"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit(),
      child: BlocBuilder<DataCubit, DataState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("AniDetector"),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: ElevatedButton(
                  onPressed: context.read<DataCubit>().pickDirectory,
                  child: const Text('Выбрать директорию'),
                ),
              ),
              state is! DirectoryDataState
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ElevatedButton(
                          onPressed: () {
                            context.read<DataCubit>().predictData();
                          },
                          child: const Text("Обработать")),
                    ),
              state is! LoadedSubmissionDataState
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ElevatedButton(
                          onPressed: () {context.read<DataCubit>().saveData();},
                          child: const Text("Выгрузить данные")),
                    )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: dataWidget(state),
            )),
          ),
        );
      }),
    );
  }
}
