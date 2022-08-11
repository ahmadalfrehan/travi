import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/Cubit/Cubit.dart';
import '../presentation/Cubit/states.dart';
import '../presentation/Profile/Profile.dart';

class NoThing extends StatelessWidget {
  const NoThing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit(),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TraviCubit t = TraviCubit.get(context);
          return SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            centerTitle: false,
            titleSpacing: 1,
            backgroundColor: const Color.fromRGBO(28, 30, 55, 1),
            expandedHeight: MediaQuery.of(context).size.height / 2.8,
            pinned: true,
            floating: false,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                t.top = t.changeConstraintsBiggestHeight(
                    t.top, constraints.biggest.height);
                return FlexibleSpaceBar(
                  centerTitle: false,
                  background: Image.asset(
                    'assets/images/Rectangle 22.png',
                    fit: BoxFit.fill,
                  ),
                  expandedTitleScale: 1.2,
                  titlePadding: const EdgeInsets.fromLTRB(45, 0, 10, 0),
                  title: t.top > 180
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height < 660
                                  ? 10
                                  : 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: const Icon(Icons.menu,
                                      color: Colors.orange, size: 20),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Profile(),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 200,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Profile(),
                                      ),
                                    );
                                  },
                                  child: const CircleAvatar(
                                    maxRadius: 20,
                                    backgroundImage:
                                        AssetImage('assets/images/A.jpg'),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height < 700
                                          ? 4
                                          : 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Hello jhon',
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 217, 132, 1),
                                    fontSize:
                                        MediaQuery.of(context).size.height < 700
                                            ? 13
                                            : 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height < 660
                                  ? 10
                                  : 30,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Where would you like\nto go ?',
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    fontSize:
                                        MediaQuery.of(context).size.height < 700
                                            ? 8
                                            : 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height < 700
                                  ? 4
                                  : 15,
                            ),
                            Container(
                              height: 40,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: InkWell(
                                      onTap: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const CircleAvatar(
                                    maxRadius: 25,
                                    child: Icon(
                                      Icons.search,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

var t = [
  {
    "id": 1,
    "name": "Saturday",
    "description": "cooking, tennis",
    "day": "2022-02-05 00:00:00",
    "dailyprogram_id": 1,
    "created_at": "2022-08-07T22:05:12.000000Z",
    "updated_at": "2022-08-07T22:05:12.000000Z",
    "events": [
      {
        "id": 1,
        "name": "rest in nature",
        "description": "running",
        "timing": "11:30 to 12:30",
        "image":
            "https://images.pexels.com/photos/12577819/pexels-photo-12577819.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
        "dateday_id": 1,
        "created_at": "2022-08-07T22:21:58.000000Z",
        "updated_at": "2022-08-07T22:21:58.000000Z"
      },
      {
        "id": 2,
        "name": "slow write",
        "description": "we are going to write slowly",
        "timing": "11:30 to 02:30",
        "image":
            "https://images.pexels.com/photos/12586694/pexels-photo-12586694.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
        "dateday_id": 1,
        "created_at": "2022-08-07T22:23:12.000000Z",
        "updated_at": "2022-08-07T22:23:12.000000Z"
      }
    ]
  },
  {
    "id": 2,
    "name": "Sunday",
    "description": "running",
    "day": "2022-02-06 00:00:00",
    "dailyprogram_id": 1,
    "created_at": "2022-08-07T22:05:42.000000Z",
    "updated_at": "2022-08-07T22:05:42.000000Z",
    "events": []
  },
  {
    "id": 3,
    "name": "Wednesday",
    "description": "music, swim",
    "day": "2022-02-09 00:00:00",
    "dailyprogram_id": 1,
    "created_at": "2022-08-07T22:06:04.000000Z",
    "updated_at": "2022-08-07T22:06:04.000000Z",
    "events": []
  }
];
