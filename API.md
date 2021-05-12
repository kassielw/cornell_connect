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
            "category": "Hotspot",
            "posts": [
                {
                    "id": 1,
                    "name": "Anonymous",
                    "picture": "N/A",
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
        "category": "Hotspot",
        "posts": [
            {
                "id": 1,
                "name": "Anonymous",
                "picture": "N/A",
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
        "category": "Food",
        "posts": [ POSTS... ]
    }
}
```

## Get list of attractions <br />

`GET` `/attraction_list/` <br />

### Success Response

```
{
    "attractions": [
        {
            "name": "RPCC",
            "address": "107 Jessup Rd, Ithaca, NY 14850",
            "category": "Food"
        },
        {
            "name": "Louie's Lunch",
            "address": "534 Thurston Ave, Ithaca, NY 14850",
            "category": "Food"
        },
        {
            "name": "Trillium Dining Hall",
            "address": "215 Garden Ave, Ithaca, NY 14850",
            "category": "Food"
        },
        {
            "name": "The Terrace Restaurant",
            "address": "130 Statler Dr, Ithaca, NY 14853",
            "category": "Food"
        },
        {
            "name": "Helen Newman Hall",
            "address": "Cradit Farm Dr, Ithaca, NY 14850",
            "category": "Fitness"
        },
        {
            "name": "Noyes Fitness Center",
            "address": "306 West Ave, Ithaca, NY 14850",
            "category": "Fitness"
        },
        {
            "name": "Teagle Down Fitness Center",
            "address": "512 Campus Rd #1, Ithaca, NY 14853",
            "category": "Fitness"
        },
        {
            "name": "Beebe Lake Trail",
            "address": "Beebe Lake Trail, Ithaca, NY 14850",
            "category": "Fitness"
        },
        {
            "name": "Cascadilla Gorge Trail",
            "address": "Cascadilla Gorge Trail, Ithaca, NY 14850",
            "category": "Fitness"
        },
        {
            "name": "Plant Science Building",
            "address": "Plant Science Building, Ithaca, NY 14850",
            "category": "Studying"
        },
        {
            "name": "Duffield Hall",
            "address": "343 Campus Rd, Ithaca, NY 14853",
            "category": "Studying"
        },
        {
            "name": "Upson Hall",
            "address": "124 Hoy Rd, Ithaca, NY 14850",
            "category": "Studying"
        },
        {
            "name": "Mann Library",
            "address": "237 Mann Dr, Ithaca, NY 14850",
            "category": "Studying"
        },
        {
            "name": "Uris Library",
            "address": "160 Ho Plaza, Ithaca, NY 14853",
            "category": "Studying"
        },
        {
            "name": "McGraw Tower",
            "address": "Towers Rd, Ithaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Cornell Botanic Gardens",
            "address": "124 Comstock Knoll Dr, Ithaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Ag Quad",
            "address": "237 Mann Dr, Ithaca, NY 14853",
            "category": "Hotspots"
        },
        {
            "name": "Arts Quad",
            "address": "Arts QuadIthaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Mary Donlon Hall",
            "address": "Mary Donlon Hall, Ithaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Court-Kay-Bauer Hall",
            "address": "148 Cradit Farm Dr, Ithaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Clara Dickson Hall",
            "address": "21 Northcross Rd, Ithaca, NY 14853",
            "category": "Hotspots"
        },
        {
            "name": "Libe Slope",
            "address": "Libe Slope, Ithaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Cascadilla Hall",
            "address": "Cascadilla Hall, Ithaca, NY 14850",
            "category": "Hotspots"
        },
        {
            "name": "Alice Cook House",
            "address": "709 University Ave, Ithaca, NY 14853",
            "category": "Hotspots"
        }
    ]
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
    "picture": "N/A",
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

## Uploading a picture

`POST` `/upload/{id}/` <br />

### Request

```
{
    "image_data": <IMAGE INFO>
}
```

### Success Response

```
{
    "success": true,
    "data": {
        "url": <IMAGE URL>
    }
}
```