localStorage = require('./mockLocalStorage').localStorage ? localStorage

class Learner

  @storage_key: 'learnerstats'

  @reset: ->
    localStorage.removeItem this.storage_key
  
  @getLastSaved: ->
    try
      return new Date(JSON.parse(localStorage.getItem Learner.storage_key).lastSaved)
    catch error
      console.log error
      return new Date(1900, 1, 1) 

  stats: ->
    data = JSON.parse(localStorage.getItem Learner.storage_key)
    if data == undefined or data == null
      data = {
        terms: {}
      }
      localStorage.setItem Learner.storage_key, JSON.stringify(data)
    return data
    

  getTermWeight: (term) ->
    try
      return @stats().terms[term].weight
    catch error
      return 0

  updateTermWeight: (term, weight) ->
    stats = @stats()
    if term of stats.terms
      stats.terms[term].weight += weight
    else
      stats.terms[term] = {
        'weight': weight
      }
    stats.lastSaved = new Date
    localStorage.setItem Learner.storage_key, JSON.stringify(stats)

  calculateScore: (termScores) ->
    score = 0
    for key, value of termScores
      score += value * @getTermWeight(key)
    return score

  rank: (list) ->
    item.score = @calculateScore(item.termScores) for item in list
    list.sort (a, b) ->
      return -1 if a.score > b.score
      return +1 if a.score < b.score
      return 0
    return list

  reportClick: (item) ->
    maxScore = Math.max.apply @, (value for key, value of item.termScores)
    @updateTermWeight(key, value / maxScore) for key, value of item.termScores


root = exports ? window
root.Learner = Learner