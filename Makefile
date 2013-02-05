compile:
	./node_modules/.bin/jison expression.jison
test: compile
	./node_modules/.bin/mocha -R spec -r chai test/*.js
.PHONY: compile test
