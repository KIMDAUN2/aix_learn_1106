# import os
# import time
# import pandas as pd
# import requests


# # 영화진흥위원회에서 재발급한 API 키를 환경 변수 KOBIS_API_KEY에 설정하세요.
# KEY = "41b06eb294b703de595d53d7206e16ea"
# URL = "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
# ITEMS_PER_PAGE = 100
# PAGE = 1  # 100개 요청

# if not KEY:
#     raise RuntimeError("KOBIS_API_KEY 환경 변수를 먼저 설정하세요.")

# params = {"key": KEY, 
#         "curPage": PAGE, 
#         "itemPerPage": ITEMS_PER_PAGE
#         }
# response = requests.get(URL, params=params, timeout=30)
# response.raise_for_status()
# data = response.json()

# if data.get("faultInfo"):
#     raise RuntimeError(f"KOBIS API 오류: {data['faultInfo']}")

# result = data["movieListResult"]
# movies = result["movieList"]
# rows = []

# for movie in movies:
#     rows.append({
#         "movie_cd": movie.get("movieCd", ""),
#         "movie_nm": movie.get("movieNm", ""),
#         "movie_nm_en": movie.get("movieNmEn", ""),
#         "prdt_year": movie.get("prdtYear", ""),
#         "open_dt": movie.get("openDt", ""),
#         "type_nm": movie.get("typeNm", ""),
#         "prdt_stat_nm": movie.get("prdtStatNm", ""),
#         "nation_alt": movie.get("nationAlt", ""),
#         "genre_alt": movie.get("genreAlt", ""),
#         "director": ", ".join(person.get("peopleNm", "") for person in movie.get("directors", [])),
#         "company": ", ".join(company.get("companyNm", "") for company in movie.get("companys", [])),
#     })

# df = pd.DataFrame(rows)
# if not df.empty:
#     df["open_dt"] = pd.to_datetime(
#         df["open_dt"], format="%Y%m%d", errors="coerce"
#     ).dt.strftime("%Y-%m-%d")

# output_path = os.path.join(os.path.dirname(__file__), "movie.csv")
# df.to_csv(output_path, index=False, encoding="utf-8-sig")
# print(f"총 {len(df)}개 영화 정보를 {output_path}에 저장했습니다.")



# #-----------------------------------------------------------------

import pandas as pd

# 파일읽어오기
df = pd.read_json('p1119/movie.json')
print(df.head(2))


# 파일저장
df.to_csv('movie.csv',encoding='utf-8-sig')
print('완료')