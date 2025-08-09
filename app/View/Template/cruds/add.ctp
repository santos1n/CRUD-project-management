<div>
    <div class="panel panel-primary">
        <div class="panel-heading"><i class="fa fa-dot-circle-o"></i> NEW </div>
        <div class="panel-body">
            <div class="col-md-12">
                <form id="form">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label> Name <i class="required">*</i></label>
                                <input type="text" class="form-control" ng-model="data.Crud.name" data-validation-engine="validate[required]">
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label> Age <i class="required">*</i></label>
                                <input type="text" class="form-control" ng-model="data.Crud.age" readonly data-validation-engine="validate[required]">
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label> Birthday <i class="required">*</i></label>
                                <input type="date" class="form-control" ng-change="ageCompute(data.Crud.birthdate, 'crud')" ng-model="data.Crud.birthdate" data-validation-engine="validate[required]">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label> Email Address <i class="required">*</i></label>
                                <input type="email" class="form-control" ng-model="data.Crud.email" data-validation-engine=" validate[required]">
                                </input>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label> Status <i class="required">*</i></label>
                                <select class="form-control" ng-model="data.Crud.crudStatusId" ng-options="opt.id as opt.value for opt in statuses" data-validation-engine="validate[required]">
                                    <option value=""></option>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group">
                                <label> Character </label>
                                <textarea class="form-control" ng-model="data.Crud.character"></textarea>
                            </div>
                        </div>
                        
                        <div class="col-md-12">
                            <table class="table table-bordered table-striped center">
                                <thead>
                                    <tr class="bg-info">
                                        <th colspan="4">UPLOAD FILES</th>
                                    </tr>
                                    <tr>
                                        <th class="w30px text-center">#</th>
                                        <th class="col-md-8 text-center">File Name</th>
                                        <th class="col-md-4 text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr ng-repeat="file in selectedFiles">
                                        <td class="text-center">{{ $index + 1 }}</td>
                                        <td>{{ file.name }}</td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-danger btn-xs" ng-click="selectedFiles.splice($index, 1)">
                                                <i class="fa fa-trash"></i> Remove
                                            </button>
                                        </td>
                                    </tr>
                                    <tr ng-if="!selectedFiles.length">
                                        <td colspan="3" class="text-center">No files selected</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" class="text-center">
                                            <input type="file"
                                                class="form-control"
                                                id="fileInput"
                                                multiple
                                                onchange="angular.element(this).scope().onFileChange(this)">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>


                        <div class="clearfix"></div>
                        <hr>

                        <div class="col-md-3 pull-left">
                            <a class="btn btn-warning btn-sm btn-block" id="save" ng-click="addBeneficiary()">ADD BENEFICIARY</a><br />
                        </div>

                        <div class="clearfix"></div>

                        <div class="col-md-12">
                            <table class="table table-bordered table-striped center">
                                <thead>
                                    <tr>
                                        <th class="w30px text-center">#</th>
                                        <th class="col-md-6 text-center">NAME</th>
                                        <th class="w100px text-center">AGE</th>
                                        <th class="text-center">BIRTHDATE</th>
                                        <th class="w100px"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- track by $index -->
                                    <tr ng-repeat="datax in data.Beneficiary">
                                        <td class="text-center"> {{ $index + 1 }} </td>
                                        <td> {{ datax.name }} </td>
                                        <td> {{ datax.age }} </td>
                                        <td> {{ datax.birthdate }} </td>
                                        <td class="text-center">
                                            <div class="btn-group btn-group-xs">
                                                <a href="javascript:void(0)" ng-click="editBeneficiary($index,datax)" class="btn btn-primary" title="EDIT"><i class="fa fa-edit"></i></a>
                                                <a href="javascript:void(0)" ng-click="removeBeneficiary($index)" class="btn btn-danger" title="DELETE"><i class="fa fa-trash"></i></a>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tbody ng-if="data.Beneficiary == ''">
                                    <td colspan="12" class="text-center">No data available</td>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>

                <div class="clearfix"></div>
                <hr>
                <div class="row">
                    <div class="col-md-4 pull-right">
                        <button class="btn btn-primary btn-sm btn-block" ng-click="save()"><i class="fa fa-save"></i> SAVE </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $('#form').validationEngine('attach');
</script>

<!-- Modal -->
<div class="modal fade" id="add-beneficiary-modal">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h2 class="modal-title">Add Beneficiary</>
            </div>
            <div class="modal-body">
                <div class="col-md-12">
                    <form id="add_beneficiary">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label> Name <i class="required">*</i></label>
                                    <input type="text" class="form-control" ng-model="adata.name" data-validation-engine="validate[required]">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label> Age <i class="required">*</i></label>
                                    <input type="text" class="form-control" ng-model="adata.age" data-validation-engine="validate[required]">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label> Birthday <i class="required">*</i></label>
                                    <input type="date" class="form-control" ng-change="ageCompute(adata.birthdate, 'beneficiary')" ng-model="adata.birthdate" data-validation-engine="validate[required]">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-sm btn-min" data-dismiss="modal">CANCEL</button>
                <button type="button" class="btn btn-primary btn-sm btn-min" ng-click="saveBeneficiary(adata)">SAVE</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="edit-beneficiary-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">EDIT BENEFICIARY </h4>
            </div>
            <div class="modal-body">
                <form id="edit_beneficiary">

                    <div class="col-md-12">
                        <div class="form-group">
                            <label> NAME <i class="required">*</i></label>
                            <input type="text" class="form-control" ng-model="adata.name" data-validation-engine="validate[required]">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label> AGE <i class="required">*</i></label>
                            <input type="text" class="form-control" ng-model="adata.age" data-validation-engine="validate[required]"></input>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>BIRTHDATE<i class="required">*</i></label>
                            <input type="date" class="form-control" ng-change="ageCompute(adata.birthdate, 'beneficiary')" ng-model="adata.birthdate" data-validation-engine="validate[required]">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-sm btn-min" data-dismiss="modal">CANCEL</button>
                <button type="button" class="btn btn-primary btn-sm btn-min" ng-click="updateBeneficiary(adata)">SAVE</button>
            </div>
        </div>
    </div>
</div>