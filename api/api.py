import asyncio
import subprocess

import flask
import time
from flask import jsonify
from flask import request
import json

app = flask.Flask(__name__)

db = {}


def load():
    try:
        with open("db.json", "r+") as db_file:
            db_saved_data = json.loads(db_file.read())
            for key in db_saved_data:
                db[key] = db_saved_data[key]
    except:
        pass


load()


@app.route('/', methods=['GET'])
def get():
    load()
    return jsonify(db)


@app.route('/<id>', methods=['GET'])
def get_by_id(id):
    load()
    return jsonify(db[id])


@app.route('/', methods=['POST'])
def post():
    request_json = request.get_json()
    response = {"subtotal": 0, "delivery": 0, "items": []}

    for item in request_json:
        db_item = db[item.get("id")]
        item_subtotal = float(db_item["price"]) * int(item["quantity"])
        item_delivery = float(db_item["delivery"]) * int(item["quantity"])
        response["subtotal"] = float(response["subtotal"]) + item_subtotal
        response["items"].append({"id": item["id"], "delivery": item_delivery, "subtotal": item_subtotal})
        response["delivery"] = response["delivery"] + item_delivery
    response["total"] = response["subtotal"] + response["delivery"]
    return jsonify(response)


@app.route('/', methods=['PUT'])
def put():
    request_json = request.get_json()
    db[request_json.get("id")] = request_json
    with open("db.json", "w+") as _db_file:
        _db_file.write(json.dumps(db))
    return jsonify(request_json)

@app.route('/async', methods=['PUT'])
def put_asyn():
    request_json = request.get_json()
    subprocess.Popen(["python", "background.py", "{0}".format(str(request_json).replace("'", '"'))], close_fds=True)
    return jsonify(db)


app.run()
