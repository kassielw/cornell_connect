import json
import os

from db import db
from db import Attraction, Post, Comment
from flask import Flask
from flask import request

app = Flask(__name__)
db_filename = "cms.db"

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


@app.route("/")
@app.route("/api/courses/")
def get_courses():
    return success_response([c.serializeSome() for c in Course.query.all()])


@app.route("/api/courses/", methods=["POST"])
def create_course():
    body = json.loads(request.data)
    new_course = Course(code=body.get("code"), name=body.get("name"))
    if not new_course.code or not new_course.name:
        return failure_response("Missing required field")
    db.session.add(new_course)
    db.session.commit()
    return success_response(new_course.serialize(), 201)


@app.route("/api/courses/<int:course_id>/")
def get_course(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response("Course not found")
    return success_response(course.serializeSome())


@app.route("/api/courses/<int:course_id>/", methods=["DELETE"])
def delete_course(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response("Course not found")
    db.session.delete(course)
    db.session.commit()
    return success_response(course.serializeSome())


@app.route("/api/users/", methods=["POST"])
def create_user():
    body = json.loads(request.data)
    new_user = User(name=body.get("name"), netid=body.get("netid"))
    if not new_user.name or not new_user.netid:
        return failure_response("Missing required field")
    db.session.add(new_user)
    db.session.commit()
    return success_response(new_user.serialize(), 201)


@app.route("/api/users/<int:user_id>/")
def get_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    return success_response(user.serialize())


@app.route("/api/courses/<int:course_id>/add/", methods=["POST"])
def add_user_to_course(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response("Course not found")
    body = json.loads(request.data)
    user_id = body.get("user_id")
    user_type = body.get("type")
    if not user_id or not user_type:
        return failure_response("Missing required field")
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    if body.get("type") == "student":
        course.students.append(user)
    elif body.get("type") == "instructor":
        course.instructors.append(user)
    elif body.get("type") != "student" or body.get("type") != "instructor":
        return failure_response("Invalid user type")
    db.session.commit()
    return success_response(course.serializeSome())


@app.route("/api/courses/<int:course_id>/assignment/", methods=["POST"])
def create_assignment(course_id):
    course = Course.query.filter_by(id=course_id).first()
    if course is None:
        return failure_response("Course not found")
    body = json.loads(request.data)
    new_assignment = Assignment(
        title=body.get("title"),
        due_date=body.get("due_date"),
        course_id=course_id
    )
    if not new_assignment.title or not new_assignment.due_date:
        return failure_response("Missing requried field")
    db.session.add(new_assignment)
    db.session.commit()
    return success_response(new_assignment.serialize())


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
