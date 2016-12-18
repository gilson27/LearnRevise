app.controller('menuController', ["$scope", 
    function($scope) {
        $scope.menu = "home";
        $scope.model = {"title": "Our Menu"};
        $scope.model.mainDish = 'BBQ Chicken Pizza'
		$scope.$watch('model.mainDish', function (newValue, oldValue) {
			if (newValue === 'BBQ Chicken Pizza') {
				alert('You have selected the BBQ Chicken Pizza!');
			}
		});
        
        $scope.changeMainDish = function(item) {
			$scope.model.mainDish = item;
		};
    }
]);
