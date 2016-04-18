import os
import time
import random
import hashlib, uuid, decimal
import psycopg2
import psycopg2.extras
from collections import defaultdict
from flask import Flask, render_template, request, session, redirect, url_for
from flask.ext.socketio import SocketIO, emit

app = Flask(__name__)
app.secret_key = os.urandom(24).encode('hex')
socketio = SocketIO(app)

user = {}
passed = False
name = ''

def connectToDB():
    connectionString = 'dbname=coffee user=visiting password=06*65uSl13Cu host=localhost'
    print(connectionString)
    try: 
        # there can be lots of errors early on, good to catch 'em. 
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")


@app.route('/')
def home():
    global passed
    global name
    if passed:
        passed = False
        session['uuid'] = uuid.uuid1()
        user[session['uuid']] = {'username': name}
        name = ""

    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('index.html', selected="home", loggedIn=loggedIn)


@app.route('/browse', methods = ['GET','POST'])
def browse():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('browse.html', selected="browse", loggedIn=loggedIn)

@app.route('/learn', methods = ['GET','POST'])
def learn():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('learn.html', selected="learn", loggedIn=loggedIn)
    # results = []
    
    # con = connectToDB()
    # cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    # try:
    #     cur.execute("SELECT * FROM learn")
    #     results = cur.fetchall()
    # except:
    #     print("Couldn't retrive roast types")
    
    # return render_template('learn.html', selected="learn", loggedIn=loggedIn, roasts=results)

@app.route('/about', methods=['GET'])
def about():	
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('about.html', selected="about", loggedIn=loggedIn)
    
@app.route('/addRecipe', methods = ['GET','POST'])
def addRecipe():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True
    return render_template('addRecipe.html', selected='addRecipe', loggedIn=loggedIn)

   
@app.route('/login', methods = ['GET','POST'])
def login():
    if 'uuid' in session:
        return redirect(url_for('account'))
    else:
        return render_template('login.html', selected="login/account", loggedIn=False)

@app.route('/register', methods = ['GET'])
def register():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('register.html', loggedIn=loggedIn)

@app.route('/account')
def account():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('account.html', selected='login/account', loggedIn=loggedIn)



@socketio.on('connect', namespace='/browse')
def makeConnection():
    print "CONNECTED TO BROWSE" 

@socketio.on('search', namespace='/browse')
def search(roast, region, price, orderBy, searchTerm):
    results = []
    con = connectToDB()
    cur = con.cursor()
    if searchTerm:
        searchTerm = '%' + searchTerm + '%'
        statement = "SELECT a.name, f.price, f.weight, c.roast, a.body, b.region, a.description FROM coffee_names AS a INNER JOIN coffee_region AS d ON a.name = d.name INNER JOIN region AS b ON d.region_id = b.region_id INNER JOIN coffee_roast AS e ON a.name = e.name INNER JOIN roast AS c ON e.roast_id = c.roast_id INNER JOIN coffee_cost AS f ON a.name = f.name WHERE LOWER(a.name) LIKE LOWER(%s) OR LOWER(a.body) LIKE LOWER(%s) OR LOWER(a.description) LIKE LOWER(%s)"
        try:
            cur.execute(statement, [searchTerm, searchTerm, searchTerm])
            results = cur.fetchall()
        except Exception, e:
            raise e
    else:
        try:
            query = "SELECT a.name AS Name, f.price AS Cost, f.weight, c.roast AS Roast, a.body, b.region AS Region, a.description FROM coffee_names AS a INNER JOIN coffee_region AS d ON a.name = d.name INNER JOIN region AS b ON d.region_id = b.region_id INNER JOIN coffee_roast AS e ON a.name = e.name INNER JOIN roast AS c ON e.roast_id = c.roast_id INNER JOIN coffee_cost AS f ON a.name = f.name WHERE c.roast LIKE %s OR b.region LIKE %s OR f.price <= %s ORDER BY " + orderBy 
            cur.execute(query, [roast, region, price])
            results = cur.fetchall()
        except Exception, e:
            raise e
    emit('clearList')
    for item in results:
        coffee = {'name': item[0], 'weight': item[2], 'roast': item[3], 'body': item[4], 'region': item[5], 'description': item[6]}
        emit('printResults', coffee)



@socketio.on('connect', namespace='/form')
def makeConnection():
    print "CONNECTED TO FROM"


@socketio.on('register', namespace='/form')
def register(firstName, lastName, zipcode, favCoffee, email, username, password, passwordConf):
    con = connectToDB()
    cur = con.cursor()
    if not firstName or not lastName or not zipcode or not favCoffee or not username or not password or not passwordConf:
            emit('FormFail', 'Please fill out all of the fields!')
    else:
        # Check if username already exists
        query = "SELECT username FROM login WHERE username = %s"
        cur.execute(query, [username])
        userCheck = cur.fetchall()
        if len(userCheck) > 0:
            emit('FormFail', 'Username already taken!')
        # Check if passwords match
        else:
            if password != passwordConf:
                emit('FormFail', 'Passwords do not match!')
            else: 
                # Insert new user into DB and load login page
                try:
                    query = "INSERT INTO login (first_name, last_name, username, password) VALUES (%s, %s, %s, crypt(%s, gen_salt('bf')))"
                    cur.execute(query, [firstName, lastName, username, password])
                    con.commit()
                    query = "INSERT INTO user_info (username, email, zipcode, favorite_coffee) VALUES (%s, %s, %s, %s)"
                    cur.execute(query, [username, email, zipcode, favCoffee])
                    con.commit()
                    emit('redirect', {'url': url_for('login')})
                except Exception, e:
                    raise e
                    con.rollback()

@socketio.on('login', namespace='/form')
def login(username, password):
    con = connectToDB()
    cur = con.cursor()
    # Track log in success state
    global passed
    global name
    query = "SELECT Username, Password FROM login WHERE username = %s and password = crypt(%s, password)"
    cur.execute(query, [username, password])
    valdate = cur.fetchall()
    # Check if user info was found in DB
    if len(valdate) != 0:
        # Create session variables for logged in user
        passed = True
        name = username
        emit('redirect', {'url': url_for('home')})
    else:
        emit('FormFail', 'Invalid username or password!')

@socketio.on('addRecipe', namespace='/addRecipe')
def addRecipe(title,recipe):
    con = connectToDB()
    cur = con.cursor()
    #get user's id
    statement = "SELECT id FROM login where username = %s"
    cur.execute(statement,(user[session['uuid']]['username'],))
    userId = cur.fetchone()[0]
    print "Username?",user[session['uuid']]['username']
    statement = "INSERT INTO recipes (title,recipe,login_id) VALUES (%s,%s,%s)"
    cur.execute(statement,(title,recipe,userId))
    con.commit()
    emit('redirect', {'url': url_for('home')})

# start the server
if __name__ == '__main__':
    socketio.run(app, host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
