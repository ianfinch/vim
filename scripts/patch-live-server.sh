#!/bin/bash

liveServer=$( readlink -f $( which live-server ) )
indexJs="$( dirname "${liveServer}" )/index.js"

sed --in-place=.bak -e 's/serveIndex(root, { icons: true })/serveIndex(root, { icons: true, hidden: true })/' "${indexJs}"
