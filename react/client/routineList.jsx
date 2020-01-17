class RoutineList extends React.Component {
  constructor(props) {
    super(props)
    this.state = {routines: [], filterItems: ['obsolete']}
    this.getRoutines()
    this.toggleFilterObsolete = this.toggleFilterObsolete.bind(this);

  }

  toggleFilterObsolete(e) {
    console.log(e.target.checked)
    if(!e.target.checked) {
      this.setState((state, props) => ({
        routines: state.routines,
        filterItems: state.filterItems.filter((item) => item != "obsolete")
      }))
    }
    else {
        this.setState((state, props) => ({
        routines: state.routines,
        filterItems: state.filterItems.concat(["obsolete"])
      }))
    }
  }

  getRoutines() {
    let that = this
    axios.get("/routines.json")
    .then(function (response) {
      let routines = response.data.routines
      that.setState({routines: routines})
    })
  }

  renderRoutines() {
    let routines = this.state.routines.filter((routine) => {
      let includesAFilterItem = this.state.filterItems
      .map((item) => routine.path.includes(item))
      .reduce((a, b) =>  a || b, false)
      return !includesAFilterItem
    })
    return(
      routines.map((routine, i) => {
        return <li key={i}>
                <a onClick={this.props.selectFn(routine.path)} href="#">
                  {routine.path}
                </a>
               </li>
      })
    )
  }

  render() {
    return(
      <div>
        <h1>Routines</h1>
        <label>Filter obsolete routines?
          <input
                type='checkbox'
                onChange={this.toggleFilterObsolete}
                defaultChecked='true'/>
        </label>
        <ul>{this.renderRoutines()}</ul>
      </div>
    )
  }
}
