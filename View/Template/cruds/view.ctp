<div class="panel panel-primary">
  <div class="panel-heading"><i class="fa fa-dot-circle-o"></i> VIEW</div>
  <div class="panel-body">
    <div class="row">
      <div class="col-md-12">
        <dl class="dl-horizontal dl-data dl-bordered">
          <dt>Name:</dt>
          <dd class="uppercase">{{ data.Crud.name }}</dd>

          <dt>Age:</dt>
          <dd>{{ data.Crud.age }}</dd>

          <dt>Birthday:</dt>
          <dd ng-bind="formatDate(data.Crud.birthdate) |  date:'MM/dd/yyyy'">{{ data.Crud.birthdate }}</dd>

          <dt>Type:</dt>
          <dd>{{ data.CrudStatus.name }}</dd>

          <dt>Character:</dt>
          <dd>{{ data.Crud.character ? data.Crud.character : 'No character available' }}</dd>

          <dt>Email:</dt>
          <dd>{{ data.Crud.email }}</dd>

          <dt>Status:</dt>
          <dd>{{ data.Crud.status }}</dd>

        </dl>
      </div>
    </div>

    <div class="col-md-12">
      <table class="table table-bordered table-striped table-hover">
        <thead>
          <tr class="bg-info">
            <th colspan="3">UPLOADED FILES</th>
          </tr>
          <tr>
            <th class="w30px text-center">#</th>
            <th class="col-md-10 text-center">FILE NAME</th>
            <th class="col-md-2 text-center">DOWNLOAD</th>
          </tr>
        </thead>
        <tbody>
          <tr ng-repeat="data in data.CrudFile">
            <td class="text-center">{{ $index + 1 }}</td>
            <td class="text-center">{{ data.fileName }}</td>
            <td class="text-center">
              <a ng-href="/Training/{{ data.filePath }}" target="_blank" download="{{ data.fileName }}" class="btn btn-xs btn-success">
                <i class="fa fa-download"></i> Download
              </a>
            </td>
          </tr>
          <tr ng-if="!data.CrudFile">
            <td colspan="3" class="text-center">No files uploaded</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="clearfix"></div>
    <hr>

    <div class="col-md-12">
      <table class="table table-bordered table-striped table-hover">
        <thead>
          <tr class="bg-info">
            <th colspan="5">BENEFICIARIES</th>
          </tr>
          <tr>
            <th class="w30px text-center">#</th>
            <th class="col-md-6 text-center">NAME</th>
            <th class="w100px text-center">AGE</th>
            <th class="text-center">BIRTHDATE</th>

          </tr>
        </thead>
        <tbody>
          <!-- track by $index -->
          <tr ng-repeat="datax in data.Beneficiary">
            <td class="text-center"> {{ $index + 1 }} </td>
            <td class="text-center"> {{ datax.name }} </td>
            <td class="text-center"> {{ datax.age }} </td>
            <td class="text-center"> {{ datax.birthdate }} </td>

          </tr>
        </tbody>
        <tbody ng-if="data.Beneficiary == ''">
          <td colspan="5" class="text-center">No data available</td>
        </tbody>
      </table>

      <div class="col-md-12">
        <div class="btn-group btn-group-sm pull-left btn-min">
          <!-- APPROVE Button -->
          <button type="button"
            class="btn btn-primary btn-min"
            ng-disabled="data.Crud.status === 'APPROVED'"
            ng-click="setStatus(data, 'APPROVED')">
            APPROVE
          </button>

          <!-- DISAPPROVE Button -->
          <button type="button"
            class="btn btn-secondary btn-min"
            ng-disabled="data.Crud.status === 'DISAPPROVED'"
            ng-click="setStatus(data, 'DISAPPROVED')">
            DISAPPROVE
          </button>

          <!-- PENDING Button -->
          <button type="button"
            class="btn btn-warning btn-min"
            ng-disabled="data.Crud.status === 'PENDING'"
            ng-click="setStatus(data, 'PENDING')">
            PENDING
          </button>
        </div>
      </div>
    </div>

    <div class="clearfix"></div>
    <hr>

    <div class="row">
      <div class="col-md-6">
        <div class="btn-group btn-group-sm btn-min">
          <button class="btn btn-primary btn-sm btn-block" ng-click="printPdf()" ng-disabled="data.Crud.status==='PENDING' || data.Crud.status==='DISAPPROVED'"><i class=" fa fa-print"></i> PRINT</button>
        </div>
      </div>

      <div class="col-md-6">
        <div class="btn-group btn-group-sm pull-right btn-min">
          <a href="#/crud/edit/{{ data.Crud.id }}" class="btn btn-primary btn-min" ng-disabled="data.Crud.status === 'APPROVED' || data.Crud.status === 'DISAPPROVED'"><i class="fa fa-edit"></i> EDIT</a>
          <button class="btn btn-danger btn-min" ng-click="remove(data.Crud)" ng-disabled="data.Crud.status === 'APPROVED' || data.Crud.status === 'DISAPPROVED'"><i class="fa fa-trash"></i> DELETE</button>
        </div>
      </div>
    </div>

  </div>


  <style>
    .table-wrapper {
      width: 100%;
      height: 500px;
      overflow-y: auto;
    }
  </style>