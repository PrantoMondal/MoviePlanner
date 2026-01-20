import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_planner/bloc/counter_bloc.dart';
import 'package:movie_planner/cubit/counter_cubit.dart';

class IncDecPage extends StatelessWidget {
  const IncDecPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => counterBloc.add(CounterIncremented()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => counterBloc.add(CounterReset()),
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () => counterBloc.add(CounterDecremented()),
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
