import 'package:flutter/material.dart';
import 'account.dart';
import 'help.dart';
import 'services_details.dart';
import 'login.dart';
import 'history.dart'; // Import history.dart here

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String? _loggedInEmail;

  final List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions.addAll([
      const HomeScreen(),
      const ServicesScreen(),
      Container(), // Placeholder for Account (will be replaced when logged in)
      const HelpScreen(),
      const HistoryScreen(), // Add History screen here
    ]);
  }

  void _onItemTapped(int index) async {
    if (index == 2) {
      // Account requires login
      final result = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      if (result != null && result.contains('@')) {
        setState(() {
          _loggedInEmail = result;
          _selectedIndex = 2;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 2
          ? AccountScreen(initialEmail: _loggedInEmail ?? '')
          : _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 217, 124, 18),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.cleaning_services),
            label: 'Services',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ), // Added History here
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cleaning_services_rounded,
              size: 100,
              color: Color.fromARGB(255, 217, 124, 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to CleanPro!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 217, 124, 18),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your trusted partner in professional cleaning services.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  final List<Map<String, dynamic>> services = const [
    {'name': 'Deep Cleaning', 'icon': Icons.cleaning_services},
    {'name': 'Carpet & Furniture Cleaning', 'icon': Icons.event_seat},
    {'name': 'Window Cleaning', 'icon': Icons.window},
    {'name': 'Solar Panels Cleaning', 'icon': Icons.solar_power},
    {'name': 'House Keeping', 'icon': Icons.house},
    {'name': 'Sterilization', 'icon': Icons.local_hospital},
    {'name': 'Pest Control', 'icon': Icons.bug_report},
    {'name': 'Stewarding', 'icon': Icons.room_service},
    {'name': 'Professional Training', 'icon': Icons.school},
    {'name': 'Products, Tools & Equipment', 'icon': Icons.build},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // disables the back arrow
        backgroundColor: const Color.fromARGB(255, 217, 124, 18),
        centerTitle: true, // centers the title
        title: const Text('Our Services'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(
                  255,
                  217,
                  124,
                  18,
                ).withOpacity(0.1),
                child: Icon(
                  service['icon'],
                  color: const Color.fromARGB(255, 217, 124, 18),
                ),
              ),
              title: Text(
                service['name'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ServiceDetailScreen(serviceName: service['name']),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 217, 124, 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
