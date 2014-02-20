localStorage = require('./mockLocalStorage').localStorage ? localStorage

class Learner

  storage_key: 'learnerstats'
  
  constructor: () ->
    @load()
  
  load: ->
    try
      @stats = JSON.parse(localStorage.getItem this.storage_key)
    catch error
      console.log 'Init @stats: caused by'
      @stats = {
        terms: {}
        lastSaved: undefined
      }

  save: ->
    localStorage.setItem this.storage_key, JSON.stringify(@stats)
