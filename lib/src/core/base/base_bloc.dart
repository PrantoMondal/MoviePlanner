import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/src/core/config/build_config.dart';
import 'package:movie_planner/src/core/network/exceptions/exceptions.dart';

import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  final logger = BuildConfig.instance.envConfig.logger;
  BaseBloc(super.initialState);

  Future<void> safeEmit(
      Emitter<S> emit,
      Future<S> Function() operation, {
        required S Function(String error) onError,
      }) async {
    try {
      final newState = await operation();
      emit(newState);
    } on ApplicationException catch (e) {
      emit(onError(e.message));
    } catch (_) {
      emit(onError("Unknown error occurred"));
    }
  }
}