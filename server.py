import os
import time
import random
import hashlib, uuid
import psycopg2
import psycopg2.extras
from flask import Flask, render_template, request


app = Flask(__name__)

def connectToDB():
    connectionString = 'dbname=coffee user=visiting password=06*65uSl13Cu host=localhost'
    print connectionString
    try: 
        # there can be lots of errors early on, good to catch 'em. 
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")


@app.route('/')
def mainIndex():
    return render_template('index.html', selected="home")
    

@app.route('/register', methods = ['GET','POST'])
def userlogin():
    con = connectToDB()
    cur = con.cursor()
    if request.method == 'POST':
        # http://stackoverflow.com/questions/9594125/salt-and-hash-a-password-in-python
        # print(request.form['first'])
        salt = uuid.uuid4().hex
        hashed_password = hashlib.sha224(request.form['password'] + salt).hexdigest()
        # print('Password: ' + hashed_password)
        cur.execute("""INSERT INTO users (First_Name, Last_Name, Username, Password) VALUES (%s, %s, %s, %s)""" ,(request.form['first'], request.form['last'], request.form['username'], hashed_password))
        con.commit()
        print("Great Success!")
        
    return render_template('register.html', selected="register")




# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)