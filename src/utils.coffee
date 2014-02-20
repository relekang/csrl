supports_local_storage = ->
  try
    return "localStorage" of window and window.localStorage isnt null
  catch e
    console.log "no local storage support"
    return false
  return

root = exports ? window
root.supports_local_storage = supports_local_storage