import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: CafeScreen());
  }
}

class CafeScreen extends StatelessWidget {
  // 이미지는 핫 리로드가 먹히지 않음 >> 껐다 키기
  final List<String> cafeImages = [
    'assets/images/1223145.png',
    'assets/images/IMG_3273.png',
    'assets/images/IMG_3274.png',
    'assets/images/IMG_3275.png',
    'assets/images/sooyeom.png',
  ];

  final List<String> cafeTitles = [
    '내 카페\n전체',
    '먼지\n',
    '인절미\n',
    '산고양이 뱃살\n 만지기 클럽',
    '전국 고양이 수염\n수집가 협회',
  ];
  // 카페 이름 두 줄 되니까 아이콘이 위로 밀림.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 66.0,
        title: Text(
          'Wonkyu Café',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print('새 카페를 생성하는 버튼입니다');
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('통합 검색 버튼입니다');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print('설정 화면 진입 버튼입니다');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('내 카페', style: TextStyle(color: Colors.black, fontSize: 21)),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(cafeImages[index]),
                    ),
                    SizedBox(height: 15),
                    Text(
                      cafeTitles[index],
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      textAlign: TextAlign.center, // 두 줄 넘어가서 가운데 정렬 함
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 10),
            Divider(
              // 얇게 경계선 나누기
              color: Colors.grey,
              thickness: 1, // 얇은 선
            ),
            SizedBox(height: 10),
            Text(
              '나를 위한 맞춤 콘텐츠',
              style: TextStyle(color: Colors.black, fontSize: 21),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: Image.asset(
                          'assets/images/IMG_3247.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/basic.png',
                            ),
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '손바닥 사탕',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '정원규',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '30분 전',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: Image.asset(
                          'assets/images/IMG_2878.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/basic.png',
                            ),
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '인절미 하이파이브',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '정원규',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '하루 전',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey, thickness: 1),
            SizedBox(height: 20),
            Text(
              '즐겨찾는 게시판',
              style: TextStyle(color: Colors.black, fontSize: 21),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/sooyeom.png',
                  ), // 프로필 이미지 경로
                  radius: 20, // 프로필 이미지 크기 조절
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '고양이 발바닥 모음 게시판',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '전국 고양이 수염 수집가 협회',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '2시간 전',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/IMG_3273.png',
                  ), // 프로필 이미지 경로
                  radius: 20, // 프로필 이미지 크기 조절
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '고양이가 도망가지 않는 빗질방법 성공 후기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '먼지',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '16시간 전',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/IMG_3275.png',
                  ), // 프로필 이미지 경로
                  radius: 20, // 프로필 이미지 크기 조절
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '고양이처럼 코딩하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '산고양이 뱃살 만지기 클럽',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '21시간 전',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CafeScreen()),
                    );
                  },
                  child: Text(
                    '홈',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text('이웃', style: TextStyle(color: Colors.black, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionPage(),
                      ),
                    );
                  },
                  child: Text(
                    '구독',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  '인기글',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  '내소식',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text('채팅', style: TextStyle(color: Colors.black, fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 66.0,
        title: Text(
          '구독',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색 (미구현)
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/basic.png',
                  ), // 프로필 이미지 경로
                  radius: 20, // 프로필 이미지 크기 조절
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '손바닥 사탕',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '정원규',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '30분 전',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: Image.asset('assets/images/IMG_3247.jpg'),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.heart),
                SizedBox(width: 5), // 가로 빈 공간
                Text('610', style: TextStyle(fontSize: 20)),
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.comments),
                SizedBox(width: 5),
                Text('309', style: TextStyle(fontSize: 20)),
                Spacer(), // 가로로도 적용 가능함
                Text('조회 1,217'),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              // 굵은 경계선 나누기
              color: Colors.grey[200],
              thickness: 17, //
            ),
            SizedBox(height: 20),

            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/basic.png',
                  ), // 프로필 이미지 경로
                  radius: 20, // 프로필 이미지 크기 조절
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인절미 하이파이브',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '정원규',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '하루 전',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 400,
                        child: Image.asset('assets/images/IMG_2878.jpg'),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.heart),
                SizedBox(width: 5),
                Text('1008', style: TextStyle(fontSize: 20)),
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.comments),
                SizedBox(width: 5),
                Text('724', style: TextStyle(fontSize: 20)),
                Spacer(),
                Text('조회 1,987'),
              ],
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey[200], thickness: 17),

            SizedBox(height: 20),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CafeScreen()),
                    );
                  },
                  child: Text(
                    '홈',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text('이웃', style: TextStyle(color: Colors.black, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionPage(),
                      ),
                    );
                  },
                  child: Text(
                    '구독',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  '인기글',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  '내소식',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text('채팅', style: TextStyle(color: Colors.black, fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
