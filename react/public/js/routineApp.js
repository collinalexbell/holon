class RoutineApp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      showList: true,
      routinePath: ""
    };
    this.genSelectRoutine = this.genSelectRoutine.bind(this);
    this.deselectRoutine = this.deselectRoutine.bind(this);
  }

  genSelectRoutine(path) {
    let that = this;
    return function () {
      that.setState({
        showList: false,
        routinePath: path
      });
    };
  }

  deselectRoutine() {
    this.setState({
      showList: true,
      routinePath: ""
    });
  }

  render() {
    if (this.state.showList) {
      return React.createElement("div", null, React.createElement("a", {
        href: "#home",
        onClick: this.props.toHome
      }, "to Home"), React.createElement(RoutineList, {
        selectFn: this.genSelectRoutine
      }));
    } else {
      return React.createElement("div", null, React.createElement(Routine, {
        path: this.state.routinePath,
        deselectFn: this.deselectRoutine,
        addToToDo: this.props.addRoutineToTodo
      }));
    }
  }

}