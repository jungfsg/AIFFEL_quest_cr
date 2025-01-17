# RPG

# 실제 피해량 == pureDamage
# 방어력에 감소하기 전 피해량 == damage
import time
import random as r

class Character():
    # 이름, 레벨, 체력, 공격력, 방어력의 속성
    # 파라미터 내에서 형식 정해두기
    def __init__(self, ID: str, level: int, HP: int, ATK: int, AMR: int):
        self.ID = ID
        self.level = level
        self.HP = HP
        self.ATK = ATK
        self.AMR = AMR

    # 인스턴스의 현재 체력이 0보다 큰지 bool값 반환하기
    def is_alive(self):
        return self.HP > 0
    

    # 공격을 받았을 때 방어력만큼 상쇄된 피해량만큼 현재 체력이 감소하는 메서드
    # 방어력보다 피해량이 낮으면 체력이 감소하지 않음
    # 피해량을 완전 상쇄하면 방어 메시지 출력하기
    def take_damage(self, damage):
        if self.AMR >= damage:
            pureDamage = 0
            # 완전방어시 연출
            time.sleep(0.6)
            print()
            print(f"🛡️  {self.ID}의 방어가 성공! 🛡️")
            print()
            time.sleep(0.6)
              
        # 피해량이 방어력보다 높을 때, 피해량에서 방어력만큼 감소시켜 HP에 반영함
        else:
            pureDamage = damage - self.AMR
        
        self.HP -= pureDamage
        print(f"{self.ID}의 HP: {self.HP}")
    
    # 타겟에게 피해를 입히는 메서드 // 피해량은 1 이상 공격력 사이의 랜덤값
    def attack_target(self, target):
        damage = r.randint(1, self.ATK)
        print(f"🪚  {self.ID}님이 {target.ID}에게 {damage} 피해량!")
        target.take_damage(damage)

    def __str__(self):
        return f"ID: {self.ID}, 레벨: {self.level}, HP: {self.HP}, 공격력: {self.ATK}, 방어력: {self.AMR}"

    
# Character 클래스를 상속받는 Player 클래스
class Player(Character):
    def __init__(self, ID: str):
        super().__init__(ID, level=1, HP=100, ATK=25, AMR=5)
        self.EXP = 0

    # 인수로 받은 정수만큼 경험치를 얻는 메서드
    # 얻은 경험치만큼 self.EXP를 더하기, 얻은 양을 별도로 출력하기
    # 레벨업 경험치를 넘길 경우 레벨업 메서드를 실행하고, 50을 제외한 나머지 경험치를 남겨두기
    def gain_exp(self, EXP: int):
        self.EXP += EXP
        print(f"{EXP}의 경험치를 획득!")
        if self.EXP >= 50:
            
            self.level_up()

    def __str__(self):
        return f"플레이어 {self.ID} (레벨 {self.level}): HP {self.HP}, 공격력 {self.ATK}, 방어력 {self.AMR}, 경험치 {self.EXP}"
        

    # exp 50 이상이면 실행되는 레벨업 메서드
    # 레벨 1, 공격력 10, 방어력 5 증가함
    # 레벨업 자체의 기능만 정의하고 레벨업은 gain_exp에서 시키기?
    def level_up(self):
        self.level += 1
        self.ATK += 10
        self.AMR += 5
        self.EXP -= 50
        print(f"***{self.ID}의 레벨이 {self.level}으로 올랐다!***")
        print(f"현재 레벨: {self.level}, 현재 EXP: {self.EXP}")

# Character 클래스를 상속받는 Monster 클래스
# 몬스터의 레벨에 비례하는 몬스터 능력치 정의
class Monster(Character):
    def __init__(self, ID: str, level: int):
        super().__init__(ID, level, HP = r.randint(10, 30) * level, ATK = r.randint(5, 20) * level, AMR = r.randint(1, 5) * level)
        # self.HP = r.randint(10, 30) * level
        # self.ATK = r.randint(5, 20) * level
        # self.AMR = r.randint(1, 5) * level
    def __str__(self):
        return f"몬스터 {self.ID} (레벨 {self.level}): HP {self.HP}, 공격력 {self.ATK}, 방어력 {self.AMR}"



# 배틀 함수 만들기
# is_alive가 False가 될 때 까지 멈추지 않는 죽음의 결투
# .ID 등을 사용해 필요한 출력값만 출력시키기
# 다음 몬스터가 남아있는데 사망할 경우 전투시작 메시지가 출력되고 나서 전투가 종료되었음
# 메시지 출력에 조건을 달아서 오출력을 방지함
def battle(player, monster):
    if player.is_alive() and monster.is_alive():            
        print(f"{monster} 상대로 전투를 시작합니다")          
    while player.is_alive() and monster.is_alive():
        player.attack_target(monster)
        # print(f"{player.ID}가 {monster.ID}를 공격함")
        if monster.is_alive():
            monster.attack_target(player)
            # print(f"{monster.ID}가 {player.ID}를 공격함")
            if player.is_alive() == False:
                # 사망 연출
                time.sleep(0.3)
                print('.')
                time.sleep(0.6)
                print('.')
                time.sleep(0.9)
                print('.')
                time.sleep(1.2)
                print('.')
                time.sleep(1.5)
                print(f"{player.ID}님이 사망했습니다..")
                time.sleep(0.6)
                print("Game Over")
                time.sleep(0.3)
                break
            
        else:
            player.gain_exp(monster.level * 20)
            time.sleep(0.9)
            print('='*20)
            print("😎😎 전투 승리!")
            print(f"{monster.ID}을(를) 이겼다!")
            print(f"{monster.level * 20}만큼의 경험치를 얻었습니다")
            print('='*20)
            time.sleep(0.9)
        

def main():
    monster_dict = {'슬라임':1, '고블린':2, '오크':4}
    player_ID = input("ID를 입력하세요: ")
    player = Player(player_ID)
    # 여러 몬스터를 for 문을 활용해 전투시키기
    # 몬스터 이름과 레벨을 딕셔너리에서 각각 참조해 모두와 전투 진행
    for monster_ID, monster_level in monster_dict.items():
        front_monster = Monster(monster_ID, monster_level)
        battle(player, front_monster)


main()