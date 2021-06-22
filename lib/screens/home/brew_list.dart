import 'package:flutter/material.dart';
import 'package:website/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:website/screens/home/brew_tile.dart';

// ignore: use_key_in_widget_constructors
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: brews[index]);
      },
    );
  }
}
