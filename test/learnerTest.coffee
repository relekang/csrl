localStorage = require('../src/mockLocalStorage').localStorage ? localStorage
chai = require 'chai'
fs = require 'fs'
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
    date = learner.getLastSaved()
    setTimeout ->
      learner.updateTermWeight('programming', 1)
      learner.getLastSaved().should.be.gt(date)
    , 1

  describe 'reportClick', ->
    it 'should update term weigths', ->
      learner = new Learner
      data = JSON.parse(new String(fs.readFileSync('test/fixtures/documents.json')).toString())
      learner.reportClick(data[1])
      learner.getTermWeight('array').should.equal(data[1].termScores['array'] / Math.max.apply @, (value for key, value of data[1].termScores))

  it 'should rerank based on data', ->
    learner = new Learner
    data = JSON.parse(new String(fs.readFileSync('test/fixtures/documents.json')).toString())
    item = data[1]
    first_rank = (i.id for i in learner.rank(data))
    learner.reportClick(item)
    second_rank = (i.id for i in learner.rank(data)) 
    first_rank.should.not.equal(second_rank)
