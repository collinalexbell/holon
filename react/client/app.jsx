class App extends React.Component {
  constructor(props) {
    super(props)
    this.state = {selection:"home", goals:[]}
    this.addRoutineToGoals = this.addRoutineToGoals.bind(this);
  }

  select(selection) {
    let that = this
    return function() {
      that.setState({selection:selection})
    }
  }

  addRoutineToGoals(goals) {
    let that = this
    return function() {
      that.setState((state, props) => {
        state.goals.push.apply(state.goals, goals)
        return state
      })
      console.log(that.state)
    }
  }

  render() {
    switch(this.state.selection) {
      case "routines":
        return (
          <RoutineApp
            toHome={this.select("home")}
            addRoutineToTodo={this.addRoutineToGoals}/>
          )
      case "goals":
        return <GoalList goals={this.state.goals} toHome={this.select("home")}/>
      default:
        return (
          <div>
            <a onClick={this.select("goals")} href="#goals">Goals</a>
            <br/>
            <a onClick={this.select("routines")} href="#routines">Routines</a>
          </div>
        )

    }
  }
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
