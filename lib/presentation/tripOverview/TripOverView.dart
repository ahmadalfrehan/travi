import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Payment/Payment.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripDays/TripDays.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripOverview/AboutTrip.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripOverview/AreasListView.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripOverview/SliverAppBar.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripOverview/reviews.dart';

import '../../presentation'
    '/Cubit/Cubit.dart';
import '../../presentation'
    '/Cubit/states.dart';

class TripOverView extends StatelessWidget {
  final int id;

  const TripOverView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SliverAppBar2 sliver = SliverAppBar2();
    return BlocProvider(
      create: (BuildContext context) => TraviCubit()
        ..getDetailsForTrips(id)
        ..getWeatherDetailsForTrips(id),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {},
        builder: (context, state) {
          TraviCubit traviCubit = TraviCubit.get(context);
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                traviCubit.details.isEmpty
                    ? const SliverAppBar()
                    : sliver.sliverAppBar2(context, traviCubit),
              ],
              body: traviCubit.details.isEmpty ||
                      state is GetDetailsTripLoadingStates
                  ? const LinearProgressIndicator()
                  : Container(
                      height: MediaQuery.of(context).size.height < 500
                          ? MediaQuery.of(context).size.height / 1.7
                          : MediaQuery.of(context).size.height / 2.8,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 20, left: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (state is GetDetailsTripLoadingStates)
                                const CircularProgressIndicator(),
                              AboutTrip(traviCubit: traviCubit, id: id),
                              AreasListView(traviCubit: traviCubit),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Rate:',
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(37, 40, 71, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 100,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: traviCubit.details[0]
                                                    .tripDetails!.reiteration,
                                                itemBuilder: (context, index) {
                                                  return const Icon(
                                                    Icons.star,
                                                    size: 20,
                                                    color: Colors.amber,
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Reviews(id: id),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Reviews(id: id),
                                                    ));
                                              },
                                              child: const Text(
                                                'view reviews',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      37, 40, 71, 1),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Color.fromRGBO(
                                                  180, 179, 179, 1),
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      color:
                                          const Color.fromRGBO(37, 40, 71, 1),
                                      height: 50,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Text(
                                        "Show trip schedule ",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      onPressed: () async {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => TripDays(
                                                id: traviCubit.details[0]
                                                    .tripDetails!.id as int),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              MaterialButton(
                                color: const Color.fromRGBO(255, 217, 132, 1),
                                minWidth: double.infinity,
                                height: 50,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Text(
                                  "Join this trip",
                                  style: TextStyle(
                                    color: Color.fromRGBO(37, 40, 71, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Payment(
                                          amount: traviCubit
                                              .details[0].tripDetails!.price
                                              .toString(),
                                          id: id,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
