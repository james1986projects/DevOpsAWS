from flask import flask  
app = flask(_name_)  

@app.route('/') 
def hello():
    return "Hello James thanks for making me secure!"

if _name_ == "_main_":
    app.run(host='0.0.0.0', port=5000)
