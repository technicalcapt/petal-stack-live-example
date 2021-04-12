#!/usr/bin/env sh

$1 eval "PetaStackExample.Release.create_repos" && \
$1 eval "PetaStackExample.Release.migrate" && \
exec $1 start
