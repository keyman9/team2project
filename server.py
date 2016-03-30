import os
import time
import random
import hashlib, uuid
import psycopg2
import psycopg2.extras
from collections import defaultdict
from flask import Flask, render_template, request, session

app = Flask(__name__)
app.secret_key = os.urandom(24).encode('hex')

def connectToDB():
    connectionString = 'dbname=coffee user=visiting password=06*65uSl13Cu host=localhost'
    print(connectionString)
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


@app.route('/browse', methods = ['GET','POST'])
def browse():
    #results = defaultdict(list)
    results = []
    colNames = []
    con = connectToDB()
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        searchFor = request.form['roast']
        statement = """SELECT * FROM coffee WHERE Roast = %s"""
        try:
            print(cur.mogrify(statement,(searchFor,)))
            cur.execute(statement,(searchFor,))
        except:
            print("Error executing select statement")
        results = cur.fetchall()
    try:
        cur.execute("""Select column_name from information_schema.columns where table_name = 'coffee'""")     
    except:
        print("Error retrieving Column names")
    colNames = cur.fetchall()    
    for item in colNames:
        for colName in item:
            colName = str(colName).capitalize()
    loggedIn = False
    if 'username' in session:
        loggedIn = True
    return render_template('browse.html',selected="browse",columns=colNames,results=results, loggedIn=loggedIn)

@app.route('/learn', methods = ['GET','POST'])
def learn():
    loggedIn = False
    if 'username' in session:
        loggedIn = True
    return render_template('learn.html', selected="learn", loggedIn=loggedIn)

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

    return render_template('register.html', selected="register")


@app.route('/about', methods=['GET'])
def about():
    loggedIn = False
    if 'username' in session:
        loggedIn = True
	return render_template('about.html', selected="about", loggedIn=loggedIn)
    
   
@app.route('/login', methods = ['GET','POST'])
def login():
    con = connectToDB()
    cur = con.cursor()
    if request.method == 'POST':
        # Get username and password inputs and check for info in DB
        username  = request.form['username']
        password = request.form['password']
        query = "SELECT Username, Password FROM login WHERE username = %s and password = crypt(%s, password)"
        cur.execute(query, [username, password])
        valdate = cur.fetchall()
        # Check if user info was found in DB
        if len(valdate) != 0:
            # Create session variables for logged in user
            session['username'] = username
            session['password'] = password
            return render_template('index.html', selected="home", loggedIn=True)
        else:
            return render_template('login.html', selected="login/account", loggedIn=False, invalid="INVALID INFO")
    
    loggedIn = False
    if 'username' in session:
        loggedIn = True
    return render_template('login.html', selected="login/account", loggedIn=loggedIn)





# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
