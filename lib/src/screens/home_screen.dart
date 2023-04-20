import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/widgets/news_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchIds();
    return Scaffold(
      appBar: AppBar(title: const Text('Top News')),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, snapshot){
        if(!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return NewsListTile(id: snapshot.data![index]);
        });
      });
  }
}