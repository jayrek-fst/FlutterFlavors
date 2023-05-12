import 'package:firebase_package/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors/utils/route_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../main_common.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedUser) {
          context.goNamed(RouteNames.dashboardRoute);
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign In'),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Text(ref.read(flavorConfigProvider.notifier).state.appTitle),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email Address'),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignedIn(
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                      },
                      child: const Text('Sign In'),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          context.goNamed(RouteNames.signUpRoute);
                        },
                        child: const Text('Don\'t have an account yet?'))
                  ],
                ),
              ),
              if (state is AuthInProgress) const Center(child: CircularProgressIndicator())
            ],
          ),
        );
      },
    );
  }
}
