app.factory("Crud", function ($resource) {
  return $resource(
    api + "cruds/:id",
    { id: "@id", search: "@search" },
    {
      query: { method: "GET", isArray: false },
      update: { method: "PUT" },
      search: { method: "GET" },
    }
  );
});

app.factory("Beneficiary", function ($resource) {
  return $resource(
    api + "beneficiaries/:id",
    { id: "@id" },
    {
      query: { method: "GET", isArray: false },
      update: { method: "PUT" },
    }
  );
});

app.factory("CrudFile", function ($resource) {
  return $resource(
    api + "crud_files/:id",
    { id: "@id" },
    {
      query: { method: "GET", isArray: false },
      update: { method: "PUT" },
    }
  );
});
