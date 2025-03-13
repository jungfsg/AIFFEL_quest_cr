import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  final String predefinedUrl =
      "https://9bb8-121-184-154-43.ngrok-free.app/"; //url 사전에 입력하기
  Future<void> fetchData({bool showLabel = true}) async {
    try {
      final response = await http.get(
        Uri.parse(predefinedUrl + "sample"), // 사전 정의된 URL 사용
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          if (showLabel) {
            result = "predicted_label: ${data['predicted_label']}";
          } else {
            result = "prediction_score: ${data['prediction_score']}";
          }
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FaIcon(FontAwesomeIcons.bell, size: 40),
        title: Text('Jellyfish Classifier'),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset(
              'assets/images/image.png',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () => fetchData(showLabel: true), // label만 출력
                  child: Icon(Icons.play_arrow),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => fetchData(showLabel: false), // score만 출력
                  child: Icon(Icons.play_arrow),
                ),

                Spacer(),
              ],
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
