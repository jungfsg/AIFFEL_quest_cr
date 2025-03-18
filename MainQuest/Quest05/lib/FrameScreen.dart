import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_gallery/250317Quest/GridScreen.dart'; // Photo 클래스가 정의된 파일 경로
import 'package:photo_gallery/250317Quest/HomeScreen.dart';

class PhotoFrameScreen extends StatefulWidget {
  final List<Photo> photos;

  const PhotoFrameScreen({Key? key, required this.photos}) : super(key: key);

  @override
  State<PhotoFrameScreen> createState() => _PhotoFrameScreenState();
}

class _PhotoFrameScreenState extends State<PhotoFrameScreen> {
  int _currentIndex = 0;
  bool _isPlaying = true;
  Timer? _timer;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startSlideshow();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_isPlaying && widget.photos.isNotEmpty) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.photos.length;
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startSlideshow();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _nextImage() {
    if (widget.photos.isNotEmpty) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.photos.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _previousImage() {
    if (widget.photos.isNotEmpty) {
      setState(() {
        _currentIndex =
            (_currentIndex - 1 + widget.photos.length) % widget.photos.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Photo Frame', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white.withValues(alpha: 0.5),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body:
          widget.photos.isEmpty
              ? const Center(
                child: Text(
                  'No photos available',
                  style: TextStyle(color: Colors.black),
                ),
              )
              : Stack(
                children: [
                  // 사진 페이지뷰
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.photos.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // 화면 탭 시 컨트롤 표시/숨김 토글 기능 추가 가능
                        },
                        child: Center(
                          child: _buildImageWidget(widget.photos[index]),
                        ),
                      );
                    },
                  ),

                  // 하단 컨트롤 바
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onPressed: _previousImage,
                          ),
                          IconButton(
                            icon: Icon(
                              _isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: Colors.white,
                              size: 40,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onPressed: _nextImage,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 상단 정보 표시
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Text(
                        widget.photos.isNotEmpty
                            ? widget.photos[_currentIndex].title
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  // 사진 개수 인디케이터
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.photos.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                index == _currentIndex
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildImageWidget(Photo photo) {
    if (photo.isAsset) {
      return Image.asset(photo.imageSource, fit: BoxFit.contain);
    } else if (photo.imageSource.startsWith('http')) {
      return Image.network(
        photo.imageSource,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
      );
    } else {
      return Image.file(File(photo.imageSource), fit: BoxFit.contain);
    }
  }
}
