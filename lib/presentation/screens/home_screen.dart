import 'package:bloc_internet_connectivity_demo/constants/enum.dart';
import 'package:bloc_internet_connectivity_demo/logic/cubit/cubit/internet_cubit_cubit.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Internet Connection'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Internet  Connection',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<InternetCubit, InternetCubitState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.wifi) {
                return const Text('Wifi connection');
              }
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.mobile) {
                return const Text('Mobile connection');
              }
              if (state is InternetDisconnected) {
                return const Text('Disconnected');
              }
              return CircularProgressIndicator();
            }),
          ],
        ),
      ),
    );
  }
}
