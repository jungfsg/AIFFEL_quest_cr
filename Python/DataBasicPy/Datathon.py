import pandas as pd
import matplotlib.pyplot as plt
import math
import googlemaps
import time

# 데이터 불러오기
df_ABListing = pd.read_csv("C:/Workspace/py/NewYork/new_york_listings_2024.csv")
df_NyBestRes = pd.read_csv("C:/Workspace/py/NewYork/10k - trip_rest_neywork_1.csv")

# 데이터 확인
print(df_ABListing.head())
print(df_ABListing.info())
print(df_NyBestRes.head())
print(df_NyBestRes.info())

# 결측치 검색
# missing_AB = df_ABListing.isnull().sum()
# missing_NYR = df_NyBestRes.isnull().sum()
# print(missing_AB)
# print(missing_NYR)

# 데이터셋에 catagory라고 되어있음
df_NYKRfood = df_NyBestRes[df_NyBestRes["Catagory"].str.contains("Korean", na = False)]

# 한식당 전체 이름 리스트
KR_title_list = df_NYKRfood['Title'].tolist()
print(KR_title_list)

print(df_NYKRfood)
# 인기지역을 정답 라벨로 쓰는 것이 적절한지

# 데이터셋 위도 경도 표시
df_ABListing.plot.scatter(x = 'longitude', y = 'latitude', figsize = (10, 8))
plt.show()

# reviews_per_month top 20의 그래프
top_20_reviews = df_ABListing.sort_values(by='reviews_per_month', ascending=False).head(300)
top_20_reviews.plot.scatter(x='longitude', y='latitude', figsize=(10, 8))
# true 

plt.title("Top Listings by Reviews per Month")
plt.show()

# df_NYKRfood.plot.scatter(x = 'longitude', y = 'latitude', figsize = (10, 8))
# plt.show()

# 해야 하는 것
# 데이터 전처리 >> 필요한 칼럼 분리하기 >> 결측값 찾아보기 >> 
# 데이터 나눠서 정규화하기? 좌표에 대입해서 컬러 정규화 수치로 지도에 '인기' 분포 나타내기?
# 리뷰 개수로 판단해보기


# 위에서 반환한 한식당 이름 리스트를 구글 api에서 좌표로 받기
# 식당 이름에 지역 단서를 달아두면 정확한 식당을 찾아낼 가능성이 높아짐
# API 키 설정
'''
gmaps = googlemaps.Client(key="MY_API")

# 각 식당 이름에 "(New York)" 추가 >> 위치 힌트
restaurant_names = [restaurant + " (New York)" for restaurant in KR_title_list]

# 각 식당에 대한 위도, 경도 리스트
restaurant_coords = []

for restaurant in restaurant_names:
    try:
        # Place Search API 요청
        places_result = gmaps.places(restaurant)
        
        # 결과 확인
        if places_result["status"] == "OK":
            latitude = places_result["results"][0]["geometry"]["location"]["lat"]
            longitude = places_result["results"][0]["geometry"]["location"]["lng"]
            restaurant_coords.append({"name": restaurant, "latitude": latitude, "longitude": longitude})
            print(f"{restaurant} - 위도: {latitude}, 경도: {longitude}")
        else:
            print(f"{restaurant} - 식당을 찾을 수 없습니다.")
    
    except Exception as e:
        print(f"Error occurred while searching for {restaurant}: {e}")
    
    # API 호출 제한을 피하기 위해 잠시 대기
    # 각 식당의 좌표를 1초 간격으로 불러오기 >> API 호출 후 1초 대기
    time.sleep(1)
'''
# 출력된 리스트 저장
restaurant_coords = [{'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'Jungsik (New York)', 'latitude': 40.7188267, 'longitude': -74.00907509999999}, {'name': 'Her Name Is Han (New York)', 'latitude': 40.7462496, 'longitude': -73.9847616}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': '54 Below (New York)', 'latitude': 40.764451, 'longitude': -73.983671}, {'name': 'Barn Joo 35 (New York)', 'latitude': 40.749723, 'longitude': -73.98577770000001}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'Danji (New York)', 'latitude': 40.7640488, 'longitude': -73.98683989999999}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'Mudspot (New York)', 'latitude': 40.7290618, 'longitude': -73.9866675}, {'name': 'Beer Culture (New York)', 'latitude': 40.75959290000001, 'longitude': -73.9897015}, {'name': 'Bar Boulud (New York)', 'latitude': 40.7718627, 'longitude': -73.98185169999999}, {'name': 'Carnegie Diner & Cafe (New York)', 'latitude': 40.765753, 'longitude': -73.98012109999999}, {'name': 'Tabernacle Steakhouse (New York)', 'latitude': 40.754045, 'longitude': -73.9933586}, {'name': "Joe G's Restaurant Italiano (New York)", 'latitude': 40.765643, 'longitude': -73.983001}, {'name': 'BCD Tofu House (New York)', 'latitude': 40.7475555, 'longitude': -73.9860445}, {'name': 'Woorijip (New York)', 'latitude': 40.7474589, 'longitude': -73.9864521}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'Thursday Kitchen (New York)', 'latitude': 40.727627, 'longitude': -73.9837604}, {'name': 'Mokbar (New York)', 'latitude': 40.7422176, 'longitude': -74.0059069}, {'name': 'Five Senses (New York)', 'latitude': 40.747715, 'longitude': -73.98605599999999}, {'name': 'Socarrat Paella Bar - Midtown East (New York)', 'latitude': 40.75529, 'longitude': -73.96846}, {'name': 'Peacefood Cafe (New York)', 'latitude': 40.7332316, 'longitude': -73.9929149}, {'name': "Gabriel's Italian Bar and Restaurant (New York)", 'latitude': 40.7652581, 'longitude': -73.97567579999999}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': "Hell's Chicken (New York)", 'latitude': 40.7618549, 'longitude': -73.9940867}, {'name': 'Han Bat (New York)', 'latitude': 40.7502064, 'longitude': -73.9863009}, {'name': 'KOBA Korean Bbq (New York)', 'latitude': 40.7592857, 'longitude': -73.9685673}, {'name': 'Vestry (New York)', 'latitude': 40.7253081, 'longitude': -74.00540699999999}, {'name': 'Chopt Salad (New York)', 'latitude': 40.7611616, 'longitude': -73.98109769999999}, {'name': 'Anytime (New York)', 'latitude': 40.7477749, 'longitude': -73.9867579}, {'name': 'Jeju Noodle Bar (New York)', 'latitude': 40.7329889, 'longitude': -74.0073417}, {'name': 'Barn Joo Nomad (New York)', 'latitude': 40.74607109999999, 'longitude': -73.9902233}, {'name': 'Off the Wagon (New York)', 'latitude': 40.7299239, 'longitude': -74.0007935}, {'name': 'Il Divo (New York)', 'latitude': 40.768135, 'longitude': -73.959204}, {'name': "Luke's Bar and Grill (New York)", 'latitude': 40.7746459, 'longitude': -73.957354}, {'name': 'Atomix (New York)', 'latitude': 40.744286, 'longitude': -73.9827936}, {'name': 'New York Kimchi (New York)', 'latitude': 40.7576225, 'longitude': -73.9792159}, {'name': 'The Jin (New York)', 'latitude': 40.7685636, 'longitude': -73.988753}, {'name': 'Pulqueria (New York)', 'latitude': 40.714458, 'longitude': -73.99825899999999}, {'name': 'Noodle Bar (New York)', 'latitude': 40.7291931, 'longitude': -73.9843779}, {'name': 'Cocoron (New York)', 'latitude': 40.7203008, 'longitude': -73.9930463}, {'name': 'Suzu Sushi (New York)', 'latitude': 40.7594619, 'longitude': -73.96230299999999}, {'name': 'Taim (New York)', 'latitude': 40.735997, 'longitude': -74.0019593}, {'name': 'Anand Indian Cuisine (New York)', 'latitude': 40.7722991, 'longitude': -73.9552362}, {'name': 'Soju Haus (New York)', 'latitude': 40.7469816, 'longitude': -73.9854428}, {'name': 'Mocha Burger - Soho (New York)', 'latitude': 40.7274326, 'longitude': -73.9997647}, {'name': 'Baby Brasa (New York)', 'latitude': 40.7359703, 'longitude': -74.0012344}, {'name': 'Kum Gang San (New York)', 'latitude': 40.7482739, 'longitude': -73.9877669}, {'name': 'Bocce USQ (New York)', 'latitude': 40.7364501, 'longitude': -73.98991269999999}, {'name': 'Char Sue (New York)', 'latitude': 40.719587, 'longitude': -73.9878488}, {'name': 'Stone Bridge Pizza & Salad (New York)', 'latitude': 40.7523041, 'longitude': -73.9806937}, {'name': '99 Cent Fresh Pizza (New York)', 'latitude': 40.7646066, 'longitude': -73.9825329}, {'name': 'Bosino NYC Brick Oven Pizza (New York)', 'latitude': 40.7987146, 'longitude': -73.9673487}, {'name': 'Rico Bagel (New York)', 'latitude': 40.7499588, 'longitude': -73.9817089}, {'name': "Ben & Jack's Steakhouse (New York)", 'latitude': 40.7518075, 'longitude': -73.97233539999999}, {'name': 'The Original Little Italy (New York)', 'latitude': 40.7512565, 'longitude': -73.9819345}, {'name': 'Blue Smoke (New York)', 'latitude': 40.638293, 'longitude': -73.7810119}, {'name': 'Thai Peppercorn (New York)', 'latitude': 40.7881619, 'longitude': -73.9536761}, {'name': 'Poke Inn (New York)', 'latitude': 40.7625749, 'longitude': -73.98806809999999}, {'name': 'Potbelly Sandwich Shop (New York)', 'latitude': 40.7529644, 'longitude': -73.9888069}, {'name': 'The Marshal (New York)', 'latitude': 40.7612602, 'longitude': -73.9940357}, {'name': 'The Monarch Room (New York)', 'latitude': 40.7503923, 'longitude': -73.986809}, {'name': 'Brooklyn bridge bistro (New York)', 'latitude': 40.6964637, 'longitude': -73.9882724}, {'name': 'The Dolar Shop Manhattan (New York)', 'latitude': 40.7310965, 'longitude': -73.98850790000002}, {'name': 'The Watering Hole (New York)', 'latitude': 40.73730320000001, 'longitude': -73.9873787}, {'name': 'Grubbs Takeaway (New York)', 'latitude': 40.7420394, 'longitude': -74.02979479999999}, {'name': 'The Grid at Great Jones Distilling Co. (New York)', 'latitude': 40.7279343, 'longitude': -73.9942513}, {'name': 'LES Crapes & Taqueria (New York)', 'latitude': 40.7154996, 'longitude': -73.9899549}, {'name': 'Cantina 33 (New York)', 'latitude': 40.7001048, 'longitude': -73.907388}, {'name': 'Saar Indian Bistro (New York)', 'latitude': 40.7626911, 'longitude': -73.9848128}, {'name': 'Emperor Dumpling (New York)', 'latitude': 40.7461489, 'longitude': -73.9902178}, {'name': 'Subway (New York)', 'latitude': 40.7584154, 'longitude': -73.9918563}, {'name': 'Cafe le Gamin (New York)', 'latitude': 40.7282982, 'longitude': -73.95713219999999}, {'name': 'Merchants Cigar Bar (New York)', 'latitude': 40.7614153, 'longitude': -73.960903}, {'name': 'Benjamin Steakhouse (New York)', 'latitude': 40.7517399, 'longitude': -73.9790543}, {'name': "Cappone's Downtown Llc (New York)", 'latitude': 40.7370269, 'longitude': -74.0051508}]
print(restaurant_coords)

# 전처리 필요함
# 좌표만 남기기(한식당 유무만 파악할 경우라면)
# 반경 단위 파악해봐야 함(위도 경도 숫자의 실제 거리 파악해보고 1km에 해당하는 거리만큼의 좌표를 구분?)
# 위도 경도 계산 API도 있는데 유료인것같음
'''
# 계산 함수
def haversine(lat1, lon1, lat2, lon2):
    R = 6371  # 지구 반지름 (km)

    lat1_rad = math.radians(lat1)
    lon1_rad = math.radians(lon1)
    lat2_rad = math.radians(lat2)
    lon2_rad = math.radians(lon2)

    dlon = lon2_rad - lon1_rad
    dlat = lat2_rad - lat1_rad

    a = math.sin(dlat / 2)**2 + math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(dlon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    distance = R * c
    return distance

# 예시: 서울과 부산의 거리 계산
seoul_lat, seoul_lon = 37.5665, 126.9780
busan_lat, busan_lon = 35.1796, 129.0756

distance = haversine(seoul_lat, seoul_lon, busan_lat, busan_lon)
print(f"서울과 부산의 거리는 약 {distance:.2f} km입니다.")
'''

# 위도차이 < 기준 and 경도차이 < 기준:
# 주변에 뭔가 있음 == True
