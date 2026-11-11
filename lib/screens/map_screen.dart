import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _position;   // null tant qu'on n'a pas la position
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPosition();   // lancé automatiquement à l'ouverture de l'écran
  }

  Future<void> _loadPosition() async {
    try {
      final pos = await LocationService.getCurrentPosition();
      setState(() => _position = LatLng(pos.latitude, pos.longitude));
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hôpitaux proches')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    if (_position == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return FlutterMap(
      options: MapOptions(
        initialCenter: _position!,
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.hopital_app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _position!,
              width: 40,
              height: 40,
              child: const Icon(Icons.person_pin_circle,
                  color: Colors.blue, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}