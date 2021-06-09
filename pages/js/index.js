'use strict';

// Loads in select bar


var apiLink = "http://localhost:5000/"


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

        .then(data => data.forEach(function (x) {
            arr.push(x.listId)
        }))

        .then(() => carSetup(arr));

});


// Creates the list of car results
function carSetup(obj) {
    let dom = document.getElementById('results');
    let msg = document.getElementById('msg')
    if (obj.length == 0) {
        dom.innerHTML = '<div class="alert alert-danger" id="alert" role="alert"> No Results Found</div>'

        if (msg.innerHTML != '') {
            msg.innerHTML = ''
        }
    } else {
        dom.innerHTML = 'Showing ' + obj.length + ' Results';
        msg.innerHTML = ''
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
            .then(() => arr[0].forEach(renderTest));


    }
}


function renderTest(obj) {

    let d1 = document.createElement('div');


    let d2 = document.createElement('div');
    d2.className = "card mb-3";
    let d3 = document.createElement('div');
    d3.className = "row g-0"
    let d4 = document.createElement('div');
    d4.className = "col-md-4"
    d4.appendChild(images(obj.filename))
    let d5 = document.createElement('div');
    d5.className = "col-md-8"

    let dom = document.getElementById('msg');


    d3.appendChild(d4);
    d2.appendChild(d3);
    d5.appendChild(testCard(obj));
    d3.appendChild(d5);
    d2.appendChild(d3);
    d1.appendChild(d2);
    dom.appendChild(d1);
}

function testCard(obj) {
    let cardBod = document.createElement('div');
    cardBod.className = "card-body"

    let cTitle = document.createElement('h5');
    cTitle.className = "card-title"
    cTitle.innerHTML = '<a href=' + obj.url + ' target="_blank">' + obj.make + " " + obj.model + " " + obj.year + '</a>';

    let pText = document.createElement('p');
    pText.className = "card-text";

    let price = 0;

    if (obj.price < 1) {
        price = "Unknown, Contact Post"
    } else {
        price = "$" + obj.price
    }

    pText.innerHTML = "<strong> Price: </strong>" + price +
        "<br> <strong> Location: </strong>" + obj.location;
    ;



    if (obj.condition != null) {
        pText.innerHTML = pText.innerHTML +
            "<br> <strong> Condition: </strong>" + obj.condition
    }

    pText.innerHTML = pText.innerHTML +
        "<br> <strong> Odometer: </strong>" + obj.odometer


    let pDate = document.createElement('p');
    let dateText = document.createElement('small')

    dateText.className = "card-text"
    dateText.innerHTML = "Posted on " + obj.date.substring(0, 10)
    pDate.appendChild(dateText);

    pDate.innerHTML = pDate.innerHTML + '<button type="button" class="btn btn-primary float-end" onclick="exampleOnclick(this)" value="' + obj.id + '">More Info</button>'

    cardBod.append(cTitle)
    cardBod.append(pText)
    cardBod.append(pDate)

    return cardBod
}

// Creates the list of car results
function images(obj) {
    let b = obj.replaceAll("[", "")
    b = b.replaceAll("]", '')
    b = b.replaceAll("\'", "")
    b = b.split(",")

    let img = document.createElement('img');
    img.className = "card-img"
    img.src = b[0]

    console.log(img)
    return img

}

function imagesTest(obj) {
    let b = obj.replaceAll("[", "")
    b = b.replaceAll("]", '')
    b = b.replaceAll("\'", "")
    b = b.split(",")

    return b[0]

}
// Creates the list of car results

function exampleOnclick(btn) {
    var name = btn.value;

    var exampleModal = getExampleModal();

    // Init the modal if it hasn't been already.
    if (!exampleModal) { exampleModal = initExampleModal(); }

    findModalCar(name);
}

function exampleClose() {
    jQuery(exampleModal).modal('hide');
}

function findModalCar(val) {
    fetch(apiLink + 'modalCar/' + val)
        .then(response => response.json())
        .then(data => data[0])
        .then(data => setModal(data[0]));
}

function setModal(obj) {
    var html =
        '<div class="modal-header">' +
        '<h5 class="modal-title" id="exampleModalLabel"><a href=' + obj.url + '" target = "_blank">' + obj.make + ' ' + obj.model + ' ' + obj.year + '</a></h5>' +
        '<button type="button" class="close" data-dismiss="modal" onclick="exampleClose()" aria-label="Close">' +
        '<span aria-hidden="true">&times;</span>' +
        '</button>' +
        '</div>' +
        '<div class="modal-body" id="modal-bod"> <div id="cara"></div>' +

        '</div>' +
        '<div class="modal-footer">' +
        '<button type="button" class="btn btn-secondary" onclick="exampleClose()" data-dismiss="modal">Close</button>' +
        '</div>';

    setExampleModalContent(html);

    setCarousel(obj.filename);

    addInfo(obj);
    // Show the modal.
    jQuery(exampleModal).modal('show');
}

function setCarousel(obj) {
    let d1 = document.createElement('div')
    d1.setAttribute('id', "carouselExampleIndicators")
    d1.className = 'carousel slide';
    d1.setAttribute('data-bs-ride', 'carousel')
    let imgs = obj.replaceAll("[", "")
    imgs = imgs.replaceAll("]", '')
    imgs = imgs.replaceAll("\'", "")
    imgs = imgs.split(",")


    let cid = document.createElement('div')
    cid.className = 'carousel-indicators'


    for (let i = 0; i < imgs.length; i++) {
        let b = document.createElement('button')
        b.setAttribute('type', 'button')
        b.setAttribute('data-target', '#carouselExampleIndicators')

        b.setAttribute('data-slide-to', [i])
        b.setAttribute('aria-label', 'Slide ' + (i + 1))
        if (i == 0) {
            b.className = 'active'
            b.setAttribute('aria-current', 'true')
        }
        cid.appendChild(b);
    }
    d1.appendChild(cid);

    let d2 = document.createElement('div')
    d2.className = 'carousel-inner'

    for (let i = 0; i < imgs.length; i++) {
        let ci = document.createElement('div')
        ci.className = 'carousel-item'
        if (i == 0) {
            ci.className = ci.className + ' active'
        }
        let pic = document.createElement('img')
        pic.className = 'd-block w-100'
        pic.src = imgs[i]
        ci.appendChild(pic)
        d2.appendChild(ci)
    }

    let a = document.getElementById('cara')

    d1.appendChild(d2)

    a.append(d1)
}

function addInfo(obj) {
    let a = document.getElementById('modal-bod')
    let b = document.createElement('div')

    let p = document.createElement('div')

    let price = 0;
    if (obj.price < 0) {
        price = "Unkown, Contact Listing"
    } else {
        price = '$' + obj.price;
    }

    p.innerHTML = p.innerHTML +
        "<br> <h3><u><strong> Listing Information: </strong></u>  </h3> <strong> Price: </strong>" + price;

    p.innerHTML = p.innerHTML +
        '<strong> Location: </strong>' + obj.location
    if (obj.condition != null) {
        p.innerHTML = p.innerHTML +
            " <strong> Condition: </strong>" + obj.condition
    }

    p.innerHTML = p.innerHTML +
        " <br> <strong> Odometer: </strong>" + obj.odometer

        let sliced = Object.keys(obj).slice(18, obj.length).reduce((result, key) => {
            result[key] = obj[key];
            return result
        }, {});
    
        let data = document.createElement('ul')
        data.className = 'list-group'
    
    
        Object.entries(sliced).forEach(entry => {
            const [key, value] = entry;
            if (value != null) {
                if (value != '[]') {
                    data.innerHTML = data.innerHTML +
                        '<li class="list-group-item"><strong>' + key + '</strong>: ' + value + '</li>'
                }
            }
        });

    let kbbData = document.createElement('div')
    kbbData.innerHTML = '<h3><u><strong> Car Data: </strong></u></h3>' +
        '<p><strong> Starting Price for New: </strong> $' + obj.startingPrice + '</p> <div class="d-grid gap-2"> <button class="btn btn-primary" data-toggle="collapse" href="#collapseExample1" role="button" aria-expanded="false" aria-controls="collapseExample"> What\'s New </button>  <div class="collapse" id="collapseExample1"> <div class="card card-body">' + obj.new.substring(11, obj.new.length) + '</div> </div>' + ' <button class="btn btn-primary justify-content-center" data-toggle="collapse" href="#collapseExample2" role="button" aria-expanded="false" aria-controls="collapseExample"> Pros </button>  <div class="collapse" id="collapseExample2"> <div class="card card-body">' + obj.pros.substring(4, obj.pros.length) + '</div></div>' + ' <button class="btn btn-primary justify-content-center" data-toggle="collapse" href="#collapseExample3" role="button" aria-expanded="false" aria-controls="collapseExample"> Cons </button>  <div class="collapse" id="collapseExample3"> <div class="card card-body">' + obj.cons.substring(4, obj.cons.length) + '</div></div>' + ' <button class="btn btn-primary justify-content-center" data-toggle="collapse" href="#collapseExample4" role="button" aria-expanded="false" aria-controls="collapseExample"> Review </button>  <div class="collapse" id="collapseExample4"> <div class="card card-body">' + obj.review + '</div></div>' + ' <button class="btn btn-primary" data-toggle="collapse" href="#collapseExample5" role="button" aria-expanded="false" aria-controls="collapseExample"> Car Specs </button>  <div class="collapse" id="collapseExample5"> ' + data.innerHTML + '</div>'


    //onsole.log(obj.slice(10,12))
    let carSpec = document.createElement('div')
    let box = document.createElement('div')
    kbbData.innerHTML = kbbData.innerHTML 

    //carSpec.appendChild(box)



    b.append(p)
    b.append(kbbData)
    b.append(carSpec)
    a.append(b)

}

function getExampleModal() {
    return document.getElementById('exampleModal');
}

function setExampleModalContent(html) {
    getExampleModal().querySelector('.modal-content').innerHTML = html;
}

function initExampleModal() {
    var modal = document.createElement('div');
    modal.classList.add('modal');
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
