import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/TripModel.dart';

abstract class TripRemoteDataSources {
  showTrip();

  getAllTrips();
}

const baseurl = 'https://ahmadalfrehan.000webhostapp.com';

class TripRemoteDataSourcesImplementation implements TripRemoteDataSources {
  final http.Client? client;

  TripRemoteDataSourcesImplementation({required this.client});

  final List<TripModel> tripModel = [];

  @override
  getAllTrips() async {
    await client?.get(
      Uri.parse('${baseurl}api/admin/showTrip'),
      headers: {"Content-Type": "application/json"},
    ).then((value) {
      tripModel.add(TripModel.fromJson(value.body as Map<dynamic, dynamic>));
    }).catchError((onError) {
      debugPrint(
        onError.toString(),
      );
    });
  }

  @override
  showTrip() async {
    await client?.get(
      Uri.parse('${baseurl}api/admin/showTrip'),
      headers: {"Content-Type": "application/json"},
    ).then((value) {
      tripModel.add(TripModel.fromJson(value.body as Map<dynamic, dynamic>));
    }).catchError((onError) {
      debugPrint(
        onError.toString(),
      );
    });
  }
}
