# Cakefile
 
{exec} = require "child_process"
 
REPORTER = "dot"
 
task "sbuild", "run tests", ->
  exec "NODE_ENV=test 
    ./node_modules/.bin/mocha 
    --compilers coffee:coffee-script/register
    --reporter #{REPORTER}
    --no-colors
  ", (err, output) ->
    console.log output
    throw err if err