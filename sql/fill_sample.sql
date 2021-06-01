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
INSERT INTO 
	dbo.make ([name]) 
VALUES 
	('Volkswagen'),('Mini'),('Land Rover'),('Daimler'),('Jaguar'),('Jeep'),('Zenvo'),
	('Pontiac'),('Saab'),('Matra-Simca'),('Porsche'),('Kia'),('Nissan'),('Lexus'),
	('Jensen'),('Seat'),('Samsung'),('Isuzu'),('SSC'),('Noble'),('GMC'),('Lancia'),
	('Dodge'),('Suzuki'),('Avanti'),('Mazda'),('Renault'),('Caterham'),('Daihatsu'),
	('Ford'),('Smart'),('Spyker'),('Luxgen'),('Holden'),('Mercedes-Benz'),('Plymouth'),
	('Opel'),('Subaru'),('Audi'),('Studebaker'),('Ascari'),('MG'),('Xedos'),('Mahindra'),
	('Saturn'),('Mitsubishi'),('Dacia'),('Venturi'),('TVR'),('Beijing'),('Acura'),('Proton'),
	('Lamborghini'),('Rolls-Royce'),('Lotus'),('De Tomaso'),('Honda'),('Vector'),('Lotec'),
	('Marcos'),('Geely'),('Eagle'),('Citroen'),('Maserati'),('Rover'),('Lincoln'),('Ginetta'),
	('Mercury'),('Chevrolet'),('Cadillac'),('Fisker'),('Maybach'),('Infiniti'),('Hummer'),
	('Hyundai'),('Riley'),('Scion'),('Italdesign'),('Aston Martin'),('Zastava'),('Bristol'),
	('Vauxhall'),('Brilliance'),('Steyr'),('Tata'),('ZAZ'),('Tesla'),('Pininfarina'),('Oldsmobile'),
	('Koenigsegg'),('Chrysler'),('Fiat'),('Donkervoort'),('Ferrari'),('Alpina'),('AC'),('Panoz'),
	('Morgan'),('Skoda'),('Lada'),('Ariel'),('McLaren'),('Volvo'),('Bugatti'),('Westfield'),('BMW'),
	('Bentley'),('Bizzarrini'),('Saleen'),('Alfa Romeo'),('Buick'),('Peugeot'),('Pagani'),('SsangYong'),
	('Daewoo'),('GAZ'),('Toyota'),('MCC')
;

-- fill listing table
INSERT INTO 
	dbo.listing (price, odometer, url, condition, date, locationId, carId)
VALUES 
	(
	6000,
	201211,
	'https://kpr.craigslist.org/cto/d/richland-2011-chevrolet-equinox/7326065096.html',
	'like new',
	'05/23/2021',
	2,
	5
	),
	(
	4000,
	215000,
	'https://kpr.craigslist.org/cto/d/kennewick-2007-acura-mdx-sport-utility/7326141765.html',
	'good',
	'05/23/2021',
	2,
	3
	), 
	(
	8200,
	000,
	'https://kpr.craigslist.org/cto/d/college-place-cj7/7326079362.html',
	'fair',
	'05/23/2021',
	2,
	4
	);

-- fill image table
INSERT INTO 
	dbo.picture (listingId, [filename])
VALUES
	(1,'1.jpg'), (1,'2.jpg'),
	(1,'3.jpg'), (1,'4.jpg'),
	(1,'5.jpg'), (1,'6.jpg'),
	(1,'7.jpg'), (1,'8.jpg'),
	(1,'9.jpg'), (2,'10.jpg'),
	(2,'11.jpg'), (2,'12.jpg'),
	(2,'13.jpg'), (2,'14.jpg'),
	(3,'15.jpg'), (3,'16.jpg'),
	(3,'17.jpg'), (3,'18.jpg'),
	(3,'19.jpg'), (3,'20.jpg'),
	(3,'21.jpg'), (3,'22.jpg')