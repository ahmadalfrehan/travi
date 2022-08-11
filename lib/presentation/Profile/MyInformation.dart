import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/Bloc.dart';
import 'Bloc/States.dart';

class MyInformation extends StatelessWidget {
  const MyInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TraviProfileBloc()..myInformation(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<TraviProfileBloc, ProfileStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var traviProfileBloc = TraviProfileBloc.get(context);
              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is MyInformationLoadingStates)
                          const LinearProgressIndicator(),
                        traviProfileBloc.userInfo.isEmpty
                            ? const Text('there is no data')
                            : Stack(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color:
                                            const Color.fromRGBO(37, 40, 71, 1),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            CircleAvatar(
                                              radius: 81,
                                              child: CircleAvatar(
                                                radius: 80,
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        37, 40, 71, 1),
                                                foregroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage: NetworkImage(
                                                      traviProfileBloc
                                                          .userInfo[0].image
                                                          .toString()),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 27),
                                            Text(
                                              traviProfileBloc.userInfo[0].name
                                                  .toString(),
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 27),
                                            Text(
                                              'email:${traviProfileBloc.userInfo[0].email}',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 27),
                                            Text(
                                              'phone:${traviProfileBloc.userInfo[0].phone}',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 27),
                                            Text(
                                              'birth:${traviProfileBloc.userInfo[0].Birth}',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
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
              );
            },
          );
        },
      ),
    );
  }
}
