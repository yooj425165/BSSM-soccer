from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import pymysql as py

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/players")
def get_players():
    conn = py.connect(
        host='127.0.0.1',
        port=3305,
        user='root',
        password='q1w2e3',
        db='football_db',
        cursorclass=py.cursors.DictCursor # 결과를 {'id': 1, 'name': '손흥민'} 형태(dict)로 받기 위한 설정
    )
    cursor = conn.cursor()
    sql = "SELECT * FROM players"
    cursor.execute(sql)
    players = cursor.fetchall()
    cursor.close()
    conn.close()
    return players
