import React from 'react';
import { shallow } from 'enzyme';
import App from '../App';
import RoutineApp from '../routineApp'
import GoalList from '../goalList'
import Enzyme from 'enzyme'
import Adapter from 'enzyme-adapter-react-16.1';

Enzyme.configure({ adapter: new Adapter() });

test('renders 2 links: goals and routines', () => {
  const app = shallow(<App />);
  expect(app.find('a')).toHaveLength(2)
});

test('clicking routines link renders RoutineApp', () => {
  const app = shallow(<App />);
  const routines = app.find('a').filterWhere(comp => comp.text() == 'Routines')
  routines.simulate('click')
  expect(app.find(RoutineApp)).toHaveLength(1)
})

test('clicking routines link renders RoutineApp', () => {
  const app = shallow(<App />);
  const goals = app.find('a').filterWhere(comp => comp.text() == 'Goals')
  goals.simulate('click')
  expect(app.find(GoalList)).toHaveLength(1)
})
