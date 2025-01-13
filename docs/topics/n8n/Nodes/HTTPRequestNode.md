---
comments: true
tags:
 - n8n
 - n8n/Action
 - n8n/Node

---
# HTTP Request Node
The http request node allows to make http request and receive to respond.

## Request
There are four components to an http request.

- url
- method
- header
- body

### Method
Action that we want to perform at the given url.

`GET` Receive Info

`POST` Send Info

`DELETE, PUT, PATCH` are less common.

### Header
In the header we communicate more detail/context for the request.

Common infos are:
- Your device location
- Your device language
- Your devie type

Example header: - `ACCEPT:application/json` tells server would like response in json format.

### Body
Only exist for post request. Contains information that get send to the server

## Response
Three components of http response.

- status code
- header
- body

### Status Code
Three digit number that indicates whether request was succesful.
`200` - OK
`401` - Unauthorised
`404` - Not found
`500` - Internal Server error

When starts with 4 most likely your mistake, when it starts with 5 problem on the server side. 

### Header
Header gives more detail to response
Common ones are:
- Content-length
- Content-type
- Expire

### Body
Data that gets returned
- html
- json
- data