#!/bin/with-contenv sh

# File tests that Wordpress is responding correctly (with error) to requests against both the 
# localhost as well as wp-specific php files (READ: not test.php). This container supports
# connecting to an existing database and, becasue of that, WP is expecting to connect to one.
# Therefore, any request against a WP file will result in a 500 error because there is no database.
# Because if we have gotten to this test we know that the server is running as expected, receipt
# of a 500 error from the server can be considered successful processing by the WP structure.

WORDPRESS_DESTINATION=${WORDPRESS_DESTINATION:=localhost}

HTTP_RESPONSE=$( curl -s -o /dev/null -w "%{http_code}" $WORDPRESS_DESTINATION )

if [[ $HTTP_RESPONSE != 500 ]]; then
    # If a file returned non-zero, print out that file so we have some testing recourse.
    echo "Apache Web Server returned a non-200 response code of ${HTTP_RESPONSE} - TEST FAILED."
    exit 1; 
else 
    echo "CURL request to localhost returned an expected error response of ${HTTP_RESPONSE} - TEST PASSED."
fi