// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:url_launcher/url_launcher.dart';

// class MapsPage extends StatefulWidget {
//   final String address;

//   const MapsPage({super.key, required this.address});

//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   double? latitude;
//   double? longitude;
//   bool isError = false; 

//   @override
//   void initState() {
//     super.initState();
//     _getLatLngFromAddress(widget.address);
//   }

//   Future<void> _getLatLngFromAddress(String address) async {
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         setState(() {
//           latitude = locations.first.latitude;
//           longitude = locations.first.longitude;
//           isError = false;
//         });
//       } else {
//         _showError('Tidak ditemukan lokasi untuk alamat: $address');
//       }
//     } catch (e) {
//       _showError('Gagal mendapatkan lokasi untuk alamat "$address": $e');
//     }
//   }

//   void _showError(String message) {
//     setState(() {
//       print('Latitude: $latitude, Longitude: $longitude'); // Debugging

//       isError = true;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: GoogleFonts.poppins(fontSize: 14)),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   Future<void> openInGoogleMaps() async {
//     if (latitude != null && longitude != null) {
//       final googleMapsUrl =
//           'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
//       if (await canLaunch(googleMapsUrl)) {
//         await launch(googleMapsUrl);
//       } else {
//         _showError('Tidak dapat membuka Google Maps.');
//       }
//     } else {
//       _showError('Lokasi tidak tersedia untuk ditampilkan di Google Maps.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'OpenStreetMap',
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.blue),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.map, color: Colors.blue),
//             onPressed: openInGoogleMaps,
//             tooltip: 'Buka di Google Maps',
//           ),
//         ],
//       ),
//       body: isError
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Alamat tidak ditemukan.',
//                     style: GoogleFonts.poppins(
//                       fontSize: 16,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() => isError = false);
//                       _getLatLngFromAddress(widget.address);
//                     },
//                     child: Text(
//                       'Coba Lagi',
//                       style: GoogleFonts.poppins(fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : latitude != null && longitude != null
//               ? FlutterMap(
//                   options: MapOptions(
//                     center: LatLng(latitude!, longitude!),
//                     zoom: 17.0,
//                   ),
//                   children: [
//                     TileLayer(
//                       urlTemplate:
//                           'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                       subdomains: const ['a', 'b', 'c'],
//                     ),
//                     MarkerLayer(
//                       markers: [
//                         Marker(
//                           point: LatLng(latitude!, longitude!),
//                           width: 80.0,
//                           height: 80.0,
//                           builder: (context) => const Icon(
//                             Icons.location_on,
//                             color: Colors.red,
//                             size: 40.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               : const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MapsPage extends StatefulWidget {
//   final String address;

//   const MapsPage({super.key, required this.address});

//   @override
//   _MapsPageState createState() => _MapsPageState();
// }

// class _MapsPageState extends State<MapsPage> {
//   double? destinationLatitude;
//   double? destinationLongitude;
//   LatLng? userLocation;
//   List<LatLng> routePoints = [];

//   @override
//   void initState() {
//     super.initState();
//     _getLatLngFromAddress(widget.address);
//     _getUserLocation();
//   }

//   Future<void> _getLatLngFromAddress(String address) async {
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       setState(() {
//         destinationLatitude = locations.first.latitude;
//         destinationLongitude = locations.first.longitude;
//       });
//       if (userLocation != null &&
//           destinationLatitude != null &&
//           destinationLongitude != null) {
//         _getRoute(
//             userLocation!, LatLng(destinationLatitude!, destinationLongitude!));
//       }
//     } catch (e) {
//       print('Error fetching location: $e');
//     }
//   }

//   Future<void> _getUserLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Cek apakah layanan lokasi diaktifkan
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Jika layanan lokasi tidak aktif, beri tahu pengguna
//       print('Location services are disabled.');
//       return;
//     }

//     // Cek izin lokasi
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Jika izin lokasi ditolak
//         print('Location permissions are denied');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Izin lokasi ditolak secara permanen
//       print(
//           'Location permissions are permanently denied, we cannot request permissions.');
//       return;
//     }

//     // Dapatkan lokasi pengguna
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       userLocation = LatLng(position.latitude, position.longitude);
//     });
//   }

//   Future<void> _getRoute(LatLng start, LatLng end) async {
//     try {
//       final url = 'https://router.project-osrm.org/route/v1/driving/'
//           '${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson';

//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List coordinates = data['routes'][0]['geometry']['coordinates'];

//         setState(() {
//           routePoints = coordinates.map((coord) {
//             return LatLng(coord[1], coord[0]);
//           }).toList();
//         });
//       } else {
//         print('Failed to get route');
//       }
//     } catch (e) {
//       print('Error fetching route: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'OpenStreetMap',
//           style: GoogleFonts.poppins(
//             textStyle: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.blue),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: destinationLatitude != null &&
//               destinationLongitude != null &&
//               userLocation != null
//           ? FlutterMap(
//               options: MapOptions(
//                 center: userLocation,
//                 zoom: 13.0,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 MarkerLayer(
//                   markers: [
//                     Marker(
//                       point: userLocation!,
//                       builder: (ctx) => const Icon(
//                         Icons.location_on,
//                         color: Colors.blue,
//                         size: 40.0,
//                       ),
//                     ),
//                     Marker(
//                       point:
//                           LatLng(destinationLatitude!, destinationLongitude!),
//                       builder: (ctx) => const Icon(
//                         Icons.location_on,
//                         color: Colors.red,
//                         size: 40.0,
//                       ),
//                     ),
//                   ],
//                 ),
//                 PolylineLayer(
//                   polylines: [
//                     Polyline(
//                       points: routePoints,
//                       strokeWidth: 4.0,
//                       color: Colors.blue,
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           : const Center(
//               child:
//                   CircularProgressIndicator()), // Show loading while fetching data
//     );
//   }
// }
