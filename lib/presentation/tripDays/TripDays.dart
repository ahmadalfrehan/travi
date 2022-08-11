import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Home/CustomAppBar.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripDays/EveryDaySchedule.dart';

import '../../data/Models/DayModel.dart';

class TripDays extends StatelessWidget {
  final int id;

  const TripDays({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(),
        backgroundColor: const Color(0xFF1C1E37),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: BlocProvider(
        create: (BuildContext context) => TraviCubit()..showDays(id: id),
        child: BlocConsumer<TraviCubit, TraviStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var traviCubit = TraviCubit.get(context);
            return Scaffold(
              body: Column(
                children: [
                  if (state is ShowDaysTripLoadingStates)
                    const LinearProgressIndicator(),
                  traviCubit.tripDays.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 20),
                          child: Row(
                            children: [
                              Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromRGBO(241, 107, 82, 1),
                                  ),
                                  child: const Icon(
                                    Icons.shop,
                                    size: 32,
                                    color: Colors.white,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${traviCubit.daysNumber} Days',
                                style: const TextStyle(
                                    color: Color.fromRGBO(37, 40, 71, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          day(context, traviCubit.tripDays[index], index),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: traviCubit.tripDays.length,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget day(BuildContext context, DayModel trip, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: double.infinity,
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          trip.name.toString(),
                          style: const TextStyle(
                              color: Color.fromRGBO(37, 40, 71, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            trip.descreption.toString(),
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            trip.day.toString(),
                            style: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color.fromRGBO(241, 107, 82, 1),
                boxShadow: [],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          EveryDaySchedule(id: trip.id as int),
                    ),
                  );
                },
                child: const Center(
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
