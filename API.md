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
            "image": <IMAGE URL>,
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
        "category": "Hotspots",
        "image": <IMAGE URL>,
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
    "category": "Food",
    "image": <IMAGE URL>
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
        "image": <IMAGE URL>,
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
        "image": <IMAGE URL>,
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
            "category": "Food",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/ONBD7VCRC1FJSBWE.jpg"
        },
        {
            "name": "Louie's Lunch",
            "address": "534 Thurston Ave, Ithaca, NY 14850",
            "category": "Food",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/G4JQANYH8HS4P0HV.jpg"
        },
        {
            "name": "Trillium Dining Hall",
            "address": "215 Garden Ave, Ithaca, NY 14850",
            "category": "Food",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/HCF2YLT12L1B8SQK.jpg"
        },
        {
            "name": "The Terrace Restaurant",
            "address": "130 Statler Dr, Ithaca, NY 14853",
            "category": "Food",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/H7AC5QL620J4NNJM.jpg"
        },
        {
            "name": "Helen Newman Hall",
            "address": "Cradit Farm Dr, Ithaca, NY 14850",
            "category": "Fitness",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/1LR26WOY7FZBNR4G.jpg"
        },
        {
            "name": "Noyes Fitness Center",
            "address": "306 West Ave, Ithaca, NY 14850",
            "category": "Fitness",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/7TGTPGAYKBQJP6JQ.jpg"
        },
        {
            "name": "Teagle Down Fitness Center",
            "address": "512 Campus Rd #1, Ithaca, NY 14853",
            "category": "Fitness",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/8BRHMO6R41SW0M0I.gif"
        },
        {
            "name": "Beebe Lake Trail",
            "address": "Beebe Lake Trail, Ithaca, NY 14850",
            "category": "Fitness",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/LGRAIIEJ7GM27YTS.jpg"
        },
        {
            "name": "Cascadilla Gorge Trail",
            "address": "Cascadilla Gorge Trail, Ithaca, NY 14850",
            "category": "Fitness",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/V6OI0HUPHDEU65ZY.jpg"
        },
        {
            "name": "Plant Science Building",
            "address": "Plant Science Building, Ithaca, NY 14850",
            "category": "Studying",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/JE51COTSF7BEFTEG.jpg"
        },
        {
            "name": "Duffield Hall",
            "address": "343 Campus Rd, Ithaca, NY 14853",
            "category": "Studying",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/OA92DACHMEIH19ZZ.jpg"
        },
        {
            "name": "Upson Hall",
            "address": "124 Hoy Rd, Ithaca, NY 14850",
            "category": "Studying",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/3WN4MTP18DZGPV1A.jpg"
        },
        {
            "name": "Mann Library",
            "address": "237 Mann Dr, Ithaca, NY 14850",
            "category": "Studying",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/GAYIUEZQHXAVW6TT.jpg"
        },
        {
            "name": "Uris Library",
            "address": "160 Ho Plaza, Ithaca, NY 14853",
            "category": "Studying",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/FL8W0J0CZRRE13QN.jpg"
        },
        {
            "name": "McGraw Tower",
            "address": "Towers Rd, Ithaca, NY 14850",
            "category": "Hotspots",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/KUH4NAAQBBM3E3EJ.jpg"
        },
        {
            "name": "Cornell Botanic Gardens",
            "address": "124 Comstock Knoll Dr, Ithaca, NY 14850",
            "category": "Hotspots",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/MR92SR6BWAQ3ZPDM.jpg"
        },
        {
            "name": "Ag Quad",
            "address": "237 Mann Dr, Ithaca, NY 14853",
            "category": "Hotspots",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/0XGARBMM4U2VX78A.jpg"
        },
        {
            "name": "Arts Quad",
            "address": "Arts QuadIthaca, NY 14850",
            "category": "Hotspots",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/TG2Y29RVWDWY0GGD.jpg"
        },
        {
            "name": "Libe Slope",
            "address": "Libe Slope, Ithaca, NY 14850",
            "category": "Hotspots",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/1HC20DTSLIFHWS1S.jpg"
        },
        {
            "name": "Mary Donlon Hall",
            "address": "Mary Donlon Hall, Ithaca, NY 14850",
            "category": "Dorm",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/90O80XYJMIQJVLEV.jpg"
        },
        {
            "name": "Court-Kay-Bauer Hall",
            "address": "148 Cradit Farm Dr, Ithaca, NY 14850",
            "category": "Dorm",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/Q1R573PF2XROLYDZ.jpg"
        },
        {
            "name": "Clara Dickson Hall",
            "address": "21 Northcross Rd, Ithaca, NY 14853",
            "category": "Dorm",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/NX5VDN7XHR8R7A5X.jpg"
        },
        {
            "name": "Cascadilla Hall",
            "address": "Cascadilla Hall, Ithaca, NY 14850",
            "category": "Dorm",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/BRN0ET0Q31RAUA11.jpg"
        },
        {
            "name": "Alice Cook House",
            "address": "709 University Ave, Ithaca, NY 14853",
            "category": "Dorm",
            "image": "https://cornellconnect.s3-us-east-2.amazonaws.com/EBOXEP8LUUFP5MKO.jpg"
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