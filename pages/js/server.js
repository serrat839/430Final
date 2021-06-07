'use strict'
// Requiring modules
const express = require('express');
const app = express();
const mssql = require("mssql");


var cors = require('cors')

app.use(cors())
// Get request
const config = {
    user: 'epicadmin',
    password: 'EpicGaming1234',
    server: 'info430g6.database.windows.net',
    database: 'davidsList'
};

app.get('/', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("SELECT l.[id] as 'listId', l.[price], l.[url], l.[date], l.odometer, l.condition, lo.[location], lo.[url] as 'locUrl', lo.id as 'locId', l.alias, l.carId,  ma.id as 'makeId', mo.id as 'modelId', mo.name as 'Model', mo.year as 'year' FROM dbo.listing as l join dbo.picture as p on l.id = p.listingId left join dbo.[location] as lo on l.locationId = lo.id left join dbo.car as c on l.carId = c.id join dbo.make as ma on c.makeId = ma.id left join dbo.model as mo on c.modelId = mo.id where l.carId != 2;",
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});

app.get('/listings', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("SELECT l.[id] as 'listId', l.[price], l.[date], l.condition, lo.id as 'locId',  ma.id as 'makeId', mo.id as 'modelId', mo.year as 'year' FROM dbo.listing as l left join dbo.[location] as lo on l.locationId = lo.id left join dbo.car as c on l.carId = c.id join dbo.make as ma on c.makeId = ma.id left join dbo.model as mo on c.modelId = mo.id where l.carId != 2;",
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});

app.get('/listing/:id', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("Select li.[id], li.[price], li.[url], li.[date], li.odometer, li.condition, lo.[location], ma.[name] as 'make', mo.[name] as 'model' from [dbo].[listing] as li left join [dbo].[car] as ca on li.carId = ca.id left join [dbo].[make] as ma on ca.makeId = ma.id left join [dbo].[model] as mo on ca.modelId = mo.id left join [dbo].[location] as lo on  li.locationId = lo.id where li.[id]=" +req.params['id'] ,
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});

app.get('/listingCard', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("Select li.id, li.price, li.url, li.date, li.odometer, li.condition, lo.location, ma.name as 'make', mo.name as 'model', picture.[filename] from [dbo].[listing] as li left join [dbo].[car] as ca on li.carId = ca.id left join [dbo].[make] as ma on ca.makeId = ma.id left join [dbo].[model] as mo on ca.modelId = mo.id left join [dbo].[location] as lo on  li.locationId = lo.id left join [dbo].picture on li.id = picture.listingId ;" ,
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});

app.get('/location', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("select * from [dbo].[location]",
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});

app.get('/makeAndModel', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("select DISTINCT mo.name as 'model', mo.year as 'modelYear', ma.name as 'make', ma.id as 'makeId', mo.id as 'modelId', ca.id as 'carId' from [dbo].[listing] as li left join [dbo].[car] as ca on li.carId = ca.id left join [dbo].[model] as mo on ca.modelId = mo.Id left join [dbo].[make] as ma on ca.makeId = ma.Id where ma.[name] != 'UNKNOWN';",
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});

app.get('/car/:id', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("select * from [dbo].[car] where id =" + req.params['id'] ,
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser
                
                res.send(records.recordsets);

            });
    });
});
var server = app.listen(5000, function () {
    console.log('Server is listening at port 5000...');
});

app.get('/special', function (req, res) {

    // Config your database credential

    // Connect to your database
    mssql.connect(config, function (err) {

        // Create Request object to preform
        // query operation
        let request = new mssql.Request();

        // Query to the database and get the records
        request.query("SELECT l.[id] as 'listId', l.[price], l.[url], l.[date], l.odometer, l.condition, lo.[location], lo.[url] as 'locUrl', l.alias, l.carId, p.[filename], ma.name as 'Make', ma.id as 'makeId', mo.id as 'modelId', mo.name as 'Model', mo.year as 'Year', k.cons as 'Cons', k.new 'New', k.pros as 'Pros', k.review as 'Review', k.startingPrice as 'sPrice', s.* FROM dbo.listing as l join dbo.picture as p on l.id = p.listingId left join dbo.[location] as lo on l.locationId = lo.id left join dbo.car as c on l.carId = c.id join dbo.make as ma on c.makeId = ma.id left join dbo.model as mo on c.modelId = mo.id left join dbo.kbb_data as k on mo.kbb_dataId = k.id left join dbo.car_spec as s on mo.car_specId = s.id where l.carId != 2;",
            function (err, records) {

                if (err) console.log(err)

                // Send records as a response
                // to browser

                res.send(records.recordsets);

            });
    });
});
