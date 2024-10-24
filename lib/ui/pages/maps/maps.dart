// import 'package:driver/ui/pages/home/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:latlong2/latlong.dart';

// class MapsPage extends StatelessWidget {
//   final double latitude;
//   final double longitude;

//   const MapsPage(
//       {super.key,
//       required this.latitude,
//       required this.longitude,
//       required String address});

//   @override
//   Widget build(BuildContext context) {
//     print('Latitude: $latitude, Longitude: $longitude');

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
//             final homeState = context.findAncestorStateOfType<HomeState>();
//             homeState?.onItemTapped(0);
//           },
//         ),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(
//               latitude, longitude), // Set map center to the given coordinates
//           zoom: 13.0,
//         ),
//         children: [ 
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 width: 80.0,
//                 height: 80.0,
//                 point: LatLng(latitude ?? 0.0,
//                     longitude ?? 0.0), // Use default 0.0 if null
//                 builder: (ctx) => const Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                   size: 40.0,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
