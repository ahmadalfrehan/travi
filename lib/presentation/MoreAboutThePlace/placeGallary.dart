import 'package:flutter/material.dart';

class PlaceGallary extends StatelessWidget {
  final listAreas;

  const PlaceGallary({Key? key, required this.listAreas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          listAreas['description'].toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Color(0xffc4c4c480),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width / 1,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
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
                          listAreas['image1'],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
