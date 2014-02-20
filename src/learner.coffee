localStorage = require('./mockLocalStorage').localStorage ? localStorage

class Learner

  storage_key: 'learnerstats'
  
  constructor: () ->
    @load()
  
  load: ->
    try
      @stats = JSON.parse(localStorage.getItem this.storage_key)
      @stats.lastLoaded
    catch error
      @stats = {
        terms: {}
        lastSaved: undefined,
        lastLoaded: new Date
      }

  save: ->
    if @getLastSaved() <= @stats.lastLoaded
      @stats.lastSaved = new Date
      localStorage.setItem this.storage_key, JSON.stringify(@stats)
      @stats.lastLoaded = new Date
    else
      console.log 'The stats has been updated since load'

  getLastSaved: ->
    try
      return new Date(JSON.parse(localStorage.getItem this.storage_key).lastSaved)
    catch error
      return new Date(1900, 1, 1) 

  getTermWeight: (term) ->
    try
      return @stats.terms[term].weight
    catch error
      console.log error

  updateTermWeight: (term, weight) ->
    if term of @stats.terms
      @stats.terms[term].weight += weight
    else
      @stats.terms[term] = {
        'weight': weight
      }
    @save()

root = exports ? window
root.Learner = Learner