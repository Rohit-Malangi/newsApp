import 'package:flutter/material.dart';
import './stories_bloc.dart';
export './stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  StoriesProvider({super.key, required super.child});

  final storiesBloc = StoriesBloc();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return (oldWidget as StoriesProvider).storiesBloc != storiesBloc;
  }

  static StoriesBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StoriesProvider>()!
        .storiesBloc;
  }
}
