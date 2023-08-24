
all:
	@echo "Valid make targets are:"
	@echo "   test"

test: test-control

test-control:
	#DEBUG=1 rc_local_file=/tmp/rc.local LOG_FILE=/dev/null scripts/controller.sh tests
	DEBUG=1 rc_local_file=/tmp/rc.local LOG_FILE=/dev/null scripts/controller.sh

test-run:
	DEBUG=1 rc_local_file=/tmp/testing_rc.local scripts/run
