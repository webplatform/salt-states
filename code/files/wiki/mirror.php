<?php

header('Content-Type: application/json');

echo json_encode($_SERVER, JSON_PRETTY_PRINT);

