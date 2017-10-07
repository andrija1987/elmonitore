<?php

require 'src/bootstrap.php';

psm_no_cache();

$router = new psm\Router();
$router->run();