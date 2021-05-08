# API Documentation

## **Attractions**

## Get all attractions <br />

`GET` `/attractions/` <br />

### Success Response

```
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Clock tower",
            "address": "123 Big Red Road, Ithaca, NY 14853",
            "description": "Iconic clock tower, that once had a pumpkin on top",
            "category": "Hotspot",
            "posts": [
                {
                    "id": 1,
                    "name": "Anonymous",
                    "picture": "N/A",
                    "rating": 4,
                    "description": "so tall!",
                    "comments": [
                        {
                            "id": 1,
                            "name": "Anonymous",
                            "description": "agreed!"
                        },
                        {
                            "id": 3,
                            "name": "Bob",
                            "description": "hey, that's my favorite place on campus!"
                        }
                    ]
                },
            ]
        },
        ...
    ]
}
```

## Get a specific attraction <br />

`GET` `/attractions/{id}/` <br />

### Success Response

```
{
    "success": true,
    "data": {
        "id": 1,
        "name": "Clock tower",
        "address": "123 Big Red Road, Ithaca, NY 14853",
        "description": "Iconic clock tower, that once had a pumpkin on top",
        "category": "Hotspot",
        "posts": [
            {
                "id": 1,
                "name": "Anonymous",
                "picture": "N/A",
                "rating": 4,
                "description": "so tall!",
                "comments": [
                    {
                        "id": 1,
                        "name": "Anonymous",
                        "description": "agreed!"
                    },
                    {
                        "id": 3,
                        "name": "Bob",
                        "description": "hey, that's my favorite place on campus!"
                    }
                ]
            },
        ]
    }
}
```

## Create an attraction

`POST` `/attractions/` <br />

### Request

```
{
    "name": "Dairy Bar",
    "address": "100 Moo Moo Lane, Ithaca, NY 14853",
    "description": "Offers the best ice cream on campus",
    "category": "Food"
}
```

### Success Response

```
{
    "success": true,
    "data": {
        "id": 2,
        "name": "Dairy Bar",
        "address": "100 Moo Moo Lane, Ithaca, NY 14853",
        "description": "Offers the best ice cream on campus",
        "category": "Food",
        "posts": []
    }
}
```

## Delete an attraction

`DELETE` `/attractions/{id}/` <br />

### Success Response

```
{
    "success": true,
    "data": {
        "id": 2,
        "name": "Dairy Bar",
        "address": "100 Moo Moo Lane, Ithaca, NY 14853",
        "description": "Offers the best ice cream on campus",
        "category": "Food",
        "posts": [ POSTS... ]
    }
}
```

## **Posts**

## Get all posts for a specific attraction

`GET` `/attractions/{id}/posts/` <br />

### Success response

```
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Anonymous",
            "picture": "N/A",
            "rating": 4,
            "description": "so tall!",
            "comments": [
                {
                    "id": 1,
                    "name": "Anonymous",
                    "description": "agreed!"
                },
                {
                    "id": 3,
                    "name": "Bob",
                    "description": "hey, that's my favorite place on campus!"
                }
            ]
        },
        {
            "id": 3,
            "name": "Hannah",
            "picture": "N/A",
            "rating": "N/A",
            "description": "look! it's pink for valentine's day",
            "comments": [
                {
                    "id": 5,
                    "name": "Zachary",
                    "description": "that's so cool!"
                },
                ...
            ]
        },
        ...
    ]
```

## Get a specific post

`GET` `/posts/{id}/` <br />

### Success response

```
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Anonymous",
            "picture": "N/A",
            "rating": 4,
            "description": "so tall!",
            "comments": [
                {
                    "id": 1,
                    "name": "Anonymous",
                    "description": "agreed!"
                },
                {
                    "id": 3,
                    "name": "Bob",
                    "description": "hey, that's my favorite place on campus!"
                }
            ]
        }
    ]
}
```

## Create a post for specific attraction

`POST` `/attractions/{id}/posts/` <br />

### Request

```
{
    "netid": "abc123",
    "name": "Janice",
    "picture": "",
    "rating": 1,
    "description": "why is bingalee so loud"
    "attraction_id": 1
}
```

### Success Response

```
{
    "success": true,
    "data": {
        "id": 7,
        "name": "Janice",
        "picture": "N/A",
        "rating": 1,
        "description": "why is bingalee so loud",
        "comments": []
    }
}
```

## Delete a post

`DELETE` `/posts/edit/{id}/` <br />

### Success Response

```
{
    "success": true,
    "data":
        {
            "id": 7,
            "name": "Janice",
            "picture": "N/A",
            "rating": 1,
            "description": "why is bingalee so loud",
            "comments": [ COMMENTS ON POST... ]
        }

}
```

## **Comments**

## Get all comments for a specific post

`GET` `/comments/{id}/` <br />

### Success response

```
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "Anonymous",
            "description": "agreed!"
        },
        {
            "id": 3,
            "name": "Bob",
            "description": "hey, that's my favorite place on campus!"
        }
    ]
}
```

## Create a comment for specific post

`POST` `/posts/{id}/` <br />

### Request

```
{
    "netid": "bob213"
    "name": "Bob"
    "description": "hey, that's my favorite place on campus!"
}
```

### Success Response

```
{
    "success": true,
    "data": {
        "id": 3,
        "name": "Bob",
        "description": "hey, that's my favorite place on campus!"
    }

}
```

## Delete a comment

`DELETE` `/comments/{id}/` <br />

### Success Response

```
{
    "success": true,
    "data":
        {
            "id": 3,
            "name": "Bob",
            "description": "hey, that's my favorite place on campus!"
        }

}
```
