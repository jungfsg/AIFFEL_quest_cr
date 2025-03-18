import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:photo_gallery/250317Quest/HomeScreen.dart';

class PhotoGallery extends StatefulWidget {
  final List<Photo> photos;

  const PhotoGallery({Key? key, required this.photos}) : super(key: key);

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  late List<Photo> photoList;

  @override
  void initState() {
    super.initState();
    photoList = List.from(widget.photos);
  }

  // 새 사진 업로드 (저장은 또 다른 문제였음)
  // 메모리에만 임시로 가지고 있다가 앱 종료시 날아감
  void uploadPhoto(String url, String title) {
    setState(() {
      photoList.add(Photo(imageSource: url, title: title));
      // Photo 객체를 생성하여 리스트에 임시 추가
    });
  }

  // 카메라로 사진 찍는 기능
  Future<void> _takePhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera, // 웹 에뮬레이터 돌릴거면 .gallery로 실행해야 함
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (photo == null) return; // 카메라 사용을 취소한 경우

      // 촬영된 사진의 경로를 URL로 사용
      final String imageUrl = photo.path;

      // 타이틀로 사진 찍은(갤러리에서 가져온) 시간을 사용
      final String photoTitle =
          'Camera Photo ${DateTime.now().toString().substring(0, 16)}';

      // 상태 업데이트 및 사진 추가
      setState(() {
        photoList.add(Photo(imageSource: imageUrl, title: photoTitle));
      });
    } catch (e) {
      // 에러 처리
      // 웹 에뮬레이터로 실행하면 카메라 에러임
      print('카메라 에러: $e');

      // 사용자에게 에러 메시지 표시
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('카메라 에러'),
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

  Future<void> _startImageGuessing(Photo photo) async {
    final String apiUrl = 'http://10.0.2.2:8000/guess-image';
    List<Map<String, String>> conversationHistory = [];

    // 대화 시작 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        final messageController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white.withValues(alpha: 0.9),
              title: Text('작명소', style: TextStyle(color: Colors.black)),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 사진 표시
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: _buildImageWidget(photo),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '이 사진에 대한 대화를 시작하세요. 제목을 지어드립니다.',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 10),

                    // 대화 기록 표시
                    if (conversationHistory.isNotEmpty) ...[
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          itemCount: conversationHistory.length,
                          itemBuilder: (context, index) {
                            final message = conversationHistory[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                    message['role'] == 'user'
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['role'] == 'user' ? '나' : 'AI',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color:
                                          message['role'] == 'user'
                                              ? Colors.deepPurple.withValues(
                                                alpha: 0.2,
                                              )
                                              : Colors.blueAccent.withValues(
                                                alpha: 0.2,
                                              ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      message['content'] ?? '',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                    ],

                    TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: '사진에 대해 설명하거나 AI에게 응답하세요...',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('종료'),
                ),
                TextButton(
                  onPressed: () async {
                    if (messageController.text.isEmpty) return;

                    // 사용자 메시지 추가
                    setState(() {
                      conversationHistory.add({
                        'role': 'user',
                        'content': messageController.text,
                      });
                    });

                    final userMessage = messageController.text;
                    messageController.clear();

                    try {
                      final response = await http.post(
                        Uri.parse(apiUrl),
                        headers: {
                          'Content-Type':
                              'application/x-www-form-urlencoded; charset=utf-8',
                          'Accept': 'application/json; charset=utf-8',
                        },
                        body: {
                          'user_description':
                              userMessage ?? '', // null이면 빈 문자열 사용
                          'conversation_history': jsonEncode(
                            conversationHistory ?? [],
                          ), // null이면 빈 배열 사용
                        },
                      );

                      final jsonData = jsonDecode(
                        utf8.decode(response.bodyBytes),
                      );
                      // 인코딩 관련 코드 추가로 응답 글자 깨짐 해결함

                      // AI 응답 추가
                      setState(() {
                        conversationHistory.add({
                          'role': 'assistant',
                          'content': jsonData['response'],
                        });
                      });
                    } catch (e) {
                      print('Error: $e');
                      setState(() {
                        conversationHistory.add({
                          'role': 'assistant',
                          'content': '죄송합니다, 오류가 발생했습니다: $e',
                        });
                      });
                    }
                  },
                  child: Text('전송'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 이미지 위젯 생성 헬퍼 메서드
  Widget _buildImageWidget(Photo photo) {
    if (photo.isAsset) {
      return Image.asset(photo.imageSource, fit: BoxFit.contain);
    } else if (photo.imageSource.startsWith('http')) {
      return Image.network(photo.imageSource, fit: BoxFit.contain);
    } else {
      return Image.file(File(photo.imageSource), fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true, // 앱 바 뒤로 body가 다닐 수 있게 하는 코드
      appBar: AppBar(
        title: const Text(
          'Photo Gallery',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // 투명 색이 있었음
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            // 화면 비율에 따라 유동적으로 조절됨 // 그리드 사진의 최대 크기 250
            maxCrossAxisExtent: 250,
            crossAxisSpacing: 12.0, // 각각 사진 간 가로, 세로 간격임
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.0, // 1.0은 정사각형임
          ),
          itemCount: photoList.length, // photoList로 변경
          itemBuilder: (context, index) {
            // 사진을 제스처 디텍터로 감싸서 동작 설정하기
            return GestureDetector(
              onTap: () {
                // 확인하기
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        // insetPadding: EdgeInsets.symmetric(
                        //   horizontal: 30,
                        //   vertical: 30,
                        // ),
                        backgroundColor: Colors.white.withValues(alpha: 0.8),
                        title: Text(
                          photoList[index].title, // photoList로 변경
                          style: TextStyle(color: Colors.black),
                        ), // 화면에 출력되는 제목

                        content:
                            photoList[index].isAsset
                                ? Image.asset(photoList[index].imageSource)
                                : (photoList[index].imageSource.startsWith(
                                      'http',
                                    )
                                    ? Image.network(
                                      photoList[index].imageSource,
                                    )
                                    : Image.file(
                                      File(photoList[index].imageSource),
                                    )),

                        // isAsset bool값을 참고하여 네트워크 혹은 로컬 이미지를 불러옴

                        // http로 시작하면 image.network, 아니라면 파일 이미지
                        // id를 같이 출력시키기 위해 칼럼으로 묶음
                        // 칼럼으로 묶으면 AlertDialog 창이 길쭉해짐
                        // alertdialog 자체 크기를 설정해야 함
                        // content 속성이 하나의 위젯만 받을 수 있기 때문에 묶어서 진행해야 함
                        // 생각해보니 id는 그냥 print로만 내뱉어도 나쁘지 않을듯 함
                        // 아니면 타이틀에 포함하는 것도..
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _startImageGuessing(photoList[index]);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green.withValues(
                                alpha: 0.7,
                              ),
                            ),
                            child: const Text(
                              '대화 시작',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    photoList[index].isAsset
                        ? Image.asset(
                          photoList[index].imageSource,
                          fit: BoxFit.cover,
                        )
                        : (photoList[index].imageSource.startsWith('http')
                            ? Image.network(
                              photoList[index].imageSource,
                              fit: BoxFit.cover,
                            )
                            : Image.file(
                              File(photoList[index].imageSource),
                              fit: BoxFit.cover,
                            )),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showuploadPhotoDialog(BuildContext context) {
    final urlController = TextEditingController();
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Upload Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // 내용에 맞게 크기 조정
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
}

class Photo {
  final String imageSource; // url 또는 에셋 경로
  final String title;
  final bool isAsset;

  // 에셋 이미지 여부를 구분

  // id 없앰

  const Photo({
    required this.imageSource,
    required this.title,
    this.isAsset = false,
  });
}

void main() {
  final photoList = [
    Photo(
      imageSource: 'assets/images/IMG_3274.png',
      title: 'Asset Image 1',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/167600ad6db07f11fab62fb85e3e5dab7928697e.jpg',
      title: 'Asset Image 2',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/IMG_2878.jpg',
      title: 'Asset Image 3',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/IMG_8657.jpg',
      title: 'Asset Image 4',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/IMG_8650.jpg',
      title: 'Asset Image 5',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/IMG_5489.jpg',
      title: 'Asset Image 6',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/IMG_3275.png',
      title: 'Asset Image 7',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/29xp-meme-superJumbo-v3.jpg',
      title: 'Asset Image 8',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/Meonji.jpg',
      title: 'Asset Image 9',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/sooyeom.png',
      title: 'Asset Image 10',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/news (1).jpeg',
      title: 'Smiley',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/news (2).jpeg',
      title: 'Crashing into the Picture',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/news (3).jpeg',
      title: 'Social Distance, please',
      isAsset: true,
    ),
    Photo(
      imageSource: 'assets/images/news (4).jpeg',
      title: 'Fun For All Ages',
      isAsset: true,
    ),
  ];

  // 사진 링크가 각각 다르기 때문에 수동 입력 링크도 만들기
  // 위젯엔 합쳐서 띄우기
  // 추가하는 식으로는 작동하기 어려운 것 같음 >> 앱 실행중 코드 수정하는 것은 안 되는 듯
  final additionalPhotos = [
    Photo(
      imageSource:
          'https://upload.wikimedia.org/wikipedia/commons/f/f3/Lathmar_Holi_2022_in_Nandgaon%2C_Uttar_Pradesh_%28edited%29.jpg',
      title: 'Lathmar Holi in Nandgaon',
      isAsset: false,
    ),
    Photo(
      imageSource:
          'https://upload.wikimedia.org/wikipedia/commons/0/08/Miguel_de_la_Fuente.jpg',
      title: 'Miguel de la Fuente',
      isAsset: false,
    ),
    Photo(
      imageSource:
          'https://upload.wikimedia.org/wikipedia/commons/4/4a/Thinktank_Birmingham_-_Plank%282%29.jpg',
      title: 'Thinktank_Birmingham',
      isAsset: false,
    ),
    Photo(
      imageSource:
          'https://upload.wikimedia.org/wikipedia/commons/0/08/Luttekepoort_1607_Anoniem_part_coll_RKD_Top_1019.jpg',
      title: 'Luttekepoort 1607',
      isAsset: false,
    ),
  ];

  // Image.asset()은 리스트로 받아올 수 없음

  // final List<String> photoList = ['assets/images/'];

  // 사진 리스트들 결합
  photoList.addAll(additionalPhotos);

  // 변경: HomeScreen을 시작점으로 설정하고 photoList를 전달
  runApp(
    MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      home: HomeScreen(photoList: photoList), // photoList를 HomeScreen에 전달
    ),
  );
}
