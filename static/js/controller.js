var CoffeeCorner = angular.module('Coffee-Corner', []);

CoffeeCorner.controller('FormFailedController', function($scope){
	var socket = io.connect('http://' + document.domain + ':'
		+ location.port);

	socket.on('connect', function(){
		console.log('Connected');
	});
});