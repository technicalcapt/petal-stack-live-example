#!/usr/bin/env sh

$1 eval "Composer.Release.create_repos" && \
$1 eval "Composer.Release.migrate" && \
exec $1 start
