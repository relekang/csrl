localStorage = require('../src/mockLocalStorage').localStorage ? localStorage
chai = require 'chai'
sinon = require 'sinon'
chai.should()


Learner = require('../src/learner').Learner

describe 'learner', ->

  it 'should load from localStorage', ->
    learner = new Learner
    learner.should.have.property 'stats' 
    learner.stats.should.have.property 'terms' 

  it 'should save to localStorage', ->
    learner = new Learner
    learner.updateTermWeight('programming', 1)
    learner.getTermWeight('programming').should.equal(1)
    learner.updateTermWeight('programming', 1)
    learner.getTermWeight('programming').should.equal(2)
