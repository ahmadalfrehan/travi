import 'package:flutter/material.dart';
import 'package:project_one_maybe_clean_architecture/main.dart';

import '../Profile/Profile.dart';
import '../Search/Search.dart';
import '../register/Activities.dart';
import 'CustomAppBar.dart';

class SliverAppBarFor {
  Widget SliverAppBarfor(BuildContext context, var traviCubit) {
    imageUrl = traviCubit.trips[0].user!.image.toString();
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      centerTitle: false,
      titleSpacing: 1,
      backgroundColor: const Color.fromRGBO(28, 30, 55, 1),
      expandedHeight: MediaQuery.of(context).size.height / 2.8,
      pinned: true,
      floating: false,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          traviCubit.top = traviCubit.changeConstraintsBiggestHeight(
              traviCubit.top, constraints.biggest.height);
          return FlexibleSpaceBar(
            centerTitle: false,
            background: Image.asset(
              'assets/images/Rectangle 22.png',
              fit: BoxFit.fill,
            ),
            expandedTitleScale: 1.2,
            titlePadding: EdgeInsets.fromLTRB(
                45, MediaQuery.of(context).size.height < 660 ? 12 : 70, 10, 0),
            title: traviCubit.top > 120
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: const Icon(Icons.menu,
                                color: Colors.orange, size: 20),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width < 364
                                  ? 164
                                  : 200),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              maxRadius: 20,
                              backgroundImage: NetworkImage(
                                traviCubit.trips[0].user!.image.toString(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height < 700
                                ? 4
                                : 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height < 660 ? 5 : 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Hello ' +
                                traviCubit.trips[0].user!.name.toString(),
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 217, 132, 1),
                              fontSize: MediaQuery.of(context).size.height < 700
                                  ? 13
                                  : 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height < 660 ? 5 : 14,
                      ),
                      Row(
                        children: [
                          Text(
                            'Where would you like\nto go ?',
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: MediaQuery.of(context).size.height < 700
                                  ? 8
                                  : 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height < 700 ? 2 : 25,
                      ),
                      Container(
                        height: 40,
                        child: Row(
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () async {
                                  await showSearch(
                                    context: context,
                                    delegate: TheSearch(contextPage: context),
                                    query: "any query",
                                  );
                                },
                                child: textFormFields(
                                    traviCubit.searchController, 'search'),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const CircleAvatar(
                              maxRadius: 25,
                              child: Icon(
                                Icons.search,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
      title: traviCubit.top <= 120 ? CustomAppBar() : Container(),
    );
  }

  nestedAlertDialogs(BuildContext context, var t) {
    var e = AlertDialog(
      actionsPadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.only(left: 0, right: 30),
      actions: [
        MaterialButton(
          onPressed: () {
            var alert = AlertDialog(
              actionsPadding: const EdgeInsets.all(20),
              contentPadding: const EdgeInsets.only(left: 0, right: 30),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: const Color.fromRGBO(255, 217, 132, 0.9),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  minWidth: double.infinity,
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: Color.fromRGBO(37, 40, 71, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
              content: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 0,
                    left: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      textFormFields(t.searchController, 'search'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          activitiesAndOther(
                            'Activity',
                            Icons.abc_outlined,
                          ),
                          activitiesAndOther(
                            'Age',
                            Icons.person,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          activitiesAndOther(
                            'Type',
                            Icons.abc_outlined,
                          ),
                          activitiesAndOther(
                            'Price',
                            Icons.abc_outlined,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          activitiesAndOther(
                            'Continent',
                            Icons.abc_outlined,
                          ),
                          activitiesAndOther(
                            'Date',
                            Icons.abc_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              scrollable: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            );
            showDialog(context: context, builder: (context) => alert);
          },
          color: const Color.fromRGBO(255, 217, 132, 0.9),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          minWidth: MediaQuery.of(context).size.width / 4,
          child: const Text(
            'Trips',
            style: TextStyle(
              color: Color.fromRGBO(37, 40, 71, 1),
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 4,
          color: const Color.fromRGBO(
            255,
            217,
            132,
            0.9,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Tourist places',
            style: TextStyle(
              color: Color.fromRGBO(37, 40, 71, 1),
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ),
      ],
      title: const Text('What are you searching for?'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
    showDialog(
      context: context,
      builder: (context) => e,
    );
  }

  Widget textFormFields(var controllerVar, String label) {
    return Material(
      shadowColor: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(50.0),
      color: const Color(0xFFFAFAFA),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          labelStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFFB4B3B3),
          ),
          fillColor: const Color(0xFFFAFAFA),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          labelText: label,
        ),
        enabled: false,
        controller: controllerVar,
        keyboardType: TextInputType.text,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'the password must not be empty';
          }
          return null;
        },
      ),
    );
  }

  Widget activitiesAndOther(String name, IconData icon) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 4),
            blurRadius: 4,
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, -0.8),
            blurRadius: 10,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: const Color.fromRGBO(241, 107, 82, 1),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFFB4B3B3),
              ),
            ),
            Builder(builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Activities(isDelete: false),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFFB4B3B3),
                  size: 15,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
