localStorage = require('../src/mockLocalStorage').localStorage ? localStorage
chai = require 'chai'
chai.should()


Learner = require('../src/learner').Learner

describe 'learner', ->

  beforeEach ->
    Learner.reset()

  it 'should save to localStorage', ->
    learner = new Learner
    learner.updateTermWeight('programming', 1)
    learner.getTermWeight('programming').should.equal(1)
    learner.updateTermWeight('programming', 1)
    learner.getTermWeight('programming').should.equal(2)

  it 'should read changes done by other instances', ->
    learner1 = new Learner
    learner2 = new Learner
    learner1.updateTermWeight('programming', 1)
    learner1.getTermWeight('programming').should.equal(1)
    learner2.getTermWeight('programming').should.equal(1)
    learner2.updateTermWeight('programming', 1)
    learner1.getTermWeight('programming').should.equal(2)
    learner2.getTermWeight('programming').should.equal(2)

  it 'should save last saved date', ->
    learner = new Learner
    learner.updateTermWeight('programming', 1)
    date = Learner.getLastSaved()
    setTimeout ->
      learner.updateTermWeight('programming', 1)
      Learner.getLastSaved().should.be.gt(date)
    , 1