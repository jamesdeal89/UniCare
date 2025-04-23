import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add fl_chart to your pubspec.yaml

class ProfileView extends StatelessWidget {
  //final String username;
  //final String profileImageUrl;

  const ProfileView({super.key}/*{super.key, required this.username, required this.profileImageUrl}*/);

  @override
  Widget build(BuildContext context) {
    final activityData = _getActivityData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Color.fromRGBO(16, 38, 59, 1),
      ),
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
            
            _buildActivityChart(activityData),
            
            const SizedBox(height: 32),
            _buildActionButton(context, "Change Nickname", Icons.edit, () {/* TODO */}),
            _buildActionButton(context, "Change Password", Icons.lock, () {/* TODO */}),
            _buildActionButton(context, "Delete Account", Icons.delete_forever, () {/* TODO */}, color: Colors.red),
          ],
        ),
      ),

    );
  }

  List<Map<String, Object>> _getActivityData(){
    return [
      {'label': 'Give', 'value':60.0, 'colour': Colors.orange},
      {'label': 'Take Notice', 'value':20.0, 'colour': Colors.yellow},
      {'label': 'Keep Learning', 'value':10.0, 'colour': Colors.blue},
      {'label': 'Connect', 'value':15.0, 'colour': Colors.purple},
      {'label': 'Be Active', 'value':50.0, 'colour': Colors.pinkAccent},
    ];
  }

  Widget _buildActivityChart(List<Map<String, Object>> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: PieChart(
            PieChartData(
              // Mapping the activities to the pie chart
              sections: data.map((d) {
                return PieChartSectionData(
                  value: d['value'] as double,
                  color: d['colour'] as Color,
                  radius: 100,
                  showTitle: false,
                );
              }).toList(),
              centerSpaceRadius: 0,
              sectionsSpace: 1,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.map((data) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data['colour'] as Color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${data['label']} - ${data['value']}%",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
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
