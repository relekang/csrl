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
    try
      return JSON.parse(localStorage.getItem Learner.storage_key)
    catch error
      stats = {
        terms: {}
      }
      localStorage.setItem Learner.storage_key, JSON.stringify(stats)
      return stats

   getTermWeight: (term) ->
    try
      return @stats().terms[term].weight
    catch error
      console.log error

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

root = exports ? window
root.Learner = Learner