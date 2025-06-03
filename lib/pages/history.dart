import 'package:flutter/material.dart';
import 'booking_data.dart'; // Import your Booking model and booking data management

// This widget displays the booking history with two tabs: Upcoming and Past bookings.
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Initialize TabController for switching between Upcoming and Past tabs
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Dispose the controller when widget is removed to free resources
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Builds a ListView for displaying a list of bookings
  Widget _buildBookingList(List<Booking> bookings) {
    // If there are no bookings, show a friendly message
    if (bookings.isEmpty) {
      return const Center(
        child: Text('No bookings found.', style: TextStyle(fontSize: 18)),
      );
    }

    // Otherwise, show a list of bookings
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return ListTile(
          // Icon indicating if booking is completed or pending
          leading: Icon(
            booking.isCompleted ? Icons.check_circle : Icons.pending_actions,
            color: booking.isCompleted ? Colors.green : Colors.orange,
          ),

          // Show service name as the title
          title: Text(booking.serviceName),

          // Show date and time in subtitle, formatted properly
          subtitle: Text(
            '${booking.date.toLocal().toString().split(' ')[0]} at ${booking.time.format(context)}',
          ),

          // If booking is not completed, show a "Mark Done" button
          trailing: booking.isCompleted
              ? null
              : ElevatedButton(
                  child: const Text('Mark Done'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 217, 124, 18),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      // Mark the booking as completed using your BookingHistoryData singleton
                      BookingHistoryData.instance.markCompleted(booking);
                    });
                  },
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the singleton instance managing bookings
    final bookingData = BookingHistoryData.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History', textAlign: TextAlign.center),
        backgroundColor: const Color.fromARGB(255, 217, 124, 18),

        // TabBar for Upcoming and Past bookings
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Disable back button
      ),

      // TabBarView shows the content for each tab
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(
            bookingData.upcomingBookings,
          ), // Upcoming bookings list
          _buildBookingList(bookingData.pastBookings), // Past bookings list
        ],
      ),
    );
  }
}
