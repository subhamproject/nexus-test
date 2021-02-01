#!/bin/bash

echo "${AUTH_KEY}" > /tmp/auth.txt
echo "${KNOWN_HOST}" > /tmp/known_host.txt

tail -f /dev/null
