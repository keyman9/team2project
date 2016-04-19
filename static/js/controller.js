var CoffeeCorner = angular.module('CoffeeCorner', []);

/** Controller for Login and Register Page **/
CoffeeCorner.controller('Form', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/form');

	$scope.firstName = "";
	$scope.lastName = "";
	$scope.zipcode = "";
	$scope.favCoffee = "";
	$scope.email = "";
	$scope.username = "";
	$scope.password = "";
	$scope.passwordConf = "";


	socket.on('connect', function(){
		console.log('Connected to Form');
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
			$scope.favCoffee, $scope.email, $scope.username, $scope.password, $scope.passwordConf);
	};
});

/** Controller for Recipes **/
CoffeeCorner.controller('Recipes', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/addRecipe');

	socket.on('connect', function(){
		console.log('Connected to Form');
	});

	socket.on('redirect', function (data) {
    	window.location = data.url;
	});

	$scope.recipeTitle = ""
    $scope.recipe = ""
    $scope.addRecipe = function(){
        console.log($scope.recipeTitle);
        console.log($scope.recipe);
        socket.emit('addRecipe', $scope.recipeTitle, $scope.recipe);
    };

});

/** Controller for Browse Page **/
CoffeeCorner.controller('Browse', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/browse');

	$scope.roast = "Light";
	$scope.region = "South America";
	$scope.price = "12.00";
	$scope.orderBy = "Name";
	$scope.searchTerm = "";

	$scope.colName = "Name";
	$scope.colPrice = "Price";
	$scope.colWeight = "Weight";
	$scope.colRoast = "Roast";
	$scope.colBody = "Body";
	$scope.colRegion = "Region";
	$scope.colDescription = "Description";
	$scope.results = [];


	socket.on('connect', function(){
		console.log('Connected to Browse');
	});

	socket.on('clearList', function(){
		$scope.results = [];
	});

	socket.on('printResults', function(coffee){
		console.log(coffee);
		$scope.results.push(coffee);
		$scope.$apply()
	});

	$scope.search = function(){
		socket.emit('search', $scope.roast, $scope.region, $scope.price, $scope.orderBy, $scope.searchTerm);
	};
});

/** Controller for Account Page **/
CoffeeCorner.controller('Account', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/account');

	$scope.user = [];


	socket.on('connect', function(){                     
		console.log('Connected to Account');
	});

	socket.on('getUser', function(){                     
		socket.emit('getUser');
	});

	socket.on('displayInfo', function(user){  
		console.log(user);                  
		$scope.user.push(user);
		$scope.$apply();
	});

	socket.on('redirect', function (data) {
    	window.location = data.url;
	});

	$scope.logOut = function(){
		socket.emit('logOut');
	}
});