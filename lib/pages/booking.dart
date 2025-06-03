import 'package:flutter/material.dart';
import 'booking_data.dart';
import 'home.dart';

class BookingScreen extends StatefulWidget {
  final String serviceName;
  final double price;

  const BookingScreen({
    super.key,
    required this.serviceName,
    required this.price,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: const Color.fromARGB(255, 217, 124, 18),
            onPrimary: Colors.black,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 217, 124, 18),
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: const Color.fromARGB(255, 217, 124, 18),
            onPrimary: Colors.black,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 217, 124, 18),
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select date and time')),
        );
        return;
      }

      final newBooking = Booking(
        serviceName: widget.serviceName,
        price: widget.price,
        customerName: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        date: _selectedDate!,
        time: _selectedTime!,
        status: 'pending',
      );

      BookingHistoryData.instance.addBooking(newBooking);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Booking confirmed for ${widget.serviceName} on ${_selectedDate!.toLocal().toString().split(' ')[0]} at ${_selectedTime!.format(context)}',
          ),
          backgroundColor: const Color.fromARGB(255, 217, 124, 18),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MainScreen(initialIndex: 2)),
        (route) => false,
      );
    }
  }

  InputDecoration _inputDecoration(IconData icon, String label) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 217, 124, 18)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 217, 124, 18),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return const TextStyle(
                color: Color.fromARGB(255, 217, 124, 18), // Orange on hover
              );
            }
            if (states.contains(MaterialState.focused)) {
              return const TextStyle(
                color: Color.fromARGB(255, 217, 124, 18), // Orange on focus
              );
            }
            return const TextStyle(
              color: Colors.black, // Default label color
            );
          }),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Book: ${widget.serviceName}'),
          backgroundColor: const Color.fromARGB(255, 217, 124, 18),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Price: \$${widget.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 217, 124, 18),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration(Icons.person, 'Full Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: _inputDecoration(Icons.phone, 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter phone' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  decoration: _inputDecoration(Icons.home, 'Address'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter address' : null,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Color.fromARGB(255, 217, 124, 18),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _selectedDate == null
                              ? 'Choose Date'
                              : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _pickTime,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Color.fromARGB(255, 217, 124, 18),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _selectedTime == null
                              ? 'Choose Time'
                              : 'Time: ${_selectedTime!.format(context)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 217, 124, 18),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
