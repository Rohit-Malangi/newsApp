import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:news/src/widgets/loading_tile.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.addItem(id);
    return StreamBuilder(
      stream: bloc.itemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingTile();
        }
        return FutureBuilder(
          future: snapshot.data![id],
          builder: (context, itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return const LoadingTile();
            }
            return 
                buildTile(itemSnapshot.data!);
          },
        );
      },
    );
  }
  
  Widget buildTile(ItemModel item) {
    return ListTile(
      title: Text('${item.title}'),
      subtitle: Text('${item.kids?.length} points'),
      trailing: Column(
        children: [
          const Icon(Icons.comment),
          Text('${item.descendant ?? ''}'),
        ],
      ),
    );
  }
}
