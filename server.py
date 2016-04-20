import os
import time
import random
import hashlib, uuid
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
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")

# Home Page
@app.route('/')
def home():
    global passed
    global name
    if passed:
        passed = False
        session['uuid'] = uuid.uuid1()
        user[session['uuid']] = {'username': name}
        name = ''

    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('index.html', selected="home", loggedIn=loggedIn)

# Browse Page
@app.route('/browse', methods = ['GET','POST'])
def browse():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('browse.html', selected="browse", loggedIn=loggedIn)

# Learn Page
@app.route('/learn', methods = ['GET','POST'])
def learn():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    results = [] 
    con = connectToDB()
    cur = con.cursor(cursor_factory=psycopg2.extras.DictCursor)
    try:
        cur.execute("SELECT * FROM learn")
        results = cur.fetchall()
    except:
        print("Couldn't retrive roast types")
    
    return render_template('learn.html', selected="learn", loggedIn=loggedIn, roasts=results)

# About Page
@app.route('/about', methods=['GET'])
def about():	
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('about.html', selected="about", loggedIn=loggedIn)
    
# Login Page   
@app.route('/login', methods = ['GET','POST'])
def login():
    if 'uuid' in session:
        return redirect(url_for('account'))
    else:
        return render_template('login.html', selected="login/account", loggedIn=False)

# Register Page
@app.route('/register', methods = ['GET'])
def register():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('register.html', loggedIn=loggedIn)

# My Account Page
@app.route('/account')
def account():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('account.html', selected='login/account', loggedIn=loggedIn)

# My Favorties Page
@app.route('/favorites')
def favorites():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('favorites.html', selected='login/account', loggedIn=loggedIn)

# Add Recipe Page
@app.route('/addRecipe', methods = ['GET','POST'])
def addRecipe():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('addRecipe.html', selected='login/account', loggedIn=loggedIn)

# Edit Account Page
@app.route('/edit')
def edit():
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

    return render_template('edit_account.html', selected='login/account', loggedIn=loggedIn)




##################### SocketIO Methods ##########################


###############################
# Socket Functions for Browse #
###############################
@socketio.on('connect', namespace='/browse')
def makeConnection():
    print "CONNECTED TO BROWSE" 

@socketio.on('search', namespace='/browse')
def search(roast, region, price, orderBy, searchTerm):
    loggedIn = False
    if 'uuid' in session:
        loggedIn = True

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

    if loggedIn:
        query = "SELECT coffee_name FROM user_likes WHERE username = %s"
        cur.execute(query, [user[session['uuid']]['username']])
        coffeeLikes = cur.fetchall()

    emit('clearList')
    for item in results:
        cost = str(item[1])
        print 'COST IS ' + cost
        coffee = {'name': item[0], 'price': cost, 'weight': item[2], 'roast': item[3], 'body': item[4], 'region': item[5], 'description': item[6], 'liked': False}
        if loggedIn:
            for like in coffeeLikes:
                if item[0] in like:
                    coffee['liked'] = True         
        emit('printResults', [coffee, loggedIn])

@socketio.on('updateFavorite', namespace='/browse')
def updateFavorite(coffeeName, liked):
    con = connectToDB()
    cur = con.cursor()
    try:
        if liked:
            query = "DELETE FROM user_likes WHERE username = %s AND coffee_name = %s"
        else:
            query = "INSERT INTO user_likes VALUES (%s, %s)"
        cur.execute(query, [user[session['uuid']]['username'], coffeeName])
        con.commit()
    except Exception, e:
        raise e
        con.rollback()


#########################################
# Socket Functions for Login & Register #
#########################################
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
    global passWrd
    query = "SELECT Username, Password FROM login WHERE username = %s and password = crypt(%s, password)"
    cur.execute(query, [username, password])
    valdate = cur.fetchall()
    # Check if user info was found in DB
    if len(valdate) != 0:
        # Create session variables for logged in user
        passed = True
        name = username
        passWrd = password
        emit('redirect', {'url': url_for('home')})
    else:
        emit('FormFail', 'Invalid username or password!')


###################################
# Socket Functions for Add Recipe #
###################################
@socketio.on('addRecipe', namespace='/addRecipe')
def addRecipe(title, recipe):
    con = connectToDB()
    cur = con.cursor()
    try:
        #get user's id
        statement = "SELECT username FROM login WHERE username = %s"
        cur.execute(statement, [user[session['uuid']]['username']])
        username = cur.fetchone()[0]
        print 'Username is ' + username
        statement = "INSERT INTO recipes (title, recipe, username) VALUES (%s, %s, %s)"
        cur.execute(statement, [title, recipe, username])
        con.commit()
        emit('redirect', {'url': url_for('account')})
    except Exception, e:
        raise e


################################
# Socket Functions for Account #
################################
@socketio.on('connect', namespace='/account')
def makeConnection():
    print "CONNECTED TO ACCOUNT"
    emit('getUser')

@socketio.on('getUser', namespace='/account')
def getUser():
    print 'GETTING USER'
    con = connectToDB()
    cur = con.cursor()
    try:
        # Get first and last name of current user
        query = "SELECT first_name, last_name FROM login WHERE username = %s"
        cur.execute(query, [user[session['uuid']]['username']])
        currentUser = cur.fetchall()
        # Get other info from user info table
        query = "SELECT * FROM user_info WHERE username = %s"
        cur.execute(query, [user[session['uuid']]['username']])
        currentUser2 = cur.fetchall()
        for item in currentUser:
            for item2 in currentUser2:
                currUser = {'First_Name': item[0], 'Last_Name': item[1], 'username': item2[0], 'email': item2[1], 'zipcode': item2[2], 'favCoffee': item2[3]}
                emit('displayInfo', currUser)

    except Exception, e:
        raise e


@socketio.on('updateAccount', namespace='/account')
def updateAccount(firstName, lastName, zipcode, favCoffee, email, oldPassword, newPassword):
    con = connectToDB()
    cur = con.cursor()
    try:
        # Track if password change and also if it is ok to update
        passwordChange = False
        okChange = False
        # Check if significant inputs are filled
        if not firstName or not lastName or not zipcode or not favCoffee or not email:
            emit('FormFail', 'Please fill out all of the field')
        # Check if old password entered
        elif oldPassword:
            # Ask user for new password if none, else check if old password is correct
            if not newPassword:
                emit('FormFail', 'Please enter a new password')
            else:
                passwordChange = True
                query = "SELECT password FROM login WHERE username = %s AND password = crypt(%s, password)"
                cur.execute(query, [user[session['uuid']]['username'], oldPassword])
                passCheck = cur.fetchall()
                if not passCheck:
                    emit('FormFail', 'Old password is incorrect!')
                else:
                    okChange = True
        # Ask user for old password if putting in new password
        elif newPassword and not oldPassword:
                emit('FormFail', 'Please enter your old password!')
        else:
            okChange = True

        if okChange:
            # Update password if it was changed, otherwise update everything else
            if passwordChange:
                query = "UPDATE login SET first_name = %s, last_name = %s, password = crypt(%s, gen_salt('bf')) WHERE username = %s"
                cur.execute(query, [firstName, lastName, newPassword, user[session['uuid']]['username']])
            else:
                query = "UPDATE login SET first_name = %s, last_name = %s WHERE username = %s"
                cur.execute(query, [firstName, lastName, user[session['uuid']]['username']])
            con.commit()

            # Update user info table with any new info
            query = "UPDATE user_info SET email = %s, zipcode = %s, favorite_coffee = %s WHERE username = %s"
            cur.execute(query, [email, zipcode, favCoffee, user[session['uuid']]['username']])
            con.commit()
            emit('redirect', {'url': url_for('account')})

    except Exception, e:
        raise e  
        con.rollback()  
    

@socketio.on('logOut', namespace='/account')
def logOut():
    session.clear()
    user = {}
    emit('redirect', {'url': url_for('home')})



##################################
# Socket Functions for Favorites #
##################################
@socketio.on('connect', namespace='/favorites')
def makeConnection():
    print "CONNECTED TO FAVORITES"
    con = connectToDB()
    cur = con.cursor()
    try:
        query = "SELECT coffee_name FROM user_likes WHERE username = %s"
        cur.execute(query, [user[session['uuid']]['username']])
        coffeeLikes = cur.fetchall()

        query = "SELECT a.name, f.price, f.weight, c.roast, a.body, b.region, a.description FROM coffee_names AS a INNER JOIN coffee_region AS d ON a.name = d.name INNER JOIN region AS b ON d.region_id = b.region_id INNER JOIN coffee_roast AS e ON a.name = e.name INNER JOIN roast AS c ON e.roast_id = c.roast_id INNER JOIN coffee_cost AS f ON a.name = f.name WHERE a.name IN (SELECT coffee_name FROM user_likes WHERE username = %s)"
        cur.execute(query, [user[session['uuid']]['username']])
        favorites = cur.fetchall()
        for item in favorites:
            cost = str(item[1])
            coffee = {'name': item[0], 'price': cost, 'weight': item[2], 'roast': item[3], 'body': item[4], 'region': item[5], 'description': item[6], 'liked': False}
            for like in coffeeLikes:
                if item[0] in like:
                    coffee['liked'] = True
            emit('getFavorites', coffee)         

    except Exception, e:
        raise e

@socketio.on('updateFavorite', namespace='/favorites')
def updateFavorite(coffeeName, liked):
    con = connectToDB()
    cur = con.cursor()
    try:
        if liked:
            query = "DELETE FROM user_likes WHERE username = %s AND coffee_name = %s"
        else:
            query = "INSERT INTO user_likes VALUES (%s, %s)"
        cur.execute(query, [user[session['uuid']]['username'], coffeeName])
        con.commit()
    except Exception, e:
        raise e
        con.rollback()


# start the server
if __name__ == '__main__':
    socketio.run(app, host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
