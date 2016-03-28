import os
import time
import random
import hashlib, uuid
import psycopg2
import psycopg2.extras
from flask import Flask, render_template, request, session

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
	loggedIn = False
	if 'username' in session:
		loggedIn = True
	return render_template('index.html', selected="home", loggedIn=loggedIn)
    

@app.route('/home')
def home():
    return render_template('home.html', active = "home")
    


@app.route('/register', methods = ['GET','POST'])
def register():
    # con = connectToDB()
    # cur = con.cursor()
    if request.method == 'POST':
        # print(request.form['first'])
        salt = uuid.uuid4().hex
        hashed_password = hashlib.sha224(request.form['password'] + salt).hexdigest()
        # print('Password: ' + hashed_password)
        # cur.execute("""INSERT INTO users (First_Name, Last_Name, Username, Password) VALUES (%s, %s, %s, %s)""" ,(request.form['first'], request.form['last'], request.form['username'], hashed_password))
        # con.commit()
        print("Great Success!")

    
    
    return render_template('register.html', active = "register")
    
    
@app.route('/learn', methods = ['GET','POST'])
def learn():
    return render_template('learn.html', selected = "learn",active = "learn")

@app.route('/login', methods = ['GET','POST'])
def login():
    # con = connectToDB()
    # cur = con.cursor()
    if request.method == 'POST':
        username  = request.form['username']
        password = request.form['password']
        print("Username: " + username + "Password: " + password)
        # print('Password: ' + hashed_password)
        # valdate = cur.execute("SELECT Username, Password FROM Users WHERE Username = %s and Password = %s" % (username,password))
        # if valdate != []:
        #     print("Connection Successful")
        #     con.commit()
        # else:
        #     print("Username not valid")

    
    return render_template('login.html', active = "home")




# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
