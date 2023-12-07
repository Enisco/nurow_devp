import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.settings),
        title: const Text("About"),
        backgroundColor: Colors.teal[700],
      ),
      body: const AboutHome(),
    );
  }
}

class AboutHome extends StatefulWidget {
  const AboutHome({Key? key}) : super(key: key);

  @override
  _AboutHomeState createState() => _AboutHomeState();
}

// ignore: camel_case_types
class _AboutHomeState extends State<AboutHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Image(
            image: const AssetImage("images/purple_leave.jpg"),
            width: size.width,
            height: size.height,
          ),
          Center(
            // ignore: prefer_const_constructors
            child: Card(
              margin: const EdgeInsets.all(10.0),
              elevation: 20.0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.white, width: 1.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  """Nurow is here to make life better. We are excited to develop this products and we believe you are anticipating too. By the year 2025, we want to make Nigeria the country with the highest number of homes connected. This we will achieve by developing these devices that can make your existing home smart without you having to tamper with any existing infrastructures.""",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
