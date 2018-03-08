<?php

if_get('/', function ()
{
    $demo = distributed_client('demo@create');

    return render('index/index', [
        'text' => $demo->id,
    ]);
});
