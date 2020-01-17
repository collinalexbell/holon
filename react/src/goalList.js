import React from 'react'
import Goal from './goal'

class GoalList extends React.Component {
  constructor(props) {
    super(props)
    this.state = {goals:props.goals}
  }

  mapGoals() {
    console.log(this.state.goals)
    return this.state.goals.map((goal, i) => {
      return <li key={i}><Goal name={goal.name}/></li>
    })}

  render() {
    let home = <a href="#home" onClick={this.props.toHome}>To Home</a>
    if(this.state.goals.length > 0)
      return(
        <div>
          {home}
          <ul>{this.mapGoals()}</ul>
        </div>
      )
    else
      return(
        <div>
          {home}
          <ul>{this.mapGoals()}</ul>
          <h4>No Goals todo</h4>
        </div>
      )
  }
}

export default GoalList
