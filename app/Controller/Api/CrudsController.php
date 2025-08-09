<?php

app::uses('CakeEmail', 'Network/Email');

class CrudsController extends AppController
{
  public function beforeFilter()
  {
    parent::beforeFilter();
    $this->RequestHandler->ext = 'json';
  }

  public $uses = array(
    'Crud',
    'Beneficiary'
  );

  public function index()
  {
    //defaut page 1
    $page = isset($this->request->query['page']) ? $this->request->query['page'] : 1;

    $conditions = array();
    $conditions['Crud.visible'] = 1;

    // Apply search condition
    if (isset($this->request->query['search'])) {
      $search = strtolower($this->request->query['search']);
      $conditions['OR'] = [
        'LOWER(Crud.name) LIKE' => '%' . $search . '%',
        'LOWER(Crud.status) LIKE' => '%' . $search . '%',
      ];
    }

    //paginate data
    $paginatorSettings = array(
      'conditions' => $conditions,
      'limit' => 25,
      'page'  => $page,
      'order' => array(
        'Crud.name' => 'ASC'
      )
    );
    $modelName = 'Crud';
    $this->Paginator->settings = $paginatorSettings;
    $tmpData = $this->Paginator->paginate($modelName);
    $paginator = $this->request->params['paging'][$modelName];

    //transform data
    $cruds_ = array();
    foreach ($tmpData as $crud) {
      $cruds_[] = array(
        'id'            => $crud['Crud']['id'],
        'name'          => properCase($crud['Crud']['name']),
        'age'           => $crud['Crud']['age'],
        'birthdate'     => date('m/d/Y', strtotime($crud['Crud']['birthdate'])),
        'character'     => $crud['Crud']['character'],
        'status'        => $crud['Crud']['status'],
        'email'         => $crud['Crud']['email'],
        'visible'       => $crud['Crud']['visible'],
        'date_created'  => date('m/d/Y', strtotime($crud['Crud']['created']))
      );
    }

    $response = array(
      'ok' => true,
      'msg' => 'Index',
      'data' => $cruds_,
      'paginator' => $paginator
    );

    $this->set(array(
      'response' => $response,
      '_serialize' => 'response'
    ));
  }


  public function add()
  {
    // Prepare array for all uploaded files
    $uploadedFiles = [];

    // Handle multiple file uploads
    if (!empty($_FILES['files']) && isset($_FILES['files']['name']) && is_array($_FILES['files']['name'])) {
      $fileCount = count($_FILES['files']['name']);
      $uploadDir = WWW_ROOT . 'uploads' . DS;
      if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
      }
      for ($i = 0; $i < $fileCount; $i++) {
        if ($_FILES['files']['error'][$i] === 0) {
          $filename = uniqid() . '_' . basename($_FILES['files']['name'][$i]);
          $targetPath = $uploadDir . $filename;
          if (move_uploaded_file($_FILES['files']['tmp_name'][$i], $targetPath)) {
            $uploadedFiles[] = [
              'fileName' => $_FILES['files']['name'][$i],
              'filePath' => 'uploads/' . $filename,
            ];
          }
        }
      }
    }

    // Get JSON data
    $data = $this->request->data;

    // Defensive: If $data is a string, try to decode it
    if (is_string($data)) {
      $decoded = json_decode($data, true);
      $data = is_array($decoded) ? $decoded : [];
    }

    // If 'data' key exists and is a string, decode it
    if (is_array($data) && isset($data['data']) && is_string($data['data'])) {
      $decoded = json_decode($data['data'], true);
      $data = is_array($decoded) ? $decoded : [];
    }

    // Attach all uploaded files info
    if (!empty($uploadedFiles)) {
      if (!isset($data['CrudFile']) || !is_array($data['CrudFile'])) {
        $data['CrudFile'] = [];
      }
      foreach ($uploadedFiles as $fileInfo) {
        $data['CrudFile'][] = $fileInfo;
      }
    }

    // Save and respond
    if ($this->Crud->saveAssociated($data)) {
      $response = array(
        'ok' => true,
        'msg' => 'Saved!',
        'data' => $data,
      );
    } else {
      $response = array(
        'ok' => false,
        'msg' => 'Not saved!',
        'data' => $data,
      );
    }
    $this->set(array(
      'response' => $response,
      '_serialize' => 'response'
    ));
  }

  public function view($id = null)
  {
    $data = $this->Crud->find('first', array(
      'contain' => array(
        'CrudStatus' => array('name'),
        'Beneficiary' => array(
          'conditions' => array(
            'Beneficiary.visible' => true,
          )
        ),
        'CrudFile' => array(
          'conditions' => array(
            'CrudFile.visible' => true,
          )
        )
      ),
      'conditions' => array(
        'Crud.id' => $id,
        'Crud.visible' => true,
      )
    ));

    $response = array(
      'ok'    => true,
      'msg'   > 'view!',
      'data'  => $data,
      // 'data_' => $data_,
    );

    $this->set(array(
      'response' => $response,
      '_serialize' => 'response'
    ));
  }

  public function edit($id = null)
  {
    // Prepare array for all uploaded files
    $uploadedFiles = [];

    // Handle multiple file uploads
    if (!empty($_FILES['files']) && isset($_FILES['files']['name']) && is_array($_FILES['files']['name'])) {
      $fileCount = count($_FILES['files']['name']);
      $uploadDir = WWW_ROOT . 'uploads' . DS;
      if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
      }
      for ($i = 0; $i < $fileCount; $i++) {
        if ($_FILES['files']['error'][$i] === 0) {
          $filename = uniqid() . '_' . basename($_FILES['files']['name'][$i]);
          $targetPath = $uploadDir . $filename;
          if (move_uploaded_file($_FILES['files']['tmp_name'][$i], $targetPath)) {
            $uploadedFiles[] = [
              'fileName' => $_FILES['files']['name'][$i],
              'filePath' => 'uploads/' . $filename,
            ];
          }
        }
      }
    }

    // Get JSON data
    $data = $this->request->data;

    // Defensive: If $data is a string, try to decode it
    if (is_string($data)) {
      $decoded = json_decode($data, true);
      $data = is_array($decoded) ? $decoded : [];
    }

    // If 'data' key exists and is a string, decode it
    if (is_array($data) && isset($data['data']) && is_string($data['data'])) {
      $decoded = json_decode($data['data'], true);
      $data = is_array($decoded) ? $decoded : [];
    }

    // Attach all uploaded files info
    if (!empty($uploadedFiles)) {
      if (!isset($data['CrudFile']) || !is_array($data['CrudFile'])) {
        $data['CrudFile'] = [];
      }
      foreach ($uploadedFiles as $fileInfo) {
        $data['CrudFile'][] = $fileInfo;
      }
    }

    if ($this->Crud->saveAssociated($data)) {
      $crud_id = $this->Crud->id;
      $response = array(
        'ok' => true,
        'msg' => 'Updated!',
        'data' => $data,
      );
    } else {
      $response = array(
        'ok' => false,
        'msg' => 'Not updated!',
        'data' => $data,
      );
    }
    $this->set(array(
      'response' => $response,
      '_serialize' => 'response'
    ));
  }

  public function delete($id = null)
  {
    if ($this->Crud->hide($id)) {
      $response = array(
        'ok' => true,
        'msg' => 'Deleted!',
        'data' => $id,
      );
    } else {
      $response = array(
        'ok' => false,
        'msg' => 'Not deleted!',
        'data' => $id,
      );
    }
    $this->set(array(
      'response' => $response,
      '_serialize' => 'response'
    ));
  }

  public function sendEmail()
  {
    if ($this->request->is('post')) {
      $email = isset($this->request->data['Crud']['email']) ? $this->request->data['Crud']['email'] : null;
      $action = isset($this->request->data['action']) ? $this->request->data['action'] : 'save';

      if ($email && filter_var($email, FILTER_VALIDATE_EMAIL)) {
        // Choose message based on action/status
        switch (strtoupper($action)) {
          case 'APPROVED':
            $message = 'Your request has been APPROVED.';
            $subject = 'CRUD Status: Approved';
            break;
          case 'DISAPPROVED':
            $message = 'Your request has been DISAPPROVED.';
            $subject = 'CRUD Status: Disapproved';
            break;
          case 'PENDING':
            $message = 'Your request is now PENDING.';
            $subject = 'CRUD Status: Pending';
            break;
          case 'save':
          default:
            $message = 'Your data has been saved successfully. Your request is now PENDING.';
            $subject = 'CRUD Add Notification';
            break;
        }

        $Email = new CakeEmail('default');
        $Email->from(array('no-reply@example.com' => 'Crud'))
          ->to($email)
          ->subject($subject)
          ->send($message);

        $this->set(array(
          'ok' => true,
          'msg' => 'Email sent.',
          '_serialize' => array('ok', 'msg')
        ));
      } else {
        $this->set(array(
          'ok' => false,
          'msg' => 'Invalid email.',
          '_serialize' => array('ok', 'msg')
        ));
      }
    }
  }
}
