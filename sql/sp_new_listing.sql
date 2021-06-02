-- SP create a new listing
CREATE PROCEDURE sp_new_listing(
	--KBB DATA
	@Make VARCHAR(252),
	@ModelAlias VARCHAR(252),
	@ModelGuess VARCHAR(252),
	@Year INT,
	@Price INT,
	@Condition VARCHAR(252),
	@Miles INT,
	@PostingDate VARCHAR(252),
	@PostingUrl VARCHAR(500),
	@ImageLinks VARCHAR(2000),
	@Region VARCHAR(252)
)
AS
BEGIN TRANSACTION
	INSERT INTO 
		davidsList.dbo.listing(price, [url], [date], [odometer], [condition], locationId, [alias], carId)
	VALUES
		(@Price, @PostingUrl, PARSE(@PostingDate as date), @Miles, @Condition, 
		(
		SELECT TOP(1)
			loc.id
		FROM 
			davidsList.dbo.[location] AS loc
		WHERE
			loc.[location] = @Region
		), @ModelAlias, 
		ISNULL(
			(
			SELECT TOP(1) 
				car.id
			FROM 
				davidsList.dbo.car AS car
			LEFT JOIN 
				davidslist.dbo.model as model
			ON 
				model.id = car.modelId
			WHERE 
				model.[name] = @ModelGuess
			ORDER BY ABS(model.year - @Year ) 
			), 2)

	);
	
	DECLARE @NewListingId INT;
	SET @NewListingId = (SELECT @@IDENTITY as 'Scope Id');
	
	INSERT INTO 
		davidsList.dbo.picture ([filename], listingId)
	VALUES	
		(@ImageLinks, @NewListingId);
			
IF @@ERROR <> 0
	ROLLBACK TRANSACTION
ELSE
	COMMIT TRANSACTION

GO

DROP PROCEDURE sp_new_listing;