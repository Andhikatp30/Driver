// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class MapsPage extends StatefulWidget {
//   const MapsPage({Key? key}) : super(key: key);

//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   late GoogleMapController mapController;
//   final LatLng _initialPosition = const LatLng(-6.200000, 106.816666); // Koordinat pusat Jakarta
//   Set<Marker> _markers = {};
//   late Position _currentPosition;
//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Memeriksa apakah layanan lokasi diaktifkan
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() {
//         _loading = false;
//       });
//       return Future.error('Layanan lokasi tidak aktif.');
//     }

//     // Memeriksa izin lokasi
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           _loading = false;
//         });
//         return Future.error('Izin lokasi ditolak.');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         _loading = false;
//       });
//       return Future.error('Izin lokasi ditolak selamanya.');
//     }

//     // Mendapatkan posisi saat ini
//     _currentPosition = await Geolocator.getCurrentPosition();
//     setState(() {
//       _loading = false;
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('currentLocation'),
//           position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
//           infoWindow: const InfoWindow(
//             title: 'Posisi Anda Saat Ini',
//           ),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//         ),
//       );

//       mapController.animateCamera(
//         CameraUpdate.newLatLngZoom(
//           LatLng(_currentPosition.latitude, _currentPosition.longitude),
//           15.0,
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Peta Lokasi'),
//         backgroundColor: Colors.teal,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _getCurrentLocation,
//           ),
//         ],
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _initialPosition,
//                 zoom: 11.0,
//               ),
//               markers: _markers,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false, // Menghilangkan tombol lokasi default Google Maps
//               compassEnabled: true,
//               mapType: MapType.normal,
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCurrentLocation,
//         backgroundColor: Colors.teal,
//         child: const Icon(Icons.my_location),
//       ),
//     );
//   }
// }
