var CoffeeCorner = angular.module('CoffeeCorner', []);

CoffeeCorner.controller('FormFailedController', function($scope){
	var socket = io.connect('http://' + document.domain + ':'
		+ location.port + '/coffee');

	$scope.test = 'Text is here';

	socket.on('connect', function(){
		console.log('Connected');
	});
});