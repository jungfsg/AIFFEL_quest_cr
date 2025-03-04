import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.star_border), // leading으로 좌상단에 아이콘 배치
          title: Text('플러터 앱 만들기'), // title을 중앙에 배치하기
          foregroundColor: Colors.white, // appbar 텍스트 색상 하얀색으로 설정함
          centerTitle: true, // >> bool값으로 설정함
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            // 위젯을 중앙 기준 세로로 정렬함 + 버튼과 컨테이너 박스 간격 고민해보기
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  print('버튼이 눌렸습니다'); // 버튼을 누르면 출력되는 텍스트
                },
                child: Text('Text'), // 버튼 자체의 텍스트
              ),
              // SizedBox(height: 60),
              Spacer(),
              Container(
                // 가장 큰 컨테이너의 사이즈 300*300, 60씩 줄이면서 좌상단에 중첩하기
                child: Align(
                  alignment: Alignment(0.0, 0.0),
                  child: Container(
                    width: 300,
                    height: 300,
                    color: Colors.deepPurple,
                    child: Align(
                      alignment: Alignment(
                        -1.0,
                        -1.0,
                      ), // 가장 좌상단의 위치는 -1.0, -1.0임
                      child: Container(
                        width: 240,
                        height: 240,
                        color: Colors.pinkAccent,
                        alignment: Alignment(-1.0, -1.0),
                        child: Container(
                          width: 180,
                          height: 180,
                          color: Colors.amberAccent,
                          alignment: Alignment(-1.0, -1.0),
                          child: Container(
                            width: 120,
                            height: 120,
                            color: Colors.lightGreen,
                            alignment: Alignment(-1.0, -1.0),
                            child: Container(
                              width: 60,
                              height: 60,
                              color: Colors.blueAccent,
                              alignment: Alignment(-1.0, -1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(), // 화면 여백 설정 >> 간격 맞추기
            ],
          ),
        ),
      ),
    );
  }
}

// leading으로 아이콘을 좌상단에 배치함
// title에 텍스트를 입력함 >> 중앙에 배치되지 않음
// centerTitle을 bool로 지정해서 중앙에 보냄 >> 아이콘 위치를 고려해서 중앙 배치 해보고싶음
// //  body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               print('버튼이 눌렸습니다');
//             },
//             child: Container(alignment: Alignment.center, child: Text('Text')),
//           ), 코드로 실행하니 화면 전체를 뒤덮는 거대한 버튼이 출력되었음
// alignment: Alignment.center 코드를 삭제하니 정상적으로 작은 버튼이 중앙에 출력되었음
// SizedBox(height: 60)로 버튼과 컨테이너 사이 간격을 조절함
// 컨테이너 별로 alignment: Alignment(-1.0, -1.0) 를 설정하지 않았더니 박스가 의도대로 중첩되지 않아서
// 20분은 헤맸음
// Spacer() 코드로 여백을 적절하게 배치하는 방법을 찾아서 적용해보았음
// >> 버튼 위, 버튼과 박스 사이, 박스 아래 3곳에 입력하면 간격을 자동 조절함

// 회고: 
// 정원규: 생각대로 금방금방 될 것이라고 생각했는데, 출력될 때마다 결과물이 생각과 많이 달라서 신기했음
// 버튼이 화면 전체를 뒤덮을 때 가장 재미있었음
// 사소한 부분에서 오류가 발생했었기 때문에 디테일이 부족했다고 느껴졌고, 
// 책의 내용을 이해하는 것과 그것을 활용해 새로 무언가를 만드는 것은 또 다른 문제라고 생각되었기 때문에 마찬가지로 이해도가 조금 더 필요하다는 생각이 들었음

// 김의훈: GPT를 이용하지 말라고 퍼실님께서 말씀하셨는데, 퀘스트에 친절히 페이지설명이 되어있어서
// 찾아보고 원규님과 상의하면서 잘 진행하였다. 스스로 문제를 해결하니 기쁨이 더 컸던것 같다.
// 퀘스트는 원규님이 화면공유를 하면서 코드의 전반적인 부분을 잘 진행해주셨다.
// 오류가 해결되면 탄성을 지르고 박수를 치며 재밌게 퀘스트를 마무리했다.