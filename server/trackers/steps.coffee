americano = require 'americano-cozy'

module.exports =
    name: "Steps - Jawbone"
    color: "#27AE61"
    description: """
Number of steps you walked every day. Data should be imported from Jawbone
Konnector."""
    model: americano.getModel 'JawboneMove', date: Date
    request:
        map: (doc) ->
            emit doc.date.substring(0,10), doc.steps
        reduce: (key, values, rereduce) ->
            sum values