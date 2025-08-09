<?php
class EmailConfig
{
    public $default = array(
        'transport' => 'Smtp',
        'from' => array('no-reply@example.com' => 'Crud'),
        'host' => 'smtp.gmail.com',
        'port' => 587,
        // 'username' => 'youremail@domain.com', // Uncomment and set your email
        // 'password' => 'aaaa bbbb cccc dddd', // Uncomment and set your passkey
        'tls' => true,
        'timeout' => 30,
        'log' => true,
        //'charset' => 'utf-8',
        //'headerCharset' => 'utf-8',
    );
}
