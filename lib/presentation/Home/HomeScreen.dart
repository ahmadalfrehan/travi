import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation'
    '/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation'
    '/Cubit/states.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Games/SnackGame.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Games/XOGame.dart';

import 'CurtomSomeThingIdonotAboutWhatIsIt.dart';
import 'SliverAppBarfor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());
    SliverAppBarFor d = SliverAppBarFor();
    print(MediaQuery.of(context).size.width.toString());
    return BlocProvider(
      create: (BuildContext context) => TraviCubit()..getDataForHomeScreen(),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TraviCubit traviCubit = TraviCubit.get(context);
          return Scaffold(
            body: state is GetHomeDataLoadingStates
                ? const SafeArea(
                    child: LinearProgressIndicator(),
                  )
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      traviCubit.trips.isEmpty
                          ? const SliverAppBar()
                          : d.SliverAppBarfor(context, traviCubit),
                    ],
                    body: RefreshIndicator(
                      onRefresh: () {
                        return traviCubit.getDataForHomeScreen();
                      },
                      child: traviCubit.trips.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'there is an error while trying to connect do you want to play some Games:',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Xo(),
                                              ),
                                            );
                                          },
                                          child: const Text('Xo Game')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Snack(),
                                              ),
                                            );
                                          },
                                          child: const Text('Snake Game')),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  MaterialButton(
                                    onPressed: () {
                                      traviCubit.getDataForHomeScreen();
                                    },
                                    child: const Text('try Again'),
                                  ),
                                ],
                              ),
                            )
                          : SafeArea(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 11),
                                itemBuilder: (context, index) {
                                  if (traviCubit.trips[0].offered != null) {
                                    return CurtomSomeThingIdonotAboutWhatIsIt(
                                      category: traviCubit.category[index],
                                      homeTripsModel: traviCubit.trips[0],
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                                itemCount: 3,
                                shrinkWrap: true,
                              ),
                            ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
