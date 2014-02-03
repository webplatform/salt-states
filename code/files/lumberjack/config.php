<?php
# Managed by Salt Stack

class config
{
	# @TODO: Use Salt pillars to populate
        static $dbms_host =             "master.db.wpdn";
        static $dbms_port =             "3306";
        static $dbms_database =         "lumberjack";
        static $dbms_user =             "lumberjack_user";
        static $dbms_pass =             "Ek7jei4ooli6aiw";

        static $default_channel =       "webplatform";
        static $default_number_of_lines = 50;

        static $timezone =              "UTC";

        static function get_db()
        {
                return new lumberjack_db( config::$dbms_host, config::$dbms_port, config::$dbms_database, config::$dbms_user, config::$dbms_pass, config::$timezone );
        }
}
