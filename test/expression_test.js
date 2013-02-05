var e = require('../expression.js').parser;
var should = require('chai').should();

describe('Expression Parser', function(){
  describe('basic math', function(){
    it('should add numbers', function(){
      e.parse('3+4').should.equal(7);
      e.parse('-3 + 2').should.equal(-1);
      e.parse('3.4 + 1.2').should.equal(4.6);
    });

    it('should subtract numbers', function(){
      e.parse('4 - 3').should.equal(1);
      e.parse('3 - 4').should.equal(-1);
      e.parse('3.5 - 0.4').should.equal(3.1);
    });

    it('should multiply', function(){
      e.parse('4 * 3').should.equal(12);
      e.parse('-3 * 4').should.equal(-12);
    });

    it('should divide', function(){
      e.parse('10 / 5').should.equal(2);
      e.parse('3.3 / 2').should.equal(1.65);
    });

    it('should do exponents', function(){
      e.parse('2 ^ 2').should.equal(4);
    });


  });
});
