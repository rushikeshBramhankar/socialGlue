import 'package:asthrax/homeScreen/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  final String userLastName; // Pass user lastname here

  HomePage({required this.userLastName});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(37.7749, -122.4194); // Example coordinates

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Google Map (covers half of the screen)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),

          // AstharaX logo and menu icon (overlaying the map)
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: [
                // AstharaX Logo
                Image.asset('assets/logo.png',
                    height: 40), // Add your AstharaX logo here

                SizedBox(width: 10),

                // Menu Icon
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.black, size: 30),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuPage(
                                  firstName: '',
                                  lastName: '',
                                )));
                  },
                ),
              ],
            ),
          ),

          // Greeting and Help Text
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 + 10,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${widget.userLastName}!", // Greeting the user
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Help is one tap away",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
          ),

          // Panic Button
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width * 0.3,
            child: GestureDetector(
              onTap: () {
                // Trigger emergency alert
                _sendEmergencyAlert();
              },
              child: Column(
                children: [
                  // Shield Icon (Panic Button)
                  Image.asset('assets/shield_icon.png',
                      height: 100), // Use shield image as panic button
                  SizedBox(height: 10),
                  Text(
                    "Panic Button",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Navigation (Timeframe and Community)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Timeframe Button (with calendar icon)
                  Column(
                    children: [
                      Icon(Icons.calendar_today, size: 30),
                      Text("Timeframe"),
                    ],
                  ),
                  // Community Button (with globe icon)
                  Column(
                    children: [
                      Icon(Icons.public, size: 30),
                      Text("Community"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to send an emergency alert
  void _sendEmergencyAlert() {
    // Trigger high-priority notification with sound to users within 500m
    // Share live location anonymously
    // Implement backend logic for alerting nearby users
  }
}
