import 'dart:async';

import 'package:flutter/material.dart'
    '';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Map/MapBloc/MapBloc.dart';
import 'package:project_one_maybe_clean_architecture/presentation/Map/MapBloc/MapStates.dart';

class MapForMyApp extends StatelessWidget {
  final lat, lng;

  MapForMyApp({Key? key, required this.lat, required this.lng})
      : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (BuildContext context) => MapBloc()
            ..addMarker(
              lng: lng,
              lat: lat,
            ),
          child: BlocConsumer<MapBloc, MapStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          markers: Set<Marker>.of(
                              MapBloc.get(context).markers.values),
                          onCameraMoveStarted: () {
                            CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(lat, lng),
                              zoom: 14.4746,
                            ));
                          },
                          myLocationEnabled: true,
                          onCameraMove: (CameraPosition) {
                            CameraUpdate.newCameraPosition(CameraPosition);
                          },
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat, lng),
                            zoom: 11.4746,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
