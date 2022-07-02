import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect_assignment/app/dio/app_dio.dart';
import 'package:pet_perfect_assignment/app/view/custom_snackbar.dart';
import 'package:pet_perfect_assignment/l10n/l10n.dart';
import 'package:pet_perfect_assignment/screen1/bloc/screen1_bloc.dart';
import 'package:pet_perfect_assignment/screen1/data/screen1_api.dart';
import 'package:video_player/video_player.dart';

class Screen1Page extends StatelessWidget {
  const Screen1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Screen1Bloc(api: Screen1API(dio: AppDio.instance))
        ..add(Screen1LoadData()),
      child: const _Screen1View(),
    );
  }
}

class _Screen1View extends StatelessWidget {
  const _Screen1View({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text(l10n.screen1AppBarTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<Screen1Bloc>().add(Screen1LoadData());
              },
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: BlocConsumer<Screen1Bloc, Screen1State>(
                  listener: (context, state) {
                    if (state is Screen1StateLoading) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }
                    if (state is Screen1StateSuccess) {
                      CustomSnackBar.info(
                        context: context,
                        text: 'Fetching ${state.imageUrl}',
                      );
                    }
                  },
                  builder: (_, state) {
                    if (state is Screen1StateLoading) {
                      return const CupertinoActivityIndicator();
                    } else if (state is Screen1StateSuccess) {
                      if (state.imageUrl.endsWith('.mp4')) {
                        return _Screen1Video(url: state.imageUrl);
                      }
                      return _Screen1Image(url: state.imageUrl);
                    } else if (state is Screen1StateFailure) {
                      return Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Screen1Image extends StatelessWidget {
  const _Screen1Image({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
          value: (loadingProgress.cumulativeBytesLoaded) /
              (loadingProgress.expectedTotalBytes ?? 1),
        );
      },
      errorBuilder: (_, url, __) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.image),
          Text('Error loading $url'),
        ],
      ),
    );
  }
}

class _Screen1Video extends StatefulWidget {
  const _Screen1Video({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<_Screen1Video> createState() => __Screen1VideoState();
}

class __Screen1VideoState extends State<_Screen1Video> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    initMyVideo();
  }

  Future<void> initMyVideo() async {
    await _controller.setLooping(true);
    await _controller.initialize();
    setState(() {
      _controller.play();
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isPlaying) {
      return CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      );
    }
    return _controller.value.isInitialized
        ? VideoPlayer(_controller)
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
