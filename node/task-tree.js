tmpQueue = [
  {
    id: 0,
    name: "Test Tmp Queue",
    description: "Ensure that the tmp queue renders",
    created: "2019-12-29",
    parent: 1
  },
  {
    id: 1,
    name: "Next Item",
    description: "Just print the sub item",
    created: "2019-12-29",
    tasks: false
  }
]

module.exports = function(req, res) {
    res.render('task-tree', {queue: tmpQueue})
}
