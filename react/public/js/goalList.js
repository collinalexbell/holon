class GoalList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      goals: props.goals
    };
  }

  mapGoals() {
    console.log(this.state.goals);
    return this.state.goals.map((goal, i) => {
      return React.createElement("li", {
        key: i
      }, React.createElement(Goal, {
        name: goal.name
      }));
    });
  }

  render() {
    let home = React.createElement("a", {
      href: "#home",
      onClick: this.props.toHome
    }, "To Home");
    if (this.state.goals.length > 0) return React.createElement("div", null, home, React.createElement("ul", null, this.mapGoals()));else return React.createElement("div", null, home, React.createElement("ul", null, this.mapGoals()), React.createElement("h4", null, "No Goals todo"));
  }

}