#define REQUEST_CAPTURE_COUNT 3
char nd_request_capture[REQUEST_CAPTURE_COUNT][] =
{
	"Prim",
	"Sec",
	"Tert"
};

int GetCaptureByIndex(int client, const char[] sArgs)
{
	for (int resource = 0; resource < REQUEST_CAPTURE_COUNT; resource++) //for all the building spots
	{
		if (StrIsWithin(sArgs, nd_request_capture[resource])) //if a location is within the string
		{
			return resource; //index of the location in nd_request_location 	
		}
	}

	return GetTranslatedArrayIndex(client, sArgs, nd_request_capture, REQUEST_CAPTURE_COUNT);
}

// A list of locations by their translation phrase
#define REQUEST_LOCATION_EX_COUNT 3
char nd_request_location_ex[REQUEST_LOCATION_EX_COUNT][] =
{
	"Roof",
	"Base",
	"Pos"
};

int GetSpotByIndexEX(int client, const char[] sArgs)
{
	for (int location = 0; location < REQUEST_LOCATION_EX_COUNT; location++) //for all the building spots
	{
		if (StrIsWithin(sArgs, nd_request_location_ex[location])) //if a location is within the string
		{
			return location; //index of the location in nd_request_location 	
		}
	}

	return GetTranslatedArrayIndex(client, sArgs, nd_request_location_ex, REQUEST_LOCATION_EX_COUNT);
}
