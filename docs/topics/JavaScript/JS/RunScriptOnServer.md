---
comments: true
tags:
  - JavaScript
---
# Run Script On Server
To run a script on a server you need a javascript environment on a server. Most commonly used for that is node.js

1. Install node.js
You can download node js on `https://nodejs.org`

To check if node.js got properly installed test in terminal `node -v`

2. Write a simple Javascript file
In a file called for example `index.js` write your javascript behaviour

To execute the javascript file in the node environment 
`node index.js` in the terminal

3. Execute File on a server
*Local server* 
If you want to execute a script on your computer as a server you can create an HTTP-Server-Script

```JS
const http = require('http')

const server = http.createServer((req,res)=>{
    res.writeHead(200,{'Content-Type': 'text/plain'});
    res.end('Hallo von meinem Node.js-Server!\n');
});

const port = 3000;
server.listen(port,()=>{
    console.log('Server läuft auf http://localhost:${port}');
});
```

*External hosting*
To host a JS script not just locally but on a server you can rent a 
Virtual Private Server or you can use free cloud products (Heroku, Railway,Render)

1. Install Node.js if it isnt already installed

2. Upload Code via Git or FTP/SSH to the server.

3. Install dependencies
`npm install`

4. Start Script
`node server.js`

4. Execute script constantly
To execute the script constantly it makes sense to use a prozessmanager like pm2 

`npm install pm2 -g`

Start script with pm2
`pm2 start server.js`