import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_package/data/data_sources/remote/auth/auth_remote_datasource.dart';
import 'package:firebase_package/data/data_sources/remote/auth/auth_remote_datasource_impl.dart';
import 'package:firebase_package/data/repositories/auth_repository_impl.dart';
import 'package:firebase_package/domain/repositories/auth_repository.dart';
import 'package:firebase_package/domain/use_cases/sign_in_use_case.dart';
import 'package:firebase_package/domain/use_cases/sign_out_use_case.dart';
import 'package:firebase_package/domain/use_cases/sign_up_use_case.dart';
import 'package:firebase_package/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'flavor.config.dart';
import 'screens/sign_in_screen.dart';

var flavorConfigProvider;

void mainCommon(FlavorConfig config) async {
  flavorConfigProvider = StateProvider((ref) => config);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            final authRemoteDataSource = AuthRemoteDataSourceImpl(firebaseAuth: FirebaseAuth.instance);
            return AuthRepositoryImpl(authRemoteDataSource: authRemoteDataSource);
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              signInUseCase: SignInUseCase(authRepository: RepositoryProvider.of<AuthRepositoryImpl>(context)),
              signUpUseCase: SignUpUseCase(authRepository: RepositoryProvider.of<AuthRepositoryImpl>(context)),
              signOutUseCase: SignOutUseCase(authRepository: RepositoryProvider.of<AuthRepositoryImpl>(context)),
            ),
          ),
        ],
        child: MaterialApp.router(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routeInformationProvider: AppRouter.router.routeInformationProvider,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate),
      ),
    );
  }
}
