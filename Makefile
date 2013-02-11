test: compile
	./node_modules/.bin/mocha -R spec -r chai test/*.js
compile:
	./node_modules/.bin/jison es_expression.jison
.PHONY: compile test
