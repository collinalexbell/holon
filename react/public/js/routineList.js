class RoutineList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      routines: [],
      filterItems: ['obsolete']
    };
    this.getRoutines();
    this.toggleFilterObsolete = this.toggleFilterObsolete.bind(this);
  }

  toggleFilterObsolete(e) {
    console.log(e.target.checked);

    if (!e.target.checked) {
      this.setState((state, props) => ({
        routines: state.routines,
        filterItems: state.filterItems.filter(item => item != "obsolete")
      }));
    } else {
      this.setState((state, props) => ({
        routines: state.routines,
        filterItems: state.filterItems.concat(["obsolete"])
      }));
    }
  }

  getRoutines() {
    let that = this;
    axios.get("/routines.json").then(function (response) {
      let routines = response.data.routines;
      that.setState({
        routines: routines
      });
    });
  }

  renderRoutines() {
    let routines = this.state.routines.filter(routine => {
      let includesAFilterItem = this.state.filterItems.map(item => routine.path.includes(item)).reduce((a, b) => a || b, false);
      return !includesAFilterItem;
    });
    return routines.map((routine, i) => {
      return React.createElement("li", {
        key: i
      }, React.createElement("a", {
        onClick: this.props.selectFn(routine.path),
        href: "#"
      }, routine.path));
    });
  }

  render() {
    return React.createElement("div", null, React.createElement("h1", null, "Routines"), React.createElement("label", null, "Filter obsolete routines?", React.createElement("input", {
      type: "checkbox",
      onChange: this.toggleFilterObsolete,
      defaultChecked: "true"
    })), React.createElement("ul", null, this.renderRoutines()));
  }

}