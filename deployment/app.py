from flask import Flask, render_template
import socket
import psutil

app = Flask(__name__)

# Get hostname
hostname = socket.gethostname()

@app.route("/")
def home():
    cpu_usage = psutil.cpu_percent(interval=1)
    memory_info = psutil.virtual_memory()
    return render_template("index.html", hostname=hostname, cpu_usage=cpu_usage, memory=memory_info)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
