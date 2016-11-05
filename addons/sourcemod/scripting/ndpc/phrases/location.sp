// A list of locations by their translation phrase
#define REQUEST_LOCATION_COUNT 5
char nd_request_location[REQUEST_LOCATION_COUNT][] =
{
	"Roof",
	"Base",
	"Prim",
	"Pos",
	"Sec"
};

int GetSpotByIndex(int client, const char[] sArgs)
{
	for (int location = 0; location < REQUEST_LOCATION_COUNT; location++) //for all the building spots
	{
		if (StrIsWithin(sArgs, nd_request_location[location])) //if a location is within the string
		{
			return location; //index of the location in nd_request_location 	
		}
	}

	return GetTranslatedArrayIndex(client, sArgs, nd_request_location, REQUEST_LOCATION_COUNT);
}

//A list of compass positions by their translation phrase
#define REQUEST_COMPASS_COUNT 6
char nd_request_compass[REQUEST_COMPASS_COUNT][] =
{
	"North",
	"South",
	"East",
	"West",
	"Left",
	"Right"
};

int GetCompassByIndex(int client, const char[] sArgs)
{
	for (int compass = 0; compass < REQUEST_COMPASS_COUNT; compass++) //for all the compass locations
	{
		if (StrIsWithin(sArgs, nd_request_compass[compass])) //if a location is within the string
		{
			return compass;	//the index of compass in nd_request_compass
		}
	}

	return GetTranslatedArrayIndex(client, sArgs, nd_request_compass, REQUEST_COMPASS_COUNT);
}
