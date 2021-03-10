TEST_SETUP=erl -noinput -s $@ tests_run 

build:
	erl -make
	@echo ""

tests_1a: build
	${TEST_SETUP}
	@echo ""

tests_1b: build
	${TEST_SETUP}
	@echo ""

tests_2a: build
	${TEST_SETUP}
	@echo ""

tests_2b: build
	${TEST_SETUP}
	@echo ""

tests_3: build
	${TEST_SETUP}
	@echo ""

tests_4: build
	${TEST_SETUP}
	@echo ""

tests_5: build
	${TEST_SETUP}


tests: tests_1a tests_1b tests_2a tests_2b tests_3 tests_4 tests_5

clean:
	rm *.beam
