import 'package:flutter/material.dart';
import 'package:project_one_maybe_clean_architecture/data/Models/HomeTripsModel.dart';

import '../tripOverview/TripOverView.dart';
import 'SeeAll.dart';

class CurtomSomeThingIdonotKnowAboutWhatIsIt extends StatelessWidget {
  final HomeTripsModel homeTripsModel;
  final String category;

  CurtomSomeThingIdonotKnowAboutWhatIsIt(
      {Key? key, required this.homeTripsModel, required this.category})
      : super(key: key);

  List<dynamic>? homeOffersAndOthersCategoryTrips = [];

  @override
  Widget build(BuildContext context) {
    if (category == 'Offers') {
      homeOffersAndOthersCategoryTrips =
          homeTripsModel.offered as List<dynamic>;
    }
    if (category == 'Recommended for you' &&
        homeTripsModel.recommended != null) {
      homeOffersAndOthersCategoryTrips =
          homeTripsModel.recommended as List<dynamic>;
    }
    if (category == 'Most popular') {
      homeOffersAndOthersCategoryTrips =
          homeTripsModel.best![0] as List<dynamic>;
    }
    return Padding(
        padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
        child: homeOffersAndOthersCategoryTrips!.isNotEmpty
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: category.length < 12
                              ? MediaQuery.textScaleFactorOf(context) * 22
                              : MediaQuery.textScaleFactorOf(context) * 13,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(241, 107, 82, 1),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeAll(
                                        category: category,
                                      )));
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 15,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(37, 40, 71, 0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'we provide you offers for trips',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.textScaleFactorOf(context) * 15,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4.9,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 45),
                      itemCount: homeOffersAndOthersCategoryTrips!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripOverView(
                                    id: homeOffersAndOthersCategoryTrips![index]
                                        ['id'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    homeOffersAndOthersCategoryTrips![index]
                                            ['image']
                                        .toString(),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 4,
                                  top: 3,
                                  bottom: 3,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Icon(
                                            Icons.favorite,
                                            size: 20,
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          homeOffersAndOthersCategoryTrips![
                                                  index]['name']
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    18,
                                          ),
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              bottomLeft: Radius.circular(30),
                                            ),
                                            color:
                                                Color.fromRGBO(241, 107, 82, 1),
                                          ),
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                homeOffersAndOthersCategoryTrips![
                                                        index]['price']
                                                    .toString(),
                                                style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.white,
                                                  fontSize:
                                                      homeOffersAndOthersCategoryTrips![
                                                                      index]
                                                                  ['offer'] !=
                                                              0
                                                          ? 8
                                                          : 12,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                              if (homeOffersAndOthersCategoryTrips![
                                                      index]['offer'] !=
                                                  0)
                                                Text(
                                                  homeOffersAndOthersCategoryTrips![
                                                          index]['offer']
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                homeOffersAndOthersCategoryTrips![
                                                                index]['about']
                                                            .toString()
                                                            .length <=
                                                        50
                                                    ? homeOffersAndOthersCategoryTrips![
                                                            index]['about']
                                                        .toString()
                                                    : homeOffersAndOthersCategoryTrips![
                                                            index]['about']
                                                        .toString()
                                                        .trim()
                                                        .replaceRange(
                                                            50,
                                                            homeOffersAndOthersCategoryTrips![
                                                                            index]
                                                                        [
                                                                        'about']
                                                                    .toString()
                                                                    .length -
                                                                1,
                                                            '...'),
                                                style: TextStyle(
                                                  overflow: TextOverflow.clip,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: MediaQuery
                                                          .textScaleFactorOf(
                                                              context) *
                                                      8.2,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                ),
                                              ),
                                              height: 20,
                                              width: 120,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    homeOffersAndOthersCategoryTrips![
                                                        index]['reiteration'],
                                                itemBuilder: (context, index) {
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              )
            : Container());
  }
}
