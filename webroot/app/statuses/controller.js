app.controller("StatusController", function ($scope, CrudStatus) {
  $("#form").validationEngine("attach");

  // load data
  $scope.load = function (options) {
    options = typeof options !== "undefined" ? options : {};
    CrudStatus.query(options, function (e) {
      if (e.ok) {
        $scope.statuses = e.data;
        //pagination
        $scope.paginator = e.paginator;
        $scope.pages = paginator($scope.paginator, 5);
      }
    });
  };
  $scope.load();

  // remove
  $scope.remove = function (data) {
    bootbox.confirm(
      "Are you sure you want to delete " + data.name + " ?",
      function (c) {
        if (c) {
          CrudStatus.remove({ id: data.id }, function (e) {
            if (e.ok) {
              $.gritter.add({
                title: "Successful!",
                text: e.msg,
              });
              $scope.load();
            }
          });
        }
      }
    );
  };
});

app.controller("StatusAddController", function ($scope, CrudStatus) {
  $("#form").validationEngine("attach");

  $scope.data = {
    CrudStatus: {},
  };

  $scope.addStatus = function () {
    $("#add_status").validationEngine("attach");
    $scope.adata = {};
    $("#add-status-modal").modal("show");
  };

  $scope.save = function () {
    valid = $("#form").validationEngine("validate");
    if (valid) {
      // console.log("Final data before saving:", $scope.data); // Inspect the entire data object
      CrudStatus.save($scope.data, function (e) {
        if (e.ok) {
          $.gritter.add({
            title: "Successful!",
            text: e.msg,
          });
          window.location = "#/statuses";
        } else {
          $.gritter.add({
            title: "Warning!",
            text: e.msg,
          });
        }
      });
    }
  };
});

app.controller(
  "StatusViewController",
  function ($scope, $routeParams, CrudStatus) {
    modalMaxHeight();
    $scope.id = $routeParams.id;
    $scope.data = {};

    $scope.data = {
      CrudStatus: {},
    };

    // load
    $scope.load = function () {
      CrudStatus.get({ id: $scope.id }, function (e) {
        $scope.data = e.data;
      });
    };
    $scope.load();

    // remove
    $scope.remove = function (data) {
      bootbox.confirm(
        "Are you sure you want to delete " + data.name + " ?",
        function (c) {
          if (c) {
            CrudStatus.remove({ id: data.id }, function (e) {
              if (e.ok) {
                $.gritter.add({
                  title: "Successful!",
                  text: e.msg,
                });
                window.location = "#/statuses";
                // $scope.load();
              }
            });
          }
        }
      );
    };
  }
);

app.controller(
  "StatusEditController",
  function ($scope, $routeParams, CrudStatus) {
    $scope.id = $routeParams.id;
    $("#form").validationEngine("attach");

    $scope.data = {
      CrudStatus: {},
    };
    // load
    $scope.load = function () {
      CrudStatus.get({ id: $scope.id }, function (e) {
        $scope.data = e.data;
      });
    };
    $scope.load();

    $scope.update = function () {
      valid = $("#form").validationEngine("validate");
      if (valid) {
        CrudStatus.update({ id: $scope.id }, $scope.data, function (e) {
          if (e.ok) {
            $.gritter.add({
              title: "Successful!",
              text: e.msg,
            });
            window.location = "#/statuses";
          } else {
            $.gritter.add({
              title: "Warning!",
              text: e.msg,
            });
          }
        });
      }
      // }
    };
  }
);
