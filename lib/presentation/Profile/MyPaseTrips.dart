import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/TripModel.dart';

import '../Cubit/Cubit.dart';
import '../Cubit/states.dart';
import '../Home/CustomAppBar.dart';
import '../tripOverview/TripOverView.dart';
import 'Bloc/Bloc.dart';
import 'Bloc/States.dart';

class MyPastTrips extends StatelessWidget {
  MyPastTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviProfileBloc()..getAllTrips(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<TraviProfileBloc, ProfileStates>(
            listener: (context, state) {
              if (state is AddReportTripsSuccessStates) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Your Report Successfully Registered we Will review it soon',
                    ),
                  ),
                );
              }
              if (state is AddReportTripsErrorStates) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      'An Error Occurred',
                    ),
                  ),
                );
              }
            },
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
                              'My Ended Trips',
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
                            return day(
                                context, traviProfileBloc.allTrips[index]);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: traviProfileBloc.allTrips.length,
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

  Widget day(BuildContext context, TripModel offered) {
    var commentController = TextEditingController();
    var starController = TextEditingController();
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
          height: 200,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            var c = AlertDialog(
                              scrollable: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text('Add Rport'),
                              content: SizedBox(
                                height: 240,
                                width: 300,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          label: const Text("headers"),
                                          //fillColor: Colors.white,
                                          filled: true,
                                          enabled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'the field must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextFormField(
                                        controller: starController,
                                        decoration: InputDecoration(
                                          label: const Text("Subject"),
                                          //fillColor: Colors.white,
                                          filled: true,
                                          enabled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'the field must not be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          TraviProfileBloc.get(context)
                                              .addReport(
                                                  id: offered.id as int,
                                                  header:
                                                      commentController.text,
                                                  subject: starController.text)
                                              .then((value) {
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text(
                                          'submit',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            );
                            showDialog(
                              context: context,
                              builder: (context) => c,
                            );
                          },
                          child: const Text(
                            'Add Report',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 17,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
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
