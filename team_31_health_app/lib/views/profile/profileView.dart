import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add fl_chart to your pubspec.yaml

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}


class _ProfileViewState extends State<ProfileView> {
  List<Map<String, Object>> activityData = [
    {'label': 'Give', 'value':10.0, 'colour': Colors.orange},
    {'label': 'Take Notice', 'value':10.0, 'colour': Colors.yellow},
    {'label': 'Keep Learning', 'value':10.0, 'colour': Colors.blue},
    {'label': 'Connect', 'value':10.0, 'colour': Colors.purple},
    {'label': 'Be Active', 'value':10.0, 'colour': Colors.pinkAccent},
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total to be used in percentage calculation
    double total = 0.0;
    for (var item in activityData){
      total += item['value'] as double;
    }

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
              //backgroundImage:
            ),
            const SizedBox(height: 16),
            Text(
              "Welcome back, John!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),
            const Text("Activity Breakdown", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            
            _buildActivityChart(total),
            
            const SizedBox(height: 32),
            _buildActionButton(context, "Change Nickname", Icons.edit, () {/* TODO */}),
            _buildActionButton(context, "Change Password", Icons.lock, () {/* TODO */}),
            _buildActionButton(context, "Delete Account", Icons.delete_forever, () {/* TODO */}, color: Colors.red),


            // Demo buttons
            const SizedBox(height: 10),
            Text(
              "Demo Buttons",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildActionButton(context, "+Give", Icons.handshake, () {_incrementActivity(0);}, color: Colors.orange),
            _buildActionButton(context, "+Take Notice", Icons.lens, () {_incrementActivity(1);}, color: Colors.yellow),
            _buildActionButton(context, "+Keep Learning", Icons.book, () {_incrementActivity(2);}, color: Colors.blue),
            _buildActionButton(context, "+Connect", Icons.link, () {_incrementActivity(3);}, color: Colors.purple),
            _buildActionButton(context, "+Be Active", Icons.man, () {_incrementActivity(4);}, color: Colors.pinkAccent),
          ],
        ),
      ),
    );
  }

  
  

  Widget _buildActivityChart(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: Stack (children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
            ),
            PieChart(
              PieChartData(
                // Mapping the activities to the pie chart
                sections: activityData.map((d) {
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
          ],),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: activityData.asMap().entries.map((entry) {
            final data = entry.value;
            final value = data['value'] as double;
            final percentage = ((value/total)*100).toStringAsFixed(1); // 1 dec. place
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
                  // Print out percentage for the given segment
                  Text(
                    "${data['label']}: $percentage%",
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

  void _incrementActivity(int index){
    setState(() {
      activityData[index]['value'] = (activityData[index]['value'] as double) + 5.0;
    });
  }

}
