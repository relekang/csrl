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
      console.log 'Init @stats: caused by'
      @stats = {
        terms: {}
        lastSaved: undefined,
        lastLoaded: new Date
      }

  save: ->
    if @getLastSaved() <= @stats.lastLoaded
      @stats.lastSaved = new Date
      localStorage.setItem this.storage_key, JSON.stringify(@stats)
    else
      console.log 'The stats has been updated since load'

  getLastSaved: ->
    try
      return JSON.parse(localStorage.getItem this.storage_key).lastSaved
    catch error
      return undefined

root = exports ? window
root.Learner = Learner