import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add fl_chart to your pubspec.yaml

class ProfileView extends StatelessWidget {
  //final String username;
  //final String profileImageUrl;

  const ProfileView({super.key}/*{super.key, required this.username, required this.profileImageUrl}*/);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            CircleAvatar(
              radius: 50,
              //backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(height: 16),
            Text(
              //"Welcome back, $username!",
              "Welcome back, User!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text("Activity Breakdown", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            SizedBox(
              height:300,
              child: PieChart(
                PieChartData(
                  sections: pieChartSection(),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            _buildActionButton(context, "Change Nickname", Icons.edit, () {/* TODO */}),
            _buildActionButton(context, "Change Password", Icons.lock, () {/* TODO */}),
            _buildActionButton(context, "Delete Account", Icons.delete_forever, () {/* TODO */}, color: Colors.red),
          ],
        ),
      ),

    );
  }

  List<PieChartSectionData> pieChartSection(){

    List<Color> sectionColours = [
        Colors.orange,
        Colors.yellow,
        Colors.blue,
        Colors.green,
        Colors.pinkAccent,
    ];

    return List.generate(
      5,
      (index){
        double value = (index + 1) * 10;
        final radius = 100.0;
        return PieChartSectionData(
          color: sectionColours[index],
          value: value,
          title: '$value%',  
          radius: radius,
        );
      } 
    );
  }

  // Button with press animation  
  Widget _buildActionButton(BuildContext context, String label, IconData icon, VoidCallback onPressed, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

}
