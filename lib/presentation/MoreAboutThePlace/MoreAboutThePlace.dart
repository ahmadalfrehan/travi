import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/main.dart';
import 'package:project_one_maybe_clean_architecture/presentation/MoreAboutThePlace/Comments.dart';
import 'package:project_one_maybe_clean_architecture/presentation/MoreAboutThePlace/ShowBottom.dart';
import 'package:project_one_maybe_clean_architecture/presentation/MoreAboutThePlace/placeGallary.dart';

import '../Cubit/Cubit.dart';
import '../Cubit/states.dart';
import '../Map/MapForMyApp.dart';

class MoreAboutThePlace extends StatelessWidget {
  final listAreas;
  final int count;

  MoreAboutThePlace(this.listAreas,this.count ,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit(),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TraviCubit traviCubit = TraviCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          listAreas['image1'].toString(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlue[900]!.withOpacity(0),
                          Colors.lightBlue[900]!.withOpacity(0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.5, 1],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 45, right: 45, bottom: 10),
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  listAreas['name'],
                                  style: textStyle(
                                      25, Colors.white, FontWeight.w700),
                                ),
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              ),
                              Text(
                                count.toString(),
                                style: textStyle(
                                  25,
                                  Colors.white,
                                  FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          if (traviCubit.l == false)
                            Container(
                              height: 40,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 0),
                              decoration: BoxDecoration(
                                color: Colors.transparent.withOpacity(0.4),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  traviCubit.l = traviCubit.changeBoolean(
                                      traviCubit.l, true);
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          if (traviCubit.l == true)
                            Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 25, right: 25, top: 15),
                              decoration: BoxDecoration(
                                color: Colors.transparent.withOpacity(0.4),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 20,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            traviCubit.changeIndex(index);
                                          },
                                          child: Text(
                                            traviCubit.list[index],
                                            style: textStyle(
                                                15,
                                                index == traviCubit.selected
                                                    ? const Color(0xFFFFD984)
                                                    : Colors.white,
                                                FontWeight.w400),
                                          ),
                                        ),
                                        separatorBuilder: (context, index) =>
                                            Text(
                                          '  |  ',
                                          style: textStyle(12, Colors.white,
                                              FontWeight.w400),
                                        ),
                                        itemCount: traviCubit.list.length,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (traviCubit.selected == 0)
                                      Comments(id: listAreas['id'] as int),
                                    if (traviCubit.selected == 1)
                                      PlaceGallary(listAreas: listAreas),
                                    if (traviCubit.selected == 2)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        child: MapForMyApp(
                                            lat: listAreas['latitude'],
                                            lng: listAreas['longitude']),
                                      ),
                                    const SizedBox(height: 10),
                                    if (traviCubit.l == true)
                                      Row(
                                        mainAxisAlignment:
                                            traviCubit.selected == 2 ||
                                                    traviCubit.selected == 0
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.center,
                                        children: [
                                          if (traviCubit.selected == 2)
                                            const SizedBox(width: 30),
                                          IconButton(
                                            onPressed: () {
                                              traviCubit.l =
                                                  traviCubit.changeBoolean(
                                                      traviCubit.l, false);
                                            },
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                          ),
                                          if (traviCubit.selected == 2)
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MapForMyApp(
                                                            lat: listAreas[
                                                                'latitude'],
                                                            lng: listAreas[
                                                                'longitude']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Explore',
                                                style: textStyle(
                                                    20,
                                                    Colors.white,
                                                    FontWeight.w500),
                                              ),
                                            ),
                                          if (traviCubit.selected == 0)
                                            ShowBottom(
                                                traviCubit: traviCubit,
                                                id: listAreas['id'] as int,
                                            )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle textStyle(double fontSize, Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
