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
  String status; // 'pending', 'completed', or 'canceled'

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

  // Helper to check if booking is completed
  bool get isCompleted => status == 'completed';

  // Helper to check if booking is canceled
  bool get isCanceled => status == 'canceled';
}

// Singleton class to manage bookings throughout the app
class BookingHistoryData {
  BookingHistoryData._privateConstructor();

  static final BookingHistoryData instance =
      BookingHistoryData._privateConstructor();

  final List<Booking> _bookings = [];

  // Bookings that are still pending
  List<Booking> get upcomingBookings =>
      _bookings.where((b) => b.status == 'pending').toList();

  // Bookings that are either completed or canceled
  List<Booking> get pastBookings =>
      _bookings.where((b) => b.status != 'pending').toList();

  // Add a new booking
  void addBooking(Booking booking) {
    _bookings.add(booking);
  }

  // Mark a booking as completed
  void markCompleted(Booking booking) {
    final index = _bookings.indexOf(booking);
    if (index != -1) {
      _bookings[index].status = 'completed';
    }
  }

  // Cancel a booking
  void cancelBooking(Booking booking) {
    final index = _bookings.indexOf(booking);
    if (index != -1) {
      _bookings[index].status = 'canceled';
    }
  }
}
