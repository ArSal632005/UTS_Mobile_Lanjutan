import 'package:flutter/material.dart';
import 'payment.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  bool saveAddress = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? selectedCountry;

  final List<String> countries = [
    'Indonesia',
    'Malaysia',
    'Singapore',
    'Thailand',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Shipping Address',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Step Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepCircle(1, true),
                _buildLine(),
                _buildStepCircle(2, true),
                _buildLine(),
                _buildStepCircle(3, false),
              ],
            ),
            const SizedBox(height: 30),

            Column(
              children: [
                _buildInputField(Icons.person_outline, 'Name', nameController),
                const SizedBox(height: 15),
                _buildInputField(
                    Icons.email_outlined, 'Email address', emailController),
                const SizedBox(height: 15),
                _buildInputField(
                    Icons.phone_outlined, 'Phone number', phoneController),
                const SizedBox(height: 15),
                _buildInputField(Icons.home_outlined, 'Address', addressController),
                const SizedBox(height: 15),
                _buildInputField(Icons.local_post_office_outlined, 'Zip code', zipController),
                const SizedBox(height: 15),
                _buildInputField(Icons.location_city_outlined, 'City', cityController),
                const SizedBox(height: 15),
                _buildDropdownField(),
                const SizedBox(height: 20),

                // Save toggle
                Row(
                  children: [
                    Switch(
                      value: saveAddress,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          saveAddress = value;
                        });
                      },
                    ),
                    const Text(
                      'Save this address',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Langsung ke halaman payment tanpa validasi
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentMethodPage(),
                ),
              );
            },
            child: const Text(
              'Next',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,
              color: Colors.white,),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      IconData icon, String hint, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCountry,
        hint: const Text('Country'),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.public_outlined, color: Colors.grey),
        ),
        items: countries.map((country) {
          return DropdownMenuItem(value: country, child: Text(country));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCountry = value;
          });
        },
      ),
    );
  }

  Widget _buildStepCircle(int step, bool active) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.white,
        border: Border.all(color: active ? Colors.green : Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      width: 40,
      height: 2,
      color: Colors.green.withOpacity(0.4),
    );
  }
}
