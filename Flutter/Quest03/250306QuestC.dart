import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 구조
// 말 그대로 is_cat이 true일 때 고양이 화면이고 false면 고양이가 아닌 무언가인 두 개의 화면

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: First_Page());
  }
}

class First_Page extends StatefulWidget {
  // StatefulWidget으로 변경
  @override
  _First_PageState createState() => _First_PageState();
}

class _First_PageState extends State<First_Page> {
  bool is_cat = true; // is_cat의 초기값 true

  @override
  void initState() {
    super.initState();
    is_cat = true; // 첫 화면으로 돌아오면 항상 true로 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.cat), // leading으로 좌상단에 아이콘 배치
        title: Text('First Page ˆ.   ̫  .ˆ ̳'), // title을 중앙에 배치하기
        foregroundColor: Colors.white, // appbar 텍스트 색상 하얀색으로 설정함
        centerTitle: true, // >> bool값으로 설정함
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // 위젯을 중앙 기준 세로로 정렬함 + 버튼과 컨테이너 박스 간격 Spacer()로 조정
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            ElevatedButton(
              onPressed: () {
                print(
                  'First Page is_cat: $is_cat',
                  // 'is_cat을 false로 초기화하고, 초기화한 is_cat을 다음 페이지로 전달하는 마법 버튼',
                );

                // Second_Page로 이동할 때 is_cat 값을 false로 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Second_Page(is_cat: false),
                  ),
                );
              },
              child: Text('Next'), // 버튼 자체의 텍스트
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                print('First Page is_cat: $is_cat');
              },
              child: Image.asset(
                'assets/images/meonji.jpg',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ), // 초기값을 true로 설정했다고 생각했는데 이미지를 클릭하면 is_cat이 false로 출력됨

            Spacer(), // 화면 여백 설정 >> 간격 맞추기
          ],
        ),
      ),
    );
  }
}

class Second_Page extends StatelessWidget {
  final bool is_cat; // First_Page에서 넘겨받을 is_cat 변수

  Second_Page({required this.is_cat}); // 생성자로 is_cat을 받아야 함

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.dog), // leading으로 좌상단에 아이콘 배치
        title: Text('Second Page ૮⍝• ᴥ •⍝ა'), // title을 중앙에 배치하기
        foregroundColor: Colors.white, // appbar 텍스트 색상 하얀색으로 설정함
        centerTitle: true, // >> bool값으로 설정함
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 뒤로 가기
              },
              child: Text('Back'),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                print('Second Page is_cat: $is_cat');
              },
              child: Image.asset(
                'assets/images/messi.jpg',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ), // is_cat 값에 따라 이미지 변경됨
            Spacer(), // 화면 여백 설정 >> 간격 맞추기
          ],
        ),
      ),
    );
  }
}

// 처음 고양이 화면에서는 is_cat이 true인데, 강아지화면에 다녀오면 false가 되어있었음
// 그런데 다시 한 번 다녀오면 또 true가 되어있었음

// Second Page 클래스에서 bool값을 제대로 전달받지 못 해서 발생한 문제였음
// ⚡hot reload 실행해도 이전 bool값 state가 기억되어 혼란스러웠음 >> restart로 테스트함
