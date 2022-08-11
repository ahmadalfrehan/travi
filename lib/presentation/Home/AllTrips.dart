import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';

import '../Cubit/Cubit.dart';
import '../tripOverview/TripOverView.dart';

class AllTrips extends StatelessWidget {
  final offered;

  const AllTrips({Key? key, required this.offered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviCubit(),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
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
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
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
                            ),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    offered.name.toString(),
                                    style: TextStyle(
                                        color: const Color.fromRGBO(
                                            241, 107, 82, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            MediaQuery.of(context).size.width <
                                                    355
                                                ? 10
                                                : 18),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    TraviCubit.get(context)
                                        .likeTrip(offered.id as int);
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    size:
                                        MediaQuery.of(context).size.width < 355
                                            ? 10
                                            : 22,
                                    color:
                                        const Color.fromRGBO(241, 107, 82, 1),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      offered.about.toString(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.clip,
                                        color: Color.fromRGBO(37, 40, 71, 0.9),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width < 355
                                  ? MediaQuery.of(context).size.width / 2
                                  : MediaQuery.of(context).size.width / 1.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      color:
                                          const Color.fromRGBO(37, 40, 71, 1),
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
                                      color:
                                          const Color.fromRGBO(37, 40, 71, 1),
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
                                    width: MediaQuery.of(context).size.width <
                                            355
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                      ),
                    ],
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
