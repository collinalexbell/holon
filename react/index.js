const fs = require('fs');
const util = require('util');
const express = require('express')
const mustacheExpress = require('mustache-express')
const goodToGreat = require('./goodToGreat')
const taskTree = require('./task-tree')
const routine = require('./routine')

const readFile = util.promisify(fs.readFile);

const app = express()
const port = 3000

app.use(express.static('public'))
app.use(express.static('node_modules'))

app.get('/', (req, res) => res.render('home'))


app.get(['/good-to-great', '/good-to-great/:stage'], function (req, res) {
  console.log("req recieved")
  goodToGreat(req, res);
})

app.get('/app', (req, res) => res.render('app'))
app.get('/task-tree', taskTree)
app.get('/routines/*.json', routine.api)
app.get('/routines.json', routine.routines)
app.get('/routines', routine.home)
app.get('/routine/*', routine.byPath)

app.engine('mst', mustacheExpress("views"))
app.set('view engine', 'mst')
app.listen(port, () => console.log(`Example app listening on port ${port}!`))
