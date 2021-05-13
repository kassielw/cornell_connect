import base64
import boto3
from flask_sqlalchemy import SQLAlchemy
from io import BytesIO
import json
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import random
import re
import string

db = SQLAlchemy()

CATEGORIES = ["Studying", "Food", "Fitness", "Hotspots", "Dorm"]

EXTENSIONS = ["png", "gif", "jpg", "jpeg"]
BASE_DIR = os.getcwd()
S3_BUCKET = "cornellconnect"
S3_BASE_URL =f'https://{S3_BUCKET}.s3-us-east-2.amazonaws.com'

class Asset(db.Model):
    __tablename__ = "asset"
    id = db.Column(db.Integer, primary_key=True)
    base_url = db.Column(db.String, nullable=False)
    salt = db.Column(db.String, nullable=False)
    extension = db.Column(db.String, nullable=False)
    height = db.Column(db.Integer, nullable=False)
    width = db.Column(db.Integer, nullable=False)

    def __init__(self, **kwargs):
        self.create(kwargs.get("image_data"))
    
    def serialize(self):
        return {
            "url": f"{self.base_url}/{self.salt}.{self.extension}"
        }
    
    def create(self, image_data):
        try:
            ext = guess_extension(guess_type(image_data)[0])[1:]
            if ext not in EXTENSIONS:
                raise Exception(f'Extension {ext} not supported')
            
            salt = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for i in range(16))

            img_str = re.sub("^data:image/.+;base64,", "", image_data)
            img_data = base64.b64decode(img_str)
            img = Image.open(BytesIO(img_data))

            self.base_url = S3_BASE_URL
            self.salt = salt
            self.extension = ext
            self.height = img.height
            self.width = img.width

            img_filename = f'{salt}.{ext}'
            self.upload(img, img_filename)
        
        except Exception as e:
            print("Error:", e)
        
    def upload(self, img, img_filename):
        try:
            img_temploc = f'{BASE_DIR}/{img_filename}'
            img.save(img_temploc)

            s3_client = boto3.client('s3')
            s3_client.upload_file(img_temploc, S3_BUCKET, img_filename)

            s3_resource = boto3.resource('s3')
            object_acl = s3_resource.ObjectAcl(S3_BUCKET, img_filename)
            object_acl.put(ACL="public-read")
            os.remove(img_temploc)

        except Exception as e:
            print("Upload Failed:", e)


class Attraction(db.Model):
    __tablename__ = "attraction"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    address = db.Column(db.String, nullable=False)
    posts = db.relationship("Post", cascade="delete")
    category = db.Column(db.String, nullable=False)
    image = db.Column(db.String, nullable=False)

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.address = kwargs.get("address")
        self.category = kwargs.get("category")
        self.image = kwargs.get("image")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "address": self.address,
            "category": self.category,
            "image": self.image,
            "posts": [p.serialize() for p in self.posts]
        }
    
    def initialize():
        with open('./location.json') as f:
            data = json.load(f)
            for a in data['attractions']:
                category=a.get("category")
                new_attraction = Attraction(name=a.get("name"), address=a.get(
                    "address"), category=a.get("category"), image=a.get("image"))
                db.session.add(new_attraction)
                db.session.commit()
        return

class Post(db.Model):
    __tablename__ = "post"
    id = db.Column(db.Integer, primary_key=True)
    netid = db.Column(db.String, nullable=False)
    name = db.Column(db.String, nullable=True)
    picture = db.Column(db.String, nullable=True)
    description = db.Column(db.String, nullable=False)
    comments = db.relationship("Comment", cascade="delete")
    attraction_id = db.Column(db.Integer, db.ForeignKey("attraction.id"))

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid")
        self.name = kwargs.get("name")
        self.picture = kwargs.get("picture")
        self.description = kwargs.get("description")
        self.attraction_id = kwargs.get("attraction_id")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name if self.name else "Anonymous",
            "picture": self.picture if self.picture else "N/A",
            "description": self.description,
            "comments": [c.serialize() for c in self.comments]
        }
    
    def initialize():
        with open('./posts.json') as f:
            data = json.load(f)
            for p in data['posts']:
                attraction_id = p.get("attraction_id")
                attraction = Attraction.query.filter_by(id=attraction_id).first()
                new_post = Post(netid=p.get("netid"), name=p.get(
                    "name"), picture=p.get("picture"), description=p.get("description"), attraction_id=attraction_id)
                db.session.add(new_post)
                db.session.commit()
        return


class Comment(db.Model):
    __tablename__ = "comment"
    id = db.Column(db.Integer, primary_key=True)
    netid = db.Column(db.String, nullable=False)
    name = db.Column(db.String, default="Anonymous")
    description = db.Column(db.String, nullable=False)
    post_id = db.Column(db.Integer, db.ForeignKey("post.id"))

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid")
        self.name = kwargs.get("name")
        self.description = kwargs.get("description")
        self.post_id = kwargs.get("post_id")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description
        }
