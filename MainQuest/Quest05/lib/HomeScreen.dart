import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'FrameScreen.dart';
import 'GridScreen.dart';

class HomeScreen extends StatefulWidget {
  final List<Photo> photoList;

  const HomeScreen({Key? key, required this.photoList}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Photo> photoList;
  List<GhostMessage> ghostMessages = [];
  Timer? _ghostTimer;
  Random random = Random();
  bool _isFlashing = false;

  @override
  void initState() {
    super.initState();
    photoList = List.from(widget.photoList);

    Future.delayed(Duration(seconds: 5), () {
      _generateGhostMessage();
    });

    // 랜덤한 간격으로 귀신 메시지 생성
    _ghostTimer = Timer.periodic(Duration(seconds: 10), (_) {
      Future.delayed(Duration(seconds: random.nextInt(20) + 10), () {
        _generateGhostMessage();
      });
    });
  }

  @override
  void dispose() {
    _ghostTimer?.cancel();
    super.dispose();
  }

  // 새 사진 업로드 메서드
  void uploadPhoto(String url, String title) {
    setState(() {
      photoList.add(Photo(imageSource: url, title: title, isAsset: false));
    });
  }

  // 카메라로 사진 찍는 기능
  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (photo == null) return; // 사용자가 카메라 사용을 취소한 경우

      // 촬영된 사진의 경로를 URL로 사용
      final String imageUrl = photo.path;

      // 타이틀로 사진 찍은 시간을 사용
      final String photoTitle =
          'Camera Photo ${DateTime.now().toString().substring(0, 16)}';

      // 상태 업데이트 및 사진 추가
      setState(() {
        photoList.add(Photo(imageSource: imageUrl, title: photoTitle));
      });
    } catch (e) {
      print('카메라 에러: $e');

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('카메라 오류'),
              content: Text('카메라를 사용할 수 없습니다: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('확인'),
                ),
              ],
            ),
      );
    }
  }

  // 귀신 메시지 생성 함수
  Future<void> _generateGhostMessage() async {
    try {
      // API 호출하여 불쾌한 메시지 생성
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/random-message'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
          'Accept': 'application/json; charset=utf-8',
        },
        body: {'prompt': '불쾌하고 섬뜩한 한 문장 메시지를 생성해줘. 15단어 이내로.'},
      );

      // API 응답이 없거나 오류 발생 시 기본 메시지 사용
      String message;
      try {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        message = jsonData['response'] ?? '너의 모든 행동을 지켜보고 있어...';
      } catch (e) {
        // API 호출 실패 시 기본 불쾌한 메시지 목록에서 랜덤 선택
        List<String> defaultMessages = ['api 연결이 안 돼....', '안된다고..'];
        message = defaultMessages[random.nextInt(defaultMessages.length)];
      }

      // 화면 깜빡임 효과
      setState(() {
        _isFlashing = true;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted)
          setState(() {
            _isFlashing = false;
          });
      });

      // 화면 크기를 고려한 랜덤 위치 계산
      final screenSize = MediaQuery.of(context).size;
      final xPosition = random.nextDouble() * (screenSize.width - 200);
      final yPosition = random.nextDouble() * (screenSize.height - 100);

      setState(() {
        // 새 메시지 추가
        ghostMessages.add(
          GhostMessage(
            message: message,
            position: Offset(xPosition, yPosition),
            opacity: 1.0,
            scale: 1.0,
            rotation: (random.nextDouble() - 0.5) * 0.2, // 약간 기울어진 효과
          ),
        );

        // 5-8초 후 메시지 페이드 아웃
        int displayDuration = random.nextInt(3) + 5; // 5-8초
        Future.delayed(Duration(seconds: displayDuration), () {
          if (mounted) {
            setState(() {
              if (ghostMessages.isNotEmpty) {
                final lastMsg = ghostMessages.last;
                ghostMessages.last = GhostMessage(
                  message: lastMsg.message,
                  position: lastMsg.position,
                  opacity: 0.0,
                  scale: lastMsg.scale,
                  rotation: lastMsg.rotation,
                );

                // 완전히 투명해지면 제거
                Future.delayed(Duration(milliseconds: 500), () {
                  if (mounted) {
                    setState(() {
                      if (ghostMessages.isNotEmpty) {
                        ghostMessages.removeLast();
                      }
                    });
                  }
                });
              }
            });
          }
        });
      });
    } catch (e) {
      print('귀신 메시지 생성 오류: $e');
    }
  }

  // 사진 업로드 다이얼로그 표시
  void _showuploadPhotoDialog(BuildContext context) {
    final urlController = TextEditingController();
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: urlController,
                decoration: InputDecoration(hintText: 'Photo URL'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Photo Title'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // 오기입 방지
                if (urlController.text.isNotEmpty &&
                    titleController.text.isNotEmpty) {
                  uploadPhoto(urlController.text, titleController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 화면 깜빡임 효과
          if (_isFlashing)
            Container(
              color: Colors.white.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),

          Row(
            // Row를 사용하여 버튼들을 수평으로 배치
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => PhotoFrameScreen(photos: photoList),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.indigoAccent[700],
                    height: double.infinity, // 세로 방향으로 화면 전체 차지
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.desktop, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Frame',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoGallery(photos: photoList),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.purple[300],
                    height: double.infinity, // 비율 상관없게 하기
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.film, color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Grid Gallery',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 귀신 메시지들 렌더링
          ...ghostMessages
              .map(
                (ghostMessage) => Positioned(
                  left: ghostMessage.position.dx,
                  top: ghostMessage.position.dy,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: ghostMessage.opacity,
                    child: Transform.rotate(
                      angle: ghostMessage.rotation,
                      child: AnimatedScale(
                        duration: Duration(milliseconds: 300),
                        scale: ghostMessage.scale,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            ghostMessage.message,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.red.withOpacity(0.5),
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
      // 누르면 분열하는 플로팅 버튼
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        overlayColor: Colors.white, // 분열할 때 배경에 덮는 색상
        overlayOpacity: 0.4,
        tooltip: 'Add Photos Here',
        spacing: 15,
        spaceBetweenChildren: 10,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        animationDuration: Duration(milliseconds: 600),
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera_alt),
            backgroundColor: Colors.cyan[600],
            foregroundColor: Colors.white,
            label: 'Take Photos',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _takePhoto(), // 카메라 함수 호출
          ),
          SpeedDialChild(
            child: Icon(Icons.photo_library),
            backgroundColor: Colors.lightGreen[700],
            foregroundColor: Colors.white,
            label: 'Upload Photo',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => _showuploadPhotoDialog(context),
          ),
          SpeedDialChild(
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Close',
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            onTap: () => {}, // 이 버튼은 기능이 없음: Speeddial이 어짜피 알아서 닫힘
          ),
        ],
      ),
    );
  }
}

// 귀신 메시지를 위한 모델 클래스
class GhostMessage {
  final String message;
  final Offset position;
  final double opacity;
  final double scale;
  final double rotation;

  GhostMessage({
    required this.message,
    required this.position,
    required this.opacity,
    required this.scale,
    required this.rotation,
  });
}
