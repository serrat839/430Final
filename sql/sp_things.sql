-- TO CLEAN OUT PROCS
DROP PROCEDURE sp_kbb_data;
DROP PROCEDURE sp_make;  
DROP PROCEDURE sp_car_spec; 
DROP PROCEDURE sp_model;   
DROP PROCEDURE sp_new_car;  

GO

-- SP to insert kbb data
CREATE PROCEDURE sp_kbb_data(
	--KBB DATA
	@Pros VARCHAR(MAX),
	@Cons VARCHAR(MAX),
	@StartingPrice DECIMAL(6,2),
	@Review VARCHAR(MAX),
	@New VARCHAR(MAX)
)
AS
BEGIN TRAN KBB_DATA
	INSERT INTO
		dbo.kbb_data (pros, cons, new, review, startingPrice)
	VALUES
		(@Pros, @Cons, @New, @Review, @StartingPrice)
IF @@ERROR <> 0
	ROLLBACK TRAN KBB_DATA
ELSE
	COMMIT TRAN KBB_DATA

GO

-- SP to insert make data
CREATE PROCEDURE sp_make(
	--KBB DATA
	@Make VARCHAR(252)
)
AS
BEGIN TRAN MAKE_DATA
	INSERT INTO
		dbo.make ([name])
	VALUES
		(@Make)
IF @@ERROR <> 0
	ROLLBACK TRAN MAKE_DATA
ELSE
	COMMIT TRAN MAKE_DATA
GO

-- SP to insert car spec data
CREATE PROCEDURE sp_car_spec (
	-- car specs, buckle up buster.
	@OriginCountry VARCHAR(30) = Null,
	@usSale BIT = Null,
	@bodyStyle VARCHAR(30) = Null,
	@exteriorColors VARCHAR(MAX) = Null,
	@interiorColors VARCHAR(MAX) = Null,
	@engineLocation VARCHAR(30) = Null,
	@engineType VARCHAR(20) = Null,
	@engineCylinders INT = Null,
	@engineDisplacement_cc INT = Null, 
	@engineDisplacement_I DECIMAL (3,2) = Null,
	@engineDisplacement_cubicIn INT = Null,
	@engineBore_mm INT = Null,
	@engineBore_in INT = Null,
	@engineStroke_mm INT = Null,
	@engineStroke_in INT = Null,
	@valvePerCylinder INT = Null,
	@maxPower_hp INT = Null,
	@maxPower_ps INT = Null,
	@maxPower_kW INT = Null,
	@maxPower_rpm INT = Null,
	@maxTorque_Nm INT = Null,
	@maxTorque_Lb_ft INT = Null,
	@maxTorque_kgf_m INT = Null,
	@maxTorque_rpm INT = Null,
	@engineCompressionRatio DECIMAL(3, 2) = Null,
	@engineFuelType VARCHAR(30) = Null,
	@drive VARCHAR(30) = Null,
	@transmission VARCHAR(30) = Null,
	@topSpeed_mph INT = Null, 
	@zeroToSixtytwoMPH DECIMAL(3, 2) = Null,
	@doors INT = Null,
	@seats INT = Null,
	@weight_kg INT = Null,
	@weight_lbs INT = Null, 
	@length_mm DECIMAL (4, 2) = Null,
	@length_in DECIMAL (4, 2) = Null,
	@width_mm DECIMAL (4, 2) = Null,
	@width_in DECIMAL (4, 2) = Null,
	@height_mm DECIMAL (4, 2) = Null,
	@height_in DECIMAL (4, 2) = Null,
	@wheelbase_mm DECIMAL (4, 2) = Null,
	@wheelbase_in DECIMAL (4, 2) = Null,
	@fuelEconomyCity_L_100km DECIMAL (3, 2) = Null,
	@fuelEconomyCity_mpg INT = Null,
	@fuelEconomyHWY_L_100km DECIMAL (3,2) = Null,
	@fuelEconomyHWY_mpg INT = Null,
	@fuelEconomyMixed_L_100km DECIMAL(3,2) = Null,
	@fuelEconomyMixed_mpg INT = Null,
	@fuelCapacity_L DECIMAL(3,2) = Null,
	@fuelCapacity_g DECIMAL(3,2) = Null
	)
AS
BEGIN TRAN SPEC_DATA
	INSERT INTO
		davidsList.dbo.car_spec (
		originCountry, usSale, bodyStyle, exteriorColors, interiorColors, engineLocation, 
		engineType, engineCylinders, [engineDisplacement(cc)], [engineDisplacement(I)], [engineDisplacement(cubicIn)],
		[engineBore(mm)], [engineBore(in)], [engineStroke(mm)], [engineStroke(in)],
		valvePerCylinder,
		[maxPower(hp)], [maxPower(ps)], [maxPower(kW)], [maxPower(rpm)],
		[maxTorque(Nm)], [maxTorque(Lb-ft)], [maxTorque(kgf-m)], [maxTorque(rpm)], 
		engineCompressionRatio, engineFuelType, drive, transmission, [topSpeed(mph)], zeroToSixtytwoMPH,
		doors, seats, 
		[weight(kg)], [weight(lbs)], 
		[length(mm)], [length(in)],
		[width(mm)], [width(in)],
		[height(mm)], [height(in)],
		[wheelbase(mm)], [wheelbase(in)],
		[fuelEconomyCity(L/100km)], [fuelEconomyCity(mpg)],
		[fuelEconomyHWY(L/100km)], [fuelEconomyHWY(mpg)],
		[fuelEconomyMixed(L/100km)], [fuelEconomyMixed(mpg)],
		[fuelCapacity(L)], [fuelCapacity(g)]
		)
	VALUES
		(
		@OriginCountry, @usSale, @bodyStyle, @exteriorColors, @interiorColors,
		@engineLocation, @engineType, @engineCylinders, @engineDisplacement_cc, @engineDisplacement_I,
		@engineDisplacement_cubicIn, @engineBore_mm, @engineBore_in, @engineStroke_mm, @engineStroke_in,
		@valvePerCylinder, @maxPower_hp, @maxPower_ps, @maxPower_kW, @maxPower_rpm, 
		@maxTorque_Nm, @maxTorque_Lb_ft, @maxTorque_kgf_m, @maxTorque_rpm, @engineCompressionRatio,
		@engineFuelType, @drive, @transmission, @topSpeed_mph, @zeroToSixtytwoMPH,
		@doors, @seats, @weight_kg, @weight_lbs, @length_mm,
		@length_in, @width_mm, @width_in, @height_mm, @height_in,
		@wheelbase_mm, @wheelbase_in, @fuelEconomyCity_L_100km, @fuelEconomyCity_mpg, @fuelEconomyHWY_L_100km,
		@fuelEconomyHWY_mpg, @fuelEconomyMixed_L_100km, @fuelEconomyMixed_mpg, @fuelCapacity_L, @fuelCapacity_g
		)
IF @@ERROR <> 0
	ROLLBACK TRAN SPEC_DATA
ELSE
	COMMIT TRAN SPEC_DATA
GO

-- sp to genereate a new model
CREATE PROCEDURE sp_model(
	@spec INT,
	@kbb INT,
	@year INT,
	@name VARCHAR(252)
)
AS 
BEGIN TRAN MODEL
	INSERT INTO 
		davidsList.dbo.model ([year], [name], kbb_dataId, car_specId)
	VALUES 
		(@year, @name, @kbb, @spec)
IF @@ERROR<>0
	ROLLBACK TRAN MODEL
ELSE 
	COMMIT TRAN MODEL
GO

-- SP to generate a new car
CREATE PROCEDURE sp_new_car (

	--KBB DATA
	@Pros VARCHAR(MAX),
	@Cons VARCHAR(MAX),
	@StartingPrice DECIMAL(6,2),
	@Review VARCHAR(MAX),
	@New VARCHAR(MAX),
	
	-- car specs, buckle up buster.
	@OriginCountry VARCHAR(30) = Null,
	@usSale BIT = Null,
	@bodyStyle VARCHAR(30) = Null,
	@exteriorColors VARCHAR(MAX) = Null,
	@interiorColors VARCHAR(MAX) = Null,
	@engineLocation VARCHAR(30) = Null,
	@engineType VARCHAR(20) = Null,
	@engineCylinders INT = Null,
	@engineDisplacement_cc INT = Null, 
	@engineDisplacement_I DECIMAL (3,2) = Null,
	@engineDisplacement_cubicIn INT = Null,
	@engineBore_mm INT = Null,
	@engineBore_in INT = Null,
	@engineStroke_mm INT = Null,
	@engineStroke_in INT = Null,
	@valvePerCylinder INT = Null,
	@maxPower_hp INT = Null,
	@maxPower_ps INT = Null,
	@maxPower_kW INT = Null,
	@maxPower_rpm INT = Null,
	@maxTorque_Nm INT = Null,
	@maxTorque_Lb_ft INT = Null,
	@maxTorque_kgf_m INT = Null,
	@maxTorque_rpm INT = Null,
	@engineCompressionRatio DECIMAL(3, 2) = Null,
	@engineFuelType VARCHAR(30) = Null,
	@drive VARCHAR(30) = Null,
	@transmission VARCHAR(30) = Null,
	@topSpeed_mph INT = Null, 
	@zeroToSixtytwoMPH DECIMAL(3, 2) = Null,
	@doors INT = Null,
	@seats INT = Null,
	@weight_kg INT = Null,
	@weight_lbs INT = Null, 
	@length_mm DECIMAL (4, 2) = Null,
	@length_in DECIMAL (4, 2) = Null,
	@width_mm DECIMAL (4, 2) = Null,
	@width_in DECIMAL (4, 2) = Null,
	@height_mm DECIMAL (4, 2) = Null,
	@height_in DECIMAL (4, 2) = Null,
	@wheelbase_mm DECIMAL (4, 2) = Null,
	@wheelbase_in DECIMAL (4, 2) = Null,
	@fuelEconomyCity_L_100km DECIMAL (3, 2) = Null,
	@fuelEconomyCity_mpg INT = Null,
	@fuelEconomyHWY_L_100km DECIMAL (3,2) = Null,
	@fuelEconomyHWY_mpg INT = Null,
	@fuelEconomyMixed_L_100km DECIMAL(3,2) = Null,
	@fuelEconomyMixed_mpg INT = Null,
	@fuelCapacity_L DECIMAL(3,2) = Null,
	@fuelCapacity_g DECIMAL(3,2) = Null,

	-- model vars
	@ModelYear INT,
	@ModelName VARCHAR(252),
	@Make VARCHAR(252)
	)

AS 
BEGIN TRY
    BEGIN TRANSACTION
		DECLARE
			@RowKBB INT, 
			@RowSpecs INT,
			@RowModel INT,
			@RowMake INT

		-- get the make's index
		SET @RowMake = (SELECT TOP(1) id FROM davidsList.dbo.make as make_tbl WHERE make_tbl.[name] = @Make)
		-- IF @rowMake is null do something to fill it ig
		
		-- get the kbb data's index after insertion
		EXEC sp_kbb_data @Pros = @Pros, @Cons = @Cons, @StartingPrice = @StartingPrice, @Review = @Review, @New = @New
		SET @RowKBB = (SELECT @@IDENTITY as 'Scope ID')

		-- get the car spec's data after insertion
		EXEC sp_car_spec @OriginCountry=@OriginCountry,
						 @usSale=@usSale,
						 @bodyStyle=@bodyStyle,
						 @exteriorColors=@exteriorColors,
						 @interiorColors=@interiorColors,
						 @engineLocation=@engineLocation,
						 @engineType=@engineType,
						 @engineCylinders=@engineCylinders,
						 @engineDisplacement_cc=@engineDisplacement_cc,
						 @engineDisplacement_I=@engineDisplacement_I,
						 @engineDisplacement_cubicIn=@engineDisplacement_cubicIn,
						 @engineBore_mm=@engineBore_mm,
						 @engineBore_in=@engineBore_in,
						 @engineStroke_mm=@engineStroke_mm,
						 @engineStroke_in=@engineStroke_in,
						 @valvePerCylinder=@valvePerCylinder,
						 @maxPower_hp=@maxPower_hp,
						 @maxPower_ps=@maxPower_ps,
						 @maxPower_kW=@maxPower_kW,
						 @maxPower_rpm=@maxPower_rpm,
						 @maxTorque_Nm=@maxTorque_Nm,
						 @maxTorque_Lb_ft=@maxTorque_Lb_ft,
						 @maxTorque_kgf_m=@maxTorque_kgf_m,
						 @maxTorque_rpm=@maxTorque_rpm,
						 @engineCompressionRatio=@engineCompressionRatio,
						 @engineFuelType=@engineFuelType,
						 @drive=@drive,
						 @transmission=@transmission,
						 @topSpeed_mph=@topSpeed_mph,
						 @zeroToSixtytwoMPH=@zeroToSixtytwoMPH,
						 @doors=@doors,
						 @seats=@seats,
						 @weight_kg=@weight_kg,
						 @weight_lbs=@weight_lbs,
						 @length_mm=@length_mm,
						 @length_in=@length_in,
						 @width_mm=@width_mm,
						 @width_in=@width_in,
						 @height_mm=@height_mm,
						 @height_in=@height_in,
						 @wheelbase_mm=@wheelbase_mm,
						 @wheelbase_in=@wheelbase_in,
						 @fuelEconomyCity_L_100km=@fuelEconomyCity_L_100km,
						 @fuelEconomyCity_mpg=@fuelEconomyCity_mpg,
						 @fuelEconomyHWY_L_100km=@fuelEconomyHWY_L_100km,
						 @fuelEconomyHWY_mpg=@fuelEconomyHWY_mpg,
						 @fuelEconomyMixed_L_100km=@fuelEconomyMixed_L_100km,
						 @fuelEconomyMixed_mpg=@fuelEconomyMixed_mpg,
						 @fuelCapacity_L=@fuelCapacity_L,
						 @fuelCapacity_g=@fuelCapacity_g
			SET @RowSpecs = (SELECT @@IDENTITY as 'Scope ID')
			print @RowSpecs
			EXEC sp_model @spec=@RowSpecs, @kbb=@RowKBB, @year=@ModelYear, @name = @ModelName
			SET @RowModel = (SELECT @@IDENTITY as 'Scope ID')

			PRINT 'HERE'
			PRINT @RowModel
			PRINT @RowMake
			INSERT INTO 
				davidsList.dbo.car (makeId, modelId)
			VALUES 
				(@RowMake, @RowModel);


    --Do some other activity
	
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
    --IF an error occurs then rollback the current transaction, which includes the stored procedure code.
    ROLLBACK TRANSACTION

END CATCH
GO

EXEC sp_new_car @Pros='test',
@Cons='test',
@StartingPrice=1.2,
@Review='test',
@New='test',
@OriginCountry='test',
@usSale=1,
@bodyStyle='test',
@exteriorColors='test',
@interiorColors='test',
@engineLocation='test',
@engineType='test',
@engineCylinders=1,
@engineDisplacement_cc=1,
@engineDisplacement_I=1.2,
@engineDisplacement_cubicIn=1,
@engineBore_mm=1,
@engineBore_in=1,
@engineStroke_mm=1,
@engineStroke_in=1,
@valvePerCylinder=1,
@maxPower_hp=1,
@maxPower_ps=1,
@maxPower_kW=1,
@maxPower_rpm=1,
@maxTorque_Nm=1,
@maxTorque_Lb_ft=1,
@maxTorque_kgf_m=1,
@maxTorque_rpm=1,
@engineCompressionRatio=1.2,
@engineFuelType='test',
@drive='test',
@transmission='test',
@topSpeed_mph=1,
@zeroToSixtytwoMPH=1.2,
@doors=1,
@seats=1,
@weight_kg=1,
@weight_lbs=1,
@length_mm=1.2,
@length_in=1.2,
@width_mm=1.2,
@width_in=1.2,
@height_mm=1.2,
@height_in=1.2,
@wheelbase_mm=1.2,
@wheelbase_in=1.2,
@fuelEconomyCity_L_100km=1.2,
@fuelEconomyCity_mpg=1,
@fuelEconomyHWY_L_100km=1.2,
@fuelEconomyHWY_mpg=1,
@fuelEconomyMixed_L_100km=1.2,
@fuelEconomyMixed_mpg=1,
@fuelCapacity_L=1.2,
@fuelCapacity_g=1.2,
@ModelYear=1,
@ModelName='test',
@Make='test'