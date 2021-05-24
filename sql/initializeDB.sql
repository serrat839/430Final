-- schema for creating my database lol
-- --------------------------------------------------------------------------------------------------
-- IMPORTANT NOTE!
-- tables will be using snake case
-- bridge tables will be noted using [t1-t2] as their name
-- columns will use column case 
-- FK will use the tablename + Id for their names
-- Now that we are here, how is your week going? :)?
-- ---------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS [listing];
DROP TABLE IF EXISTS [car];
DROP TABLE IF EXISTS [make];
DROP TABLE IF EXISTS [model];
DROP TABLE IF EXISTS [user-listing]
DROP TABLE IF EXISTS [user];
DROP TABLE IF EXISTS [location];
DROP TABLE IF EXISTS [car_spec];
DROP TABLE IF EXISTS [kbb_data];
DROP TABLE IF EXISTS [picture];

-- create table "user" that governs users
CREATE TABLE [user](
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[username] VARCHAR (252) NOT NULL,
	[password] VARCHAR(252) NOT NULL
	)

-- create location table
CREATE TABLE [location](
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[location] VARCHAR (252) NOT NULL,
	[url] VARCHAR(252) NOT NULL
	)

-- create car spec table
CREATE TABLE [car_spec] (
	[id] INT PRIMARY KEY IDENTITY (1,1),
	[originCountry] VARCHAR(30),
	[usSale] BIT,
	[bodyStyle] VARCHAR(30),
	[exteriorColors] VARCHAR(MAX),
	[interiorColors] VARCHAR(MAX),
	[engineLocation] VARCHAR(30),
	[engineType] VARCHAR(20),
	[engineCylinders] INT,
	[engineDisplacement(cc)] INT, 
	[engineDisplacement(I)] DECIMAL (3,2),
	[engineDisplacement(cubicIn)] INT,
	[engineBore(mm)] INT,
	[engineBore(in)] INT,
	[engineStroke(mm)] INT,
	[engineStroke(in)] INT,
	[valvePerCylinder] INT,
	[maxPower(hp)] INT,
	[maxPower(ps)] INT,
	[maxPower(kW)] INT,
	[maxPower(rpm)] INT,
	[maxTorque(Nm)] INT,
	[maxTorque(Lb-ft)] INT,
	[maxTorque(kgf-m)] INT,
	[maxTorque(rpm)] INT,
	[engineCompressionRatio] DECIMAL (3, 2),
	[engineFuelType] VARCHAR(30),
	[drive] VARCHAR(30),
	[transmission] VARCHAR(30),
	[topSpeed(mph)] INT, 
	[zeroToSixtytwoMPH] DECIMAL (3, 2),
	[doors] INT,
	[seats] INT,
	[weight(kg)] INT,
	[weight(lbs)] INT, 
	[length(mm)] DECIMAL (4, 2),
	[length(in)] DECIMAL (4, 2),
	[width(mm)] DECIMAL (4, 2),
	[width(in)] DECIMAL (4, 2),
	[height(mm)] DECIMAL (4, 2),
	[height(in)] DECIMAL (4, 2),
	[wheelbase(mm)] DECIMAL (4, 2),
	[wheelbase(in)] DECIMAL (4, 2),
	[fuelEconomyCity(L/100km)] DECIMAL (3, 2),
	[fuelEconomyCity(mpg)] INT,
	[fuelEconomyHWY(L/100km)] DECIMAL (3,2),
	[fuelEconomyHWY(mpg)] INT,
	[fuelEconomyMixed(L/100km)] DECIMAL(3,2),
	[fuelEconomyMixed(mpg)] INT,
	[fuelCapacity(L)] DECIMAL(3,2),
	[fuelCapacity(g)] DECIMAL(3,2)
)

-- create kbb data table
CREATE TABLE [kbb_data] (
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[pros] VARCHAR(MAX) NOT NULL,
	[cons] VARCHAR(MAX) NOT NULL,
	[new] VARCHAR(MAX) NOT NULL,
	[review] VARCHAR(MAX) NOT NULL,
	[startingPrice] DECIMAL (6,2) NOT NULL
)
-- create model table
CREATE TABLE [model] (
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[year] INT NOT NULL,
	[name] VARCHAR(252),
	[kbb_dataId] INT,
	[car_specId] INT,
	CONSTRAINT [modelToKbb_data]
		FOREIGN KEY ([kbb_dataId])
		REFERENCES [kbb_data](id),
	CONSTRAINT [modelTocar_spec]
		FOREIGN KEY ([car_specId])
		REFERENCES [car_spec](id)
)

-- create make table
CREATE TABLE [make] (
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[name] VARCHAR(252) NOT NULL,
	CONSTRAINT uniqueMake UNIQUE([name])
)
-- create car table
CREATE TABLE [car] (
	[id] INT PRIMARY KEY IDENTITY (1,1),
	[makeId] INT NOT NULL,
	[modelId] INT NOT NULL,
	CONSTRAINT [carToMake]
		FOREIGN KEY ([makeId])
		REFERENCES [make](id),
	CONSTRAINT [carToModel]
		FOREIGN KEY ([modelId])
		REFERENCES [model](id)
)

-- create listing table 
CREATE TABLE [listing] (
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[price] DECIMAL(6, 2) NOT NULL, -- no car is on craigslist for 1M dollars i swear
	[url] VARCHAR(252) NOT NULL,
	[date] DATE NOT NULL,
	[odometer] INT,
	[condition] VARCHAR(252),
	[locationId] INT NOT NULL,
	[carId] INT NOT NULL,
	CONSTRAINT [listingToLocation]
		FOREIGN KEY ([locationId])
		REFERENCES [location](id),
	CONSTRAINT [listingToCar]
		FOREIGN KEY ([carId])
		REFERENCES [car](id)
)

CREATE TABLE [user-listing] (
	[userId] INT,
	[listingId] INT,
	PRIMARY KEY ([userId], [listingId]),
	CONSTRAINT [user-listingToUser]
		FOREIGN KEY ([userId])
		REFERENCES [user](id),
	CONSTRAINT [user-listingToListing]
		FOREIGN KEY ([listingId])
		REFERENCES [listing](id)
)

-- create picture table
CREATE TABLE [picture](
	[id] INT PRIMARY KEY IDENTITY(1,1),
	[listingId] INT NOT NULL,
	CONSTRAINT [pictureToListing] 
		FOREIGN KEY ([listingId])
		REFERENCES [listing](id)
	)