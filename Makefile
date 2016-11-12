all:
	cd Python && $(MAKE) test
	cd C && $(MAKE) test
	cd Java && $(MAKE) test
	cd JavaScript && $(MAKE) test
