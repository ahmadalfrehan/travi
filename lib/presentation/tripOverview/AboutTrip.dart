import 'package:flutter/material.dart';
import 'package:project_one_maybe_clean_architecture/presentation/tripOverview/TripOverView.dart';

class AboutTrip extends StatelessWidget {
  final traviCubit, id;

  const AboutTrip({Key? key, required this.traviCubit, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              traviCubit.details.isEmpty
                  ? 'aa'
                  : traviCubit.details[0].tripDetails!.name.toString(),
              style: const TextStyle(
                color: Color.fromRGBO(241, 107, 82, 1),
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        traviCubit.likeTrip(id).then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripOverView(id: id),
                            ),
                            (route) => false,
                          );
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Color.fromRGBO(241, 107, 82, 1),
                        size: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(traviCubit.details[0].tripDetails!.like_counter == null
                        ? '0'
                        : traviCubit
                            .details[0].tripDetails!.like_counter['count']
                            .toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.photo_camera_back_rounded,
              color: const Color.fromRGBO(37, 40, 71, 1),
              size: 12,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${traviCubit.details[0].tripDetails!.startTrip} to ${traviCubit.details[0].tripDetails!.endTrip}',
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 71, 1),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          traviCubit.details[0].tripDetails!.about.toString(),
          style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              traviCubit.details[0].tripDetails!.nameTeam.toString(),
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 71, 1),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'orgnizer for famous trip',
              style: TextStyle(
                color: Color.fromRGBO(5, 7, 22, 0.95),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        SizedBox(
          height: 20,
          width: 300,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: traviCubit.details[0].activities.length,
            itemBuilder: (context, index) {
              return Text(
                traviCubit.details[0].activities[index].toString(),
                style: const TextStyle(
                  color: Color.fromRGBO(5, 7, 22, 0.95),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  traviCubit.getDetailsForTrips(id);
                },
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      color: Color.fromRGBO(241, 107, 82, 1),
                      size: 30,
                    ),
                    Text(
                      '${traviCubit.details[0].tripDetails!.price}\$',
                      style: const TextStyle(
                        color: Color.fromRGBO(37, 40, 71, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  traviCubit.getWeatherDetailsForTrips(id);
                },
                child: Column(
                  children: [
                    const Icon(
                      Icons.cloud_sharp,
                      color: Color.fromRGBO(241, 107, 82, 1),
                      size: 30,
                    ),
                    Text(
                      traviCubit.temp.isEmpty
                          ? '34'
                          : traviCubit.temp[0]['main']['temp'].toString(),
                      style: const TextStyle(
                        color: Color.fromRGBO(37, 40, 71, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Column(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Color.fromRGBO(241, 107, 82, 1),
                      size: 30,
                    ),
                    Text(
                      traviCubit.details[0].tripDetails!.total.toString(),
                      style: const TextStyle(
                        color: Color.fromRGBO(37, 40, 71, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Column(
                  children: [
                    const Icon(
                      Icons.group,
                      color: Color.fromRGBO(241, 107, 82, 1),
                      size: 30,
                    ),
                    Text(
                      traviCubit.details[0].tripDetails!.type.toString(),
                      style: const TextStyle(
                        color: const Color.fromRGBO(37, 40, 71, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
