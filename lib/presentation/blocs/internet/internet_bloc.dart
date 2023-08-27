import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  final Connectivity _connectivity = Connectivity();

  onAppStart() async {
    final ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      add(ConnectEvent());
    } else if (connectivityResult == ConnectivityResult.none) {
      add(DisconnectEvent());
    }
  }

  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      if (event is ConnectEvent) {
        emit(ConnectedState());
      } else if (event is DisconnectEvent) {
        emit(DisconnectedState());
      }
    });
    onAppStart();
    _subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        add(ConnectEvent());
      } else if (result == ConnectivityResult.none) {
        add(DisconnectEvent());
      }
    });
  }

  @override
  Future<void> close() {
    if (_subscription != null) {
      _subscription!.cancel();
    }
    return super.close();
  }
}
