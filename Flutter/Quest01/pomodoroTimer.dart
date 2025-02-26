import 'dart:async';

void main() {
  int cycles = 4; // 작업-휴식 반복 횟수 >> 0부터 3까지 4번 실행됨
  int currentCycle = 0;

  void startWorkTimer() {
    int totalSeconds = 1 * 60; // 25분을 초 단위로 변환 (테스트시 1 * 60으로 진행함)
    print('작업 타이머를 시작합니다. (Cycle ${currentCycle + 1})');

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      totalSeconds--;

      // 남은 시간 분과 초로 변환
      int minutes = totalSeconds ~/ 60;
      int seconds = totalSeconds % 60;
      String formattedMinutes = minutes.toString().padLeft(2, '0');
      String formattedSeconds = seconds.toString().padLeft(2, '0');
      print(
        '작업: $formattedMinutes : $formattedSeconds',
      ); // 어느 타이머가 실행되고 있는지 확인하기 위해 '작업: ' 문자 포함함

      // 작업 시간 종료 시
      if (totalSeconds == 0) {
        print('작업 시간이 종료되었습니다. 휴식 시간을 시작합니다.');
        timer.cancel();

        void startBreakTimer() {
          print('휴식 타이머를 시작합니다. (Cycle ${currentCycle + 1})');
          int breakSeconds = 1 * 60; // 테스트시 1 * 60으로 진행함

          // 4번째 사이클에서는 15분 휴식
          if (currentCycle == 3) {
            // 0부터 시작하므로 네 번째는 3
            breakSeconds += 2 * 60; // 10분 추가 / 테스트 시 2분만 추가했음
          }

          Timer.periodic(Duration(seconds: 1), (Timer breakTimer) {
            breakSeconds--;

            // 남은 시간 변환
            int minutes = breakSeconds ~/ 60;
            int seconds = breakSeconds % 60;
            String formattedBreakMinutes = minutes.toString().padLeft(2, '0');
            String formattedBreakSeconds = seconds.toString().padLeft(2, '0');
            print(
              '휴식 : $formattedBreakMinutes : $formattedBreakSeconds',
            ); // 어느 타이머가 실행되고 있는지 확인하기 위해 '휴식: ' 문자 포함함

            if (breakSeconds == 0) {
              breakTimer.cancel();
              currentCycle++;

              if (currentCycle < cycles) {
                // 3을 넘어가면 종료
                print('휴식 시간이 종료되었습니다. 다음 작업 시간을 시작합니다.');
                startWorkTimer();
              } else {
                print('모든 작업과 휴식 주기가 종료되었습니다.');
              }
            }
          });
        }

        startBreakTimer(); // 휴식 타이머 실행
      }
    });
  }

  startWorkTimer(); // 타이머 시작
}
// Timer.periodic 키워드를 검색함
// Timer.periodic(Duration(seconds: 1) 코드가 1s 마다 count를 1씩 -- 하는 식으로 초기 방향을 설정함
// 콘솔에 시간의 형태로 출력되지 않고 정수로 표시되는 문제가 있었음
// 휴식시간을 구분하는 방법 고민해보기

// 실행 횟수?를 카운트해서 4회차마다 휴식시간 조건을 바꾸기
// 출력부분 $ 이용해서 분과 초 분리해서 표시하기
// 1자리수도 03 05 이런 식으로 0 포함해서 나타내보기


// 휴식 타이머 시작할 때 00:00인 타이머가 반복 출력 되었음
// >> 작업 타이머 print에 '작업'이라는 단어를 붙여서 반복 출력되는 00:00 이 어느 타이머인지 확인함
// >> 휴식 타이머였음
// >> 휴식 타이머 print문에 작업 타이머 변수를 넣고 실행하고 있었음
// 변수명을 확실하게 명시해야 한다는 사실을 다시 한 번 깨달았음
// 작업 타이머 종료 후 휴식 타이머 실행까지 구현함
// 타이머 실행 카운트를 저장할 방법을 찾아야 했음

// 한 번의 실행에서 유저에게 시작을 묻는 식으로 프로그램 종료하지 않고 카운트?
// 4번째 실행에서 시간이 추가되는 식으로 구상함
// 조건문에서 4번째 실행에 시간을 추가하도록 하였는데 실제로는 추가되지 않았음


// 회고

// 테스트 시간을 1분 이하로 줄이는 방법을 떠올리지 못해서 타이머를 실제로 돌리기가 어려웠다.
// 사이클 카운트를 3이나 4로 명시하고 시작하면 빠르다는 발상을 너무 뒤늦게 깨달았다.😂
// 변수명을 확실하게 명시해야 한다는 사실을 다시 한 번 깨달았음

// 