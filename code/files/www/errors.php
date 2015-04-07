<?php

header('Cache-Control: max-age=90, public, must-revalidate, proxy-revalidate');

$s = (is_numeric($_GET['s']))?$_GET['s']:403;
$path = '/var/www/errors/'.$s.'.html';

http_response_code((int) $s);

if(file_exists($path)) {
  die(require($path));
}
