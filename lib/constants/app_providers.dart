import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo_test/blocs/Register%20bloc/register_user_bloc.dart';
import 'package:zybo_test/blocs/banner%20bloc/bloc/banners_bloc.dart';
import 'package:zybo_test/blocs/fetch%20products/bloc/fetch_products_bloc.dart';
import 'package:zybo_test/blocs/login%20bloc/bloc/login_user_bloc.dart';
import 'package:zybo_test/blocs/profile_bloc/bloc/fetch_profile_bloc.dart';
import 'package:zybo_test/blocs/verify%20bloc/verify_user_bloc.dart';
import 'package:zybo_test/blocs/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:zybo_test/main.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => VerifyUserBloc()),
      BlocProvider(create: (context) => LoginUserBloc()),
      BlocProvider(create: (context) => RegisterUserBloc()),
      BlocProvider(create: (context) => BannersBloc()),
      BlocProvider(create: (context) => FetchProductsBloc()),
      BlocProvider(create: (context) => FetchProfileBloc()),
      BlocProvider(create: (context) => WishlistBloc())
    ], child: MyApp());
  }
}
