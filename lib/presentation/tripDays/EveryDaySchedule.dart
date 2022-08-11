import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Home/CustomAppBar.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Payment/Payment.dart';

import '../Cubit/states.dart';

class EveryDaySchedule extends StatelessWidget {
  final int id;

  const EveryDaySchedule({Key? key, required this.id}) : super(key: key);

  TextStyle textStyle(double fontSize, Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

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
        create: (BuildContext context) => TraviCubit()..showEvent(id: id),
        child: BlocConsumer<TraviCubit, TraviStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var traviCubit = TraviCubit.get(context);
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width > 700 ? 0 : 20,
                  right: 30,
                  left: 30,
                  bottom: 20),
              child: Column(
                children: [
                  if (state is ShowEventTripLoadingStates)
                    const LinearProgressIndicator(),
                  traviCubit.days.isEmpty
                      ? const Text('there is no data')
                      : Row(
                          children: [
                            Text(
                              traviCubit.days[0].day
                                  .toString()
                                  .trim()
                                  .replaceRange(
                                      10, traviCubit.days[0].day?.length, ''),
                              style: textStyle(
                                  27,
                                  const Color.fromRGBO(73, 40, 71, 1),
                                  FontWeight.w700),
                            ),
                            Text(
                              traviCubit.days[0].name
                                  .toString()
                                  .trim()
                                  .replaceRange(
                                      3, traviCubit.days[0].name?.length, ''),
                              style: textStyle(
                                  15,
                                  const Color.fromRGBO(241, 107, 82, 1),
                                  FontWeight.w700),
                            ),
                          ],
                        ),
                  traviCubit.days.isEmpty
                      ? const Text('there is no data')
                      : Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width > 700
                                  ? 0
                                  : 20,
                            ),
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    traviCubit.showEvent(
                                        id: traviCubit.days[index].id as int);
                                  },
                                  child: Text(
                                    traviCubit.days[index].name
                                        .toString()
                                        .trim()
                                        .replaceRange(
                                            3,
                                            traviCubit.days[index].name?.length,
                                            ''),
                                    style: textStyle(
                                        15,
                                        const Color.fromRGBO(37, 40, 71, 0.25),
                                        FontWeight.w500),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 20),
                                itemCount: traviCubit.days.length,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width > 700
                                  ? 0
                                  : 20,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width > 700
                                  ? 0
                                  : 20,
                              width: double.infinity,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          traviCubit.showEvent(
                                              id: traviCubit.days[index].id
                                                  as int);
                                        },
                                        child: Text(
                                          traviCubit.days[index].day
                                              .toString()
                                              .trim()
                                              .replaceRange(
                                                  10,
                                                  traviCubit
                                                      .days[index].day?.length,
                                                  '')
                                              .trim()
                                              .replaceRange(0, 8, ''),
                                          style: textStyle(
                                              20,
                                              const Color.fromRGBO(
                                                  37, 40, 71, 1),
                                              FontWeight.w500),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 33),
                                  itemCount: traviCubit.days.length),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width > 700
                                  ? 0
                                  : 11,
                            ),
                          ],
                        ),
                  const Divider(
                    color: Color.fromRGBO(196, 196, 196, 0.5),
                    thickness: 1.4,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width > 700 ? 0 : 11,
                  ),
                  if (MediaQuery.of(context).size.height > 560)
                    traviCubit.events.isEmpty
                        ? const Text('there is no data')
                        : SizedBox(
                            height: MediaQuery.of(context).size.height > 658
                                ? MediaQuery.of(context).size.height / 1.78
                                : MediaQuery.of(context).size.height / 2.2,
                            width: double.infinity,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection:
                                  MediaQuery.of(context).size.width > 700
                                      ? Axis.horizontal
                                      : Axis.vertical,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 0),
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    verticalDivider(),
                                    const SizedBox(width: 20),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(1, 1),
                                              spreadRadius: 0,
                                              blurStyle: BlurStyle.outer,
                                              blurRadius: 3,
                                              color: Color.fromRGBO(
                                                  196, 196, 196, 1)),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            traviCubit.events[index].image
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  traviCubit.events[index].name
                                                      .toString(),
                                                  style: textStyle(
                                                    MediaQuery.of(context).size.width <
                                                            380
                                                        ? 13
                                                        : 20,
                                                    const Color.fromRGBO(37, 40, 71, 1),
                                                    FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Wrap(
                                            children: [
                                              Text(
                                                traviCubit
                                                    .events[index].descreption
                                                    .toString(),
                                                style: textStyle(
                                                  MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          380
                                                      ? 8
                                                      : 12,
                                                  const Color.fromRGBO(
                                                      27, 27, 27, 1),
                                                  FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    700
                                                ? 0
                                                : 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.watch_later,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                traviCubit.events[index].timing
                                                    .toString(),
                                                style: textStyle(
                                                    12,
                                                    const Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 0),
                              itemCount: traviCubit.events.length,
                            ),
                          )
                  else
                    traviCubit.events.isEmpty
                        ? const Text('there is no data')
                        : SizedBox(
                            height: MediaQuery.of(context).size.height > 545
                                ? MediaQuery.of(context).size.height / 2.2
                                : MediaQuery.of(context).size.height / 3,
                            width: double.infinity,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection:
                                  MediaQuery.of(context).size.width > 700
                                      ? Axis.horizontal
                                      : Axis.vertical,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 0, bottom: 0),
                                child: Row(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    verticalDivider(),
                                    const SizedBox(width: 20),
                                    Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(1, 1),
                                              spreadRadius: 0,
                                              blurStyle: BlurStyle.outer,
                                              blurRadius: 3,
                                              color: Color.fromRGBO(
                                                  196, 196, 196, 1)),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            traviCubit.events[index].image
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          traviCubit.events[index].name
                                              .toString(),
                                          style: textStyle(
                                            MediaQuery.of(context).size.width <
                                                    380
                                                ? 13
                                                : 20,
                                            const Color.fromRGBO(37, 40, 71, 1),
                                            FontWeight.w700,
                                          ),
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                              traviCubit
                                                  .events[index].descreption
                                                  .toString(),
                                              style: textStyle(
                                                MediaQuery.of(context)
                                                            .size
                                                            .width <
                                                        380
                                                    ? 8
                                                    : 12,
                                                const Color.fromRGBO(
                                                    27, 27, 27, 1),
                                                FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  700
                                              ? 0
                                              : 10,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.watch_later,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              traviCubit.events[index].timing
                                                  .toString(),
                                              style: textStyle(
                                                  12,
                                                  const Color.fromRGBO(
                                                      0, 0, 0, 1),
                                                  FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 0),
                              itemCount: traviCubit.events.length,
                            ),
                          ),
                  const Spacer(),
                  MaterialButton(
                    color: const Color.fromRGBO(255, 217, 132, 1),
                    minWidth: double.infinity,
                    height: 45,
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Payment(amount: '800',id:1)));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget verticalDivider() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 3,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        Container(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          child: const SizedBox(
            height: 120,
            width: 1,
          ),
        ),
      ],
    );
  }

  Widget numberAntText(String text, String number) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              text,
              style: textStyle(
                  15, const Color.fromRGBO(37, 40, 71, 0.25), FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              number,
              style: textStyle(
                  20, const Color.fromRGBO(37, 40, 71, 1), FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }
}
