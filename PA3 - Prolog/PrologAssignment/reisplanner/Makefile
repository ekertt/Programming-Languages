SWP=swipl -l
RUNNER=-s run.pl
# ORDER MATTERS!
# Name your files accordingly(See PDF).
SOURCES= solution1.pl solution2.pl solution3.pl solution4.pl queries.pl

test: one two three four five

.PHONY: one two three four five
one:
	$(SWP) $(word 1, $(SOURCES)) $(RUNNER)

two:
	$(SWP) $(word 2, $(SOURCES)) $(RUNNER)

three:
	$(SWP) $(word 3, $(SOURCES)) $(RUNNER)

four:
	$(SWP) $(word 4, $(SOURCES)) $(RUNNER)


.PHONY: dist
dist:
	zip -r PrologTeam.zip report.pdf $(SOURCES)
