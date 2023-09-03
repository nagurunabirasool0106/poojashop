import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

const Color darkBlue = Color(0xFF12202F);

class NavBar extends StatelessWidget {
  final String imagePath;
  final bool isEdit;

  const NavBar({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
  }) : super(key: key);

  Future<User?> _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<User?>(
        future: _getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          if (snapshot.hasData) {
            final user = snapshot.data!;
            final username = user.displayName ?? "User";
            final email = user.email ?? "No Email";

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.pink),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 30,
                            bottom: 10,
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('./images/sampleProfile.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.person_2_outlined),
                  title: Text('Profile'),
                  selectedColor: Colors.amber,
                  selectedTileColor: Colors.amber,
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                const ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Logout'),
                )
              ],
            );
          } else {
            return const Text("Not Logged In");
          }
        },
      ),
    );
  }
}
