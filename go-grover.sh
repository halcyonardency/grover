#!/bin/sh

cd /opt/grover
puppet apply -v --modulepath modules manifests/site.pp
