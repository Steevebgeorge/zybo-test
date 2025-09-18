import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/blocs/auth_blocs/bloc/verify_user_bloc.dart';
import 'package:zybo_test/blocs/auth_blocs/login%20bloc/bloc/login_user_bloc.dart';
import 'package:zybo_test/main.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => VerifyUserBloc()),
      BlocProvider(create: (context) => LoginUserBloc())
    ], child: MyApp());
  }
}
