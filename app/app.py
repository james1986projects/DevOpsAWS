from flask import Flask, request, jsonify
from werkzeug.middleware.proxy_fix import ProxyFix
from flask_talisman import Talisman
import boto3
import uuid

app = Flask(__name__)

# Make Flask aware it's behind an ALB and use X-Forwarded headers
# x_proto=1 ensures HTTPS detection
# x_host=1 ensures correct domain in redirects
app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1)

# Configure Flask-Talisman for HTTPS + HSTS
# force_https=True -> redirect HTTP to HTTPS
# strict_transport_security=True -> adds Strict-Transport-Security header
# strict_transport_security_max_age -> 1 year (recommended)
# include_subdomains=True -> apply to *.devopsjames.com
Talisman(
    app,
    force_https=True,
    strict_transport_security=True,
    strict_transport_security_max_age=31536000,  # 1 year
    strict_transport_security_include_subdomains=True
)

# DynamoDB lazy initialization
def get_table():
    dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
    return dynamodb.Table('flask-data')

@app.route('/')
def hello():
    return "Hello James! Fully secure with HTTPS + HSTS + CI/CD-ready!"

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

