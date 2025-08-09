<?php
class StatusesController extends AppController {
  public function beforeFilter() {
    parent::beforeFilter();
    $this->RequestHandler->ext = 'json';
  }

  public $uses = array(
    'CrudStatus'
  );
  
  public function index() {
 
    //with pagination
    //defaut page 1
    $page = isset($this->request->query['page'])? $this->request->query['page'] : 1;


    $conditions = array();
    $conditions['CrudStatus.visible'] = 1;

    //paginate data
    $paginatorSettings = array(
      'conditions' => $conditions,
      'limit' => 25,
      'page'  => $page,
      'order' => array(
        'CrudStatus.name' => 'ASC')
    );
    $modelName = 'CrudStatus';
    $this->Paginator->settings = $paginatorSettings;
    $tmpData = $this->Paginator->paginate($modelName);
    $paginator = $this->request->params['paging'][$modelName];

    //transform data
    $statuses_= array();
    foreach ($tmpData as $status) {
      $statuses_[]=array(
        'id'            => $status['CrudStatus']['id'],
        'name'          => properCase($status['CrudStatus']['name']),
        'visible'       => $status['CrudStatus']['visible'],
        'date_created'  => date('m/d/Y', strtotime($status['CrudStatus']['created']))
      );
    }

    $response = array(
    'ok'=> true,
    'msg'=>'Index',
    'data'=>$statuses_, //transformed data
    'paginator'=> $paginator
    ); 
    
    $this->set(array(
        'response'=>$response,
        '_serialize'=>'response'
    ));
  }
  
  public function add() {
    $data=$this->request->data;
    if ($this->CrudStatus->save($data)) {
        $response = array(
        'ok'=> true,
        'msg'=>'Saved!',
        'data'=>$this->request->data,
        );
    } else {
        $response = array(
        'ok'=> false,
        'msg'=>'Not saved!',
        'data'=>$this->request->data,
    );
    }
        $this->set(array(
          'response'=>$response,
          '_serialize'=>'response'
        ));
  }

  public function view($id = null){
    
    $data = $this->CrudStatus->find('first', array(
        'conditions'=> array(
            'CrudStatus.id'=> $id,
            'CrudStatus.visible'=> true,
        )
    ));

    $response = array(
        'ok'    => true,
        'msg'   =>'view!',
        'data'  => $data,
    );

    $this->set(array(
          'response'=>$response,
          '_serialize'=>'response'
        ));
    
  }

  public function edit($id = null){
    if ($this->CrudStatus->save($this->request->data)) {
        $response = array(
        'ok'=> true,
        'msg'=>'Updated!',
        'data'=>$this->request->data,
        );    
    } else {
        $response = array(
        'ok'=> false,
        'msg'=>'Not updated!',
        'data'=>$this->request->data,
    );
    }
    $this->set(array(
          'response'=>$response,
          '_serialize'=>'response'
        ));
 }

 public function delete($id = null){
    if ($this->CrudStatus->hide($id)) {
        $response = array(
        'ok'=> true,
        'msg'=>'Deleted!',
        'data'=>$id,
        );
    } else {
        $response = array(
        'ok'=> false,
        'msg'=>'Not deleted!',
        'data'=>$id,
    );
    }
    $this->set(array(
      'response'=>$response,
      '_serialize'=>'response'
    ));
  }
}