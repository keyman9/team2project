import os
import time
import random
from flask import Flask, render_template, request

import psycopg2
import psycopg2.extras

app = Flask(__name__)

def connectToDB():
    connectionString = 'dbname=people user=radio password=12345 host=localhost'
    print connectionString
    try: # there can be lots of errors early on, good to catch 'em. 
        return psycopg2.connect(connectionString)
    except:
        print("Can't connect to database")


@app.route('/')
def mainIndex():
    return render_template('index.html', active = "home")

@app.route('/cart')
def cart():
    return render_template('cart.html', active = "cart")

@app.route('/checkout')
def checkout():
    return render_template('checkout.html', active = "checkout")

@app.route('/shop')
def shop():
    return render_template('shop.html', active = "shop")

@app.route('/single-product')
def singleProduct():
    return render_template('single-product.html', active = "single-product")

# start the server
if __name__ == '__main__':
    app.run(host=os.getenv('IP', '0.0.0.0'), port =int(os.getenv('PORT', 8080)), debug=True)
