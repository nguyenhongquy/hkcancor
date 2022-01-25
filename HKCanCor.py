# -*- coding: utf-8 -*-
"""
Spyder Editor

HKCancor
"""

import pycantonese
corpus1 = pycantonese.hkcancor()
#words_by_utterances = corpus1.words(by_utterances=True)
sfps = corpus1.search(pos='Y', by_utterances=True)
len(sfps)   #17542 sentences

#%%
import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='tieudiep', #your password
    database='Cantonese' 
    )

mycursor = mydb.cursor()
#mycursor.execute("SHOW TABLES")
#mycursor.execute("SELECT * FROM cantonese")
#myresult = mycursor.fetchall()
#for x in myresult:
#    print(x)
    
#%%

for j in range(len(sfps)):

    sql = "INSERT INTO sentence VALUES(%s)"
    val = (j,)
    mycursor.execute(sql, val)
    mydb.commit()    
    
    for token in sfps[j]:
        sql = "SELECT * FROM pos WHERE pos_type = %s"
        pos_type = (token.pos, )
        mycursor.execute(sql, pos_type)
        myresult = mycursor.fetchall()
        if len(myresult) == 0:
            mycursor.execute("SELECT MAX(pos_num) FROM pos")
            myresult = mycursor.fetchone()        
            if type(myresult[0]) == int:
                pos_id = myresult[0] + 1;
            else:
                pos_id = 0;
            sql = "INSERT INTO pos(pos_type, pos_num) VALUES(%s, %s)"
            val = (token.pos, pos_id)
            mycursor.execute(sql, val)
            mydb.commit()
    
    
    for i in range(len(sfps[j])):
        mycursor.execute("SELECT MAX(id) FROM words")
        myresult = mycursor.fetchone()
        if type(myresult[0]) == int :
            word_id = myresult[0] + 1
        else :
            word_id = 0;
        sql = "SELECT pos_num FROM pos WHERE pos_type = %s"
        val = (sfps[j][i].pos, )
        mycursor.execute(sql, val)
        myresult = mycursor.fetchone()
        word_pos = myresult[0]
        sql = "INSERT INTO words(id, chi_char, pos, roman, sent_seq, sent_num) VALUES(%s, %s, %s, %s, %s, %s)"
        val = (word_id, sfps[j][i].word, word_pos, sfps[j][i].jyutping, i, j)
        mycursor.execute(sql, val)
        mydb.commit()
       # print(mycursor.rowcount, "record inserted")
     

#%% Co-occurence of SFPs
# -- Used after adverbials (POS tag: ‘D’ pos_num = '4' or ‘C’, pos_num='26')
# -- Find all examples of right dislocation 
# -- Clusters: more than one SFPs
# -- Share the same basic particle but come with various tonal variants (e.g. aa1, aa3, aa6)

    
   
