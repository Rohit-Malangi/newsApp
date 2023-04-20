import 'package:flutter/material.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
            title: helper(),
            trailing: helper(),
          ),
          const Divider(),
        ],
    );
  }

  Widget helper() {
    return Container(
      height: 30,
      width: 150,
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.grey[300],
    );
  }
}