class Routine extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      goals: []
    };
    this.getRoutineElements();
  }

  getRoutineElements() {
    let that = this;
    axios.get("/routines/" + this.props.path + ".json").then(function (response) {
      that.setState({
        goals: response.data.goals
      });
    });
  }

  renderRoutineElements() {
    return this.state.goals.map((goal, i) => {
      console.log(goal);
      return React.createElement("li", {
        key: i
      }, goal.name);
    });
  }

  render() {
    return React.createElement("div", null, React.createElement("a", {
      href: "#",
      onClick: this.props.deselectFn
    }, "back to All"), React.createElement("h1", null, this.props.path), React.createElement("ul", null, this.renderRoutineElements()), React.createElement("button", {
      onClick: this.props.addToToDo(this.state.goals)
    }, "Add to Todo List"));
  }

}