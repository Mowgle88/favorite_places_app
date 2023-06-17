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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(onPressed: () {}, icon: const Icon(Icons.save))
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          minZoom: 5,
          maxZoom: 18,
          zoom: 13,
          center: LatLng(widget.location.latitude, widget.location.longitude),
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
            markers: [
              Marker(
                point:
                    LatLng(widget.location.latitude, widget.location.longitude),
                builder: (ctx) =>
                    const Icon(Icons.location_on_rounded, color: Colors.red),
              )
            ],
          )
        ],
      ),
    );
  }
}
