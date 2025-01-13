---
comments: true
tags:
 - n8n

---

# Basics

Automation is about predefined actions that transform data from one point to another.

# Core concepts
## Trigger
Every workflow starts with a trigger. They start the automation.
Trigger only have an output branch.
They launch and activate the workflow.
There are:
-*manual trigger*
-*[Scheduled Trigger](./Nodes/ScheduledTrigger.md)* - Every minute/hour etc.
-*Applications* - Webhook, Property update, Form submission(['n8n Form Trigger'](./Nodes/n8nFormTrigger.md))

We can have multiple triggers.

## Filter
Filter allow or block certain types of data from following a path based on certain conditions.
['Filter Node'](./FilterNode.md)

## Actions
Actions allow to interact with applications

## Workflow

Trigger --> Sorting/Filtering/Fromatting/Transforming/Segmenting --> Action

First step is to map out the process by creating a flowchart:
- List every single step as a block; Get website link -> create image -> save image

## API's and Webhooks
API = Application programming interfaces

An API exposes a service and developers write programs to consume it.

In the documentation of an API we see how it works.

We send a request through the interface to the Application -> the application uses the interface to send a response

        --> Request
client                  Server/Interface/Application
        <-- Response

For that we for example use an [HTTP Request Node](./Nodes/HTTPRequestNode.md)

### Credentials
Let the application know that we are allowed to make a given request. Most API's require authentification through credentials.

Main ways to authenticate:
- Query Parameter: `?api_key=...`
- Header: `Authorization:Bearer...`

### Webhooks
Webhooks or Reverse API's

Webhooks indicate that something that you are waiting for has happened.

For example: Stripe
Everytime a customer made a payment to your stripe account

There are two options to retrieve that information:
- Polling - every x minutes check if new payment
- Webhook sends when new payment

## Nodes
Nodes are the building blocks of n8n

There are 3 main categories of nodes
- Entry piont like [Triggers](#trigger)
- Functions to transform, filter or format data
- Exit point - Apps/Application

Types are:
- Trigger
- Action in App
- Data transformation
- Flow
- Files
- Advanced.

In the Node View the left side shows the input data and the right side shows the output data.

Each node executes once per item.

In `Output Fieldname`can we rename the output data key name.

We also can set `Execute Once` in the node setting - the whole node just executes for first item in input.

Some nodes ask you for field names - in this case you don't use the expression. You use the name

## Data and Expressions
We can drag the key from the input field into the nodes fields.
That creates an expression "return for each item the associated value for that key" 
Everything between the `{{}}` is an expression.

Expression can combine plain text, item variables and javascript.

`{{$JSON.name}} says {{$JSON.greeting}}`

To create a key:value pair you assign a key name under `Name`field and then drag the expressions into the field.

We can add multiple fields under `Add Field`




## Branches
We create branches when we want to set different paths/sets of actions.

Nodes with multiple outputs have two output options to start branches on the right.

![Filter Out Empty Fields in Table](./Workflows/FilterOutEmptyFieldsTable.md)

## Useful Nodes

![Edit Fields](./Nodes/EditFields.md)

![Aggregate](./Nodes/Aggregate.md)

![Webhook](./Nodes/Webhook.md)