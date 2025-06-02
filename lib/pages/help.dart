import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  final String location = '123 CleanPro Street, Beirut, Lebanon';
  final String phone = '+961 12345678';
  final String instagram = '@cleanpro_lb';
  final String facebook = 'facebook.com/cleanprolb';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Color(0xFF6C63FF),
                ),
                title: const Text('Location'),
                subtitle: Text(location),
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Color(0xFF6C63FF)),
                title: const Text('Phone'),
                subtitle: Text(phone),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  color: Color(0xFF6C63FF),
                ),
                title: const Text('Instagram'),
                subtitle: Text(instagram),
              ),
              ListTile(
                leading: const Icon(Icons.facebook, color: Color(0xFF6C63FF)),
                title: const Text('Facebook'),
                subtitle: Text(facebook),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
