const fs = require('fs')
const mustache = require('mustache')

stages = JSON.parse(fs.readFileSync('data/goodToGreat/stages.json'))

function home (req, res) {
  res.render('goodToGreat/home', {base:'good-to-great', stages:stages})
}

function findStage (url) {
  for(var stage of stages) {
    if (stage.url == url) {
      return stage
    }
  }
}

function routeStage (req, res) {
  var stage = findStage(req.params.stage)
  var template = fs.readFileSync('views/goodToGreat/stage.mst').toString()
  var stagePartial = fs.readFileSync('views/goodToGreat/' + stage.url + '.mst').toString()
  var html = mustache.render(template, {stage:stage}, {stagePartial: stagePartial})
  res.send(html)
}

module.exports = function(req, res) {
  if (req.params.stage == undefined) {
    home(req, res)
  } else {
    routeStage(req, res)
  }
}
