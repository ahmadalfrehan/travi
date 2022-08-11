import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef MarkerUpdateAction = Marker Function(Marker marker);

class MapMyApp extends StatelessWidget {
  final lat, lng;

  MapMyApp({Key? key, required this.lat, required this.lng}) : super(key: key);
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  double latitude1 = 32.9573689;
  double longitude2 = 35.9586301;

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  MarkerId? selectedMarker;
  LatLng? markerPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng center = const LatLng(32.9573689, 35.9586301);

  GoogleMapController? controller;

  //Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // MarkerId? selectedMarker;
  int _markerIdCounter = 1;

  // LatLng? markerPosition;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(32.9573689, 35.9586301),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = const CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(32.9573689, 35.9586301),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      final MarkerId? previousMarkerId = selectedMarker;
      if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
        final Marker resetOld = markers[previousMarkerId]!
            .copyWith(iconParam: BitmapDescriptor.defaultMarker);
        markers[previousMarkerId] = resetOld;
      }
      selectedMarker = markerId;
      final Marker newMarker = tappedMarker.copyWith(
        iconParam: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
      );
      markers[markerId] = newMarker;

      markerPosition = null;
    }
  }

  Future<void> _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    markerPosition = newPosition;
  }

  Future<void> _onMarkerDragEnd(
      MarkerId markerId, LatLng newPosition, BuildContext context) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      markerPosition = null;
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  void add(BuildContext context) {
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
        center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) =>
          _onMarkerDragEnd(markerId, position, context),
      onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );
  }

  moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16),
      ),
    );
  }

  void _remove(MarkerId markerId) {
    if (markers.containsKey(markerId)) {
      markers.remove(markerId);
    }
  }

  void _changePosition(MarkerId markerId) {
    final Marker marker = markers[markerId]!;
    final LatLng current = marker.position;
    final Offset offset = Offset(
      center.latitude - current.latitude,
      center.longitude - current.longitude,
    );
    markers[markerId] = marker.copyWith(
      positionParam: LatLng(
        center.latitude + offset.dy,
        center.longitude + offset.dx,
      ),
    );
  }

  void _changeAnchor(MarkerId markerId) {
    final Marker marker = markers[markerId]!;
    final Offset currentAnchor = marker.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);
    markers[markerId] = marker.copyWith(
      anchorParam: newAnchor,
    );
  }

  Future<void> _changeInfoAnchor(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final Offset currentAnchor = marker.infoWindow.anchor;
    final Offset newAnchor = Offset(1.0 - currentAnchor.dy, currentAnchor.dx);

    markers[markerId] = marker.copyWith(
      infoWindowParam: marker.infoWindow.copyWith(
        anchorParam: newAnchor,
      ),
    );
  }

  Future<void> _toggleDraggable(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;

    markers[markerId] = marker.copyWith(
      draggableParam: !marker.draggable,
    );
  }

  Future<void> _toggleFlat(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;

    markers[markerId] = marker.copyWith(
      flatParam: !marker.flat,
    );
  }

  Future<void> _changeInfo(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final String newSnippet = '${marker.infoWindow.snippet!}*';

    markers[markerId] = marker.copyWith(
      infoWindowParam: marker.infoWindow.copyWith(
        snippetParam: newSnippet,
      ),
    );
  }

  Future<void> _changeAlpha(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final double current = marker.alpha;

    markers[markerId] = marker.copyWith(
      alphaParam: current < 0.1 ? 1.0 : current * 0.75,
    );
  }

  Future<void> _changeRotation(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final double current = marker.rotation;

    markers[markerId] = marker.copyWith(
      rotationParam: current == 330.0 ? 0.0 : current + 30.0,
    );
  }

  Future<void> _toggleVisible(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;

    markers[markerId] = marker.copyWith(
      visibleParam: !marker.visible,
    );
  }

  Future<void> _changeZIndex(MarkerId markerId) async {
    final Marker marker = markers[markerId]!;
    final double current = marker.zIndex;

    markers[markerId] = marker.copyWith(
      zIndexParam: current == 12.0 ? 0.0 : current + 1.0,
    );
  }

  void _setMarkerIcon(MarkerId markerId, BitmapDescriptor assetIcon) {
    final Marker marker = markers[markerId]!;

    markers[markerId] = marker.copyWith(
      iconParam: assetIcon,
    );
  }

  Future<BitmapDescriptor> _getAssetIcon(BuildContext context) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config = createLocalImageConfiguration(context);

    const AssetImage('assets/red_square.png')
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      if (bytes == null) {
        bitmapIcon.completeError(Exception('Unable to encode icon'));
        return;
      }
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }

  @override
  Widget build(BuildContext context) {
    final MarkerId? selectedId = selectedMarker;
    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              markers: Set<Marker>.of(markers.values),
              mapType: MapType.hybrid,
              onCameraMoveStarted: () {
                CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(latitude1, longitude2),
                  zoom: 14.4746,
                ));
              },
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude1, longitude2),
                zoom: 14.4746,
              ),
              onMapCreated: onMapCreated,
              //markers: Set<Marker>.of(markers.values),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  add(context);
                },
                child: const Text('Add'),
              ),
              TextButton(
                onPressed:
                    selectedId == null ? null : () => _remove(selectedId),
                child: const Text('Remove'),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed:
                    selectedId == null ? null : () => _changeInfo(selectedId),
                child: const Text('change info'),
              ),
              TextButton(
                onPressed: selectedId == null
                    ? null
                    : () => _changeInfoAnchor(selectedId),
                child: const Text('change info anchor'),
              ),
              TextButton(
                onPressed:
                    selectedId == null ? null : () => _changeAlpha(selectedId),
                child: const Text('change alpha'),
              ),
              TextButton(
                onPressed:
                    selectedId == null ? null : () => _changeAnchor(selectedId),
                child: const Text('change anchor'),
              ),
              TextButton(
                onPressed: selectedId == null
                    ? null
                    : () => _toggleDraggable(selectedId),
                child: const Text('toggle draggable'),
              ),
              TextButton(
                onPressed:
                    selectedId == null ? null : () => _toggleFlat(selectedId),
                child: const Text('toggle flat'),
              ),
              TextButton(
                onPressed: selectedId == null
                    ? null
                    : () => _changePosition(selectedId),
                child: const Text('change position'),
              ),
              TextButton(
                onPressed: selectedId == null
                    ? null
                    : () => _changeRotation(selectedId),
                child: const Text('change rotation'),
              ),
              TextButton(
                onPressed: selectedId == null
                    ? null
                    : () => _toggleVisible(selectedId),
                child: const Text('toggle visible'),
              ),
              TextButton(
                onPressed:
                    selectedId == null ? null : () => _changeZIndex(selectedId),
                child: const Text('change zIndex'),
              ),
              TextButton(
                onPressed: selectedId == null
                    ? null
                    : () {
                        _getAssetIcon(context).then(
                          (BitmapDescriptor icon) {
                            _setMarkerIcon(selectedId, icon);
                          },
                        );
                      },
                child: const Text('set marker icon'),
              ),
            ],
          ),
        ],
      ),
      Visibility(
        visible: markerPosition != null,
        child: Container(
          color: Colors.white70,
          height: 30,
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if (markerPosition == null)
                Container()
              else
                Expanded(child: Text('lat: ${markerPosition!.latitude}')),
              if (markerPosition == null)
                Container()
              else
                Expanded(child: Text('lng: ${markerPosition!.longitude}')),
            ],
          ),
        ),
      ),
    ]);
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
