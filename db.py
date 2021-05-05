from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Attraction(db.Model):
    __tablename__ = "attraction"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    address = db.Column(db.String, nullable=False)
    description = db.Column(db.String, nullable=False)
    posts = relationship("Post", back_populates("attraction"))

    def __init__(self, **kwargs):
        self.name = kwargs.get("name")
        self.address = kwargs.get("address")
        self.description = kwargs.get("description")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "address": self.address,
            "description": self.description,
            "posts": [p.serialize() for p in self.posts]
        }


class Post(db.Model):
    __tablename__ = "post"
    id = db.Column(db.Integer, primary_key=True)
    netid = db.Column(db.String, nullable=False)
    name = db.Column(db.String, default="Anonymous")
    picture = db.Column(db.String, nullable=True)
    rating = db.Column(db.Integer,  nullable=True)
    description = db.Column(db.String, nullable=False)
    comments = relationship("Comment", back_populates("post"))
    attraction = relationship("Attraction", back_populates("posts"))

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid")
        self.name = kwargs.get("name")
        self.picture = kwargs.get("picture")
        self.rating = kwargs.get("rating")
        self.description = kwargs.get("description")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "picture": self.picture if self.picture else "N/A",
            "rating": self.rating if self.rating else "N/A",
            "description": self.description,
            "comments": [c.serialize() for c in self.comments]
        }

    # def serialize_some(self):
    #     return {
    #         "id": self.id,
    #         "name": self.name,
    #         "rating": self.rating,
    #         "description": self.description,
    #         "comments": [c.serialize() for c in self.comments]
    #     }


class Comment(db.Model):
    __tablename__ = "comment"
    id = db.Column(db.Integer, primary_key=True)
    netid = db.Column(db.String, nullable=False)
    name = db.Column(db.String, default="Anonymous")
    description = db.Column(db.String, nullable=False)
    post = relationship("Post", back_populates("comments"))

    def __init__(self, **kwargs):
        self.netid = kwargs.get("netid")
        self.name = kwargs.get("name")
        self.description = kwargs.get("description")

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description
        }
