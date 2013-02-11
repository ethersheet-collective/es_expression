var e = require('../es_expression').parser;
var should = require('chai').should();

describe('Expression Parser', function(){
  describe('basic math', function(){
    it('should add numbers', function(){
      e.parse('3 + 4').should.equal(7);
      e.parse('-3 + 2').should.equal(-1);
      e.parse('3.4 + 1.2').should.equal(4.6);
    });
    it('should not care bout whitespace', function(){
      e.parse('  3    +  2  ').should.equal(e.parse('3+2'));
    });

    it('should subtract numbers', function(){
      e.parse('4 - 3').should.equal(1);
      e.parse('3 - 4').should.equal(-1);
      e.parse('3--3').should.equal(6);
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

    it('should respect order of operations', function(){
      e.parse('2 - 2 + 3').should.equal(3);
      e.parse('(3 - 1) ^ 2 - 1 * 3 + 2').should.equal(3);
    });

    it('should parse mathematical constants', function(){
      e.parse('E').should.equal(Math.E);
      e.parse('PI').should.equal(Math.PI);
    });

  });
  describe('boolean logic', function(){
    it('should work with basic boolean logic', function(){
      e.parse('3 NOT 4').should.equal(true);
      e.parse('4 NOT 4').should.equal(false);
      e.parse(' 4 < 3').should.equal(false);
      e.parse(' 4 > 3').should.equal(true);
      e.parse('3 >= 4').should.equal(false);
      e.parse('3 <= 4').should.equal(true);
      e.parse('4 <= 4').should.equal(true);
      e.parse('4 = 4').should.equal(true);
      e.parse('3 = 4').should.equal(false);
    });
  });
  describe('other methods', function(){
    it('should parse strings', function(){
      e.parse('"foo"').should.equal('foo');
    });
    it('should parse percentages', function(){
      e.parse('15% + 5%').should.equal(0.2);
    });
  });
});
