import json
import os

from db import db
from db import Asset, Attraction, Post, Comment, CATEGORIES
from flask import Flask
from flask import request

app = Flask(__name__)
db_filename = "hack_challenge.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = False

db.init_app(app)
with app.app_context():
    db.create_all()
    Attraction.initialize()
    Post.initialize()


def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code


def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

# retrieve all categories
@app.route("/categories/")
def get_categories():
    return success_response(CATEGORIES)

# retrieve a category
@app.route("/categories/<int:c_id>/")
def get_category(c_id):
    return success_response([a.serialize() for a in Attraction.query.filter_by(category_id=c_id).all()]) 

# retrieve all attractions
@app.route("/attractions/")
def get_attractions():
    return success_response([a.serialize() for a in Attraction.query.all()])

# retrieve an attraction
@app.route("/attractions/<int:attraction_id>/")
def get_attraction(attraction_id):
    attraction = Attraction.query.filter_by(id=attraction_id).first()
    if not attraction:
        return failure_response("Attraction not found")
    return success_response(attraction.serialize())

# create attraction
@app.route("/attractions/", methods=["POST"])
def create_attraction():
    body = json.loads(request.data)
    category=body.get("category")
    if category not in CATEGORIES:
        return failure_response("Category not found")
    new_attraction = Attraction(name=body.get("name"), address=body.get(
          "address"), category=body.get("category"), image=body.get("image"))
    if not new_attraction.name or not new_attraction.address or not new_attraction.category or not new_attraction.image:
        return failure_response("Missing required field")
    db.session.add(new_attraction)
    db.session.commit()
    return success_response(new_attraction.serialize(), 201)


# @app.route("/attraction_list/", methods=["POST"])
# def create_mult_att():
#     body = json.loads(request.data)
#     atts = body.get("attractions")
#     if not atts:
#         return failure_response("Missing required field")
#     added = []
#     for a in atts:
#         category=a.get("category")
#         if category not in CATEGORIES:
#             return failure_response("Category not found")
#         new_attraction = Attraction(name=a.get("name"), address=a.get(
#             "address"), category=a.get("category"), image=a.get("image"))
#         if not new_attraction.name or not new_attraction.address or not new_attraction.category or not new_attraction.image:
#             return failure_response("Missing required field")
#         db.session.add(new_attraction)
#         db.session.commit()
#         added.append(new_attraction.serialize())
#     return success_response(added, 201)


# delete attraction
@app.route("/attractions/<int:attraction_id>/", methods=["DELETE"])
def delete_attraction(attraction_id):
    attraction = Attraction.query.filter_by(id=attraction_id).first()
    if not attraction:
        return failure_response("Attraction not found")
    db.session.delete(attraction)
    db.session.commit()
    return success_response(attraction.serialize())

# retrieve all posts for a given attraction
@app.route("/attractions/<int:attraction_id>/posts/")
def get_posts(attraction_id):
    attraction = Attraction.query.filter_by(id=attraction_id).first()
    if not attraction:
        return failure_response("Attraction not found")
    posts = Post.query.filter_by(attraction_id=attraction_id).all()
    if not posts:
        return failure_response("Posts not found")
    return success_response([p.serialize() for p in posts])

# retrieve a post
@app.route("/posts/<int:post_id>/")
def get_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if not post:
        return failure_response("Post not found")
    return success_response(post.serialize())

# create post (add post to attraction)
@app.route("/attractions/<int:attraction_id>/posts/", methods=["POST"])
def create_post(attraction_id):
    body = json.loads(request.data)
    attraction = Attraction.query.filter_by(id=attraction_id).first()
    if not attraction:
        return failure_response("Attraction not found")
    new_post = Post(netid=body.get("netid"), name=body.get(
          "name"), picture=body.get("picture"), description=body.get("description"), attraction_id=attraction_id)
    if not new_post.netid or not new_post.description:
        return failure_response("Missing required field")
    db.session.add(new_post)
    db.session.commit()
    return success_response(new_post.serialize(), 201)

# delete post
@app.route("/posts/edit/<int:post_id>/", methods=["DELETE"])
def delete_post(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if not post:
        return failure_response("Post not found")
    db.session.delete(post)
    db.session.commit()
    return success_response(post.serialize())

# retrieve all comments for a given post
@app.route("/comments/<int:post_id>/")
def retrieve_comments(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if not post:
        return failure_response("Post not found")
    comments_on_post = post.comments
    return success_response([comment.serialize() for comment in comments_on_post])
    
# create comment (add comment to post)
@app.route("/comments/<int:post_id>/", methods=["POST"])
def create_comment(post_id):
    post = Post.query.filter_by(id=post_id).first()
    if not post:
        return failure_response('Post not found')
    body = json.loads(request.data)
    name = body.get('name')
    description = body.get('description')
    if not body:
        return failure_response('Missing required field')
    new_comment = Comment(netid = body.get("netid"), name = name, description = description)
    post.comments.append(new_comment)
    db.session.add(new_comment)
    db.session.commit()
    return success_response(new_comment.serialize(), 201)

# delete comment
@app.route("/comments/<int:comment_id>/", methods=["DELETE"])
def delete_comment(comment_id):
    comment = Comment.query.filter_by(id = comment_id).first()
    if not comment:
        return failure_response("Comment not found")
    db.session.delete(comment)
    db.session.commit()
    return success_response(comment.serialize())

# upload picture
@app.route("/upload/", methods=["POST"])
def upload():
    body = json.loads(request.data)
    image_data = body.get("image_data")
    if not image_data:
        return failure_response("Missing image")
    asset = Asset(image_data = image_data)
    db.session.add(asset)
    db.session.commit()
    return success_response(asset.serialize(), 201)


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
