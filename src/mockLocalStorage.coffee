DEBUG = false 
FILTER_OUT = ['getItem', 'setItem', 'removeItem', 'toString']

localStorage = {}
localStorage.getItem = (key) ->
  console.log "getItem(#{key})" if DEBUG
  console.log "In localStorage: #{this.toString()}" if DEBUG
  try
    return localStorage[key]
  catch error
    console.log error if DEBUG

localStorage.setItem = (key, value) ->
  console.log "setItem(#{key}, #{value})" if DEBUG
  localStorage[key] = value + ""
  console.log "In localStorage: #{this.toString()}" if DEBUG

localStorage.removeItem = (key) ->
  console.log "removeItem(#{key})" if DEBUG
  delete localStorage[key]
  console.log "In localStorage: #{this.toString()}" if DEBUG

localStorage.toString = ->
    return ("#{key}: #{value}" if not key in FILTER_OUT for own key, value of this).toString()

 Object.defineProperty localStorage, "length",
  get: ->
    Object.keys(this).length - FILTER_OUT.length 
 

root = exports ? window
root.localStorage = localStorage