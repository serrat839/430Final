'use strict';

// Loads in select bar
window.onload = function () {
    fetchCarData();
}

let L = window.L

const carData = fetch('./data/carInfo.json')
    .then(response => response.json());

const listData = fetch('./data/listingInfo.json')
.then(response => response.json());

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

    unique.forEach((car) => addToSel(car));
}

// Adds the filtered value onto the select bar
function addToSel(obj) {
    let sel = document.getElementById('sel');
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

// Creates the list of car results
function carSetup (obj) {
    let dom = document.getElementById('msg');
    dom.innerHTML = '';
    obj.forEach(findCar);
}

// Creates the list of car results
function findCar (obj) {
    let carsel = obj.carId
    fetch('./data/carInfo.json')
    .then(response => response.json())
    .then(data =>data.carInfo.find(x => x.car == carsel))
    .then(data => renderCar(data, obj));
}
// Creates the list of car results
function renderCar (car, list) {
    let d1 = document.createElement('div');
    d1.className = 'container';

    let d2 = document.createElement('div');
    d2.className = "card mb-3";
    let d3 = document.createElement('div');
    d3.className = "row no-gutters"
    let d4 = document.createElement('div');
    d4.className = "col-md-4"
    d4.appendChild(images(list.filename))
    let d5 = document.createElement('div');
    d5.className = "col-md-8"
    let d6 = document.createElement('div');
    d6.className = "card-body"
    let dom = document.getElementById('msg');


    d6.appendChild(cardBody(car,list))

    d3.appendChild(d4);
    d2.appendChild(d3);
    d5.appendChild(cardBody(car,list));
    d3.appendChild(d5);
    d2.appendChild(d3);
    d1.appendChild(d2);
    dom.appendChild(d1);
}

// Creates the list of car results
function images(obj) {
    let  b = obj.replaceAll("[","")
    b = b.replaceAll("]",'')
    b = b.replaceAll("\'","")
    b = b.split(",")

    let img = document.createElement('img');
    img.className = "img-fluid card-img"
    img.src = b[0]
    return img
}
// Creates the list of car results
function cardBody(car, list) {
    let cardBod = document.createElement('div');
    cardBod.className = "card-body"

    let cTitle = document.createElement('h5');
    cTitle.className = "card-title"
    cTitle.innerHTML = car.make + " " + car.model;

    let pText = document.createElement('p');
    pText.className="card-text";
    pText.innerHTML ="<strong> Price: </strong> $" + list.price  + " <strong>Starting Price: </strong> $" + car.startingprice;

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
    pDate.appendChild(contact)

    cardBod.append(cTitle)
    cardBod.append(pText)
    cardBod.append(pDate)

    return cardBod
}