CREATE TABLE "packs" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL
);

CREATE TABLE "cards" (
    "id" INTEGER PRIMARY KEY ,
    "content" TEXT NOT NULL,
    "type" TEXT  CHECK ("type" IN ('Black','White')) NOT NULL,
    "pack_id" INT, "pick" CHECK ("pick" >= 0) DEFAULT 0,
    FOREIGN KEY ("pack_id") REFERENCES "packs"("id")
);

CREATE TABLE "games" (
    "id" INTEGER PRIMARY KEY,
    "room_code" INT,
    "winner" INT DEFAULT NULL,
    "is_active" INT CHECK("is_active" IN (0,1)) DEFAULT 1,
    "num_blacks" INT CHECK("num_blacks" > 0)
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
    "id" INTEGER PRIMARY KEY,
    "username" TEXT UNIQUE NOT NULL,
    "points" INT DEFAULT 0 CHECK("points" >= 0),
    "password" TEXT NOT NULL
);

CREATE TABLE "player_has_cards" (
    "id" INTEGER PRIMARY KEY,
    "player_id" INT,
    "game_id" INT,
    "card_id" INT,
    FOREIGN KEY ("card_id") REFERENCES "cards"("id"),
    FOREIGN KEY ("player_id") REFERENCES "players"("id"),
    FOREIGN KEY ("game_id") REFERENCES "games"("id")
);

--table to keep track of what player is in what game.
CREATE TABLE "player_in_game" (
    "id" INTEGER PRIMARY KEY,
    "player_id" INT NOT NULL,
    "game_id" INT NOT NULL,
    FOREIGN KEY ("player_id") REFERENCES "players"("id"),
    FOREIGN KEY ("game_id") REFERENCES "games"("id")
);

--table to keep track of what player in what game makes what move
CREATE TABLE "moves" (
    "id" INTEGER PRIMARY KEY,
    "player_in_game_id" INT NOT NULL,
    "black_card_id" INT,
    "white_card_id" INT,
    FOREIGN KEY ("player_in_game_id") REFERENCES "player_in_game"("id"),
    FOREIGN KEY ("black_card_id") REFERENCES "cards"("id"),
    FOREIGN KEY ("white_card_id") REFERENCES "cards"("id")    
);

CREATE VIEW "black_cards" AS 
SELECT "cards"."id" AS "card_id","content","packs"."name" AS "pack_name","pick"
FROM "cards"
JOIN "packs" ON "packs"."id" = "cards"."pack_id"
WHERE "type" = 'Black' ;

CREATE VIEW "white_cards" AS 
SELECT "cards"."id" AS "card_id","content","packs"."name" AS "pack_name"
FROM "cards"
JOIN "packs" ON "packs"."id" = "cards"."pack_id"
WHERE "type" = 'White' ;

CREATE INDEX "packs_by_name" ON "packs"("name");
CREATE INDEX "cards_by_type" ON "cards"("type");