# Creates a wordpress instance using Apache/PHP/Mariadb

## Dependencies
* project42/apache
* mariadb

## Usage
* Default values are provided for database name, user, password. These can be changed at runtime by running docker-compose and setting the appropriate variable values.
** Variables are:
*** MYSQL_ROOT_PASSWORD_ENV
*** MYSQL_DATABASE_ENV
*** MYSQL_USER_ENV
*** MYSQL_PASSWORD_ENV
*** DATABASE_PREFIX_ENV