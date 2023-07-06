import 'package:favorite_places_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../constants/app_constant.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: Hero(
        tag: 'map',
        child: FlutterMap(
          options: MapOptions(
            minZoom: 5,
            maxZoom: 18,
            zoom: 13,
            center: LatLng(widget.location.latitude, widget.location.longitude),
            onTap: !widget.isSelecting
                ? null
                : (tapPosition, point) {
                    setState(() {
                      _pickedLocation = point;
                    });
                  },
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/mowgle/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
              additionalOptions: const {
                'mapStyleId': AppConstants.mapBoxStyleId,
                'accessToken': AppConstants.mapBoxAccessToken,
              },
            ),
            MarkerLayer(
              markers: (_pickedLocation == null && widget.isSelecting)
                  ? []
                  : [
                      Marker(
                        point: _pickedLocation ??
                            LatLng(widget.location.latitude,
                                widget.location.longitude),
                        builder: (ctx) => const Icon(Icons.location_on_rounded,
                            color: Colors.red),
                      )
                    ],
            )
          ],
        ),
      ),
    );
  }
}
