BINARY=SudokuSolver
TEST=python3 -m pytest -q --exe="$(shell pwd)/${BINARY}"



${BINARY}: ${BINARY}.hs
	ghc $< -o $@

test: test_competent test_gevorderd test_expert test_master

test_competent: test_competent.py ${BINARY}
	${TEST} $<

test_gevorderd: test_gevorderd.py ${BINARY}
	${TEST} $<

test_expert: test_expert.py ${BINARY}
	${TEST} $<

test_master: test_master.py ${BINARY}
	${TEST} $<


.PHONY: clean
clean:
	rm *.hi *.o ${BINARY}
	rm -rf __pycache__
