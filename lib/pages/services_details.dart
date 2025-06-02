import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceName;
  final String description;
  final List<String> features;

  ServiceDetailScreen({super.key, required this.serviceName})
    : description = _getDescription(serviceName),
      features = _getFeatures(serviceName);

  static String _getDescription(String name) {
    switch (name) {
      case 'Deep Cleaning':
        return 'Revitalize your space with our thorough deep clean. We tackle dirt and allergens hidden in every corner.';
      case 'Carpet & Furniture Cleaning':
        return 'Remove stains and odors with professional steam cleaning for carpets and upholstery.';
      case 'Window Cleaning':
        return 'Crystal-clear, streak-free windows inside and out. Safe for all window types and heights.';
      case 'Solar Panels Cleaning':
        return 'Maintain efficiency with dust-free solar panels. We clean using safe, non-abrasive tools.';
      case 'House Keeping':
        return 'Scheduled clean-ups to keep your home tidy and stress-free. Great for routine care.';
      case 'Sterilization':
        return 'High-grade sterilization using safe disinfectants. Perfect for clinics and high-risk zones.';
      case 'Pest Control':
        return 'Eliminate pests safely and effectively with our eco-conscious pest management system.';
      case 'Stewarding':
        return 'Complete dish washing and hygiene services for commercial kitchens and events.';
      case 'Professional Training':
        return 'Train your staff with industry-standard cleaning techniques and safety practices.';
      case 'Products, Tools & Equipment':
        return 'We supply pro-grade tools and products to meet your cleaning needs.';
      default:
        return 'Service description coming soon.';
    }
  }

  static List<String> _getFeatures(String name) {
    switch (name) {
      case 'Deep Cleaning':
        return [
          'Full-room dusting & vacuuming',
          'Tile and grout scrubbing',
          'Bathroom and kitchen sanitization',
          'Baseboard and window sill cleaning',
          'High-reach dust removal',
        ];
      case 'Carpet & Furniture Cleaning':
        return [
          'Stain treatment',
          'Hot water extraction',
          'Upholstery deodorization',
          'Quick-dry system',
          'Eco-safe materials',
        ];
      case 'Window Cleaning':
        return [
          'Streak-free finish',
          'Screen cleaning',
          'Exterior and interior glass',
          'Sunroof and skylight service',
          'High-reach equipment used',
        ];
      case 'Solar Panels Cleaning':
        return [
          'Deionized water rinse',
          'Dust and debris removal',
          'Non-abrasive tools',
          'Panel surface inspection',
          'Boost performance',
        ];
      case 'House Keeping':
        return [
          'Daily/weekly scheduling',
          'Vacuum & mopping floors',
          'Trash removal',
          'Linen replacement',
          'Bathroom touch-ups',
        ];
      case 'Sterilization':
        return [
          'Electrostatic fogging',
          'Touch point disinfection',
          'Safe disinfectants',
          'Certified service',
          'Airborne pathogen control',
        ];
      case 'Pest Control':
        return [
          'On-site pest inspection',
          'Eco-safe sprays',
          'Rodent proofing',
          'Traps and repellents',
          'Regular maintenance',
        ];
      case 'Stewarding':
        return [
          'Dish & utensil cleaning',
          'Waste sorting',
          'Surface sanitation',
          'Commercial kitchen hygiene',
          'Event support',
        ];
      case 'Professional Training':
        return [
          'OSHA-compliant modules',
          'Chemical safety',
          'Equipment handling',
          'Efficiency training',
          'Certification provided',
        ];
      case 'Products, Tools & Equipment':
        return [
          'Microfiber mops & towels',
          'Heavy-duty vacuums',
          'Eco-friendly chemicals',
          'Safety gear',
          'Scrub tools',
        ];
      default:
        return ['Feature list coming soon.'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        backgroundColor: Color(0xFF6C63FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(description, style: TextStyle(fontSize: 16, height: 1.5)),
            SizedBox(height: 20),
            Text(
              'Features:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...features.map(
              (feature) => ListTile(
                leading: Icon(Icons.check, color: Color(0xFF6C63FF)),
                title: Text(feature),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
