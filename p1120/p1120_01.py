import pandas as pd

# 파일읽어오기
df = pd.read_json('p1120/gallerylist.json')
print(df.head(2))


# 파일저장
df.to_csv('gallerylist.csv',encoding='utf-8-sig')
print('완료')