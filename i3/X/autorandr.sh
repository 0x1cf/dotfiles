#!/usr/bin/env bash

set -e

tmpdir=$(mktemp -d /tmp/autorandr.XXXXXX)

pushd $tmpdir
git clone https://github.com/phillipberndt/autorandr.git
cd autorandr
sudo make install
popd
