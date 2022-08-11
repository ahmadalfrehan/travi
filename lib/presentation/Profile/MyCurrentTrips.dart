import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/MyCurrentTripsModel.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Home/AllTrips.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/Bloc/States.dart';

import '../Cubit/Cubit.dart';
import '../Cubit/states.dart';
import '../Home/CustomAppBar.dart';
import '../tripOverview/TripOverView.dart';
import 'Bloc/Bloc.dart';

class MyCurrentTrips extends StatelessWidget {
  const MyCurrentTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TraviProfileBloc()..getCurrentUserTrips(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<TraviProfileBloc, ProfileStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var traviProfileBloc = TraviProfileBloc.get(context);
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: MediaQuery.of(context).size.height / 10,
                  automaticallyImplyLeading: false,
                  title: CustomAppBar(),
                  backgroundColor: const Color(0xFF1C1E37),
                  centerTitle: false,
                  titleSpacing: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is GetDetailsTripLoadingStates)
                        const LinearProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, right: 20, left: 20, bottom: 20),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'My Current Trips',
                              style: TextStyle(
                                  color: Color.fromRGBO(241, 107, 82, 1),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.3,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return AllTrips(
                                offered: traviProfileBloc.currentTrips[index]);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: traviProfileBloc.currentTrips.length,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget day(BuildContext context, MyCurrentTripsModel offered) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripOverView(id: offered.id as int),
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Color(0xFFFAFAFA),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 0,
                blurStyle: BlurStyle.outer,
                blurRadius: 3,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          offered.image.toString(),
                        )),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width < 355
                          ? MediaQuery.of(context).size.width / 2.1
                          : MediaQuery.of(context).size.width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            offered.name.toString(),
                            style: TextStyle(
                                color: const Color.fromRGBO(241, 107, 82, 1),
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.width < 355
                                        ? 10
                                        : 22),
                          ),
                          InkWell(
                            onTap: () {
                              TraviCubit.get(context)
                                  .likeTrip(offered.id as int);
                            },
                            child: Icon(
                              Icons.favorite,
                              size: MediaQuery.of(context).size.width < 355
                                  ? 10
                                  : 22,
                              color: const Color.fromRGBO(241, 107, 82, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: Wrap(
                        children: [
                          Text(
                            offered.about.toString(),
                            style: const TextStyle(
                              color: Color.fromRGBO(37, 40, 71, 0.9),
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width < 355
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width / 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.person,
                            size: 12,
                            color: Color.fromRGBO(241, 107, 82, 1),
                          ),
                          Text(
                            offered.total.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: const Color.fromRGBO(37, 40, 71, 1),
                            ),
                          ),
                          const Icon(
                            Icons.shop_rounded,
                            size: 12,
                            color: Color.fromRGBO(241, 107, 82, 1),
                          ),
                          Text(
                            '${offered.rest} day',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: const Color.fromRGBO(37, 40, 71, 1),
                            ),
                          ),
                          Icon(
                            size: 12,
                            Icons.groups_rounded,
                            color: Color.fromRGBO(241, 107, 82, 1),
                          ),
                          Text(
                            offered.type.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color.fromRGBO(37, 40, 71, 1),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width < 355
                                ? MediaQuery.of(context).size.width / 6
                                : MediaQuery.of(context).size.width / 5,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              color: Color.fromRGBO(241, 107, 82, 1),
                              boxShadow: [],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${offered.price}\$',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
