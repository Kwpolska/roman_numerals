all:
	cd Python && $(MAKE) test
	cd C && $(MAKE) test
	cd Java && $(MAKE) test
	cd JavaScript && $(MAKE) test
	cd Ruby && $(MAKE) test
	cd Swift && $(MAKE) test
