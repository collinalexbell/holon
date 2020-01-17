class RoutineApp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {showList: true, routinePath: ""}
    this.genSelectRoutine = this.genSelectRoutine.bind(this);
    this.deselectRoutine = this.deselectRoutine.bind(this);
  }

  genSelectRoutine(path) {
    let that = this
    return function() {
      that.setState({showList: false, routinePath: path})
    }
  }

  deselectRoutine() {
    this.setState({showList: true, routinePath: ""})
  }

  render() {
    if(this.state.showList) {
      return(
        <div>
          <a href='#home' onClick={this.props.toHome}>to Home</a>
          <RoutineList selectFn={this.genSelectRoutine}/>
        </div>
      )
    }
    else {
      return(
        <div>
          <Routine
            path={this.state.routinePath}
            deselectFn={this.deselectRoutine}
            addToToDo={this.props.addRoutineToTodo}/>
        </div>
      )
    }
  }
}
