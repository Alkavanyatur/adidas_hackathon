var express = require('express');
var app = express();
var https = require('https');
var regression = require('regression');

function getTypeSport(preferences){
    console.log('A:' + preferences);
    var rand = Math.floor((Math.random() * 5));
    switch(rand){
        case 0:
            if (preferences.bike === true) {
                return 'bike';
            }
            break;
        case 1:
            if (preferences.hiking === true) {
                return 'hiking';
            }
            break;
        case 2:
            if (preferences.run === true) {
                return 'run';
            }
            break;
        case 3:
            if (preferences.swimming === true) {
                return 'swimming';
            }
            break;
        case 4:
            if (preferences.walk === true) {
                return 'walk';
            }
            break;
    }
}

function generateAndChallange(uID, resp){
    var url = 'https://hackatonadidas-f8805.firebaseio.com/Users/'+ uID +'.json';
    https.get(url, function(res){
        var body = '';
        res.on('data', function(chunk){
            body += chunk;
        });
        res.on('end', function(){
            var fbResponse = JSON.parse(body);
            console.log(fbResponse);
            var typeSport = getTypeSport(fbResponse.preferences);
            var measuresArray = [];
            var isDistance = false;
            if (Math.floor((Math.random() * 100) + 1) > 30){
                for (measure in fbResponse.medicalStats.distance){
                    measuresArray.push(fbResponse.medicalStats.distance[measure]);
                    isDistance = true;
                }
            } else {
                for (measure in fbResponse.medicalStats.kcal){
                    measuresArray.push(fbResponse.medicalStats.kcal[measure]);
                }
            }
            const data = [];
            measuresArray.forEach(function(val, i){
                data.push([i,val]);
            });
            const result = regression.polynomial(data, { order: 1 });
            var response = {};
            if (isDistance === true){
                response = {
                    distance: result.points.length * result.equation[0] + result.equation[1],
                    kcal: 0,
                    longDescriptionChallenge: "You must complete this distance within the time window.",
                    oponentID: 0,
                    oponentName: "",
                    result: "onGoing",
                    state: "active",
                    timestamp: Date.now(),
                    type: "predefined",
                    typeSport: typeSport
                }
            }else {
                response = {
                    distance: 0,
                    kcal: result.points.length * result.equation[0] + result.equation[1],
                    longDescriptionChallenge: "You must consme this calories within the time window.",
                    oponentID: 0,
                    oponentName: "",
                    result: "onGoing",
                    state: "active",
                    timestamp: Date.now(),
                    type: "predefined",
                    typeSport: typeSport
                }
            }
            resp.send(response);
        });
    });
}

app.get('/:userId/', function (req, res) {
    generateAndChallange(req.params.userId, res);
});

var thereIsAnUserWaiting = false;
var userWaiting = '';
app.get('/:userId/match', function (req, resp) {
    if(thereIsAnUserWaiting === false){
        thereIsAnUserWaiting = true;
        userWaiting = req.params.userId;
        resp.send('Wait please!');
    } else {
        var url = 'https://hackatonadidas-f8805.firebaseio.com/Users/'+ req.params.userId +'.json';
        https.get(url, function(res){
            var body = '';
            res.on('data', function(chunk){
                body += chunk;
            });
            res.on('end', function(){
                var fbResponse = JSON.parse(body);
                var typeSport = getTypeSport(fbResponse.preferences);
                var response = {};
                var measuresArray = [];
                if (Math.floor((Math.random() * 100) + 1) > 30){
                    for (measure in fbResponse.medicalStats.distance){
                        measuresArray.push(fbResponse.medicalStats.distance[measure]);
                    }
                    const data = [];
                    measuresArray.forEach(function(val, i){
                        data.push([i,val]);
                    });
                    const result = regression.polynomial(data, { order: 1 });
                    response = {
                        distance: result.points.length * result.equation[0] + result.equation[1],
                        kcal: 0,
                        longDescriptionChallenge: "You must complete this event to beat your opponent",
                        oponentID: userWaiting,
                        oponentName: "",
                        result: "onGoing",
                        state: "active",
                        timestamp: Date.now(),
                        type: "match",
                        typeSport: typeSport
                    };
                } else {
                    for (measure in fbResponse.medicalStats.distance){
                        measuresArray.push(fbResponse.medicalStats.kcal[measure]);
                    }
                    const data = [];
                    measuresArray.forEach(function(val, i){
                        data.push([i,val]);
                    });
                    const result = regression.polynomial(data, { order: 1 });
                    response = {
                        distance: 0,
                        kcal: result.points.length * result.equation[0] + result.equation[1],
                        longDescriptionChallenge: "You must complete this event to beat your opponent",
                        oponentID: userWaiting,
                        oponentName: "",
                        result: "onGoing",
                        state: "active",
                        timestamp: Date.now(),
                        type: "match",
                        typeSport: typeSport
                    };
                }
                thereIsAnUserWaiting = false;
                userWaiting = '';
                resp.send(response);
            });
        });
    }
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
