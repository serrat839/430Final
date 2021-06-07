
import CarSearch from './make.js';
import CARINFO from './carInfo.json';
import React from 'react';


class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      CARINFO,
    }
  }
  render () {

    return (
      <CarSearch group = {this.state.CARINFO}/>
    )
  }
}

export default App;
