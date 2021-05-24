-- fill locations table
INSERT INTO 
	dbo.location (location, url)
VALUES
	('Bellingham', 'https://bellingham.craigslist.org/'),
	('Kennewick, Pasco, Richland', 'https://kpr.craigslist.org/'),
	('Lewiston', 'https://lewiston.craigslist.org/'),
	('Moses Lake', 'https://moseslake.craigslist.org/'),
	('Olympia', 'https://olympic.craigslist.org/'),
	('Pullman', 'https://pullman.craigslist.org/'),
	('Skagit', 'https://skagit.craigslist.org/'),
	('Spokane', 'https://spokane.craigslist.org/'),
	('Wenatchee', 'https://wenatchee.craigslist.org/'),
	('Yakima', 'https://yakima.craigslist.org/')
;
SELECT * FROM dbo.location;

-- fill make table
INSERT INTO 
	dbo.make ([name])
VALUES
	('test')
;
-- should fill with all possible makes

-- fill kbb data table 


-- fill listing table
INSERT INTO 
	dbo.listing (id, price, odometer, url, condition, date, locationId, carId)
VALUES 
	(1,
	2200,
	203000,
	'https://kpr.craigslist.org/cto/d/eltopia-2009-chevy-traverse-ls/7325713616.html',
	'good',
	'05/22/2021',
	2,
	1);
