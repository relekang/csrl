localStorage = require('./mockLocalStorage').localStorage ? localStorage

class Learner

  @storage_key: 'learnerstats'

  @reset: ->
    localStorage.removeItem this.storage_key

  save: (stats) ->
    localStorage.setItem Learner.storage_key, JSON.stringify(stats)

  load: ->
    data = localStorage.getItem Learner.storage_key
    if not data
      stats = { terms: {} }
    else
      stats = JSON.parse(data)
    return stats

  getLastSaved: ->
      return new Date(@load().lastSaved)

  getTermWeight: (term) ->
    try
      return @load().terms[term].weight
    catch error
      return 0

  updateTermWeight: (term, weight) ->
    stats = @load()
    if term of stats.terms
      stats.terms[term].weight += weight
    else
      stats.terms[term] = {
        'weight': weight
      }
    stats.lastSaved = new Date
    @save stats

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