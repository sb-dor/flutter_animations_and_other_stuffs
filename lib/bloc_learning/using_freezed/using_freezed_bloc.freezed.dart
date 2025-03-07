// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'using_freezed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UsingFreezedEvents {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() decrement,
    required TResult Function() increment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? decrement,
    TResult? Function()? increment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? decrement,
    TResult Function()? increment,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DecrementEvent value) decrement,
    required TResult Function(IncrementEvent value) increment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DecrementEvent value)? decrement,
    TResult? Function(IncrementEvent value)? increment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DecrementEvent value)? decrement,
    TResult Function(IncrementEvent value)? increment,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsingFreezedEventsCopyWith<$Res> {
  factory $UsingFreezedEventsCopyWith(
          UsingFreezedEvents value, $Res Function(UsingFreezedEvents) then) =
      _$UsingFreezedEventsCopyWithImpl<$Res, UsingFreezedEvents>;
}

/// @nodoc
class _$UsingFreezedEventsCopyWithImpl<$Res, $Val extends UsingFreezedEvents>
    implements $UsingFreezedEventsCopyWith<$Res> {
  _$UsingFreezedEventsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsingFreezedEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DecrementEventImplCopyWith<$Res> {
  factory _$$DecrementEventImplCopyWith(
          _$DecrementEventImpl value, $Res Function(_$DecrementEventImpl) then) =
      __$$DecrementEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DecrementEventImplCopyWithImpl<$Res>
    extends _$UsingFreezedEventsCopyWithImpl<$Res, _$DecrementEventImpl>
    implements _$$DecrementEventImplCopyWith<$Res> {
  __$$DecrementEventImplCopyWithImpl(
      _$DecrementEventImpl _value, $Res Function(_$DecrementEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsingFreezedEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DecrementEventImpl implements DecrementEvent {
  const _$DecrementEventImpl();

  @override
  String toString() {
    return 'UsingFreezedEvents.decrement()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DecrementEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() decrement,
    required TResult Function() increment,
  }) {
    return decrement();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? decrement,
    TResult? Function()? increment,
  }) {
    return decrement?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? decrement,
    TResult Function()? increment,
    required TResult orElse(),
  }) {
    if (decrement != null) {
      return decrement();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DecrementEvent value) decrement,
    required TResult Function(IncrementEvent value) increment,
  }) {
    return decrement(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DecrementEvent value)? decrement,
    TResult? Function(IncrementEvent value)? increment,
  }) {
    return decrement?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DecrementEvent value)? decrement,
    TResult Function(IncrementEvent value)? increment,
    required TResult orElse(),
  }) {
    if (decrement != null) {
      return decrement(this);
    }
    return orElse();
  }
}

abstract class DecrementEvent implements UsingFreezedEvents {
  const factory DecrementEvent() = _$DecrementEventImpl;
}

/// @nodoc
abstract class _$$IncrementEventImplCopyWith<$Res> {
  factory _$$IncrementEventImplCopyWith(
          _$IncrementEventImpl value, $Res Function(_$IncrementEventImpl) then) =
      __$$IncrementEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IncrementEventImplCopyWithImpl<$Res>
    extends _$UsingFreezedEventsCopyWithImpl<$Res, _$IncrementEventImpl>
    implements _$$IncrementEventImplCopyWith<$Res> {
  __$$IncrementEventImplCopyWithImpl(
      _$IncrementEventImpl _value, $Res Function(_$IncrementEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsingFreezedEvents
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IncrementEventImpl implements IncrementEvent {
  const _$IncrementEventImpl();

  @override
  String toString() {
    return 'UsingFreezedEvents.increment()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IncrementEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() decrement,
    required TResult Function() increment,
  }) {
    return increment();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? decrement,
    TResult? Function()? increment,
  }) {
    return increment?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? decrement,
    TResult Function()? increment,
    required TResult orElse(),
  }) {
    if (increment != null) {
      return increment();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DecrementEvent value) decrement,
    required TResult Function(IncrementEvent value) increment,
  }) {
    return increment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DecrementEvent value)? decrement,
    TResult? Function(IncrementEvent value)? increment,
  }) {
    return increment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DecrementEvent value)? decrement,
    TResult Function(IncrementEvent value)? increment,
    required TResult orElse(),
  }) {
    if (increment != null) {
      return increment(this);
    }
    return orElse();
  }
}

abstract class IncrementEvent implements UsingFreezedEvents {
  const factory IncrementEvent() = _$IncrementEventImpl;
}

/// @nodoc
mixin _$UsingFreezedState {
  UsingFreezedStateModel get stateModel => throw _privateConstructorUsedError;

  /// Create a copy of UsingFreezedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsingFreezedStateCopyWith<UsingFreezedState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsingFreezedStateCopyWith<$Res> {
  factory $UsingFreezedStateCopyWith(
          UsingFreezedState value, $Res Function(UsingFreezedState) then) =
      _$UsingFreezedStateCopyWithImpl<$Res, UsingFreezedState>;
  @useResult
  $Res call({UsingFreezedStateModel stateModel});
}

/// @nodoc
class _$UsingFreezedStateCopyWithImpl<$Res, $Val extends UsingFreezedState>
    implements $UsingFreezedStateCopyWith<$Res> {
  _$UsingFreezedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsingFreezedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stateModel = null,
  }) {
    return _then(_value.copyWith(
      stateModel: null == stateModel
          ? _value.stateModel
          : stateModel // ignore: cast_nullable_to_non_nullable
              as UsingFreezedStateModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsingFreezedStateImplCopyWith<$Res> implements $UsingFreezedStateCopyWith<$Res> {
  factory _$$UsingFreezedStateImplCopyWith(
          _$UsingFreezedStateImpl value, $Res Function(_$UsingFreezedStateImpl) then) =
      __$$UsingFreezedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UsingFreezedStateModel stateModel});
}

/// @nodoc
class __$$UsingFreezedStateImplCopyWithImpl<$Res>
    extends _$UsingFreezedStateCopyWithImpl<$Res, _$UsingFreezedStateImpl>
    implements _$$UsingFreezedStateImplCopyWith<$Res> {
  __$$UsingFreezedStateImplCopyWithImpl(
      _$UsingFreezedStateImpl _value, $Res Function(_$UsingFreezedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsingFreezedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stateModel = null,
  }) {
    return _then(_$UsingFreezedStateImpl(
      null == stateModel
          ? _value.stateModel
          : stateModel // ignore: cast_nullable_to_non_nullable
              as UsingFreezedStateModel,
    ));
  }
}

/// @nodoc

class _$UsingFreezedStateImpl implements _UsingFreezedState {
  const _$UsingFreezedStateImpl(this.stateModel);

  @override
  final UsingFreezedStateModel stateModel;

  @override
  String toString() {
    return 'UsingFreezedState(stateModel: $stateModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsingFreezedStateImpl &&
            (identical(other.stateModel, stateModel) || other.stateModel == stateModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stateModel);

  /// Create a copy of UsingFreezedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsingFreezedStateImplCopyWith<_$UsingFreezedStateImpl> get copyWith =>
      __$$UsingFreezedStateImplCopyWithImpl<_$UsingFreezedStateImpl>(this, _$identity);
}

abstract class _UsingFreezedState implements UsingFreezedState {
  const factory _UsingFreezedState(final UsingFreezedStateModel stateModel) =
      _$UsingFreezedStateImpl;

  @override
  UsingFreezedStateModel get stateModel;

  /// Create a copy of UsingFreezedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsingFreezedStateImplCopyWith<_$UsingFreezedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
