fs = require('fs')
routines = []


function loadRoutines(dirname, levels) {
  var dir = fs.readdirSync(dirname, {withFileTypes:true})
  for(dirent of dir){
    if(dirent.isDirectory() && dirent.name.charAt(0) != '.') {
      loadRoutines(dirname + dirent.name + '/', levels.concat(dirent.name))
    } else if (dirent.isFile() && dirent.name.charAt(0) != '.') {
      path = levels.concat(dirent.name).join("/")
      if(!path.includes("social")) {
        routines.push({path: path})
      }
    }
  }
}

loadRoutines("/home/kuberlog/docs/routines/", [])

function goalsFromFileText(fileText) {
  goals = []
  names = fileText.split("\n")
  for(name of names) {
    if(name.length > 0){
      goals.push({name: name})
    }
  }
  return goals
}

module.exports.api = function(req, res) {
  fpath = req.params[0].replace(".json", "")
  routine = fs.readFileSync("/home/kuberlog/docs/routines/" + fpath).toString()
  res.set("Content-Type", "text/json")
  res.send(JSON.stringify({goals: goalsFromFileText(routine)}))
}

module.exports.byPath = function (req, res) {
  html = fs.readFileSync('views/routine.html')
  res.set('Content-Type', 'text/html')
  res.send(html)
}

module.exports.routines = function(req, res) {
  res.send(JSON.stringify({routines: routines}))
}

module.exports.home = function(req, res) {
    res.render('routines', {routines: routines})
}
