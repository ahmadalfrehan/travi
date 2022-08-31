/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Debug/log.dart';
import '../getx/home/teacher/timetable/timetable_controller.dart';

class MonthDetails extends StatefulWidget {
  const MonthDetails({Key? key}) : super(key: key);

  @override
  State<MonthDetails> createState() => _MonthDetailsState();
}

class _MonthDetailsState extends State<MonthDetails> {
  int selectedMonth = 1;
  final controller = Get.put(TimeTableController());
  String selectedYear = '2020';

  var list = [];
  bool isSelected = false;
  List months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Sept',
    'Oct',
    'Nov',
    'Dic'
  ];
  List days = [
    'HORA',
    'LUNES',
    'MARTES',
    'MIE’RCOLES',
    'JUEVES',
    'VIERNES',
    'DOMINGO',
    'SA’BADO',
  ];
  List semana = [
    'Semana1',
    'Semana2',
    'Semana3',
    'Semana4',
    'Semana5',
    'Semana6',
  ];
  List hours = [
    '6:00',
    '6:30',
    '7:00',
    '7:30',
    '8:00',
    '8:30',
    '9:00',
    '9:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
    '19:00',
    '19:30',
    '20:00',
    '20:30',
    '21:00',
    '21:30',
    '22:00',
    '22:30',
    '23:00',
  ];
  var sizeWidth = 60.0, sizeHeight = 30.0;

  var isWeek = false;
  var isDays = false;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      // Allows to add a border decoration around your table
      children: [
        TableRow(
          children: [
            for (int i = 0; i < days.length; i++) Text(days[i]),
          ],
        ),
        for (int i = 0; i < hours.length; i++)
          TableRow(
            children: [
              Container(
                alignment: Alignment.center,
                width: sizeWidth,
                height: sizeHeight,
                color: const Color.fromRGBO(196, 235, 251, 1),
                child: Text(hours[i]),
              ),
              container(days[1], i + 0),
              container(days[2], i + 1),
              container(days[3], i + 2),
              container(days[4], i + 3),
              container(days[5], i + 4),
              container(days[6], i + 5),
              container(days[7], i + 6),
            ],
          ),
      ],
    );
  }

  container(String day, int id) {
    return InkWell(
      onTap: () {
        setState(() {
          list.add(id);
          isSelected == true ? isSelected = false : isSelected = true;
          log(isSelected);
        });
      },
      child: Container(
        width: sizeWidth,
        height: sizeHeight,
        color: list.contains(id)
            ? const Color.fromRGBO(196, 235, 251, 1)
            : const Color.fromRGBO(147, 197, 250, 1),
      ),
    );
  }
}

  var list = [];

  calculate() {
    for (int i = 0; i < controller.availableTimes.length; i++) {
      //list.add(controller.availableTimes[i].id);
    }
    //log(list.toString());
    int c = 0;
    for (int i = 0; i < controller.hours.length; i++) {
      for (int j = 1; j < 8; j++) {
        log((j + c).toString());
      }
      c = c + 7;
      print(c);
    }
  }

  _monthDetails(String monthName) {
    list.clear();
    for (int i = 0; i < controller.availableTimes.length; i++) {
      list.add(controller.availableTimes[i].id);
    }
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            for (int i = 0; i < controller.days.length; i++)
              Text(controller.days[i]),
          ],
        ),
        for (int i = 0, c = 0; i < controller.hours.length; i++, c = c + 7)
          TableRow(
            children: [
              Container(
                alignment: Alignment.center,
                width: sizeWidth,
                height: sizeHeight,
                color: const Color.fromRGBO(196, 235, 251, 1),
                child: Text(controller.hours[i]),
              ),
              for (int j = 1; j < 8; j++) container(controller.days[j], j + c),
            ],
          ),
      ],
    );
  }

  container(String day, int id1) {
    //  print(id1);
    return InkWell(
      onTap: () {
        setState(() {});
      },
      child: Container(
        width: sizeWidth,
        height: sizeHeight,
        color: list.contains(id1)
            ? const Color.fromRGBO(147, 197, 250, 1)
            : const Color.fromRGBO(196, 235, 251, 1),
      ),
    );
  }


*/
/*
SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height > 700
            ? MediaQuery.of(context).size.height / 1.6
            : MediaQuery.of(context).size.height / 2.3,
        width: MediaQuery.of(context).size.width > 550
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 1.09,
        child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(
                    months[selectedMonth] + '\u{25BC}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.availableTimes.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index1) {
                        return Row(
                          children: [
                            Column(
                              children: [
                                if (index1 == 0)
                                  SizedBox(
                                    width: sizeWidth,
                                    child: const Text(
                                      'Hora',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                Container(
                                  alignment: Alignment.center,
                                  width: sizeWidth,
                                  height:
                                      index1 == 0 ? sizeHeight * 2 : sizeHeight,
                                  color:
                                      // ignore: unrelated_type_equality_checks
                                      controller.availableTimes[index1]
                                                  .is_available ==
                                              true
                                          ? const Color.fromRGBO(
                                              196, 235, 251, 1)
                                          : const Color.fromRGBO(
                                              147, 197, 250, 1),
                                  child: Text(
                                    controller.availableTimes[index1].time
                                        .toString(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height:
                                  index1 == 0 ? sizeHeight * 2.2 : sizeHeight,
                              child: ListView.separated(
                                //  physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(width: 10),
                                itemCount: 7,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      if (index1 == 0)
                                        SizedBox(
                                          width: sizeWidth,
                                          child: Text(
                                            days[index],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            AlertDialogs alerts =
                                                AlertDialogs();
                                            controller.availableTimes[index1]
                                                        .is_available ==
                                                    true
                                                ? libre(context)
                                                : alerts.alerts(context);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: sizeWidth,
                                            height: index1 == 0
                                                ? sizeHeight * 2
                                                : sizeHeight, // sizeHeight,
                                            color:
                                                // ignore: unrelated_type_equality_checks
                                                controller
                                                            .availableTimes[
                                                                index1]
                                                            .is_available ==
                                                        true
                                                    ? const Color.fromRGBO(
                                                        196, 235, 251, 1)
                                                    : const Color.fromRGBO(
                                                        147, 197, 250, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
*/
