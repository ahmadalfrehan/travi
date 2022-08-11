import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_one_maybe_clean_architecture/main.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/Bloc/Bloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/EditProfile.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/MyFavouriteTrips.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/MyInformation.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/MyNextTrips.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Profile/MyPaseTrips.dart';
import 'package:project_one_maybe_clean_architecture/presentation/login/login_screen.dart';

import 'Bloc/States.dart';
import 'MyCurrentTrips.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 40, 71, 1),
      body: BlocProvider(
        create: (BuildContext context) => TraviProfileBloc(),
        child: BlocConsumer<TraviProfileBloc, ProfileStates>(
          listener: (context, state) {
            if (state is LogoutSuccessStates) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            var traviProfileBloc = TraviProfileBloc.get(context);
            return Column(
              children: [
                if (state is LogoutLoadingStates)
                  const LinearProgressIndicator(),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: const Color.fromRGBO(37, 40, 71, 1),
                      height: MediaQuery.of(context).size.height / 1,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          CircleAvatar(
                            radius: 81,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor:
                                  const Color.fromRGBO(37, 40, 71, 1),
                              foregroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    TraviProfileBloc.get(context).linkPhoto ==
                                            null
                                        ? NetworkImage(imageUrl)
                                        : NetworkImage(
                                            TraviProfileBloc.get(context)
                                                .linkPhoto
                                                .toString(),
                                          ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: traviProfileBloc.listOfButtons.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      switch (traviProfileBloc
                                          .listOfButtons[index]) {
                                        case 'Edit Profile':
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile(),
                                            ),
                                          );
                                          break;
                                        case 'My Current Trips':
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyCurrentTrips(),
                                            ),
                                          );
                                          break;
                                        case 'My Next Trips':
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyNextTrips(),
                                            ),
                                          );
                                          break;
                                        case 'My Favourite Trips':
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyFavouriteTrips(),
                                            ),
                                          );
                                          break;
                                        case 'My Information':
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyInformation(),
                                            ),
                                          );
                                          break;
                                        case 'Contact Us':
                                          traviProfileBloc.makeEmailCall(
                                            'ahmadalfrehan@gmail.com',
                                          );
                                          break;
                                        case 'Help':
                                          TraviProfileBloc.get(context)
                                              .getImageProfile(
                                                  ImageSource.gallery);
                                          break;
                                        case 'My Ended Trips':
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyPastTrips(),
                                            ),
                                          );
                                          break;
                                        case 'Suggest trip':
                                         TraviProfileBloc.get(context).makeMessage('0982867882');
                                          break;

                                        case 'Logout':
                                          traviProfileBloc
                                              .logOut()
                                              .then((value) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(),
                                              ),
                                            );
                                          });
                                          break;
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromRGBO(
                                              241,
                                              107,
                                              82,
                                              0.32,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: Text(
                                            traviProfileBloc
                                                .listOfButtons[index],
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(37, 40, 71, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
