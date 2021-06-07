import React from 'react';
import reactDom from 'react-dom';
import Select from 'react-select'
import CARINFO from './carInfo.json';


class CarSearch extends React.Component {
    
    state = {
        id:'',
        selectedOption:'b',
        name:'a',
    };

    handleChange = (e) => {
        this.setState({selectedOption: e.make, name: e.make})
    };

    render () {
        const { selectedOption } = this.state;

        let unique = [];
        this.props.group.map((d) => {
            let findItem = unique.find(x => x.make == d.make);
            if (!findItem)
                unique.push(d);
        });

        let makeN = (unique.map((d) => {
            return {
                key: d.make,
                label: d.make,
                value: d.make,
                id: d.make
            }
        }));

        return (
            <div>
                <Select
                options = {makeN}
                value= {selectedOption}
                onChange={this.handleChange}
                onSubmit={this.onSubmit}
                />
                <Test name={this.state.name}/>
                <p> {this.state.make} </p>
                <p>{this.props.group.make} aa</p>
            </div>
        ) 
    }
}

class Test extends React.Component {
    render() {
        return (
           <div>
           <p> {this.props.name}</p>
            </div>
        )
    }
}

export default CarSearch;