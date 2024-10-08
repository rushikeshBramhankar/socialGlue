import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final String firstName;
  final String lastName;

  MenuPage({required this.firstName, required this.lastName});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background for Menu Slide Animation
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Arrow Button
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  SizedBox(height: 20),

                  // // Profile Picture with + Symbol
                  // Center(
                  //   child: Stack(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 50,
                  //         backgroundImage: AssetImage(
                  //             // 'assets/profile_placeholder.png'), // Placeholder image for profile
                  //       ),
                  //       Positioned(
                  //         bottom: 0,
                  //         right: 0,
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             // Function to change profile picture
                  //             _changeProfilePicture();
                  //           },
                  //           child: Container(
                  //             height: 30,
                  //             width: 30,
                  //             decoration: BoxDecoration(
                  //               color: Colors.blue,
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: Icon(Icons.add,
                  //                 color: Colors.white, size: 20),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: 10),

                  // Display User's First and Last Name
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "${widget.firstName} ${widget.lastName}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the Profile View Page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ViewProfilePage()),
                            );
                          },
                          child: Text(
                            "View Profile",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Menu Options
                  _buildMenuItem(Icons.document_scanner, "Evidence Vault", () {
                    // Navigate to Evidence Vault Page
                  }),
                  _buildMenuItem(Icons.contacts, "Emergency Contacts", () {
                    // Navigate to Emergency Contacts Page
                  }),
                  _buildMenuItem(Icons.help_outline, "How it Works", () {
                    // Navigate to How it Works Page
                  }),
                  _buildMenuItem(Icons.group_add, "Refer a Friend", () {
                    // Navigate to Refer a Friend Page
                  }),
                  _buildMenuItem(Icons.support_agent, "Customer Support", () {
                    // Navigate to Customer Support Page
                  }),

                  Spacer(),

                  // Terms of Use and Privacy Policy
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Navigate to Terms of Use
                          },
                          child: Text(
                            "Terms of Use",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to Privacy Policy
                          },
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Menu Item Widget
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  // Function to handle profile picture change
  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upload Profile Picture"),
          content: Text("Choose a picture from your gallery or camera."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle upload picture logic
              },
              child: Text("Gallery"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle camera picture logic
              },
              child: Text("Camera"),
            ),
          ],
        );
      },
    );
  }
}

// Dummy View Profile Page
class ViewProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Center(child: Text("This is the profile page")),
    );
  }
}
