<?php
class Crud extends AppModel
{

    public $actsAs = array('Containable');
    public $belongsTo = array(
        'CrudStatus' => array(
            'foreignKey' => 'crudStatusId'
        )
    );
    public $hasMany = ['Beneficiary', 'CrudFile'];
}
