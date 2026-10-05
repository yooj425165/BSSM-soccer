-- 데이터베이스가 없으면 생성 (선택 사항)
CREATE DATABASE IF NOT EXISTS football_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE football_db;

-- 1. 선수 (players) 테이블
CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,                   -- 선수 이름
    position VARCHAR(20) NOT NULL,               -- 포지션 (예: ST, CM, CB, GK)
    matches_played INT UNSIGNED DEFAULT 0,        -- 경기 수
    goals INT UNSIGNED DEFAULT 0,                 -- 골 수
    assists INT UNSIGNED DEFAULT 0,               -- 어시스트 수
    
    -- 기본 능력치 (0~99 스탯 범위)
    stat_speed INT UNSIGNED DEFAULT 50,           -- 속도
    stat_physical INT UNSIGNED DEFAULT 50,        -- 피지컬
    stat_defending INT UNSIGNED DEFAULT 50,       -- 수비
    stat_shooting INT UNSIGNED DEFAULT 50,        -- 슈팅
    stat_passing INT UNSIGNED DEFAULT 50,         -- 패스
    stat_dribbling INT UNSIGNED DEFAULT 50,       -- 드리블
    
    is_hof BOOLEAN DEFAULT FALSE,                 -- 명예의 전당(Hall of Fame) 여부 (TRUE/FALSE)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. 경기 (matches) 테이블
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    blue_team_name VARCHAR(50) DEFAULT 'Blue Team', -- 블루팀 이름
    red_team_name VARCHAR(50) DEFAULT 'Red Team',   -- 레드팀 이름
    blue_score INT UNSIGNED DEFAULT 0,             -- 블루팀 득점
    red_score INT UNSIGNED DEFAULT 0,              -- 레드팀 득점
    match_date DATETIME DEFAULT CURRENT_TIMESTAMP,  -- 경기 일시
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. 커뮤니티 게시글 (posts) 테이블
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,                  -- 게시글 제목
    content TEXT NOT NULL,                         -- 게시글 내용
    author VARCHAR(50) NOT NULL,                  -- 작성자 (닉네임 또는 이름)
    player_id INT NULL,                           -- (선택) 특정 선수와 관련된 글일 경우 FK
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- 선수가 삭제되어도 게시글은 유지되도록 SET NULL 설정
    CONSTRAINT fk_posts_player FOREIGN KEY (player_id) 
        REFERENCES players(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;