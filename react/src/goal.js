import React from 'react';

class Goal extends React.Component {
  constructor(props) {
    super(props)
  }
  render() {
    return(
      <div>
        <div className="goal-name">Goal: {this.props.name}</div>
        {this.props.description != undefined &&
          this.props.description.length > 0 &&

          <div class='goal-description'>Description: {this.props.description}</div>}
        <button onClick={this.props.complete}>Complete</button>
      </div>
    )
  }
}

export default Goal;
