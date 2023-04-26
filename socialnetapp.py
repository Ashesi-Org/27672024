# importng necessary libraries 
import os
import json
from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, firestore
import functions_framework
from flask_cors import CORS
import re
from email_validator import validate_email, EmailNotValidError
from uuid import uuid4
from flask_mail import Mail, Message
from datetime import datetime
import secrets


creden = credentials.Certificate("keys.json")
firebase_admin.initialize_app(creden)


app = Flask(__name__)
CORS(app) 

# firestore client 
db = firestore.client()
profiles_ref = db.collection('profiles')
posts_ref = db.collection('posts')

# initialise flask app
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USE_SSL'] = True
app.config['MAIL_USERNAME'] = 'ashesinetwork2023@gmail.com'
app.config['MAIL_PASSWORD'] = 'zqfbfzqdtmoozgtf'
mail = Mail(app)


# get all user emails 
def get_all_user_emails():
    
    if not profiles_ref:
        return jsonify({"error":"No profile registered yet"}), 400
    
    result_list = list()
    
    for user in profiles_ref.get(): 
        user = user.to_dict()
        result_list.append(user["email"])
        
    return result_list

def get_user_by_email(email):
    
    data = profiles_ref.get()
    
    if not data: 
        return jsonify({"error":"No profile registered yet"}), 404
    
    for profile in data:
        profile = profile.to_dict()
        if profile['email'] == email:
            return profile
        
    return jsonify({"error": f"User with {email} is not registered!"}), 404

        


# send emails to users 
def send_email(post_data):
    
    recipients = get_all_user_emails()
    
    # get user who made the post
    user = get_user_by_email(post_data["email"])
    if type(user) == tuple:
        return user
    
    message = Message(
        "New post from " + user["name"],
        sender = "ashesinetwork2023@gmail.com",
        recipients = recipients
    )
    
    message.body = user["name"] + " " + " has made a new post on ashesi social!\n"
    message.body += "Post title" + " " + post_data["title"] + "\n"
    message.body += "Post content" + " " + post_data["content"] + "\n\n"
    message.body += "Regards, \n  Ashei Soccial Team"
    
    if mail.send(message):
        return "Email sent!"
    
    return "Email not sent!", 400

    
    



# @functions_framework.http
# def api_server(request):

#     if request.method == 'POST' and request.path == '/profiles':
#         return create_profile()
#     elif request.method == 'GET' and request.path == '/profiles':
#         return update_profile()
#     elif request.method == 'VIEW' and request.path == '/profiles':
#         return query_profile()
#     elif request.method == 'POST' and request.path == '/posts':
#         return create_post()
#     elif request.method == 'GET' and request.path == '/posts':
#         return query_post()        
#     return jsonify("Bad request sent")

# profiles endpoint definition

@app.route('/profiles/', methods=['POST'])
def create_profile():
    record = json.loads(request.data)
    
    # Required fields validations
    required_fields = ['studentId', 'name', 'email', 'dateOfBirth', 'yearGroup', 'major', 'residenceStatus', 'bestFood', 'bestMovie', 'password']
    for field in required_fields:
        if field not in record:
            return jsonify({'error': f'{field} is required'}), 400
    
    # Email validation
    try:
        email = validate_email(record['email']).email
    except EmailNotValidError as e:
        return jsonify({'error': 'Invalid email address'}), 400
    
    record['email'] = email
    
    # Password validation
    password_pattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
    if not re.match(password_pattern, record['password']):
        return jsonify({'error': 'Password must be at least 8 characters long and contain at least one letter and one number.'}), 400
    
    # yearGroup validation such that all yeargroup inputs should be greater than 2002(year of Ashesi establishment)
    if int(record['yearGroup']) <= 2002:
        return jsonify({'error': 'yearGroup must be greater than 2002.'}), 400
    
    new_record_ref = db.collection('profiles').document(record["studentId"]).set(record)
    return jsonify(record)




@app.route('/profiles/', methods=['PUT'])
def update_profile():
    try:
        # Validate input
        record = request.get_json()
        required_fields = ['studentId', 'name', 'email', 'dateOfBirth', 'yearGroup', 'major', 'residenceStatus', 'bestFood', 'bestMovie']
        if not all(field in record for field in required_fields):
            return jsonify({'error': 'Missing required field(s)'}), 400

        # Check if student exists in Firestore
        profiles_ref = db.collection('profiles').document(record['studentId'])
        profiles = profiles_ref.get()
        if profiles.exists:
            # Update student record
            profiles_ref.update(record)
            print("Updating")
        else:
            # Create new student record
            profiles_ref.set(record)
            print("Creating")

        return jsonify(record)
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@app.route('/profiles/', methods=['GET'])
def query_profile():
    studentId = request.args.get('studentId')
    
    if studentId:
        query_ref = db.collection('profiles').where('studentId', '==', studentId)
        docs = query_ref.get()
        if len(docs) == 0:
            return jsonify({'error': 'Data not found'}), 404
        for doc in docs:
            return jsonify(doc.to_dict())
    else:
        docs = db.collection('profiles').get()
        result = []
        for doc in docs:
            result.append(doc.to_dict())
        return jsonify(result)



@app.route('/posts/', methods=['POST'])
def create_post():
    record = request.get_json()
    # Check if election with given ID already exists
    
    post_data = record
    current_datetime = datetime.now()
    datetime_formatted = current_datetime.strftime("%d/%m/%Y %H:%M:%S")
    post_data['date_created'] = datetime_formatted
    send_email(post_data)
    post_data['postId'] = secrets.token_hex(16)
    db.collection('posts').document(post_data['postId']).set(post_data)
    return jsonify(record)
    

@app.route('/posts/', methods=['GET'])
def query_post():
    postId = request.args.get('postId')
    
    if postId:
        query_ref = db.collection('posts').where('postId', '==', postId)
        docs = query_ref.get()
        if len(docs) == 0:
            return jsonify({'error': 'Data not found'}), 404
        for doc in docs:
            return jsonify(doc.to_dict())
    else:
        docs = db.collection('posts').order_by('date_created', direction=firestore.Query.DESCENDING).get()
        result = []
        for doc in docs:
            result.append(doc.to_dict())
        return jsonify(result)




