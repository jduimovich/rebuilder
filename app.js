
const express = require("express");
const app = express(); 

function run_web_site(port) {  
	const router = express.Router();  
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
	app.use(express.static('html')); 
	app.use("/", router);   
	app.listen(port, function () {
		console.log("Static site hosted on port", port);
	});
} 
run_web_site(8080) 