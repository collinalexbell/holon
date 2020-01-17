class Goal extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return React.createElement("div", null, React.createElement("div", {
      class: "goal-name"
    }, "Goal: ", this.props.name), this.props.description != undefined && this.props.description.length > 0 && React.createElement("div", {
      class: "goal-description"
    }, "Description: ", this.props.description));
  }

}