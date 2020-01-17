class Routine extends React.Component {
  constructor(props) {
    super(props)
    this.state = {goals: []}
    this.getRoutineElements()
  }

  getRoutineElements() {
    let that = this
    axios.get( "/routines/" + this.props.path + ".json")
    .then(function (response) {
      that.setState({goals: response.data.goals})
    })
  }

  renderRoutineElements() {
    return this.state.goals.map((goal, i) => {
      console.log(goal)
      return <li key={i}>{goal.name}</li>
    })
  }

  render() {
    return(
      <div>
        <a href="#" onClick={this.props.deselectFn}>back to All</a>
        <h1>{this.props.path}</h1>
        <ul>{this.renderRoutineElements()}</ul>
        <button onClick={this.props.addToToDo(this.state.goals)}>
          Add to Todo List
        </button>
      </div>
    )
  }
}
