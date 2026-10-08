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

def get_db():
    return py.connect(
        host='db',
        port=3306,
        user='root',
        password='q1w2e3',
        db='football_db',
        cursorclass=py.cursors.DictCursor # 결과를 {'id': 1, 'name': '손흥민'} 형태(dict)로 받기 위한 설정
    )

@app.get("/api/players")
def get_players():
    conn = get_db()
    cursor = conn.cursor()
    sql = "SELECT * FROM players"
    cursor.execute(sql)
    players = cursor.fetchall()
    cursor.close()
    conn.close()
    return players

@app.post("/api/register")
def get_players(data: dict):
    conn = get_db()
    cursor = conn.cursor()
    sql = "INTO players (name, position, speed, physical, defending, shooting, passing, dribbling) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, (
        data.get("name"),
        data.get("position"),
        int(data.get("speed", 0)),
        int(data.get("physical", 0)),
        int(data.get("defense", 0)),
        int(data.get("shoot", 0)),
        int(data.get("pass", 0)),
        int(data.get("drible", 0)),
    ))
    conn.commit()
    cursor.close()
    conn.close()
    return {"status" : "sucess"}
