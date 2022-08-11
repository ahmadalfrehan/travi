import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Search/ShowResult.dart';

class TheSearch extends SearchDelegate<String> {
  TheSearch({required this.contextPage});

  BuildContext contextPage;
  final suggestions1 = ["ahmad alfrehan"];

  @override
  String get searchFieldLabel => "What are you looking for?";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, 'null');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit()..search(query: query),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return ShowResult(
              listSearch: TraviCubit.get(context).searchList,
              traviCubit: TraviCubit.get(context));
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty ? suggestions1 : [];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (content, index) => ListTile(
        leading: const Icon(Icons.arrow_left),
        title: Text(
          suggestions[index],
        ),
      ),
    );
  }
}
