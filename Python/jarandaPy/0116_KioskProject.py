# 순서
# 메뉴 입력 >> hot ice 입력 >> 가격 안내 및 추가주문 여부 확인 >> 지불 방법 선택 >> 주문서 출력
# 비어있는 주문메뉴 및 가격의 리스트를 각각 만들어 주문할 때 마다 리스트에 추가하기
# 주문이 끝나면 메뉴명은 리스트대로, 가격은 sum() 하여 합계 출력하기
# 오입력시 재 입력 유도하기?
# 마지막 주문서에 총 몇잔인지 출력하기
# 마지막 주문서에 결제 방법도 출력시키기

class Kiosk:
    def __init__(self):
        self.menu = ['Americano', 'Latte', 'Mocha', 'Yuza_tea', 'Green_tea', 'Choco_latte']
        self.price = [2000, 3000, 3000, 2500, 2500, 3000]
        
        self.ordered_menu = []      # 주문한 메뉴의 리스트
        self.sum_price = []         # 주문한 메뉴의 가격 리스트

        self.payment_flag = 0

    # 메뉴 출력 메서드
    def menu_print(self):
        for i in range(len(self.menu)):
            print(f"{i+1} {self.menu[i]} : {self.price[i]} Won")            # 메뉴 번호 1번부터 시작하기기
        
    # 주문 메서드
    def menu_select(self):
        while True:             # 정상 입력으로 break가 걸릴 때 까지 반복하기
            try:
                num = int(input("주문하실 메뉴의 번호를 입력하세요: "))
                if 1 <= num <= len(self.menu):          # 입력값이 1 이상이고 메뉴 숫자 이하일 때 (정상 입력)
                    selected_menu = self.menu[num -1]   # 사용자에게 노출된 메뉴번호는 리스트의 인덱스 + 1임
                    selected_price = self.price[num - 1]    
                    print(f'주문하신 메뉴는 {selected_menu}, 가격은 {selected_price} Won 입니다.')

                    while True:
                        tmp = int(input('HOT(1)과 ICE(2) 중 입력해주세요: '))
                         
                        if tmp == 1:
                            temp = 'HOT'
                            break
                        elif tmp == 2:
                            temp = 'ICE'
                            break
                        else:
                            print('HOT(1)과 ICE(2) 중에서만 골라주세요 \n')
                    
                    self.ordered_menu.append(f"{temp} {selected_menu}")                         # 주문 메뉴 리스트에 온도와 함께 추가
                    self.sum_price.append(selected_price)                                       # append() 이용해서 총 가격 리스트에 추가
                    print(f"{temp} {selected_menu}, 가격은 {selected_price} Won 입니다.")        # 현재 선택한 음료 알려주기
                    
                    additional = int(input("추가 주문하시겠습니까? \n@ 1 @을 입력해 추가 주문하기 \n@ 아무 숫자 @를 입력해 결제하러 가기: "))
                    if additional == 1:
                        continue                                    
                    else:
                        print('결제 단계로 이동합니다')
                        break

                else:
                    print("올바른 메뉴 번호를 다시 입력하세요")
            except:
                print("추가 주문을 다시 진행해주세요 \n")               # 숫자를 오입력하면 else구문이, 숫자가 아닌 다른 포맷을 입력하면 except문이 실행됨됨
        print()
        print("주문하신 내용은 다음과 같습니다")
        print('='*25)
        print(f"{self.ordered_menu} 총 {len(self.ordered_menu)} 잔")
        print(f"합계: {sum(self.sum_price)} Won")
        print('='*25)


    # 지불
    def pay(self):
        while True:
            try:
                choose_pay = int(input("1(현금 지불), 2(카드 결제) 중 선택해주세요: "))
                if choose_pay == 1:
                    self.payment_flag += 1
                    print('현금을 현금 투입구에 투입하세요 \n@주문서가 출력됩니다')
                    break
                elif choose_pay == 2:
                    self.payment_flag -= 1
                    print("카드를 스캐너에 터치해주세요 \n@주문서가 출력됩니다")
                    break
                else:
                    print("유효한 결제 방법을 선택하세요")
                    continue
            except:
                print("사실을 알려주세요 직원에게 고장났다고")

       

    # # 주문서 출력 
    def table(self):
        
        print('⟝' + '-' * 30 + '⟞')
        for i in range(5):
            print('|' + ' ' * 31 + '|')
        
        for i in range(len(self.ordered_menu)):
            print(f"{self.ordered_menu[i]} : {self.sum_price[i]}")
        print(f"총 {len(self.ordered_menu)} 잔")
        print(f"합계 : {sum(self.sum_price)}")
        if self.payment_flag > 0:                   # 결제방법을 플래그 숫자로 기억하기
            print("$ 현금 결제됨 $")
        else:
            print("$ 카드 결제됨 $")
        

        for i in range(5):
            print('|' + ' ' * 31+ '|')
        print('⟝' + '-' * 30 + '⟞')

        
me_at = Kiosk()
me_at.menu_print()
me_at.menu_select()
me_at.pay()
me_at.table()