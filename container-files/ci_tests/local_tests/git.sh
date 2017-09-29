#!/bin/with-contenv sh

#Simply test to see that the git package is installed. 

git --version 2>&1 >/dev/null # improvement by tripleee
GIT_IS_AVAILABLE=$?

if [[ $GIT_IS_AVAILABLE == 0 ]]; then
    echo "A return value of 0 from 'git --version' indicates git is installed and working - TEST PASSED"
else
    echo "git --version returned an unexpected value of ${GIT_IS_AVAILABLE} - TEST FAILED"
fi