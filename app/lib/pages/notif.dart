import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool allowNotifications = true;
  bool emailNotifications = false;
  bool orderNotifications = false;
  bool generalNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSwitchTile(
              "Allow Notifications",
              "Lorem ipsum dolor sit amet, consectetur sadi pscing elitr, sed diam nonumym",
              allowNotifications,
              (val) => setState(() => allowNotifications = val),
            ),
            _buildSwitchTile(
              "Email Notifications",
              "Lorem ipsum dolor sit amet, consectetur sadi pscing elitr, sed diam nonumym",
              emailNotifications,
              (val) => setState(() => emailNotifications = val),
            ),
            _buildSwitchTile(
              "Order Notifications",
              "Lorem ipsum dolor sit amet, consectetur sadi pscing elitr, sed diam nonumym",
              orderNotifications,
              (val) => setState(() => orderNotifications = val),
            ),
            _buildSwitchTile(
              "General Notifications",
              "Lorem ipsum dolor sit amet, consectetur sadi pscing elitr, sed diam nonumym",
              generalNotifications,
              (val) => setState(() => generalNotifications = val),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text("Save settings"),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: const Color.fromARGB(31, 4, 134, 43), blurRadius: 4)],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green, // << warna hijau aktif
        ),
      ],
    ),
  );
}

}
