import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/blocs/Register%20bloc/register_user_bloc.dart';
import 'package:zybo_test/blocs/login%20bloc/bloc/login_user_bloc.dart';
import 'package:zybo_test/blocs/verify%20bloc/verify_user_bloc.dart';

import 'package:zybo_test/main.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => VerifyUserBloc()),
      BlocProvider(create: (context) => LoginUserBloc()),
      BlocProvider(create: (context) => RegisterUserBloc())
    ], child: MyApp());
  }
}
