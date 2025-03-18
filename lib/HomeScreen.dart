import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/250317Quest/GridScreen.dart';
import 'package:photo_gallery/250317Quest/FrameScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  final List<Photo> photoList;

  const HomeScreen({Key? key, required this.photoList}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Photo> photoList;

  @override
  void initState() {
    super.initState();
    photoList = List.from(widget.photoList);
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
      // appBar: AppBar(
      //   title: const Text('Home', style: TextStyle(color: Colors.black)),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      // ),
      body: Row(
        // Row를 사용하여 버튼들을 수평으로 배치
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoFrameScreen(photos: photoList),
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
