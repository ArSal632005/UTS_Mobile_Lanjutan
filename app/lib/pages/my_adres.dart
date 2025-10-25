import 'package:flutter/material.dart';

class MyAddressPage extends StatefulWidget {
  const MyAddressPage({super.key});

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  bool isDefault = true;

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: "Russell Austin");
    final TextEditingController addressController = TextEditingController(
        text: "2811 Crescent Day, LA Port, California, United States 77571");
    final TextEditingController cityController = TextEditingController(text: "California");
    final TextEditingController zipController = TextEditingController(text: "77571");
    final TextEditingController phoneController = TextEditingController(text: "+1 202 555 0142");

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildAddressCard(
              isDefault: isDefault,
              name: "Russell Austin",
              address: "2811 Crescent Day. LA Port California, United States 77571",
              phone: "+1 202 555 0142",
              isExpanded: true,
              nameController: nameController,
              addressController: addressController,
              cityController: cityController,
              zipController: zipController,
              phoneController: phoneController,
            ),
            const SizedBox(height: 16),
            buildAddressCard(
              isDefault: false,
              name: "Jissca Simpson",
              address: "2811 Crescent Day. LA Port California, United States 77571",
              phone: "+1 202 555 0142",
              isExpanded: false,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6AB04A),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text(
                "Save settings",
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddressCard({
    required bool isDefault,
    required String name,
    required String address,
    required String phone,
    required bool isExpanded,
    TextEditingController? nameController,
    TextEditingController? addressController,
    TextEditingController? cityController,
    TextEditingController? zipController,
    TextEditingController? phoneController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDefault ? const Color(0xFF6AB04A) : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6AB04A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "DEFAULT",
                style: TextStyle(
                  color: Color(0xFF6AB04A),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
               
                radius: 20,
                child: Icon(Icons.location_on, color: Color(0xFF6AB04A)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(address, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    Text(phone, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
              if (isExpanded)
                const Icon(Icons.keyboard_arrow_up, color: Color(0xFF6AB04A))
              else
                const Icon(Icons.keyboard_arrow_down, color: Colors.black45),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 12),
            buildTextField(icon: Icons.person_outline, label: "Name", controller: nameController),
            const SizedBox(height: 8),
            buildTextField(icon: Icons.location_on_outlined, label: "Address", controller: addressController),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: buildTextField(icon: Icons.location_city, label: "City", controller: cityController)),
                const SizedBox(width: 8),
                Expanded(child: buildTextField(icon: Icons.local_post_office, label: "Zip code", controller: zipController)),
              ],
            ),
            const SizedBox(height: 8),
            buildTextField(icon: Icons.language, label: "Country", hint: "United States"),
            const SizedBox(height: 8),
            buildTextField(icon: Icons.phone, label: "Phone number", controller: phoneController),
            const SizedBox(height: 8),
            Row(
              children: [
                Switch(
                  activeColor: const Color(0xFF6AB04A),
                  value: isDefault,
                  onChanged: (val) {
                    setState(() {
                      isDefault = val;
                    });
                  },
                ),
                const Text("Make default", style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget buildTextField({
    required IconData icon,
    required String label,
    String? hint,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF8F9FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
