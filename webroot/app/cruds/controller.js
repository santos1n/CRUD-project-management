app.controller("CrudController", function ($scope, Crud, $http) {
  // load data
  $scope.load = function (options) {
    options = typeof options !== "undefined" ? options : {};
    Crud.query(options, function (e) {
      if (e.ok) {
        $scope.cruds = e.data;
        //pagination
        $scope.paginator = e.paginator;
        $scope.pages = paginator($scope.paginator, 5);
      }
    });
  };
  $scope.load();

  //search
  $scope.search = function (search) {
    search = typeof search !== "undefined" ? search : "";
    if (search.length > 0) {
      $scope.load({
        search: search,
      });
    } else {
      $scope.load();
    }
  };

  $scope.printPdf = function () {
    var dataToPrint = $scope.cruds;

    var form = document.createElement("form");
    form.method = "POST";
    form.action = "print/printTable";
    form.target = "_blank";

    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "table_data";
    input.value = JSON.stringify(dataToPrint);

    form.appendChild(input);
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
  };

  $scope.selectedStatus = "";
  $scope.toggleStatus = function (status) {
    if ($scope.selectedStatus === status) {
      // If the status is already selected, clear the selection
      $scope.selectedStatus = "";
      $scope.search("");
    } else {
      // Otherwise, select the new status and perform the search
      $scope.selectedStatus = status;
      $scope.search(status);
    }
  };

  // remove
  $scope.remove = function (data) {
    bootbox.confirm(
      "Are you sure you want to delete " + data.name + " ?",
      function (c) {
        if (c) {
          Crud.remove({ id: data.id }, function (e) {
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

app.controller(
  "CrudAddController",
  function ($scope, Crud, Select, AgeService, $http) {
    $("#form").validationEngine("attach");

    // get crud status
    Select.get({ code: "crud-statuses" }, function (e) {
      $scope.statuses = e.data;
    });

    $scope.data = {
      Crud: {},
      Beneficiary: [],
      CrudFile: [],
    };

    $scope.selectedFiles = [];

    $scope.addBeneficiary = function () {
      $("#add_beneficiary").validationEngine("attach");
      $scope.adata = {};
      $("#add-beneficiary-modal").modal("show");
    };

    $scope.saveBeneficiary = function (data) {
      valid = $("#add_beneficiary").validationEngine("validate");

      if (valid) {
        // console.log("Adding beneficiary:", data);
        $scope.data.Beneficiary.push(data);
        // console.log("$scope.data.Beneficiary:", $scope.data.Beneficiary);
        $("#add-beneficiary-modal").modal("hide");
      }
    };

    $scope.editBeneficiary = function (index, data) {
      $("#edit_beneficiary").validationEngine("attach");
      data.index = index;
      $scope.adata = data;
      $("#edit-beneficiary-modal").modal("show");
    };

    $scope.updateBeneficiary = function (data, index) {
      valid = $("#edit_beneficiary").validationEngine("validate");

      if (valid) {
        $scope.data.Beneficiary[data.index] = data;
        $("#edit-beneficiary-modal").modal("hide");
      }
    };

    $scope.removeBeneficiary = function (index) {
      $scope.data.Beneficiary.splice(index, 1);
    };

    $scope.selectedFiles = [];

    $scope.onFileChange = function (element) {
      $scope.$apply(function () {
        // Convert FileList to Array
        var newFiles = Array.from(element.files);

        // Filter out duplicates by name (optional)
        newFiles = newFiles.filter(function (newFile) {
          return !$scope.selectedFiles.some(function (existingFile) {
            return (
              existingFile.name === newFile.name &&
              existingFile.size === newFile.size
            );
          });
        });

        // Append new files to the existing array
        $scope.selectedFiles = $scope.selectedFiles.concat(newFiles);

        // Clear the input so the same file can be selected again if needed
        element.value = "";
      });
    };

    $scope.save = function () {
      var valid = $("#form").validationEngine("validate");

      if (valid) {
        const email = $scope.data.Crud.email;
        const regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!regex.test(email)) {
          $.gritter.add({
            title: "Error!",
            text: "Please enter a valid email address.",
            class_name: "gritter-error",
          });
          return;
        } else {
          // Use FormData for file upload
          var formData = new FormData();
          formData.append("data", JSON.stringify($scope.data));
          if ($scope.selectedFiles && $scope.selectedFiles.length > 0) {
            $scope.selectedFiles.forEach(function (file) {
              formData.append("files[]", file);
            });
          }

          $http
            .post("/Training/cruds/add", formData, {
              transformRequest: angular.identity,
              headers: { "Content-Type": undefined },
            })
            .then(function (response) {
              var e = response.data.response || response.data;
              if (e.ok) {
                $http.post("/Training/cruds/sendEmail", {
                  Crud: { email: email },
                  action: "save",
                });
                $.gritter.add({
                  title: "Successful!",
                  text: e.msg,
                });
                window.location = "#/cruds";
              } else {
                $.gritter.add({
                  title: "Warning!",
                  text: e.msg,
                });
              }
            });
        }
      }
    };

    $scope.ageCompute = function (birthdate, caller) {
      if (caller === "crud") {
        // console.log(caller);
        $scope.data.Crud.age = AgeService.ageCompute(birthdate);
      } else {
        $scope.adata.age = AgeService.ageCompute(birthdate);
      }
    };
  }
);

app.controller(
  "CrudViewController",
  function ($scope, $routeParams, Crud, Beneficiary, $http) {
    modalMaxHeight();
    $scope.id = $routeParams.id;
    $scope.data = {};
    $scope.data.Beneficiary = [];
    $scope.data.CrudFile = [];

    $scope.data = {
      Crud: {},
      Beneficiary: [],
      CrudFile: [],
    };

    // load
    $scope.load = function () {
      Crud.get({ id: $scope.id }, function (e) {
        $scope.data = e.data;
      });
    };
    $scope.load();

    $scope.formatDate = function (date) {
      var dateOut = new Date(date);
      return dateOut;
    };

    $scope.printPdf = function () {
      var dataToPrint = $scope.data;

      var form = document.createElement("form");
      form.method = "POST";
      form.action = "print/printProfile";
      form.target = "_blank";

      var input = document.createElement("input");
      input.type = "hidden";
      input.name = "profile_data";
      input.value = JSON.stringify(dataToPrint);

      form.appendChild(input);
      document.body.appendChild(form);
      form.submit();
      document.body.removeChild(form);
    };

    $scope.addBeneficiary = function () {
      $("#add_beneficiary").validationEngine("attach");
      $scope.adata = {};
      $("#add-beneficiary-modal").modal("show");
    };

    $scope.saveBeneficiary = function (data) {
      valid = $("#add_beneficiary").validationEngine("validate");

      if (valid) {
        $scope.data.Beneficiary.push(data);
        $("#add-beneficiary-modal").modal("hide");
      }
    };

    $scope.removeBeneficiary = function (index) {
      $scope.data.Beneficiary.splice(index, 1);
    };

    // Helper function to update status
    $scope.setStatus = function (data, newStatus) {
      let name = data.Crud.name;
      let statusText =
        newStatus == "APPROVED"
          ? "Approved"
          : newStatus == "DISAPPROVED"
          ? "Disapproved"
          : "Pending";

      bootbox.confirm({
        message:
          'Are you sure you want to set "' +
          name +
          '" to ' +
          statusText +
          "  ?",
        buttons: {
          cancel: {
            label: "No",
            className: "btn-default",
          },
          confirm: {
            label: "Yes",
            className: "btn-danger",
          },
        },
        callback: function (c) {
          if (c) {
            Crud.update(
              { id: data.Crud.id },
              {
                Crud: {
                  id: data.Crud.id,
                  status: newStatus,
                },
              },
              function (e) {
                if (e.ok) {
                  $http.post("/Training/cruds/sendEmail", {
                    Crud: { email: data.Crud.email },
                    action: newStatus,
                  });
                  $.gritter.add({
                    title: "Successful!",
                    text: e.msg,
                    class_name: "gritter-success",
                  });
                } else {
                  $.gritter.add({
                    title: "Warning!",
                    text: e.msg,
                    class_name: "gritter-warning",
                  });
                }
                $scope.load();
              }
            );
          }
        },
      });
    };

    // remove
    $scope.remove = function (data) {
      bootbox.confirm(
        "Are you sure you want to delete " + data.name + " ?",
        function (c) {
          if (c) {
            Crud.remove({ id: data.id }, function (e) {
              if (e.ok) {
                $.gritter.add({
                  title: "Successful!",
                  text: e.msg,
                });
                window.location = "#/cruds";
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
  "CrudEditController",
  function ($scope, $routeParams, Crud, Select, AgeService, $http) {
    $scope.id = $routeParams.id;
    $("#form").validationEngine("attach");

    // get crud status
    Select.get({ code: "crud-statuses" }, function (e) {
      $scope.statuses = e.data;
    });

    $scope.data = {
      Crud: {},
      Beneficiary: [],
      CrudFile: [],
    };

    $scope.selectedFiles = [];

    // Load existing data
    $scope.load = function () {
      Crud.get({ id: $scope.id }, function (e) {
        $scope.data = e.data;
      });
    };
    $scope.load();

    // File input handler: push new files to data.CrudFile
    $scope.onFileChange = function (element) {
      $scope.$apply(function () {
        var newFiles = Array.from(element.files);
        // Filter out duplicates by name and size
        newFiles = newFiles.filter(function (newFile) {
          return !$scope.data.CrudFile.some(function (existingFile) {
            return (
              (existingFile.name === newFile.name &&
                existingFile.size === newFile.size) ||
              (existingFile.fileName === newFile.name && existingFile.filePath) // avoid duplicate with existing
            );
          });
        });
        // Push new files as objects (they have .name and .size)
        Array.prototype.push.apply($scope.data.CrudFile, newFiles);
        element.value = "";
      });
    };

    // Remove file (existing or new)
    $scope.removeFile = function (index) {
      var file = $scope.data.CrudFile[index];
      // If it's an existing file (has filePath), mark as invisible for backend
      if (file.filePath) {
        $scope.data.CrudFile[index].visible = 0;
      } else {
        // Otherwise, just remove from array
        $scope.data.CrudFile.splice(index, 1);
      }
    };

    $scope.ageCompute = function (birthdate, caller) {
      if (caller === "crud") {
        $scope.data.Crud.age = AgeService.ageCompute(birthdate);
      } else {
        $scope.adata.age = AgeService.ageCompute(birthdate);
      }
    };

    $scope.addBeneficiary = function () {
      $("#add_beneficiary").validationEngine("attach");
      $scope.adata = {};
      $("#add-beneficiary-modal").modal("show");
    };

    $scope.saveBeneficiary = function (data) {
      valid = $("#add_beneficiary").validationEngine("validate");

      if (valid) {
        $scope.data.Beneficiary.push(data);
        $("#add-beneficiary-modal").modal("hide");
      }
    };

    $scope.updateBeneficiary = function (data, index) {
      valid = $("#edit_beneficiary").validationEngine("validate");

      if (valid) {
        $scope.data.Beneficiary[data.index] = data;
        $("#edit-beneficiary-modal").modal("hide");
      }
    };

    $scope.editBeneficiary = function (index, data) {
      $("#edit_beneficiary").validationEngine("attach");
      data.index = index;
      $scope.adata = data;
      $("#edit-beneficiary-modal").modal("show");
    };

    $scope.removeBeneficiary = function (index) {
      // $scope.data.Beneficiary.splice(index, 1);
      $scope.data.Beneficiary[index].visible = 0;
    };

    // Update/save logic
    $scope.update = function () {
      var valid = $("#form").validationEngine("validate");
      if (valid) {
        var formData = new FormData();
        // Prepare a data copy for backend (exclude File objects)
        var dataCopy = angular.copy($scope.data);

        // Remove File objects from CrudFile for backend, only send info for existing files
        dataCopy.CrudFile = dataCopy.CrudFile.filter(function (file) {
          return file.filePath || file.visible === 0;
        });

        // Remove CrudStatus to prevent accidental creation/duplication
        delete dataCopy.CrudStatus;

        formData.append("data", JSON.stringify(dataCopy));
        // Append new files (File objects) to FormData
        $scope.data.CrudFile.forEach(function (file) {
          if (!file.filePath && file instanceof File) {
            formData.append("files[]", file);
          }
        });

        $http
          .post("/Training/cruds/edit/" + $scope.id, formData, {
            transformRequest: angular.identity,
            headers: { "Content-Type": undefined },
          })
          .then(function (response) {
            var e = response.data.response || response.data;
            if (e.ok) {
              $.gritter.add({
                title: "Successful!",
                text: e.msg,
              });
              window.location = "#/cruds";
            } else {
              $.gritter.add({
                title: "Warning!",
                text: e.msg,
              });
            }
          });
      }
    };
  }
);

app.factory("AgeService", function () {
  return {
    ageCompute: function (birthdate) {
      if (birthdate) {
        var birthDate = new Date(birthdate);
        var today = new Date();
        var age = today.getFullYear() - birthDate.getFullYear();
        var month = today.getMonth() - birthDate.getMonth();

        // Adjust age if birthday hasn't occurred yet this year
        if (
          month < 0 ||
          (month === 0 && today.getDate() < birthDate.getDate())
        ) {
          age = null;
        }

        return age;
      }
      return null;
    },
  };
});
