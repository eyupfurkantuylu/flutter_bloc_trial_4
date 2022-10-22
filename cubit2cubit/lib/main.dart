import 'dart:io';

import 'package:cubit2cubit/cubits/color/color_cubit.dart';
import 'package:cubit2cubit/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(
            colorCubit: context.read<ColorCubit>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'cubit2cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.read<ColorCubit>().changeColor();
              },
              child: Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '${context.watch<CounterCubit>().state.counter}',
              style: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterCubit>().changeCounter();
              },
              child: Text(
                'Increment Counter',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
