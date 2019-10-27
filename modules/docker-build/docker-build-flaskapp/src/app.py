from flask import Flask
from flask import request
import socket

app = Flask(__name__)

@app.route("/")
def show_details() :
    return "Hello from " + socket.gethostname() + "\n"

if __name__ == "__main__":
    app.run(debug = True, host = '0.0.0.0', port = 8080)
