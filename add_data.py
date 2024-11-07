import sqlite3
import json

db  = sqlite3.connect("cah.db")

with open('cards.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    pack_id = 0
    for pack in data:
        # inserting pack in packs table in cards.db
        name = pack.get("name")
        db.execute('''
                    INSERT INTO "packs" ("id","name")
                    VALUES (?,?);
        ''',(pack_id,name))

        white_cards = pack.get("white")

        for white_card in white_cards:
            text = white_card.get('text')

            db.execute('''
                INSERT INTO "cards" ("content","type","pack_id")
                VALUES (?,'White',?);''',(text,pack_id))
        
        black_cards = pack.get("black")

        for black_card in white_cards:
            text = black_card.get('text')
            
            db.execute('''
                INSERT INTO "cards" ("content","type","pack_id")
                VALUES (?,'Black',?);''',(text,pack_id))
            

        pack_id += 1



