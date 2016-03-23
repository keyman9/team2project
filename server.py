import os
import time
import random
import hashlib, uuid
import psycopg2
import psycopg2.extras
from flask import Flask, render_template, request


app = Flask(__name__)

def connectToDB():
    connectionString = 'dbname=Coffee user=visiting password=06*65uSl13Cu host=localhost'
    print connectionString
    try: 
        # there can be lots of errors early on, good to catch 'em. 
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")


@app.route('/')
def mainIndex():
    return render_template('index.html', active = "home")
    

@app.route('/register', methods = ['GET','POST'])
def userlogin():
    # con = connectToDB()
    # cur = con.cursor()
    
    # print(request.form['first'], request.form['last'])
    # print("Here")
    # salt = uuid.uuid4().hex
    # hashedPassword = hashlib.sha512(request.form['password'] + salt).hexdigest()
    
    
    return render_template('register.html', active = "home")



# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
