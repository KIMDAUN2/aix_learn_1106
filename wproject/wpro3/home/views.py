from django.shortcuts import render
from django.http import JsonResponse
from pathlib import Path
from scipy.special import expit
import numpy as np
import joblib

BASE_DIR = Path(__file__).resolve().parent.parent
model_wine = joblib.load(BASE_DIR / "model_wine.joblib")

def ajax_data(request):
    #html에서 들어온 입력데이터
    data= request.POST.get('data','9.4,1.9,3.51')

    #파일변환
    in_data =data.split(',')
    in_data = list(map(float,in_data))
    print('입력데이터 : ',in_data)

    #예측
    result = model_wine.predict([in_data])

    #확률
    decisions = model_wine.decision_function([in_data])
    white = expit(decisions)[0]                     
    red = np.round(1 - white, decimals=3)
    white = np.round(white, decimals=3)         

    if result[0] == 0:
        result_data ='레드와인'
    else:
        result_data ='화이트와인 아님'
    print(f'예측와인 : {result_data} (레드: {red}, 화이트: {white})')

    # 파일전달
    context = {
        'result_data':result_data,    #예측결과
        'result2':float(red),
        'result3':float(white),         
    }
    return JsonResponse(context)


def index(request):
    return render(request,'index.html')