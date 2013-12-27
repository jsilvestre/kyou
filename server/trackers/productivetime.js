// Generated by CoffeeScript 1.6.3
var americano;

americano = require('americano-cozy');

module.exports = {
  name: "Productive Time - Rescue Time",
  color: "#27AE61",
  description: "Number of minutes spent on apps and websites with productiviy rating superior to\n0 in Rescue Time. Data should be imported from Rescue Time konnector",
  model: americano.getModel('RescueTimeActivity', {
    date: Date
  }),
  request: {
    map: function(doc) {
      if (doc.productivity > 0) {
        return emit(doc.date.substring(0, 10), doc.duration / 60);
      }
    },
    reduce: function(key, values, rereduce) {
      return sum(values);
    }
  }
};