from flask import Flask, request, jsonify
import boto3
import uuid
import os

app = Flask(__name__)

# Use IAM role for credentials on ECS
dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('flask-data')

@app.route('/')
def hello():
    return "Hello James thanks for making me secure!"

@app.route('/data', methods=['POST'])
def add_data():
    data = request.json
    item_id = str(uuid.uuid4())
    item = {'id': item_id, 'value': data.get('value', '')}
    table.put_item(Item=item)
    return jsonify({'message': 'Item added', 'id': item_id})

@app.route('/data/<item_id>', methods=['GET'])
def get_data(item_id):
    response = table.get_item(Key={'id': item_id})
    item = response.get('Item')
    if item:
        return jsonify(item)
    return jsonify({'message': 'Item not found'}), 404

if __name__ == "__main__":  
    app.run(host='0.0.0.0', port=5000)
