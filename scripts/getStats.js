#!/usr/bin/env node

var program = require('commander');

/* Commander  Stuff*/
program
.version('0.0.1')
.option('-c, --config <path>', 'Config file')
.parse(process.argv);

if (!program.config){
	console.log('\n\t error: option \'-c, --config <path>\' is mandatory \n');
	return;
}

/*Get config from json file*/
var fs = require('fs');

var file = __dirname + "/" + program.config;

fs.readFile(file, 'utf8', function (err, data) {
	if (err)  {console.dir(err); return;}

	configData = JSON.parse(data);

	var request = require('request');
	var username = configData.uid;
	var password = configData.password;
	var options = {
		url: configData.url,
		auth: {
			user: username,
			password: password
		}
	};

	request(options, function (err, res, body) {
		if (err) {console.dir(err); return;}

		if (res.statusCode == 200){
			var statsData = {};

			statsData.datetime = new Date().toJSON();

			var parseString = require('xml2js').parseString;
			parseString(body, function (err, result) {
				if (err)  {console.dir(err); return;}

				statsData.streams = [];
				configData.streams.map(function (wantedStream){
					result.icestats.source.map(function (receivedStream){
						if(wantedStream == receivedStream.$.mount.replace("\/","")){
							thisStream = {};
							thisStream.streamName = wantedStream;
							thisStream.listners = receivedStream.listeners[0];
							thisStream.max_listners = receivedStream.listener_peak[0];
							statsData.streams.push(thisStream);
						}
					});
				});

				var fileData = [];

				fs.exists(configData.outputfilepath, function(exists) {
					if (exists){
						readData = fs.readFileSync(configData.outputfilepath, 'utf8');
						fileData = JSON.parse(readData);
					}
					else{
						var mkdirp = require("mkdirp");
						var getDirName = require("path").dirname;
						mkdirp.sync(getDirName(configData.outputfilepath));
					}

					if (fileData != null){
					fileData.push(statsData);
					fs.writeFile(configData.outputfilepath, JSON.stringify(fileData),function (err){
						if (err)  {console.dir(err); return;}
					});
				}
				});
			});
}
});

});
