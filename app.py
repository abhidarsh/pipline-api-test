from flask import Flask, jsonify

app = Flask(__name__)
#Added a route to handle requests to the root path and return a welcome message.
@app.route('/', methods=['GET'])
def index():
    return jsonify({"message": "Welcome to the Version API"}), 200

@app.route('/version', methods=['GET'])
def get_version():
    version_info = {
        "version": "1.0.0",
        "build_sha": "abc57858585",
        "description": "pre-interview technical test"
    }
    return jsonify(version_info)
#Added a route to handle requests to /favicon.ico and return a 204 No Content response, which is a standard way to handle favicon requests without an actual favicon file
@app.route('/favicon.ico')
def favicon():
    return '', 204

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
