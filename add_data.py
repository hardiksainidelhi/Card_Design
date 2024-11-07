import sqlite3
import json

db  = sqlite3.connect("cah.db")

with open('cards.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
    for pack in data:
        # inserting pack in packs table in cards.db
        name = pack.get("name")
        db.execute('''
                    INSERT INTO "packs" ("name")
                    VALUES (?)
        ''',(name,))
        



