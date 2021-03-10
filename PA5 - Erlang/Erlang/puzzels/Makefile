.PHONY: tests
check: build
	erl -noinput -s tests run_tests

.PHONY: build
build:
	erl -make

.PHONY: clean
clean:
	rm -rf *.beam
