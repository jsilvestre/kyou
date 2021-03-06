// Generated by CoffeeScript 1.7.1
var moment;

moment = require('moment');

module.exports = {
  normalize: function(rows, end) {
    var data, date, dateString, normalizedRows, row, _i, _len;
    if (end == null) {
      end = moment();
    }
    normalizedRows = {};
    data = {};
    for (_i = 0, _len = rows.length; _i < _len; _i++) {
      row = rows[_i];
      data[row.key] = row.value;
    }
    end.hours(0, 0, 0, 0);
    date = moment(end);
    date.subtract('month', 6);
    while (date < end) {
      date = date.add('days', 1);
      dateString = date.format("YYYY-MM-DD");
      if (data[dateString] != null) {
        normalizedRows[dateString] = data[dateString];
      } else {
        normalizedRows[dateString] = 0;
      }
    }
    return normalizedRows;
  },
  toClientFormat: function(data) {
    var date, dateEpoch, results, value;
    results = [];
    for (date in data) {
      value = data[date];
      dateEpoch = new Date(date).getTime() / 1000;
      results.push({
        x: dateEpoch,
        y: value
      });
    }
    return results;
  }
};
