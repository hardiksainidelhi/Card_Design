import sqlite3
import json

db  = sqlite3.connect("cah.db")

with open('cards.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    pack_id = 0
    card_id = 0
    for pack in data:
        # inserting pack in packs table in cards.db
        name = pack.get("name").strip()
        db.execute('''
                    INSERT INTO "packs" ("id","name")
                    VALUES (?,?);
        ''',(pack_id,name))

        white_cards = pack.get("white")

        for white_card in white_cards:
            text = white_card.get('text')

            db.execute('''
                INSERT INTO "cards" ("id","content","type","pack_id")
                VALUES (?,?,'White',?);''',(card_id,text,pack_id))
            
            card_id += 1
        
        
        black_cards = pack.get("black")

        
        for black_card in black_cards:

            text = black_card.get('text')
            pick = black_card.get('pick')
        
            db.execute('''INSERT INTO "cards" ("id","content", "type", "pack_id", "pick")
                        VALUES (?, ?, 'Black', ?, ?);''', (card_id,text, pack_id, pick))

            card_id += 1

        pack_id += 1
    db.commit
    





