import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? streamSubscription;
  InternetBloc() : super(InternetInitialState()) {
    on<InternetConnectedEvent>((event, emit) {
      emit(const InternetConnectedState(message: 'Connected'));
    });
    on<InternetNotConnectedEvent>((event, emit) {
      emit(const InternetNotConnectedState(message: 'Not Connected'));
    });

    streamSubscription =
        Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        add(InternetConnectedEvent());
      } else {
        add(InternetNotConnectedEvent());
      }
    });
  }
  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}
