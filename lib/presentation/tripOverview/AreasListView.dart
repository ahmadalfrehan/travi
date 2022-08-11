import 'package:flutter/material.dart';

import '../MoreAboutThePlace/MoreAboutThePlace.dart';

class AreasListView extends StatelessWidget {
  final traviCubit;

  const AreasListView({Key? key, required this.traviCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 10),
        Row(
          children: const [
            Text(
              'Places trip cover ',
              style: TextStyle(
                color: Color.fromRGBO(37, 40, 71, 1),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Container(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 1,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: traviCubit.details[0].tripDetails!.areas.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreAboutThePlace(
                          traviCubit.details[0].tripDetails!.areas[index],
                          traviCubit.details[0].tripDetails!.like_counter['count'] ?? 0,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(2, 2),
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            spreadRadius: 1,
                            blurStyle: BlurStyle.inner,
                            blurRadius: 22),
                        BoxShadow(
                            offset: Offset(-2, 2),
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            spreadRadius: 1,
                            blurStyle: BlurStyle.inner,
                            blurRadius: 22),
                      ],
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          traviCubit.details[0].tripDetails!
                                  .areas[index]['image1']!
                                  .toString()
                                  .contains('https')
                              ? traviCubit.details[0].tripDetails!
                                  .areas[index]['image1']
                                  .toString()
                              : traviCubit.images[index],
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                    traviCubit.details[0].tripDetails!
                                        .areas[index]['name']
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 14,
                              ),
                              Text(
                                traviCubit.details[0].tripDetails!.areas[index]
                                            ['like_counter'] ==
                                        null
                                    ? '0'
                                    : traviCubit.details[0].tripDetails!
                                        .areas[index]['like_counter']['count']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
