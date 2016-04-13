var CoffeeCorner = angular.module('CoffeeCorner', []);

CoffeeCorner.controller('FormFailedController', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/coffee');

	$scope.firstName = "";
	$scope.lastName = "";
	$scope.zipcode = "";
	$scope.favCoffee = "";
	$scope.username = "";
	$scope.password = "";
	$scope.passwordConf = "";


	socket.on('connect', function(){
		console.log('Connected');
	});

	socket.on('registerFail', function(msg){
		console.log('REGISTER FAILED');
		document.getElementById('message').textContent = msg;
	});

	socket.on('redirect', function (data) {
    	window.location = data.url;
	});

	$scope.register = function(){
		console.log("In Register");
		console.log("Password is " + $scope.password);
		console.log($scope.passwordConf);
		socket.emit('register', $scope.firstName, $scope.lastName, $scope.zipcode, 
			$scope.favCoffee, $scope.username, $scope.password, $scope.passwordConf);
	};
});