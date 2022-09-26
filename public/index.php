<?php

header('Access-Control-Allow-Origin: *');

// init
include __DIR__.'/../bootstrap.php';
include FRAME_DIR.'/http/php_fpm/application.php';

view_path(ROOT_DIR.'/view/');

set_error_handler('http_err_action', E_ALL);
set_exception_handler('http_ex_action');
register_shutdown_function('http_fatal_err_action');

if_has_exception(function ($ex) {
    echo "<pre>";
    var_dump($ex);

    return json([
        'succ' => false,
        'msg' => $ex->getMessage(),
    ]);
});

if_verify(function ($action, $args) {

    $data = $action(...$args);

    header('Content-type: text/html');

    return $data;
});

// init interceptor

// init 404 handler
if_not_found(function () {

    return 404;
});

// init controller
include CONTROLLER_DIR.'/index.php';

// fix
not_found();
