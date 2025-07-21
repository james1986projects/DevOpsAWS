from flask import Flask, request, jsonify
import boto3
import uuid

app = Flask(__name__)

# Delayed initialization of DynamoDB table to avoid crashing at startup
def get_table():
    dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
    return dynamodb.Table('flask-data')

@app.route('/')
def hello():
    return "Hello James thanks for making me secure and adding CI/CD!"

@app.route('/data', methods=['POST'])
def add_data():
    table = get_table()
    data = request.json
    item_id = str(uuid.uuid4())
    item = {'id': item_id, 'value': data.get('value', '')}
    table.put_item(Item=item)
    return jsonify({'message': 'Item added', 'id': item_id})

@app.route('/data/<item_id>', methods=['GET'])
def get_data(item_id):
    table = get_table()
    response = table.get_item(Key={'id': item_id})
    item = response.get('Item')
    if item:
        return jsonify(item)
    return jsonify({'message': 'Item not found'}), 404

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

print("🚀 Test CI/CD deploy to test environment")

