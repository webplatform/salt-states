#!/bin/bash

set -e

if [ ! -d "${SYNC_DIR}" ]; then
    echo "Directory ${SYNC_DIR} doesnt exist"
    exit 1
fi
echo "Directory will be ${SYNC_DIR}"


if [ -z "${SYNC_BUCKET}" ]; then
    echo "Required environment variable SYNC_BUCKET missing"
    exit 1
fi
echo "Bucket will be ${SYNC_BUCKET}"


if [ -z "${ST_AUTH}" ]; then
    echo "Required environment variable ST_AUTH missing"
    exit 1
fi
echo "Endpoint will be ${ST_AUTH}"


if [ -z "${ST_KEY}" ]; then
    echo "Required environment variable ST_KEY missing"
    exit 1
fi
echo "Key will be ${ST_KEY}"


if [ -z "${ST_USER}" ]; then
    echo "Required environment variable ST_USER missing"
    exit 1
fi
echo "User will be ${ST_USER}"


BIN=`which swift`

if [ -z "${BIN}" ]; then
    echo "Python Swift client (python-swiftclient) not found"
    exit 1
fi

cd ${SYNC_DIR}
find ${SYNC_DIR} -type f -mtime -1 | sed 's/^\.\///' | sort -u > dreamobjects_upload.${SYNC_BUCKET}.list
while read FILE; do swift upload ${SYNC_BUCKET} $FILE --changed; done < dreamobjects_upload.${SYNC_BUCKET}.list

