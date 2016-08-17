#!/usr/bin/env bash

[ -f /.ssh/*.pub ] && echo "Exists" && exit 1

echo "whoops"