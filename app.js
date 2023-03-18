
const express = require("express");
const app = express(); 

function run_web_site(port) {  
	const router = express.Router();  
	console.log("Hook /rebuild")
	router.get("/rebuild", function (req, res) { 
		res.setHeader('Content-Type', 'application/json');
		console.log("/rebuild")
		res.send({ "status": 'OK' });
		const { exec } = require('child_process');
        var yourscript = exec('bash ./scripts/rebuild-once.sh',
          (error, stdout, stderr) => {
              console.log(stdout);
              console.log(stderr);
              if (error !== null) {
                  console.log(`exec error: ${error}`);
              }
          });

	}); 
	console.log("Hook /authorize")
	router.get("/authorize", function (req, res) { 
		res.setHeader('Content-Type', 'application/json');
		console.log("/authorize")
		res.send({ "status": 'OK' }); 
		const { exec } = require('child_process');
        var yourscript = exec('bash ./scripts/authorize.sh '+req.query.id,
          (error, stdout, stderr) => {
              console.log(stdout);
              console.log(stderr);
              if (error !== null) {
                  console.log(`exec error: ${error}`);
              }
          });

	});
	console.log("Hook /poll")
	router.get("/poll", function (req, res) { 
		res.setHeader('Content-Type', 'application/json');
		console.log("/poll")
		res.send({ "status": 'OK' }); 
		const { exec } = require('child_process');
        var yourscript = exec('bash ./scripts/poll.sh ',
          (error, stdout, stderr) => {
              console.log(stdout);
              console.log(stderr);
              if (error !== null) {
                  console.log(`exec error: ${error}`);
              }
          });

	});


	app.use(express.static('html')); 
	app.use("/", router);   
	console.log("Ready to serve")
	app.listen(port, function () {
		console.log("Static site hosted on port", port);
	});
} 
run_web_site(8080) 