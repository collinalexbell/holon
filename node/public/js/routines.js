class RoutineList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      routines: []
    };
    this.getRoutines();
  }

  getRoutines() {
    let that = this;
    axios.get(window.location.pathname + ".json").then(function (response) {
      that.setState({
        routines: response.data.routines
      });
    });
  }

  renderRoutines() {
    console.log(this.state);
    return this.state.routines.map((routine, i) => {
      return React.createElement("li", {
        key: i
      }, React.createElement("a", {
        onClick: this.props.selectFn(routine.path),
        href: "#"
      }, routine.path));
    });
  }

  render() {
    return React.createElement("div", null, React.createElement("h1", null, "Routines"), React.createElement("ul", null, this.renderRoutines()));
  }

}

class App extends React.Component {
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
      return React.createElement("div", null, React.createElement(RoutineList, {
        selectFn: this.genSelectRoutine
      }));
    } else {
      return React.createElement("div", null, React.createElement(Routine, {
        path: this.state.routinePath,
        deselectFn: this.deselectRoutine
      }));
    }
  }

}

ReactDOM.render(React.createElement(App, null), document.getElementById('root'));