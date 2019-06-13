from flask import Flask, jsonify
import cx_Oracle

# declare constants for flask app
HOST = '0.0.0.0'
PORT = 5000

# initialize flask application
app = Flask(__name__)

# automonous data warehouse connection constants
# update below with your db credentials
# add wallet files to wallet folder
DB = "<DSN Connection String from tnsnames.ora>"
DB_USER = "admin"
DB_PASSWORD = "<DB Password>"

connection = cx_Oracle.connect(DB_USER, DB_PASSWORD, DB)

# api endpoint returning version of database from automonous data warehouse
@app.route('/api/version')
def version():
    return jsonify(status='success', db_version=connection.version)

if __name__ == '__main__':
    app.run(host=HOST, debug=True, port=PORT)
