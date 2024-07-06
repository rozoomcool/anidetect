// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_row_default.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DataRowDefault _$DataRowDefaultFromJson(Map<String, dynamic> json) {
  return _DataRowDefault.fromJson(json);
}

/// @nodoc
mixin _$DataRowDefault {
  String get image_name => throw _privateConstructorUsedError;
  String get class_name => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataRowDefaultCopyWith<DataRowDefault> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataRowDefaultCopyWith<$Res> {
  factory $DataRowDefaultCopyWith(
          DataRowDefault value, $Res Function(DataRowDefault) then) =
      _$DataRowDefaultCopyWithImpl<$Res, DataRowDefault>;
  @useResult
  $Res call(
      {String image_name, String class_name, int count, double confidence});
}

/// @nodoc
class _$DataRowDefaultCopyWithImpl<$Res, $Val extends DataRowDefault>
    implements $DataRowDefaultCopyWith<$Res> {
  _$DataRowDefaultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image_name = null,
    Object? class_name = null,
    Object? count = null,
    Object? confidence = null,
  }) {
    return _then(_value.copyWith(
      image_name: null == image_name
          ? _value.image_name
          : image_name // ignore: cast_nullable_to_non_nullable
              as String,
      class_name: null == class_name
          ? _value.class_name
          : class_name // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$DataRowDefaultImplCopyWith<$Res>
    implements $DataRowDefaultCopyWith<$Res> {
  factory _$$DataRowDefaultImplCopyWith(_$DataRowDefaultImpl value,
          $Res Function(_$DataRowDefaultImpl) then) =
      __$$DataRowDefaultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String image_name, String class_name, int count, double confidence});
}

/// @nodoc
class __$$DataRowDefaultImplCopyWithImpl<$Res>
    extends _$DataRowDefaultCopyWithImpl<$Res, _$DataRowDefaultImpl>
    implements _$$DataRowDefaultImplCopyWith<$Res> {
  __$$DataRowDefaultImplCopyWithImpl(
      _$DataRowDefaultImpl _value, $Res Function(_$DataRowDefaultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image_name = null,
    Object? class_name = null,
    Object? count = null,
    Object? confidence = null,
  }) {
    return _then(_$DataRowDefaultImpl(
      image_name: null == image_name
          ? _value.image_name
          : image_name // ignore: cast_nullable_to_non_nullable
              as String,
      class_name: null == class_name
          ? _value.class_name
          : class_name // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$DataRowDefaultImpl implements _DataRowDefault {
  const _$DataRowDefaultImpl(
      {required this.image_name,
      required this.class_name,
      required this.count,
      required this.confidence});

  factory _$DataRowDefaultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataRowDefaultImplFromJson(json);

  @override
  final String image_name;
  @override
  final String class_name;
  @override
  final int count;
  @override
  final double confidence;

  @override
  String toString() {
    return 'DataRowDefault(image_name: $image_name, class_name: $class_name, count: $count, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataRowDefaultImpl &&
            (identical(other.image_name, image_name) ||
                other.image_name == image_name) &&
            (identical(other.class_name, class_name) ||
                other.class_name == class_name) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, image_name, class_name, count, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataRowDefaultImplCopyWith<_$DataRowDefaultImpl> get copyWith =>
      __$$DataRowDefaultImplCopyWithImpl<_$DataRowDefaultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataRowDefaultImplToJson(
      this,
    );
  }
}

abstract class _DataRowDefault implements DataRowDefault {
  const factory _DataRowDefault(
      {required final String image_name,
      required final String class_name,
      required final int count,
      required final double confidence}) = _$DataRowDefaultImpl;

  factory _DataRowDefault.fromJson(Map<String, dynamic> json) =
      _$DataRowDefaultImpl.fromJson;

  @override
  String get image_name;
  @override
  String get class_name;
  @override
  int get count;
  @override
  double get confidence;
  @override
  @JsonKey(ignore: true)
  _$$DataRowDefaultImplCopyWith<_$DataRowDefaultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
