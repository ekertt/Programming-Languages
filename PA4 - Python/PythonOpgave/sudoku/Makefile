.PHONY: test
test: test_ontwikkeld test_competent test_gevorderd test_master


.PHONY: test_ontwikkeld
test_ontwikkeld: test_ontwikkeld.py
	pytest $<

.PHONY: test_competent
test_competent: test_competent.py
	pytest $<

.PHONY: test_gevorderd
test_gevorderd: test_gevorderd.py
	pytest $<

# Expert wordt handmatig via Codegrade gedaan.

.PHONY: test_master
test_master: test_master.py
	pytest $<
