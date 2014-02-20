localStorage = {}
localStorage.getItem = (key) ->
  #console.log "getItem(#{key})"
  return localStorage[key]

localStorage.setItem = (key, value) ->
  #console.log "setItem(#{key}, #{value})"
  localStorage[key] = value + ""

root = exports ? window
root.localStorage = localStorage 