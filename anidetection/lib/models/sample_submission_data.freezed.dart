// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_submission_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SampleSubmissionData _$SampleSubmissionDataFromJson(Map<String, dynamic> json) {
  return _SampleSubmissionData.fromJson(json);
}

/// @nodoc
mixin _$SampleSubmissionData {
  String get nameFolder => throw _privateConstructorUsedError;
  String get imageName => throw _privateConstructorUsedError;
  String get className => throw _privateConstructorUsedError;
  DateTime get dateRegistrationStart => throw _privateConstructorUsedError;
  DateTime? get dateRegistrationEnd => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SampleSubmissionDataCopyWith<SampleSubmissionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SampleSubmissionDataCopyWith<$Res> {
  factory $SampleSubmissionDataCopyWith(SampleSubmissionData value,
          $Res Function(SampleSubmissionData) then) =
      _$SampleSubmissionDataCopyWithImpl<$Res, SampleSubmissionData>;
  @useResult
  $Res call(
      {String nameFolder,
      String imageName,
      String className,
      DateTime dateRegistrationStart,
      DateTime? dateRegistrationEnd,
      int count,
      double confidence});
}

/// @nodoc
class _$SampleSubmissionDataCopyWithImpl<$Res,
        $Val extends SampleSubmissionData>
    implements $SampleSubmissionDataCopyWith<$Res> {
  _$SampleSubmissionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameFolder = null,
    Object? imageName = null,
    Object? className = null,
    Object? dateRegistrationStart = null,
    Object? dateRegistrationEnd = freezed,
    Object? count = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      nameFolder: null == nameFolder
          ? _value.nameFolder
          : nameFolder // ignore: cast_nullable_to_non_nullable
              as String,
      imageName: null == imageName
          ? _value.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      dateRegistrationStart: null == dateRegistrationStart
          ? _value.dateRegistrationStart
          : dateRegistrationStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateRegistrationEnd: freezed == dateRegistrationEnd
          ? _value.dateRegistrationEnd
          : dateRegistrationEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SampleSubmissionDataImplCopyWith<$Res>
    implements $SampleSubmissionDataCopyWith<$Res> {
  factory _$$SampleSubmissionDataImplCopyWith(_$SampleSubmissionDataImpl value,
          $Res Function(_$SampleSubmissionDataImpl) then) =
      __$$SampleSubmissionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nameFolder,
      String imageName,
      String className,
      DateTime dateRegistrationStart,
      DateTime? dateRegistrationEnd,
      int count,
      double confidence});
}

/// @nodoc
class __$$SampleSubmissionDataImplCopyWithImpl<$Res>
    extends _$SampleSubmissionDataCopyWithImpl<$Res, _$SampleSubmissionDataImpl>
    implements _$$SampleSubmissionDataImplCopyWith<$Res> {
  __$$SampleSubmissionDataImplCopyWithImpl(_$SampleSubmissionDataImpl _value,
      $Res Function(_$SampleSubmissionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameFolder = null,
    Object? imageName = null,
    Object? className = null,
    Object? dateRegistrationStart = null,
    Object? dateRegistrationEnd = freezed,
    Object? count = null,
    Object? confidence = null,
  }) {
    return _then(_$SampleSubmissionDataImpl(
      nameFolder: null == nameFolder
          ? _value.nameFolder
          : nameFolder // ignore: cast_nullable_to_non_nullable
              as String,
      imageName: null == imageName
          ? _value.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _value.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      dateRegistrationStart: null == dateRegistrationStart
          ? _value.dateRegistrationStart
          : dateRegistrationStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dateRegistrationEnd: freezed == dateRegistrationEnd
          ? _value.dateRegistrationEnd
          : dateRegistrationEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SampleSubmissionDataImpl implements _SampleSubmissionData {
  const _$SampleSubmissionDataImpl(
      {required this.nameFolder,
      required this.imageName,
      required this.className,
      required this.dateRegistrationStart,
      required this.dateRegistrationEnd,
      required this.count,
      required this.confidence});

  factory _$SampleSubmissionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SampleSubmissionDataImplFromJson(json);

  @override
  final String nameFolder;
  @override
  final String imageName;
  @override
  final String className;
  @override
  final DateTime dateRegistrationStart;
  @override
  final DateTime? dateRegistrationEnd;
  @override
  final int count;
  @override
  final double confidence;

  @override
  String toString() {
    return 'SampleSubmissionData(nameFolder: $nameFolder, imageName: $imageName, className: $className, dateRegistrationStart: $dateRegistrationStart, dateRegistrationEnd: $dateRegistrationEnd, count: $count, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SampleSubmissionDataImpl &&
            (identical(other.nameFolder, nameFolder) ||
                other.nameFolder == nameFolder) &&
            (identical(other.imageName, imageName) ||
                other.imageName == imageName) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.dateRegistrationStart, dateRegistrationStart) ||
                other.dateRegistrationStart == dateRegistrationStart) &&
            (identical(other.dateRegistrationEnd, dateRegistrationEnd) ||
                other.dateRegistrationEnd == dateRegistrationEnd) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nameFolder, imageName, className,
      dateRegistrationStart, dateRegistrationEnd, count, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SampleSubmissionDataImplCopyWith<_$SampleSubmissionDataImpl>
      get copyWith =>
          __$$SampleSubmissionDataImplCopyWithImpl<_$SampleSubmissionDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SampleSubmissionDataImplToJson(
      this,
    );
  }
}

abstract class _SampleSubmissionData implements SampleSubmissionData {
  const factory _SampleSubmissionData(
      {required final String nameFolder,
      required final String imageName,
      required final String className,
      required final DateTime dateRegistrationStart,
      required final DateTime? dateRegistrationEnd,
      required final int count,
      required final double confidence}) = _$SampleSubmissionDataImpl;

  factory _SampleSubmissionData.fromJson(Map<String, dynamic> json) =
      _$SampleSubmissionDataImpl.fromJson;

  @override
  String get nameFolder;
  @override
  String get imageName;
  @override
  String get className;
  @override
  DateTime get dateRegistrationStart;
  @override
  DateTime? get dateRegistrationEnd;
  @override
  int get count;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$SampleSubmissionDataImplCopyWith<_$SampleSubmissionDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
