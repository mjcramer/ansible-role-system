#!/bin/bash

grep -q 'changed=0.*failed=0' && (echo 'Idempotence: PASS' && exit 0) || (echo 'Idempotence: FAIL' && exit 1)
