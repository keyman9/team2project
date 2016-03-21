import os
import time
import random
from flask import Flask, render_template, request

import psycopg2
import psycopg2.extras

app = Flask(__name__)

def connectToDB():
    connectionString = 'dbname=coffee user=visiting password=06*65uSl13Cu host=localhost'
    print connectionString
    try: 
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")


@app.route('/', methods=['POST', 'GET'])
def mainIndex():
    con = connectToDB()
    cur = con.cursor()
    if request.method == 'POST':
        try:
            name = request.form['name']
            price = request.form['price']
            weight = request.form['weight']
            roast = request.form['roast']
            region = request.form['region']
            description = request.form['description']
            query = 'INSERT INTO coffee (name, price, weight, roast, region, description) VALUES (%s, %s, %s, %s, %s, %s)'
            cur.execute(query, [name, price, weight, roast, region, description])
            con.commit()
        except:
            print 'INSERT ERROR'

    return render_template('index.html')


# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
