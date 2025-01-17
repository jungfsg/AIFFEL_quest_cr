
# 은행이름: ~  예금주: ~  계좌번호: ~ 잔고: ~
# 계좌번호 생성을 위해 랜덤 모듈 불러오기
import random as r

class Account():
    # 생성된 계좌의 개수 저장
    account_count = 0

    def __init__(self, depositor, balance):
        self.doIpgeum_count = 0                     # 입금 횟수를 저장
        self.doIpgeum_log = []
        self.doChoolgeum_log = []
        self.bank = 'SC 은행'
        self.depositor = depositor
        self.balance = balance
        self.cleaned_acc_number = []
        acc_ranList = []
        for i in range(11):
            acc_ranList.append(r.randint(0, 9))
    
        acc_number = ''.join(map(str, acc_ranList))
        self.cleaned_acc_number = f"{acc_number[:3]}-{acc_number[3:5]}-{acc_number[5:]}"     # 슬라이싱한 11자리 숫자를 f 스트링을 사용해 계좌번호 형식으로 분리
        Account.account_count += 1

    # 생성된 계좌의 개수 출력
    def get_account_num(self):
        print(f"생성된 계좌의 총 개수: {Account.account_count}")

    # 입금 메서드
    def deposit(self, doIpgeum):
        if doIpgeum >= 1:                   # 입금액이 1 이상은 있어야 입금하기
            self.balance += doIpgeum
            self.doIpgeum_log.append(doIpgeum)
            print("입금이 완료되었습니다")

            # 입금 횟수 카운트해서 이자 넣기
            # 입금된 이자 금액을 출력하기 위해 이자 변수를 별도로 정의함
            self.doIpgeum_count += 1
            if self.doIpgeum_count % 5 == 0:
                eeJa = self.balance * 0.01
                self.balance += eeJa
                print(f"{eeJa}의 이자가 입금되었습니다")

    # 출금 메서드
    def withdraw(self, doChoolgeum):            # 출금액이 잔액보다 많으면 실행되지 않음
        if self.balance > doChoolgeum:
            self.balance -= doChoolgeum
            self.doChoolgeum_log.append(doChoolgeum)
            print("출금이 완료되었습니다")

        elif self.balance < doChoolgeum:
            print('잔액이 부족합니다')


    # 계좌 정보 출력
    def printAccInfo(self):
        # print(self.depositor)
        # print(self.balance)
        # print(self.cleaned_acc_number)
        # print(self.cleaned_balance)
    
        # print(f"생성된 계좌의 총 개수: {Account.account_count}")
        self.cleaned_balance = "{:,}".format(self.balance)              # 잔고에 3자리마다 쉼표 포함하기
        print(f"은행: {self.bank}, 예금주: {self.depositor}, 계좌번호: {self.cleaned_acc_number}, 잔고: {self.cleaned_balance}")
    
    # 입금 내역 확인
    def deposit_history(self):
        print('=' * 10, '입금 내역', '=' * 10)
        for doIpgeum in self.doIpgeum_log:
            print(doIpgeum)
        print('=' * 31)

    # 출금 내역 확인
    def withdraw_history(self):
        print('=' * 10, '출금 내역', '=' * 10)
        for doChoolgeum in self.doChoolgeum_log:
            print(doChoolgeum)
        print('=' * 31)


    




# Account 클래스로부터 3개 이상의 인스턴스를 생성하고 리스트에 저장하기
db = []
Joong = Account("이중배", 100000)
Yoon = Account("김윤섭", 5000000)
Mook = Account("임성묵", 100000)
Meonji = Account("먼지", 200000)

db.append(Joong)
db.append(Yoon)
db.append(Mook)
db.append(Meonji)

# 객체 순회 반복문으로 조건에 맞는 고객님 정보 출력하기
for vip in db:
    if vip.balance >= 1000000:
        vip.printAccInfo()



# 입금과 출금 내역 기록 // 이자 적립 확인
print()

Joong.printAccInfo()
Joong.withdraw(1000)
Joong.withdraw(1000)
Joong.withdraw(1000)
print()

Joong.printAccInfo()
Joong.withdraw_history()
print()

Meonji.printAccInfo()
Meonji.deposit(10000)
Meonji.deposit(10000)
Meonji.deposit(10000)
Meonji.deposit(10000)
Meonji.deposit(10000)
Meonji.printAccInfo()
print()


Meonji.deposit_history()