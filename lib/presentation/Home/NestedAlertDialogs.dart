import 'package:flutter/material.dart';

import '../register/Activities.dart';

class NestedAlertDialogs extends StatelessWidget {
  NestedAlertDialogs({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
                          textFormFields(searchController, 'search'),
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
              color: const Color.fromRGBO(255, 217, 132, 0.9),
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
      },
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          labelText: label,
        ),
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
                      builder: (context) => const Activities(isDelete: false,),
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
