<div class="panel panel-primary">
  <div class="panel-heading"><i class="fa fa-dot-circle-o"></i> STATUS </div>
  <div class="panel-body">
    <div class="row">
        <div class="col-md-12">
            <dl class="dl-horizontal dl-data dl-bordered">
                <dt>Status ID:</dt>
                <dd class="uppercase">{{ data.CrudStatus.id }}</dd>

                <dt>Status:</dt>
                <dd class="uppercase">{{ data.CrudStatus.name }}</dd>
            </dl>
        </div> 
    </div>
    <div class="row">
      <div class="col-md-12">
          <div class="btn-group btn-group-sm pull-right btn-min">

          <a href="#/status/edit/{{ data.CrudStatus.id }}" class="btn btn-primary btn-min"><i class="fa fa-edit"></i> EDIT</a> 
          <button class="btn btn-danger btn-min" ng-click="remove(adata.CrudStatus)"><i class="fa fa-trash"></i> DELETE</button>

          </div> 
      </div>
    </div>

</div>


