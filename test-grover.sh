#!/bin/sh

cd /opt/grover
puppet apply --show_diff --noop -v --modulepath modules manifests/site.pp
