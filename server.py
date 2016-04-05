import os
import time
import random
import hashlib, uuid
import psycopg2
import psycopg2.extras
from collections import defaultdict
from flask import Flask, render_template, request, session
from flask.ext.socketio import SocketIO, emit

app = Flask(__name__)
app.secret_key = os.urandom(24).encode('hex')
socketio = SocketIO(app)

def connectToDB():
    connectionString = 'dbname=coffee user=visiting password=06*65uSl13Cu host=localhost'
    print(connectionString)
    try: 
        # there can be lots of errors early on, good to catch 'em. 
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")


@socketio.on('connect')
def makeConnection():
    print "connected"

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
    con = connectToDB()
    cur = con.cursor()
    if request.method == 'POST':
        # Get the user inputs into variables
        firstName = request.form['first']
        lastName = request.form['last']
        zipcode = request.form['zipcode']
        favCoffee = request.form['fav-coffee']
        username = request.form['username']
        password = request.form['password']
        passwordConf = request.form['password-conf']
        # Check if username already exists
        query = "SELECT username FROM login WHERE username = %s"
        cur.execute(query, [username])
        userCheck = cur.fetchall()
        if len(userCheck) > 0:
            return render_template('register.html', invalid="Username is already taken!")
        else:
            if password != passwordConf:
                return render_template('register.html', invalid="Passwords do not match!")
            else: 
                try:
                    query = "INSERT INTO login (first_name, last_name, username, password) VALUES (%s, %s, %s, crypt(%s, gen_salt('bf')))"
                    cur.execute(query, [firstName, lastName, username, password])
                    con.commit()
                    query = "INSERT INTO user_info (username, zipcode, favorite_coffee) VALUES (%s, %s, %s)"
                    cur.execute(query, [username, zipcode, favCoffee])
                    con.commit()
                    return render_template('login.html', selected="login/account")

                except Exception, e:
                    raise e
                    con.rollback()


    return render_template('register.html')


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
            return render_template('login.html', selected="login/account", loggedIn=False, invalid="Invalid Username or Password")
    
    loggedIn = False
    if 'username' in session:
        loggedIn = True

    return render_template('login.html', selected="login/account", loggedIn=loggedIn)

@app.route('/shop', methods = ['GET', 'POST'])
def shop():

    loggedIn = False
    return render_template('shop.html', selected="shop", loggedIn=loggedIn)





# start the server
if __name__ == '__main__':
    # app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
    socketio.run(app, host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
