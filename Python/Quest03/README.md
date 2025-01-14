# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 정원규
- 리뷰어 : 류지호


# PRT(Peer Review Template)
- [ ]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
        - 중요! 해당 조건을 만족하는 부분을 캡쳐해 근거로 첨부
          ![image](https://github.com/user-attachments/assets/888746ff-4756-41b8-848c-cf44dffcb70e)
          실행을 한번더 하는 경우 최댓값이 다시 올바르게 나오는 것을 확인할 수 있었다. (123이 아닌 1010)
          ![image](https://github.com/user-attachments/assets/bd5da8a3-0656-4831-9b2c-73a474d143a3)
          Hello Aiffel!과 say_hello 실행횟수: 가 위아래 순서가 바뀌어 나왔지만, 두 문장 모두 잘 출력됐다.


    
- [x]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭을 왜 핵심적이라고 생각하는지 확인
    - 해당 코드 블럭에 doc string/annotation이 달려 있는지 확인
    - 해당 코드의 기능, 존재 이유, 작동 원리 등을 기술했는지 확인
    - 주석을 보고 코드 이해가 잘 되었는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - ![image](https://github.com/user-attachments/assets/b01ae481-f227-4381-a67c-d32ad0b6b9b3)
        - 주석의 안내 내용 대로 잘 코드가 작성되었고, 함수 이름과 변수 이름도 이해하기 쉽게 잘 작성됐다.
        - ![image](https://github.com/user-attachments/assets/293f9c6c-edb8-42a7-97c5-5e54dcbbbbc1)
        - countAdd 함수 안에 *arg와 **kwargs를 통해 fn()에 넣어 해결한 점이 인상깊었다.


        
- [x]  **3. 에러가 난 부분을 디버깅하여 문제를 해결한 기록을 남겼거나
새로운 시도 또는 추가 실험을 수행해봤나요?**
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인
    - 프로젝트 평가 기준에 더해 추가적으로 수행한 나만의 시도, 
    실험이 기록되어 있는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
     ![image](https://github.com/user-attachments/assets/376fd608-524c-48dd-a7ca-79c6d479aabc)
잘못 출력된 것을 바로 잡기 위해 많은 시도를 했으며, 어떤 오류가 났는지 잘 적혀있고 실패 사례도 많이 적어주셨다.

        
- [x]  **4. 회고를 잘 작성했나요?**
    - 주어진 문제를 해결하는 완성된 코드 내지 프로젝트 결과물에 대해
    배운점과 아쉬운점, 느낀점 등이 기록되어 있는지 확인
    - 전체 코드 실행 플로우를 그래프로 그려서 이해를 돕고 있는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - ![image](https://github.com/user-attachments/assets/a0d9a254-3827-48dd-9c4b-b4bb76c43c6a)
        - 느낀점과 보완할 점 2가지 모두 자세하게 회고를 잘 작성해주셨다.

        
- [x]  **5. 코드가 간결하고 효율적인가요?**
    - 파이썬 스타일 가이드 (PEP8) 를 준수하였는지 확인
    - 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 함수화/모듈화했는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
        - ![image](https://github.com/user-attachments/assets/0f8a562e-d5d4-4939-a7e9-8deeb7dd5593)

        - ![image](https://github.com/user-attachments/assets/ca13880d-e138-4beb-86f6-20e8b85f6949)
        - 특히 2번째 문제에 대한 코드를 매우 간결하게 작성했다.



# 회고(참고 링크 및 코드 개선)
```
![image](https://github.com/user-attachments/assets/41aa2697-da5e-4bed-9a19-27e67acac7f9)
위와 같이 return 뒤 fn(*arg, **kwargs)을 함수 안쪽으로 이동하면 원하는 결과값이 순서에 맞게 나오는 것을 알 수 있다.
![image](https://github.com/user-attachments/assets/11df8ec0-7db5-465e-bc2a-bf55e6665aee)
이 부분에 대해서는 fn의 정확한 역할에 대해 다시 함께 설명을 듣고 싶다.

```
