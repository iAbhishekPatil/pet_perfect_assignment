import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_assignment/app/dio/app_dio.dart';
import 'package:pet_perfect_assignment/l10n/l10n.dart';
import 'package:pet_perfect_assignment/screen2/bloc/screen2_bloc.dart';
import 'package:pet_perfect_assignment/screen2/data/screen2_api.dart';
import 'package:pet_perfect_assignment/screen2/data/screen2_model.dart';

class Screen2Page extends StatelessWidget {
  const Screen2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Screen2Bloc(api: Screen2API(dio: AppDio.instance))
        ..add(Screen2LoadData()),
      child: const _Screen2View(),
    );
  }
}

class _Screen2View extends StatelessWidget {
  const _Screen2View();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text(l10n.screen2AppBarTitle)),
      body: Center(
        child: BlocBuilder<Screen2Bloc, Screen2State>(
          builder: (context, state) {
            if (state is Screen2StateLoading) {
              return CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              );
            }
            if (state is Screen2StateFailure) {
              return Text(
                state.message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              );
            }
            if (state is Screen2StateSuccess) {
              return _Screen2ListView(state.data);
            }
            return const Text('HI');
          },
        ),
      ),
    );
  }
}

class _Screen2ListView extends StatelessWidget {
  const _Screen2ListView(this.data);

  final List<Screen2Model> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final post = data[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
        );
      },
    );
  }
}
