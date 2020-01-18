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

function expectLinkClickToRender(text, component, n = 1) {
  const app = shallow(<App />);
  const routines = app.find('a').filterWhere(comp =>
    {return comp.text().toLowerCase() == text.toLowerCase()})
  routines.simulate('click')
  expect(app.find(component)).toHaveLength(n)
}

test('clicking routines link renders RoutineApp', () => {
  expectLinkClickToRender("routines", RoutineApp)
})

test('clicking routines link renders RoutineApp', () => {
  expectLinkClickToRender("goals", GoalList)
})
