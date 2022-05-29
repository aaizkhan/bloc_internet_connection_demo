import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_internet_connectivity_demo/constants/enum.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_cubit_state.dart';

class InternetCubit extends Cubit<InternetCubitState> {
  Connectivity? connectivity;
  StreamSubscription? connectivityStateSubscription;
  InternetCubit({@required this.connectivity}) : super(InternetLoading()) {
    checkingInternetConnection();
  }

  void checkingInternetConnection() {
    connectivityStateSubscription =
        connectivity!.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (event == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (event == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    // TODO: implement close
    connectivityStateSubscription!.cancel();
    return super.close();
  }
}
