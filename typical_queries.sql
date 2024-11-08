-- selecting given no. of black cards randomly from user defined packs
SELECT * FROM "black_cards"
WHERE trim("pack_name") IN ('2012 Holiday Pack','2013 Holiday Pack')
ORDER BY RANDOM()
LIMIT 50;

SELECT * FROM "white_cards"
WHERE trim("pack_name") IN ('2012 Holiday Pack','2013 Holiday Pack')
ORDER BY RANDOM()
LIMIT 50;

-- adding users
INSERT INTO "players" ("username","password")
VALUES ('test','1234');

-- adding games
INSERT INTO "games" ("room_code","num_blacks")
VALUES (1234,7);

-- adding pack details to games
INSERT INTO "game_uses_packs" ("pack_id","game_id")
VALUES (
    (SELECT "id" FROM "packs" WHERE "name" = '2012 Holiday Pack'),
    (SELECT "id" FROM "games" WHERE "room_code" = 1234)
);

-- distributing cards to players
INSERT INTO "player_has_cards" ("player_id","game_id","card_id")
VALUES (1,1,5);