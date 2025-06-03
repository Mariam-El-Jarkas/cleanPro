import 'package:flutter/material.dart';

// This class represents a booking entry with all details
class Booking {
  final String serviceName;
  final double price;
  final String customerName;
  final String phone;
  final String address;
  final DateTime date;
  final TimeOfDay time;
  String status; // Status: 'pending' or 'completed'

  Booking({
    required this.serviceName,
    required this.price,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.date,
    required this.time,
    this.status = 'pending',
  });

  // Helper property to quickly check if booking is completed
  bool get isCompleted => status == 'completed';
}

// Singleton class to manage bookings throughout the app
class BookingHistoryData {
  // Private constructor
  BookingHistoryData._privateConstructor();

  // Singleton instance
  static final BookingHistoryData instance =
      BookingHistoryData._privateConstructor();

  // Internal list of all bookings
  final List<Booking> _bookings = [];

  // Getter to return upcoming (pending) bookings only
  List<Booking> get upcomingBookings =>
      _bookings.where((booking) => !booking.isCompleted).toList();

  // Getter to return past (completed) bookings only
  List<Booking> get pastBookings =>
      _bookings.where((booking) => booking.isCompleted).toList();

  // Method to add a new booking
  void addBooking(Booking booking) {
    _bookings.add(booking);
  }

  // Method to mark a booking as completed
  void markCompleted(Booking booking) {
    final index = _bookings.indexOf(booking);
    if (index != -1) {
      _bookings[index].status = 'completed';
    }
  }
}
