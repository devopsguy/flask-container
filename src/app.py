from flask import Flask
import socket

app = Flask(__name__)

@app.route("/")
def hello_flask():
    return "Hello Flask from %s!" % socket.gethostname()

if __name__ == '__main__':
    app.run(debug=False, host="0.0.0.0", port=3000)