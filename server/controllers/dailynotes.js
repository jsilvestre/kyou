// Generated by CoffeeScript 1.7.1
var DailyNote, moment;

DailyNote = require('../models/dailynote');

moment = require('moment');

module.exports.day = function(req, res, next) {
  console.log(req.day);
  return DailyNote.getDailyNote(req.day, function(err, dailynote) {
    if (err) {
      return next(err);
    } else if (dailynote != null) {
      return res.send(dailynote);
    } else {
      return res.send({});
    }
  });
};

module.exports.updateDay = function(req, res, next) {
  return DailyNote.getDailyNote(req.day, function(err, dailynote) {
    var data;
    if (err) {
      return next(err);
    } else if (dailynote != null) {
      dailynote.text = req.body.text;
      return dailynote.save(function(err) {
        if (err) {
          return next(err);
        } else {
          return res.send(dailynote);
        }
      });
    } else {
      data = {
        text: req.body.text,
        date: req.day
      };
      return DailyNote.create(data, function(err, dailynote) {
        if (err) {
          return next(err);
        } else {
          return res.send(dailynote);
        }
      });
    }
  });
};
