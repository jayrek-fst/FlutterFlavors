import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'flavor.config.dart';

var flavorConfigProvider;

void mainCommon(FlavorConfig config) {
  flavorConfigProvider = StateProvider((ref) => config);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'),),
      body: Center(
        child: Text(ref.read(flavorConfigProvider.notifier).state.appTitle),
      ),
    );
  }
}
