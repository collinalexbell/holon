var goals = Array()

class Goal {
  constructor (name) {
    this.name = name
    this.id =
    this.description = ""
    this.created = new Date()
    this.completed = false
  }

  create (name) {
    goal = new Goal(name)
    goal.save()
    return goal
  }

  static save(goal) {
    goal.id = goals.length
    goals.push(goal)
  }

  static load(id) {
    console.log(goals)
    return goals[id]
  }
}

module.exports = Goal
