app.config(function ($routeProvider) {
  $routeProvider
    .when("/statuses", {
      templateUrl: tmp + "statuses__index",
      controller: "StatusController",
    })
    .when("/status/add", {
      templateUrl: tmp + "statuses__add",
      controller: "StatusAddController",
    })
    .when("/status/edit/:id", {
      templateUrl: tmp + "statuses__edit",
      controller: "StatusEditController",
    })
    .when("/status/view/:id", {
      templateUrl: tmp + "statuses__view",
      controller: "StatusViewController",
    });
});
