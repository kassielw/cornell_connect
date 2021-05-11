# CornellConnect

> Closing the distance between Cornell students in a world of social distancing

## Links

-   [Git Repo](https://github.com/kassielw/food_cloud)
-   [HerokuApp](https://cornellconnect.herokuapp.com/)  (For the herokuapp to display use one of the routes specified in our API)

## Description

Reddit-Like Platform where Cornell Students can post about their favorite attractions on campus anonymously. 

With this app we have central attractions on campus, IE something like the clocktower. A student can make an anonymous (or identifiable) post about that attraction, for example a picture. The student can tag the picture with an appropriate tag that describes the picture ie photograph. And students can comment on the post.

Our API detailing every route that was implemented by backend is documented in our API.

## Database Schema

We have a database table linking Attraction to Post (a one to many relationship) Each attraction can have many posts.

We have a database table linking Post to Comment (a one to many relationship again) Each post can have many comments.

These are the two main tables we employ in our design.

In essence from a top down ideation we have each attraction having the possibility for many posts each having the possibility for many comments.

## Features

Insert screenshots of our app and other feature highlights here.

![insert screenshot here](screenshot.jpg)

## Addressing Requirements

### iOS

-   INSERT IOS REQUIREMENTS/INFO HERE

### Backend

-   We have over 4 routes. Most are get and post, but there are a few delete ones.

## Team Members

### iOS

-   Varsha Iyer – [vvi2](vvi2@cornell.edu)
-   Janice Lee – [jl2838](jl2838@cornell.edu)

### Backend

-   Hannah Lee – [hel33](hel33@cornell.edu)
-   Zachary Thurston – [zwt3](zwt3@cornell.edu)
-   Kassie Wang – [klw242](klw242@cornell.edu)
