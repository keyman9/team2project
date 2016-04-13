var CoffeeCorner = angular.module('CoffeeCorner', []);

CoffeeCorner.controller('FormFailedController', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port);

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

	socket.on('FormFail', function(msg){
		document.getElementById('message').textContent = msg;
	});

	socket.on('redirect', function (data) {
    	window.location = data.url;
	});

	$scope.login = function(){
		socket.emit('login', $scope.username, $scope.password);
	};

	$scope.register = function(){
		socket.emit('register', $scope.firstName, $scope.lastName, $scope.zipcode, 
			$scope.favCoffee, $scope.username, $scope.password, $scope.passwordConf);
	};

});