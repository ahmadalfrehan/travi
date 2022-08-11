import 'package:flutter/material.dart';

import '../../main.dart';
import '../Profile/Profile.dart';
import '../Search/Search.dart';
import '../register/Activities.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    Key? key,
  }) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: const Icon(Icons.menu, color: Colors.orange),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: InkWell(
                onTap: () async {
                  await showSearch(
                    context: context,
                    delegate: TheSearch(contextPage: context),
                    query: "any query",
                  );
                },
                child: textFormFields(searchController, 'search')),
          ),
          const SizedBox(
            width: 20,
          ),
          const CircleAvatar(
            maxRadius: 20,
            child: Icon(
              Icons.search,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
            child: CircleAvatar(
              maxRadius: 23,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height < 700 ? 4 : 20,
          ),
        ],
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

  Widget textFormFields(var controllerVar, String label) {
    return Material(
      shadowColor: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(50.0),
      color: const Color(0xFFFAFAFA),
      child: TextFormField(
        enabled: false,
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
}
