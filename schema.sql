CREATE TABLE "packs" (
    "id" INT,
    "name" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

CREATE TABLE "cards" (
    "id" INT ,
    "content" TEXT NOT NULL,
    "type" TEXT  CHECK ("type" IN ('Black','White')) NOT NULL,
    "pack_id" INT,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("pack_id") REFERENCES "packs"("id")
);

CREATE TABLE "games" (
    "id" INT,
    "room_code" INT,
    "winner" INT DEFAULT NULL,
    "is_active" INT CHECK("is_active" IN (0,1)) DEFAULT 1,
    "num_blacks" INT CHECK("num_blacks" > 0),
    PRIMARY KEY ("id")
);

-- table specifying what game uses what packs
CREATE TABLE "game_uses_packs" (
    "game_id" INT,
    "pack_id" INT,
    FOREIGN KEY ("game_id") REFERENCES "games"("id"),
    FOREIGN KEY ("pack_id") REFERENCES "packs"("id"),
    PRIMARY KEY ("game_id","pack_id")
);

CREATE TABLE "players" (
    "id" INT,
    "username" TEXT UNIQUE NOT NULL,
    "points" INT DEFAULT 0 CHECK("points" >= 0),
    "password" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

--table to keep track of what player is in what game.
CREATE TABLE "player_in_game" (
    "id" INT,
    "player_id" INT NOT NULL,
    "game_id" INT NOT NULL,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("player_id") REFERENCES "players"("id"),
    FOREIGN KEY ("game_id") REFERENCES "games"("id")
);

--table to keep track of what player in what game makes what move
CREATE TABLE "moves" (
    "id" INT,
    "player_in_game_id" INT NOT NULL,
    "black_card_id" INT,
    "white_card_id" INT,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("player_in_game_id") REFERENCES "player_in_game"("id"),
    FOREIGN KEY ("black_card_id") REFERENCES "cards"("id"),
    FOREIGN KEY ("white_card_id") REFERENCES "cards"("id")    
);