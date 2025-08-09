app.factory("CrudStatus", function ($resource) {
  return $resource(
    api + "statuses/:id",
    { id: "@id", search: "@search" },
    {
      query: { method: "GET", isArray: false },
      update: { method: "PUT" },
      search: { method: "GET" },
    }
  );
});
