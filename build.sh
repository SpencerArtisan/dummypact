#!/bin/bash
set -e
log()  { printf "$*\n" ; return $? ;  }
fail() { log "\nERROR: $*\n" ; exit 1 ; }

if [ $# -ne 1 ]
then
  log "Must specify a rake task name.  Available tasks are:"
  rake -T
  exit 2
fi

rvm use 1.9.3@cardthings --create
bundle install --without deployment
test_to_run=$1

case $test_to_run in
  integration-xvfb)
    log "running integration tests with xvfb"
    xvfb-run --auto-servernum bundle exec rake integration
    ;;
  smoke-xvfb)
    log "running smoke tests with xvfb"
    xvfb-run --auto-servernum bundle exec rake smoke
    ;;
  all)
    log "running all tests"
    bundle exec rake unit && bundle exec rake integration && bundle exec rake smoke
    ;;
  *)
    log "running with bundle exec rake"
    bundle exec rake $test_to_run
    ;;
esac
