# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 조현정, 정원규
- 리뷰어 : 이혜승, 류지호


<aside>
🔑 **PRT(Peer Review Template)**

- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 기능이 정상적으로 작동하는지?
    - 의도한 대로 잘 작동했고, 직접 화면공유를 통해 구현하는 것을 보여주셨습니다.
        - 해당 조건을 만족하는 부분의 코드 및 결과물을 근거로 첨부
        - ![image](https://github.com/user-attachments/assets/dc667674-27cb-4984-9adb-54c8a3f49b7a)
        - ![image](https://github.com/user-attachments/assets/eca6703b-fde1-4bcb-a89a-ee384bd8f402)


- [x]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
    - 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
    - 주석을 보고 코드 이해가 잘 되었는지 확인
    - predefinedUrl과 fetchData 함수 내에서 URL 사용을 설명하는 주석을 잘 기록해두셨습니다.
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
        - ![image](https://github.com/user-attachments/assets/b8ba50a2-8263-482c-adbb-1e7e9c3ba012)
        - ![image](https://github.com/user-attachments/assets/3b7c7672-ae81-4928-9642-44b8c189b170)

        
- [x]  **3.** 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는
   “새로운 시도 및 추가 실험”을 해봤나요? ****
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인 또는
    - 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도,
    실험이 기록되어 있는지 확인
        - 잘 작성되었다고 생각되는 부분을 근거로 첨부합니다.
        - ![image](https://github.com/user-attachments/assets/6be1728e-4726-4d90-9064-5944f36bbe9c)
        - ![image](https://github.com/user-attachments/assets/ac3df889-3621-4808-b8ee-4368ba71ffb5)
        - 이미지 사이즈(차원?)에 의한 오류를 의심하고 이미지 파일을 변환하려고 디버깅한 부분이 코드에 남아있습니다!
        
- [x]  **4. 회고를 잘 작성했나요?**
    - 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요?
    - 회고를 상세하게 잘 작성해주셨습니다.
    - ![image](https://github.com/user-attachments/assets/df193427-aa12-4e9d-8104-43d00e86c0f5)


- [x]  **5. 코드가 간결하고 효율적인가요?**
    - 코드 중**복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지**
    - 코드가 잘 구조화되어 있어 가독성이 매우 좋습니다. 각 기능이 명확히 구분되어 있어 이해하기 쉬워요.
    - fetchData 함수에서 try-catch 문을 잘 사용해 에러 처리에 간결하게 신경을 쓴 부분이 인상적입니다.
        - **잘 작성되었다고 생각되는 부분을 근거로** 첨부합니다.
        - ![image](https://github.com/user-attachments/assets/bad49176-7a84-4121-ab19-89aadcd96673)

</aside>  


# 회고(참고 링크 및 코드 개선)    
'''


[류지호]    
로컬 환경에서 서버를 띄우고, 이미지 데이터를 모델에 맞게 처리하는 과정이 잘 구현되었습니다.    
버튼 클릭 시 결과에 따라 label과 score를 가져오는 과정도 깔끔하게 처리되었습니다.    
ngrok의 링크가 실행할 때마다 변경되므로 매번 수정이 필요하다는 점은 조금 불편할 수도 있습니다.    
UI가 깔끔하고 직관적으로 구성되어 있던 점이 인상깊었습니다.    
  
[이혜승]    
500 server error랑 ngrok 실행할 때마다 링크를 수정해줘야해서 번거로웠다는 말에 격하게 공감했습니다..    
여러가지 시도를 많이 해보고, 어려웠던 점들을 공유해주셔서 배울 점이 많았습니다.    
UI를 깔끔하게 구현하고 추론 결과도 잘 프린팅되었습니다.    
boolean으로 데이터 라벨을 나누어 가져온 점이 인상깊었습니다.    


```
