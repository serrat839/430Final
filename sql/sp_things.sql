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
	@StartingPrice DECIMAL(10,2),
	@Review VARCHAR(MAX),
	@New VARCHAR(MAX)
)
AS
BEGIN TRAN KBB_DATA
	INSERT INTO
		davidsList.dbo.kbb_data (pros, cons, new, review, startingPrice)
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
		davidsList.dbo.make ([name])
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
	@engineDisplacement_I DECIMAL (7,2) = Null,
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
	@engineCompressionRatio DECIMAL(7, 2) = Null,
	@engineFuelType VARCHAR(30) = Null,
	@drive VARCHAR(30) = Null,
	@transmission VARCHAR(30) = Null,
	@topSpeed_mph INT = Null, 
	@zeroToSixtytwoMPH DECIMAL(7, 2) = Null,
	@doors INT = Null,
	@seats INT = Null,
	@weight_kg INT = Null,
	@weight_lbs INT = Null, 
	@length_mm DECIMAL (7, 2) = Null,
	@length_in DECIMAL (7, 2) = Null,
	@width_mm DECIMAL (7, 2) = Null,
	@width_in DECIMAL (7, 2) = Null,
	@height_mm DECIMAL (7, 2) = Null,
	@height_in DECIMAL (7, 2) = Null,
	@wheelbase_mm DECIMAL (7, 2) = Null,
	@wheelbase_in DECIMAL (7, 2) = Null,
	@fuelEconomyCity_L_100km DECIMAL (7, 2) = Null,
	@fuelEconomyCity_mpg INT = Null,
	@fuelEconomyHWY_L_100km DECIMAL (7,2) = Null,
	@fuelEconomyHWY_mpg INT = Null,
	@fuelEconomyMixed_L_100km DECIMAL(7,2) = Null,
	@fuelEconomyMixed_mpg INT = Null,
	@fuelCapacity_L DECIMAL(7,2) = Null,
	@fuelCapacity_g DECIMAL(7,2) = Null
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
	@StartingPrice DECIMAL(10,2),
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
	@engineDisplacement_I DECIMAL (7,2) = Null,
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
	@engineCompressionRatio DECIMAL(7, 2) = Null,
	@engineFuelType VARCHAR(30) = Null,
	@drive VARCHAR(30) = Null,
	@transmission VARCHAR(30) = Null,
	@topSpeed_mph INT = Null, 
	@zeroToSixtytwoMPH DECIMAL(7, 2) = Null,
	@doors INT = Null,
	@seats INT = Null,
	@weight_kg INT = Null,
	@weight_lbs INT = Null, 
	@length_mm DECIMAL (7, 2) = Null,
	@length_in DECIMAL (7, 2) = Null,
	@width_mm DECIMAL (7, 2) = Null,
	@width_in DECIMAL (7, 2) = Null,
	@height_mm DECIMAL (7, 2) = Null,
	@height_in DECIMAL (7, 2) = Null,
	@wheelbase_mm DECIMAL (7, 2) = Null,
	@wheelbase_in DECIMAL (7, 2) = Null,
	@fuelEconomyCity_L_100km DECIMAL (7, 2) = Null,
	@fuelEconomyCity_mpg INT = Null,
	@fuelEconomyHWY_L_100km DECIMAL (7,2) = Null,
	@fuelEconomyHWY_mpg INT = Null,
	@fuelEconomyMixed_L_100km DECIMAL(7,2) = Null,
	@fuelEconomyMixed_mpg INT = Null,
	@fuelCapacity_L DECIMAL(7,2) = Null,
	@fuelCapacity_g DECIMAL(7,2) = Null,

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
@doors=null,
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
go

EXEC sp_new_car @Pros='Pros
2020 Best Buy Award winner for subcompact luxury SUVs
Impressive technology
Roomy interior for its size
Standard all-wheel drive
Stylish & sporty',
@Cons='Cons
Transmission can feel jumpy
No hybrid or performance variants
Adaptive cruise control still costs extra',
@StartingPrice=36000.00,
@Review='The Q3 was totally revamped just two years ago. This 2nd-generation Q3 brings bolder design, innovative technology, and excellent fit and finish. Last year’s model impressed us so much that we named it our Best Buy Award winner in a segment that includes formidable rivals like the Mercedes-Benz GLA, BMW X1, and Volvo XC40.
The Q3 stands out with its standard quattro all-wheel-drive system and a long list of included features such as leather interior and a panoramic sunroof. Unlike rivals, only one powertrain is offered in the Q3, and we found its transmission in need of more refinement. But there’s good power on tap. Cargo space isn’t quite as generous as that of the boxy Volvo’s but considerable nonetheless for a subcompact SUV.Driving the  2021 Audi Q3The latest generation of the Audi Q3 is now in a much better position to compete with its rivals thanks to its handsome style, a spacious interior, and a wide array of technology features. While this Audi isn’t as sporty as other models in the company’s lineup, it proved an entertaining vehicle on twisty roads.
The biggest shortcoming we found in driving the new Q3 is its transmission programming: Shifts from the small SUV’s 8-speed automatic are somewhat jumpy when accelerating at lower speeds. Putting the vehicle into Dynamic mode does help smooth things out. Once you get past that initial jumpiness, power delivery is good. The Q3 wrings 228 horsepower from its turbocharged 2.0-liter 4-cylinder. That is enough to scoot the Q3 from 0-60 mph in seven seconds flat. That won’t blow your socks off, but it’s plenty quick enough to merge onto freeways without drama.
We also like that despite its small size, the Q3 feels at home on open roads. Steering response is light and accurate, and Audi has done an admirable job of balancing performance and comfort. The Q3’s interior looks like it was pulled from a much more expensive Audi, making the drive that much nicer. This isn’t a vehicle that’s about hard-core performance; it’s about the overall experience.
Favorite FeaturesGORGEOUS, FUNCTIONAL INTERIOR
Tall passengers will find the 2021 Audi Q3’s rear seating rather accommodating without infringing on cargo space. From the quality materials and stunning design to the integration of such high-tech features as a 10.1-inch touch screen and digital instrument cluster, the Q3 looks the part of a luxury SUV.
TECH POWERHOUSE
Along with the aforementioned features, Audi’s Q3 also comes with both Type A and C USB ports, Audi Pre Sense collision warning and preparation, plus Apple CarPlay and Android Auto. Optional are Audi’s brilliant Virtual Cockpit – an all-digital instrument cluster – top-view camera, and superb Bang & Olufsen audio system.
 2021 Audi Q3 InteriorWith this latest Q3, Audi took an already attractive interior and made it better. Its high-quality materials and sharp, modern design give the Q3’s cabin the look and feel of an interior that’s a class above. Front and rear seats are respectably roomy given that this is a subcompact crossover. The second row slides forward and back for added space. Cargo space is also good, with 23.7 cubic feet behind the rear seat and 48 cubic feet with them folded. That does trail the 57.5 cubic feet of space in the more angular Volvo XC40.
Up front, the Audi Q3’s center stack has an 8.8-inch or optional 10.1-inch screen that controls infotainment, with heat/vent/air-conditioning (HVAC) controls below. Nestled underneath those hard buttons is an available wireless smartphone charger, which worked with an iPhone 8+ without having to take it out of its case. The Q3 comes with a digital gauge cluster. Even better is the optional Audi Virtual Cockpit fully digital instrument cluster that can be configured to relay audio info, satellite maps, and more.
Unlike rivals, the Q3 comes standard with leather upholstery. In addition to the usual black or beige, we are fans of the Okapi Brown. The new Black optic package also offers a choice of black or gray sport seats with contrast stitching.
 2021 Audi Q3 ExteriorThis 2nd-gen version of the Q3 has a handsome, more mature design. It now looks less like a raised hatchback and more like a smaller-scale Audi Q5 SUV.
Details we like include its classy grille, subtle sheet metal creases, and sharply angled lines around the LED headlights. Wide wheel arches house big 19- or 20-inch wheels touting bold designs that make the Q3 look like it’s moving fast even when standing still.
An integrated rear spoiler is both beautiful and functional, as are the LED taillights found on every model. The formerly optional S-line treatment with exterior details like a more aggressive front end and wider lower openings is now standard. New for 2021 is the Black optic sport package that adds darkened 19-inch wheels, black accents, and roof rails.
 2021 Audi Q3 Standard FeaturesFor an entry-level luxury SUV, the Q3 allures with a long list of standard features. A base model, which Audi dubs the “Premium” trim, includes leather upholstery, heated and 8-way power front seats with 4-way lumbar support, panoramic sunroof, a power tailgate, and tri-zone climate control.
Audis are known for their impressive tech, and here, too, the Q3 excels out the gate. Standard is a 10.25-inch digital instrument cluster plus an 8.8-inch central touchscreen. As is becoming par the course these days in most new cars, Apple CarPlay/Android Auto compatibility is standard. There are four USB ports, including USB-C ports, and a 10-speaker/180-watt audio system.
Standard safety features include lane-departure warning, forward-collision warning, and low-speed automatic emergency braking.
 2021 Audi Q3 OptionsStepping up to higher-trim Audi Q3 levels brings features like the Virtual Cockpit, the MMI touchpad with a larger screen (10.1 inches) and navigation, and a 15-speaker/680-watt Bang & Olufsen audio system. You can also get a top-view camera system, adaptive cruise control, power-folding side mirrors, and rear side airbags. Added safety and driver-assist features include blind-spot monitoring with rear cross-traffic alert, and a system that aids in parallel and perpendicular parking.
For 2021, the Premium Plus trim now comes with adaptive cruise control, customizable LED interior lighting, and a stainless-steel trunk sill.
 2021 Audi Q3 EngineAudi offers just one engine and transmission in the Q3: A 228-horsepower 2.0-liter turbocharged 4-cylinder engine mated to an 8-speed Tiptronic automatic transmission with manual-shift mode. Audi’s quattro all-wheel drive is standard. The EPA rates the 2021 Audi Q3 at 22 mpg city/30 mpg highway.

2.0-liter turbocharged inline-4
228 horsepower @ 5,000-6,700 rpm
258 lb-ft of torque @ 1,700-4,400 rpm
EPA city/highway fuel economy: 22/30 mpg
How Much Does the  2021 Audi Q3  Cost? The Audi Q3 brings a higher starting price for 2021 because it now comes standard with the S line package. That brings the Manufacturer’s Suggested Retail Price (MSRP) to $36,000, plus destination. That’s $1,300 more than last year’s model. Loaded, a 2021 Audi Q3 can reach into the mid-$40,000 range.
Even with its higher starting price for 2021, the Audi Q3 is in line with competitors. This is especially true if you factor in the Audi’s included all-wheel drive, which costs extra on rivals.
Before buying, check the KBB.com Fair Purchase Price to see what others in your area are paying for the new Q3. The Audi Q3’s resale value is above average. It is predicted to hold its value well, though not quite up to the level of a Volvo XC40.
Which   2021 Audi Q3  Model is Right for Me? 2021 Audi Q3 Premium
All-wheel drive
Panoramic sunroof
Heated leather seats
Apple CarPlay/Android Auto integration
Power liftgate
2021 Audi Q3 Premium Plus
Audi cruise assist
Wireless smartphone charger
Keyless start & smart key
Audi side assist with lane-departure warning
Read Full Review',
@New='What''s New for 2021
S line exterior styling becomes standard
Prestige trim dropped. Premium Plus trim can be optioned with its features.
Technology package now includes Bang & Olufsen audio
Parking Assistance package available
New Black optic package with darkened aesthetics

The 2021 Audi Q3 is the German luxury brand’s smallest crossover SUV. Starting at',
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
@doors=null,
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