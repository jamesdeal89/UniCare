import 'package:flutter/material.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpView();
}

class _HelpView extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 32, top: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Help",
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'CupertinoSystemDisplay'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
