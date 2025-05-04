import 'package:fl_chart/fl_chart.dart'; // Add fl_chart to your pubspec.yaml
import 'package:flutter/material.dart';
import 'package:team_31_health_app/data/database/journalRepo.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.journalRepo});
  final JournalRepo journalRepo;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isImageEnlarged = false;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }


  late Future<List<Map<String, Object>>> activityData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activityData = getActivityData();
  }

  Future<List<Map<String, Object>>> getActivityData() async {
    try {
      int give = await widget.journalRepo.count(0);
      int takeNotice = await widget.journalRepo.count(1);
      int keepLearning = await widget.journalRepo.count(2);
      int connect = await widget.journalRepo.count(3);
      int beActive = await widget.journalRepo.count(4);

      List<Map<String, Object>> activityData = [
        {
          'label': 'Give',
          'value': give.toDouble(),
          'colour': Colors.orange
        },
        {
          'label': 'Take Notice',
          'value': takeNotice.toDouble(),
          'colour': Colors.yellow
        },
        {
          'label': 'Keep Learning',
          'value': keepLearning.toDouble(),
          'colour': Colors.blue
        },
        {
          'label': 'Connect',
          'value': connect.toDouble(),
          'colour': Colors.purple
        },
        {
          'label': 'Be Active',
          'value': beActive.toDouble(),
          'colour': Colors.pinkAccent
        },
      ];
      return activityData;
    } catch (e) {
      rethrow;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage;
    Widget? avatar;
    if(_profileImage != null){
      backgroundImage = FileImage(_profileImage!);
      avatar = null;
    } else {
      backgroundImage = AssetImage('assets/images/example_profile_pricture.jpg');
      avatar = Icon(Icons.add_a_photo, color: Colors.white70, size: 30);
    }

    return FutureBuilder(future: activityData, builder: (context, snapshot) {
      if(snapshot.connectionState != ConnectionState.done){
        return Text("Loading");
      }
      else if (snapshot.hasError || !snapshot.hasData){
        print(snapshot.hasError);
        return TextButton(
          onPressed: (){
            setState(() {
              activityData = getActivityData();
            });
          },
          child: Text("Retry")
        );
        
      } else {
        // Calculate total to be used in percentage calculation
        double total = 0.0;
        for (var item in snapshot.data!) {
          total += item['value'] as double;
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                    child: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          
                          // Profile picture
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isImageEnlarged = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: backgroundImage,
                              child: avatar,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.photo_library),
                            label: const Text("Change Profile Picture"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),


                          const SizedBox(height: 16),
                          Text(
                            "Hello John",
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 24),
                          const Text("Activity Breakdown", style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 16),

                          _buildActivityPieChart(total),

                          const SizedBox(height: 32),
                          _buildActionButton(context, "Change Nickname", Icons.edit, () {}, color: Colors.green),
                          _buildActionButton(context, "Change Profile Picture", Icons.photo, _pickImage, color: Colors.green),
                          // For the sake of the demo, these buttons are placeholders
                          _buildActionButton(context, "Change Password", Icons.lock, () {}, color: Colors.green),
                          _buildActionButton(context, "Delete Account", Icons.delete_forever, () {}, color: Colors.red),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    }
    });
  }

  Widget _buildActivityPieChart(double total) {
    return FutureBuilder(future: activityData,builder: (context, snapshot) {
      if(snapshot.connectionState != ConnectionState.done){
        return Text("Loading");
      }
      if (snapshot.hasError || !snapshot.hasData){
        setState(() {
          activityData = getActivityData();
        });
        return Text("Retrying");
      } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              children: [
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
                    sections: snapshot.data!.map((d) {
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
              ],
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: snapshot.data!.asMap().entries.map((entry) {
              final data = entry.value;
              final value = data['value'] as double;
              final percentage = ((value / total) * 100).toStringAsFixed(1); // Calculate percentage to 1 d.p.
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
    }});
  
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
