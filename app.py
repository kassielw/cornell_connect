import json
import os

from db import db
from db import Attraction, Post, Comment
from flask import Flask
from flask import request

app = Flask(__name__)
db_filename = "hack_challenge.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()


def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code


# retrieve all attractions
@app.route("/attractions/")
def get_attractions():
    return success_response([a.serialize() for a in Attraction.query.all()])

# retrieve an attraction
@app.route("/attractions/<int:id>/")
def get_attraction(id):
    attraction = Attraction.query.filter_by(id=id).first()
    if not attraction:
        return failure_response("Attraction not found")
    return success_response(attraction.serialize())

# create attraction
@app.route("/attractions/", methods=["POST"])
def create_attraction():
  body = json.loads(request.data)
      new_attraction = Attraction(name=body.get("name"), address=body.get(
          "address"), description=body.get("description"))
       if not new_attraction.name or not new_attraction.address or not new_attraction.description:
            return failure_response("Missing required field")
        db.session.add(new_attraction)
        db.session.commit()
        return success_response(new_attraction.serialize(), 201)

# delete attraction
@app.route("/attractions/<int:a_id>/", methods=["DELETE"])
def delete_attraction(a_id):
    attraction = Attraction.query.filter_by(id=a_id).first()
    if not attraction:
        return failure_response("Attraction not found")
    db.session.delete(attraction)
    db.session.commit()
    return success_response(attraction.serialize())

# retrieve all posts for a given attraction
@app.route("/posts/attraction/<int:a_id>/")
def get_posts(a_id):
    attraction = Attraction.query.filter_by(id=a_id).first()
    if not attraction:
        return failure_response("Attraction not found")
    posts = Post.query.filter_by(attraction=a_id).all()
    if not posts:
        return failure_response("Posts not found")
    return success_response([p.serialize() for p in posts], 201)

# retrieve a post
@app.route("/posts/<int:id>/")
def get_post(id):
    post = Post.query.filter_by(id=id).first()
    if not post:
        return failure_response("Post not found")
    return success_response(post.serialize())

# create post (add post to attraction)
@app.route("/posts/attraction/<int:a_id>/", methods=["POST"])
def create_post(a_id):
  body = json.loads(request.data)
  attraction = Attraction.query.filter_by(id=a_id).first()
        if not attraction:
            return failure_response("Attraction not found")
      new_post = Post(netid=body.get("netid"), name=body.get(
          "name"), picture=body.get("picture"), rating=body.get("rating"), description=body.get("description"), attraction=a_id)
       if not new_post.netid or not new_post.name or not new_post.description:
            return failure_response("Missing required field")
        db.session.add(new_post)
        db.session.commit()
        return success_response(new_post.serialize(), 201)

# ZACH TODO: edit post (ensure that user netid is same as previous)
@app.route("/posts/edit/<int:id>/", methods=["POST"])
def edit_post(p_id):
    body = json.loads(request.data)
    netid = body.get("netid")
    post_to_edit = Post.query.filter_by(id = p_id).first()
    if netid is None or post_to_edit.netid is not netid:
        return failure_response("NetID issue")
    new_content = body.get("description")
    if new_content is None:
        return failure_response("Missing field")
    post_to_edit.description = new_content
    db.session.commit()
    return success_response(post_to_edit.serialize(), 201)

# ZACH TODO: retrieve all comments for a given post
@app.route("/comments/<int:p_id>/")
def retrieve_comments(p_id):
    post = Post.query.filter_by(id = p_id).first()
    comments_on_post = post.comments
    return success_response([comment.serialize() for comment in comments_on_post])
    
# ZACH TODO: create comment (add comment to post)
@app.route("/comments/<int:p_id>/", methods=["POST"])
def create_comment(p_id):
    post = Post.query.filter_by(id = p_id).first()
    if post is None:
        return failure_response('Post not found')
    body = json.loads(request.data)
    name = body.get('name')
    description = body.get('description')
    if body is None or name is None:
        return failure_response('Missing field')
    new_comment = Comment(netid = body.get("netid"), name = name, description = description)
    post.comments.append(new_comment)
    db.session.add(new_comment)
    db.session.commit()
    return success_response(new_comment.serialize())

# ZACH TODO: edit comment (ensure that user netid is same as previous)
@app.route("/comments/edit/<int:id>/", methods=["POST"])
def edit_comment(c_id):
    body = json.loads(request.data)
    netid = body.get("netid")
    comment_to_edit = Comment.query.filter_by(id = c_id).first()
    if netid is None or comment_to_edit.netid is not netid:
        return failure_response("NetID issue")
    new_content = body.get("description")
    if new_content is None:
        return failure_response("Missing field")
    comment_to_edit.description = new_content
    db.session.commit()
    return success_response(comment_to_edit.serialize(), 201)

# notifcation system (reach goal): given netid, retrieve posts and comments
# @app.route("/posts/<int:a_id>/")
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
