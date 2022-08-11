import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/Cubit.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Cubit/states.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Home/HomeScreen.dart';
import 'package:project_one_maybe_clean_architecture/presentation/login/login_screen.dart';

class Activities extends StatelessWidget {
  final bool isDelete;

  const Activities({Key? key, required this.isDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 16;
    return BlocProvider(
      create: (BuildContext context) => TraviCubit()..showActivity(),
      child: BlocConsumer<TraviCubit, TraviStates>(
        listener: (context, state) {
          if (state is PostActivityErrorStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An Error Occurred Try Again'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is PostActivitySuccessStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is PostActivitySuccessStates &&
              state.message.contains("User successfully selected activity")) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully Added Activity'),
                backgroundColor: Colors.green,
              ),
            );
            Timer(
              const Duration(seconds: 1),
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: const Color.fromRGBO(250, 250, 250, 1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 20, 40, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Color.fromRGBO(180, 179, 179, 1),
                              size: 36,
                            ),
                          ),
                          Text(
                            isDelete
                                ? 'choose the activity to delete it'
                                : 'Activities',
                            style: const TextStyle(
                                color: Color.fromRGBO(241, 107, 82, 1),
                                fontSize: 33,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 30,
                        ),
                        shrinkWrap: true,
                        itemCount: TraviCubit.get(context).activity.length,
                        itemBuilder: (context, index) {
                          //  String t =  TraviCubit.get(context).activitesPost.containsKey(TraviCubit.get(context).activity[index]) as String;
                          return Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  height: 70,
                                  color: TraviCubit.get(context)
                                          .activitiesPost
                                          .containsKey(TraviCubit.get(context)
                                              .activity[index])
                                      ? Colors.grey
                                      : const Color.fromRGBO(250, 250, 250, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  elevation: 5,
                                  onPressed: () {
                                    TraviCubit.get(context)
                                            .activitiesPost
                                            .containsKey(TraviCubit.get(context)
                                                .activity[index])
                                        ? TraviCubit.get(context).removeActivity(
                                            TraviCubit.get(context)
                                                .activity[index],
                                          )
                                        : TraviCubit.get(context).addActivity(
                                            name: TraviCubit.get(context)
                                                .activity[index],
                                            added: true);
                                    print(TraviCubit.get(context).activitiesPost);
                                  },
                                  child: Text(
                                    TraviCubit.get(context).activity[index],
                                    style: TextStyle(
                                      color:
                                          const Color.fromRGBO(37, 40, 71, 0.9),
                                      fontWeight: FontWeight.w700,
                                      fontSize: size,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                isDelete
                    ? TraviCubit.get(context).deleteUserActivity(
                        activity: TraviCubit.get(context)
                            .activitiesPost
                            .keys
                            .toList(),
                      )
                    : TraviCubit.get(context).postActivity(
                        activities: TraviCubit.get(context)
                            .activitiesPost
                            .keys
                            .toList());
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text('Next'),
            ),
          );
        },
      ),
    );
  }
}
