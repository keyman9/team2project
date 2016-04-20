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
	$scope.loggedIn = false;


	socket.on('connect', function(){
		console.log('Connected to Browse');
	});

	socket.on('clearList', function(){
		document.getElementById("results").style.display = "none";
		$scope.results = [];
	});

	socket.on('printResults', function(data){
		document.getElementById("results").style.display = "block";
		$scope.loggedIn = data[1];
		$scope.results.push(data[0]);
		$scope.$apply()
	});

	$scope.search = function(){
		socket.emit('search', $scope.roast, $scope.region, $scope.price, $scope.orderBy, $scope.searchTerm);
	};

	$scope.updateFavorite = function(coffeeName, liked){
		socket.emit('updateFavorite', coffeeName, liked);
		for (i=0; i<$scope.results.length; i++){
			if ($scope.results[i]['name'] == coffeeName){
				$scope.results[i]['liked'] = !liked;
			}
		}
	};
});

/** Controller for Account Page **/
CoffeeCorner.controller('Account', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/account');

	$scope.user = [];
	$scope.firstName = "";
	$scope.lastName = "";
	$scope.zipcode = "";
	$scope.favCoffee = "";
	$scope.email = "";
	$scope.username = "";
	$scope.oldPassword = "";
	$scope.newPassword = "";


	socket.on('connect', function(){                     
		console.log('Connected to Account');
	});

	socket.on('getUser', function(){                     
		socket.emit('getUser');
	});

	socket.on('FormFail', function(msg){
		document.getElementById('message').textContent = msg;
	});

	socket.on('displayInfo', function(user){  
		$scope.firstName = user['First_Name'];
		$scope.lastName = user['Last_Name'];
		$scope.zipcode = user['zipcode'];
		$scope.favCoffee = user['favCoffee'];
		$scope.email = user['email'];              	 
		$scope.user.push(user);
		$scope.$apply();
	});

	socket.on('redirect', function (data) {
    	window.location = data.url;
	});

	$scope.updateAccount = function(){
		socket.emit('updateAccount', $scope.firstName, $scope.lastName, $scope.zipcode, 
			$scope.favCoffee, $scope.email, $scope.oldPassword, $scope.newPassword);
	};

	$scope.logOut = function(){
		socket.emit('logOut');
	};
});

/** Controller for Favorite Page **/
CoffeeCorner.controller('Favorites', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/favorites');

	$scope.colName = "Name";
	$scope.colPrice = "Price";
	$scope.colWeight = "Weight";
	$scope.colRoast = "Roast";
	$scope.colBody = "Body";
	$scope.colRegion = "Region";
	$scope.colDescription = "Description";
	$scope.results = [];

	socket.on('connect', function(){                     
		console.log('Connected to Favorites');
	});

	socket.on('getFavorites', function(coffee){
		$scope.results.push(coffee);
		$scope.$apply()
	});

	$scope.updateFavorite = function(coffeeName, liked){
		socket.emit('updateFavorite', coffeeName, liked);
		for (i=0; i<$scope.results.length; i++){
			// When coffee found, update to opposite of current state
			if ($scope.results[i]['name'] == coffeeName){
				$scope.results[i]['liked'] = !liked;
			}
		}
	};
});

/** Controller for Favorite Page **/
CoffeeCorner.controller('FindFriends', function($scope){
	var socket = io.connect('http://' + document.domain + ':' + location.port + '/friends');

	$scope.userSearch = "";
	$scope.userList = [];

	socket.on('connect', function(){                     
		console.log('Connected to Find Friends');
	});

	socket.on('FormFail', function(msg){
		document.getElementById('message').textContent = msg;
	});

	socket.on('clearList', function(){
		document.getElementById("results").style.display = "none";
		$scope.userList = [];
	});

	socket.on('displayUsers', function(user){
		document.getElementById("results").style.display = "block";
		console.log(user);
		$scope.userList.push(user);
		$scope.$apply()
	});

	$scope.findFriends = function(){
		console.log("Looking for " + $scope.userSearch);
		socket.emit('findFriends', $scope.userSearch);
	};

	$scope.updateFriend = function(username, alreadyFollowing){
		socket.emit('updateFriend', username, alreadyFollowing);
		for (i=0; i<$scope.userList.length; i++){
			// When user found, update to opposite of current state
			if ($scope.userList[i]['username'] == username){
				$scope.userList[i]['following'] = !alreadyFollowing;
			}
		}
	};
});



