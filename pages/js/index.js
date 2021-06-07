'use strict';

// Loads in select bar
window.onload = function () {

}

let L = window.L

var apiLink = "http://localhost:5000/"



let bigArr = [];

function loadSearch() {
    fillMData('make', 'Id');
    fillMData('model', 'Id');
    findLocationData();
    fillYearData();
}

loadSearch();


// Finds and fills in location
function findLocationData() {
    fetch(apiLink + 'location')
        .then(response => response.json())
        .then(data => data[0].forEach(loc => addToSelTest(loc, 'selLoc', 'id', 'location')));
}

//Finds and fills in Year
function fillYearData() {
    fetch(apiLink + 'makeAndModel')
        .then(response => response.json())
        .then(data => fillYear(data[0]));
}

function fillYear(obj) {
    let test = [];
    test = findUniqueValue(obj, 'modelYear', '').sort(function (a, b) {
        return a.modelYear - b.modelYear
    })
    test.forEach(x => addToSelTest(x, 'yearMin', 'modelYear', 'modelYear'))
    test.forEach(x => addToSelTest(x, 'yearMax', 'modelYear', 'modelYear'))
}

//Finds and fills in Make Data

function fillMData(name, val) {
    fetch(apiLink + 'makeAndModel')
        .then(response => response.json())
        .then(data => fillSelect(data[0], name, val))
}

//Finds and fills in Model Data

function fillSelect(obj, name, val) {
    let arr = []
    arr = findUniqueValue(obj, name, val);

    sortName(arr, name).forEach((x) => addToSelTest(x, name, name + val, name));
}

// Helper Methods

// Sorts arrays by alphabetical name
// Takes in array of object (obj) and name of object (name) you want sorted
// Returns sorted array
function sortName(obj, name) {
    let sorted = [];
    sorted = obj.sort(function (a, b) {
        let aa = a[name].toLowerCase();
        let bb = b[name].toLowerCase();
        return (aa < bb) ? -1 : (aa > bb) ? 1 : 0;
    })
    return sorted;
}

// Finds Unique Values
// Takes in array of objects (obj), name of object (name), and value you want (val)
// Returns unique array of just the object name and it's value
function findUniqueValue(obj, name, val) {
    let idTest = name + val;
    let valTest = name;
    let unique = []
    obj.forEach((d) => {
        let findItem = unique.find(x => x[valTest] === d[valTest]);
        if (!findItem)
            unique.push({ [name]: d[name], [idTest]: d[idTest] });
    });

    return unique;
}

// Adds list to the correct select element
// Finds the id of select (ele) and then inserts options with
// the name (opt) and value (val)
function addToSelTest(obj, ele, val, opt) {
    let sel = document.getElementById(ele);
    sel.innerHTML = sel.innerHTML +
        '<option value="' + obj[val] + '">' + obj[opt] + '</option>';
}

document.getElementById('make').addEventListener('change', function () {
    if (this.value != '') {
        let sel = document.getElementById('model')
        sel.innerHTML = '<option value="">-- Model --</option>'
        fetch(apiLink + 'makeAndModel')
            .then(response => response.json())
            .then(data => data[0].filter(d => d.makeId == this.value))
            .then(data => fillSelect(data, 'model', 'Id'));
    } else {
        fillMData('model', 'Id')
    }
});

document.getElementById('search').addEventListener("click", function () {
    let makeVal = document.getElementById('make').value
    let modelVal = document.getElementById('model').value
    let locVal = document.getElementById('selLoc').value
    let yearMin = document.getElementById('yearMin').value
    let yearMax = document.getElementById('yearMax').value
    let minPrice = document.getElementById('minPrice').value
    let maxPrice = document.getElementById('maxPrice').value

    console.log('ah', makeVal, modelVal, locVal);

    let arr = [];

    fetch(apiLink + 'listings')
        .then(response => response.json())
        .then(data => data[0])
        .then(data => {
            if (makeVal != '') {
                return data.filter(x => x.makeId == makeVal)
            }
            else {
                return data
            }
        })
        .then(data => {
            if (modelVal != '') {
                return data.filter(x => x.modelId == modelVal)
            }
            else {
                return data
            }
        })
        .then(data => {
            if (locVal != '') {
                return data.filter(x => x.locId == locVal)
            }
            else {
                return data
            }
        })
        .then(data => {
            if (yearMin != '') {
                return data.filter(x => x.year >= yearMin)
            }
            else {
                return data
            }
        })
        .then(data => {
            if (yearMax != '') {
                return data.filter(x => x.year <= yearMax)
            }
            else {
                return data
            }
        })
        .then(data => {
            if (minPrice != '') {
                return data.filter(x => x.price >= minPrice)
            }
            else {
                return data
            }
        })
        .then(data => {
            if (maxPrice != '') {
                return data.filter(x => x.price <= maxPrice)
            }
            else {
                return data
            }
        })


        //.then(data => console.log(data))

        .then(data => data.forEach(function (x) {
            arr.push(x.listId)
        }))

        .then(() => carSetup(arr));

});



/*

function findTable(name, val) {
    fetch(apiLink + name)
        .then(response => response.json())
        .then(data => findUnique(data[0], val))
        .then(data => console.log(data));

}

*/


// Previous code below

/*

// Fetches data for select bar
function fetchCarData() {
    let a = fetch('./data/carInfo.json')
        .then(response => response.json())
        .then(fillSelect);
    return a;
}

// Fills in select bar with unqiue attributes
function fillSelect(obj) {
    let sel = document.getElementById('sel');
    sel.innerhtml = '';
    let unique = [];
    obj.carInfo.forEach((d) => {
        let findItem = unique.find(x => x.make == d.make);
        if (!findItem)
            unique.push(d);
    });

    unique.forEach((car) => addToSel(car, 'sel'));
}

// Adds the filtered value onto the select bar
function addToSel(obj, el) {
    let sel = document.getElementById(el);
    sel.innerHTML = sel.innerHTML +
        '<option value="' + obj.make + '">' + obj.make + '</option>';
}

// Eventt listener for chagning select bar
document.getElementById('sel').addEventListener('change', function () {
    console.log(this.value);


    var listCar = []
    fetch('./data/carInfo.json')
        .then(response => response.json())
        .then(data => (data.carInfo.filter(x => x.make == this.value)))
        .then(d => d.forEach((b) => {
            listCar.push(b.car);
        }));

    fetch('./data/listingInfo.json')
        .then(response => response.json())
        .then(data => carSetup((data.listingInfo.filter((x) => listCar.includes(x.carId)))))
})
*/
// Creates the list of car results
function carSetup(obj) {
    let dom = document.getElementById('results');
    if (obj.length == 0) {
        dom.innerHTML ='<div class="alert alert-danger" id="alert" role="alert"> No Results Found</div>'
    } else {
        dom.innerHTML = 'Showing ' + obj.length + ' Results';
        document.getElementById('msg').innerHTML = ''
        let arr = [];
        let sort = document.getElementById('sortBy').value
        fetch(apiLink + 'listingCard')
            .then(response => response.json())
            .then(data => data[0])
            .then(data => (data.filter(x => (obj.includes(x.id)))))
            .then((data) => {
                if (sort == '' || sort == 'new') {
                    data.sort(function (a, b) {
                        return new Date(b.date) - new Date(a.date)
                    })
                } else if (sort == 'old') {

                    data.sort(function (a, b) {
                        return new Date(a.date) - new Date(b.date)
                    })
                } else if (sort == 'priceAsc') {

                    data.sort(function (a, b) {
                        return a.price - b.price
                    })
                } else if (sort == 'priceDes') {

                    data.sort(function (a, b) {
                        return b.price - a.price
                    })
                } return data
            })
            .then(data => arr.push(data))
            .then(() => console.log(arr))
            .then(() => arr[0].forEach(renderTest));


    }
}



function renderTest(obj) {
    let d1 = document.createElement('div');
    if (obj.price < 0) {
        obj.price = "Contact Listing"
    }
    d1.innerHTML = '<div class="container"> <div class="card mb-3">' + '<div class="row no-gutters"> <div class="col-md-4"> <img src="' + images(obj.filename) + '" class="img-fluid card-img" alt="..."> </div> <div class="col-md-8">  <div class="card-body"> <h5 class="card-title">' + obj.make + ' ' + obj.model + '</h5> <p class="card-text"> <strong> Price: </strong> $' + obj.price ;

    let dom = document.getElementById('msg');
    dom.appendChild(d1)
}

function render(obj) {
    let d1 = document.createElement('div');
    d1.innerHTML = '<div class="container"> <div class="card mb-3">' + '<div class="row no-gutters"> <div class="col-md-4">'
    d1.className = 'container';

    let d2 = document.createElement('div');
    d2.className = "card mb-3";
    let d3 = document.createElement('div');
    d3.className = "row no-gutters"
    let d4 = document.createElement('div');
    d4.className = "col-md-4"
    //d4.appendChild(images(list.filename))
    let d5 = document.createElement('div');
    d5.className = "col-md-8"
    let d6 = document.createElement('div');
    d6.className = "card-body"
    let dom = document.getElementById('msg');


    d6.appendChild(cardBody(car, list))

    d3.appendChild(d4);
    d2.appendChild(d3);
    d5.appendChild(cardBody(car, list));
    d3.appendChild(d5);
    d2.appendChild(d3);
    d1.appendChild(d2);
    dom.appendChild(d1);
}


// Creates the list of car results
function renderCar(car, list) {
    let d1 = document.createElement('div');
    d1.className = 'container';

    let d2 = document.createElement('div');
    d2.className = "card mb-3";
    let d3 = document.createElement('div');
    d3.className = "row no-gutters"
    let d4 = document.createElement('div');
    d4.className = "col-md-4"
    //d4.appendChild(images(list.filename))
    let d5 = document.createElement('div');
    d5.className = "col-md-8"
    let d6 = document.createElement('div');
    d6.className = "card-body"
    let dom = document.getElementById('msg');


    d6.appendChild(cardBody(car, list))

    d3.appendChild(d4);
    d2.appendChild(d3);
    d5.appendChild(cardBody(car, list));
    d3.appendChild(d5);
    d2.appendChild(d3);
    d1.appendChild(d2);
    dom.appendChild(d1);
}

// Creates the list of car results
function images(obj) {
    let b = obj.replaceAll("[", "")
    b = b.replaceAll("]", '')
    b = b.replaceAll("\'", "")
    b = b.split(",")
    /*
    let img = document.createElement('img');
        img.className = "img-fluid card-img"
        img.src = b[0]
        */
    return b[0]

}
// Creates the list of car results
function cardBody(car, list) {
    let cardBod = document.createElement('div');
    cardBod.className = "card-body"

    let cTitle = document.createElement('h5');
    cTitle.className = "card-title"
    cTitle.innerHTML = car.make + " " + car.model;

    let pText = document.createElement('p');
    pText.className = "card-text";
    pText.innerHTML = "<strong> Price: </strong> $" + list.price + " <strong>Starting Price: </strong> $" + car.startingprice;

    if (typeof list.condition != "undefined") {
        pText.innerHTML = pText.innerHTML +
            "<br> <strong> Condition: </strong>" + list.condition
    }

    pText.innerHTML = pText.innerHTML +
        " <strong> Odometer: </strong>" + list.odometer


    let pDate = document.createElement('p');
    let dateText = document.createElement('small')
    dateText.className = "text-muted"
    dateText.className = "card-text"
    dateText.innerHTML = "Posted on " + list.date
    pDate.appendChild(dateText);
    let contact = document.createElement('a')
    contact.className = "float-end"
    contact.href = list.url
    contact.innerHTML = "Contact"
    let but = document.createElement('button');
    but.innerHTML = '<button type="button" class="btn btn-outline-primary" onclick="exampleOnclick(this)" value="' + list.url + '">More Info</button>'
    pDate.appendChild(but)
    pDate.appendChild(contact)
    cardBod.append(cTitle)
    cardBod.append(pText)
    cardBod.append(pDate)

    return cardBod
}

function exampleOnclick(btn) {
    var name = btn.value;

    var exampleModal = getExampleModal();

    // Init the modal if it hasn't been already.
    if (!exampleModal) { exampleModal = initExampleModal(); }

    let test = findUrl(name);
    console.log(test.length);
    console.log(test[1])
    let car = findCarForModal(test)

    var html =
        '<div class="modal-header">' +
        '<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>' +
        '<button type="button" class="close" data-dismiss="modal" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button>' +
        '</div>' +
        '<div class="modal-body">' +
        name +
        '</div>' +
        '<div class="modal-footer">' +
        '<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>' +
        '<button type="button" class="btn btn-primary">Save changes</button>' +
        '</div>';

    setExampleModalContent(html);

    // Show the modal.
    jQuery(exampleModal).modal('show');

}

function findUrl(val) {
    let a = fetch('./data/listingInfo.json')
        .then(response => response.json())
        .then(data => (data.listingInfo.find(x => x.url == val)));

    return a
}

function findCarForModal(obj) {
    console.log(obj.carId)
    let a = fetch('./data/carInfo.json')
        .then(response => response.json())
        .then(data => data.carInfo.find(x => x.car == obj.carId))
        .then(data => console.log(data));

}

function getExampleModal() {
    return document.getElementById('exampleModal');
}

function setExampleModalContent(html) {
    getExampleModal().querySelector('.modal-content').innerHTML = html;
}

function initExampleModal() {
    var modal = document.createElement('div');
    modal.classList.add('modal', 'fade');
    modal.setAttribute('id', 'exampleModal');
    modal.setAttribute('tabindex', '-1');
    modal.setAttribute('role', 'dialog');
    modal.setAttribute('aria-labelledby', 'exampleModalLabel');
    modal.setAttribute('aria-hidden', 'true');
    modal.innerHTML =
        '<div class="modal-dialog" role="document">' +
        '<div class="modal-content"></div>' +
        '</div>';
    document.body.appendChild(modal);
    return modal;
}
