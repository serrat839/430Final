-- Basic Select Query to get the listing info

SELECT 
	l.[id] as 'listId', 
	l.[price], 
	l.[url], 
	l.[date], 
	l.odometer, 
	l.condition, 
	lo.[location], 
	lo.[url] as 'locUrl', 
	lo.id as 'locId', 
	l.alias, l.carId,  
	ma.id as 'makeId',
	mo.id as 'modelId',
	mo.name as 'Model',
	mo.year as 'year' 
FROM 
	dbo.listing as l 
join
	dbo.picture as p 
on 
	l.id = p.listingId 
left join
	dbo.[location] as lo 
on	
		l.locationId = lo.id 
left join
	dbo.car as c 
on 
	l.carId = c.id 
join 
	dbo.make as ma 
on 
	c.makeId = ma.id 
left join 
	dbo.model as mo 
on 
	c.modelId = mo.id 
where 
	l.carId != 2;


-- /listingCard
-- Basic Select Query to get the listing info

SELECT 
	l.[id] as 'listId',
	l.[price], 
	l.[date], 
	l.condition, 
	lo.id as 'locId', 
	ma.id as 'makeId', 
	mo.id as 'modelId', 
	mo.year as 'year' 
FROM 
	dbo.listing as l 
left join 
	dbo.[location] as lo
on 
	l.locationId = lo.id 
left join 
	dbo.car as c 
on
	l.carId = c.id 
join 
	dbo.make as ma 
on
	c.makeId = ma.id 
left join 
	dbo.model as mo 
on
	c.modelId = mo.id 
where
	l.carId != 2;,

--'/listing/:id'
-- Select Query for listing information on a specific listingId
-- req.params['id'] is for api to know which value is getting filtered
Select 
	li.[id], 
	li.[price], 
	li.[url], 
	li.[date],
	li.odometer, 
	li.condition, 
	lo.[location], 
	ma.[name] as 'make', 
	mo.[name] as 'model' 
from 
	[dbo].[listing] as li 
left join 
	[dbo].[car] as ca 
on 
	li.carId = ca.id 
left join 
	[dbo].[make] as ma 
on 
	ca.makeId = ma.id
left join 
	[dbo].[model] as mo 
on 
	ca.modelId = mo.id 
left join
	[dbo].[location] as lo 
on  
	li.locationId = lo.id 
where 
	li.[id]= + req.params['id'];

-- /modalCar/:id
-- Select query for listing information of a specfic car for a listing to fill up modal

select 
	li.id as 'listId', 
	li.price, li.url, 
	li.date, li.odometer, 
	li.condition, 
	lo.location, 
	ma.name as 'make', 
	mo.name as 'model', 
	mo.year as 'year', 
	picture.[filename] , 
	kb.id as 'kbbId', 
	kb.pros, 
	kb.cons,
	kb.new, 
	kb.review,
	kb.startingPrice ,
	cs.* 
from 
	[dbo].[listing] as li 
left join 
	[dbo].[car] as ca 
on 
	li.carId = ca.id 
left join 
	[dbo].[model] as mo 
on 
	ca.modelId = mo.id 
left join 
	[dbo].[make] as ma 
on 
	ca.makeId = ma.id 
left join 
	[dbo].[car_spec] as cs 
on
	mo.car_specId = cs.id 
left join 
	[dbo].[kbb_data] as kb 
on
	mo.kbb_dataId = kb.id 
left join 
	[dbo].[location] as lo
on 
	li.locationId = lo.id
left join
	[dbo].picture 
on 
	li.id = picture.listingId
where 
	li.id = +req.params['id']

-- /location
-- Select query to get all locations and their data

select 
	* 
from 
	[dbo].[location]

-- /makeAndModel
-- Select query to get all distinct make and models availible in the listing

select 
DISTINCT 
	mo.name as 'model', 
	mo.year as 'modelYear', 
	ma.name as 'make', 
	ma.id as 'makeId', 
	mo.id as 'modelId', 
	ca.id as 'carId' 
from 
	[dbo].[listing] as li 
left join 
	[dbo].[car] as ca 
on
	li.carId = ca.id 
left join 
	[dbo].[model] as mo 
on 
	ca.modelId = mo.Id
left join 
	[dbo].[make] as ma
on 
	ca.makeId = ma.Id 
where 
	ma.[name] != 'UNKNOWN';

-- /car/:id
-- Select Query to get car with a sepcfic id
select 
	* 
from 
	[dbo].[car] 
where 
	id =" + req.params['id']