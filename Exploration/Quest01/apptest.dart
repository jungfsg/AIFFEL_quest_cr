import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '이파리 이미지 분류',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageClassifierPage(),
    );
  }
}

class ImageClassifierPage extends StatefulWidget {
  @override
  _ImageClassifierPageState createState() => _ImageClassifierPageState();
}

class _ImageClassifierPageState extends State<ImageClassifierPage> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  String _resultText = '';
  String _errorMessage = '';
  String _imageUrl = '';
  double _confidence = 0.0;

  Future<void> _predictImage() async {
    setState(() {
      _isLoading = true;
      _resultText = '';
      _errorMessage = '';
      _imageUrl = _urlController.text;
      _confidence = 0.0;
    });

    try {
      final apiUrl = 'http://localhost:5000/predict_url';

      // HTTP POST 요청
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': _urlController.text}),
      );

      if (response.statusCode == 200) {
        // 응답 처리
        final data = jsonDecode(response.body);
        setState(() {
          _resultText = data['predicted_class'];
          _confidence = data['confidence'];
          _isLoading = false;
        });
      } else {
        // 오류 처리
        setState(() {
          _errorMessage = '서버 오류: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '연결 오류: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이미지 분류기')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: '이미지 URL',
                hintText: '분류할 이미지의 URL을 입력하세요',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _urlController.clear(),
                ),
              ),
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _predictImage,
              child:
                  _isLoading
                      ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                      : Text('분류하기'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(height: 24),
            if (_errorMessage.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.red[100],
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red[900]),
                ),
              ),
            if (_imageUrl.isNotEmpty && _errorMessage.isEmpty) ...[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Image.network(
                          'http://localhost:5000/proxy_image?url=${Uri.encodeComponent(_imageUrl)}',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            // 앱에 이미지 출력이 안 됨 >> 디버그용 print문
                            print('이미지 로드 오류: $error');
                            print("이미지 URL: $_imageUrl");
                            return Center(
                              child: Text('이미지를 로드할 수 없습니다. 오류: $error'),
                            );
                          },
                        ),
              ),
              SizedBox(height: 16),
              if (_resultText.isNotEmpty) ...[
                Text(
                  '분류 결과:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  _resultText,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '신뢰도: ${(_confidence * 100).toStringAsFixed(2)}%',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
