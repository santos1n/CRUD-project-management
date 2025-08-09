<?php

Router::connect('/', array(
  'controller' => 'main',
  'action'     => 'index',
));

Router::connect('/login', array(
  'controller' => 'main',
  'action' => 'login',
));

Router::connect('/logout', array(
  'controller' => 'main',
  'action'     => 'logout'
));

// Router::connect(
//   '/api/cruds/sendEmail',
//   array('prefix' => 'api', 'api' => true, 'controller' => 'cruds', 'action' => 'sendEmail', '[method]' => 'POST')
// );

// api resources
$resources = array(
  'users',
  'select',
  'cruds',
  'assigns',
  'names',
  'suppliers',
  'shipments',
  'equips',
  'trucks',
  'statuses',
  'files'
);

Router::mapResources($resources, array('prefix' => 'api'));
Router::parseExtensions('json');

CakePlugin::routes();
require CAKE . 'Config' . DS . 'routes.php';
