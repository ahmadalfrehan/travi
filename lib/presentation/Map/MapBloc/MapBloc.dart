import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'MapStates.dart';

class MapBloc extends Cubit<MapStates> {
  MapBloc() : super(MapInitialStates());

  static MapBloc get(context) => BlocProvider.of(context);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  GoogleMapController? controller;
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  LatLng? markerPosition;

  void addMarker({required double lat, required double lng}) {
    LatLng center = LatLng(lat, lng);
    final int markerCount = markers.length;
    if (markerCount == 12) {
      return;
    }
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude,
        center.longitude,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );

    emit(MapAddedMarkerStates());
    markers[markerId] = marker;
  }
}
