/**
 * Wrapper for looping clients on team
 * matching the specified flags.
 *
 * @param 1		Name of index varriable (accessible inside the loop)
 * @param 2		Team varriable check if each client is on.
 */
#define LOOP_TEAM(%1,%2) for (int %1=Client_GetNext(%2); %1 >= 1 && %1 <= MaxClients; %1=Client_GetNext(%2, ++%1))	
int Client_GetNext(int team, int index = 1)
{
	for (int client = index; client <= MaxClients; client++) 
	{
		if (IsOnTeam(client, team)) 
		{
			return client;
		}
	}

	return -1;
}

#define PRINT_SIZE 128
#define PHRASE_SIZE 64
#define PHRASE_NOT_FOUND -1

/* Get the space count in a given chat message (or string) */
int GetStringSpaceCount(const char[] sArgs)
{
	int spaceCount = 0;
	
	for (int idx = 0; idx < strlen(sArgs); idx++)
	{
		if (IsCharSpace(sArgs[idx]))
			spaceCount++;
	}
	
	return spaceCount;
}

// Parse through translations equal to the client's game language.
// See if the request is being made in their game language
int GetTranslatedArrayIndex(int client, const char[] sArgs, const char[] nd_phrase_array, int aSize)
{
	// Is the game client language not equal to english?
	if (!StrEqual(GetLanguageName(client), "english", false))
	{	
		char phraseName[64];
		
		// For each index in the inputed translation array
		for (int idx = 0; idx < aSize; idx++)
		{
			// Get the phrase string in the clients game language
			Format(phraseName, sizeof(phraseName), "%T", nd_phrase_array[idx], client);
			
			// Check if the chat message contains the phrase string
			if (StrIsWithin(sArgs, phraseName))
				return idx;	
		}
	}
	
	// If it reaches here, we haven't found any translated requests
	return PHRASE_NOT_FOUND;
}

stock void NDPC_PrintRequestS0(int team, const char[] pName, const char[] request)
{
	LOOP_TEAM(idx, team) 
	{
		char ToPrint[128];
		Format(ToPrint, sizeof(ToPrint), "%T", request, idx);
		NDPC_PrintToChat(idx, pName, ToPrint);	
	}	
}

stock void NDPC_PrintRequestS1(int team, const char[] pName, const char[] request, const char[] p1)
{
	LOOP_TEAM(idx, team) 
	{
		char ToPrint[128];
		Format(ToPrint, sizeof(ToPrint), "%T", request, idx, GetTransString(idx, p1));
		NDPC_PrintToChat(idx, pName, ToPrint);	
	}
}

stock void NDPC_PrintRequestS2(int team, const char[] pName, const char[] request, const char[] p1, const char[] p2)
{
	LOOP_TEAM(idx, team) 
	{
		char ToPrint[128];
		Format(ToPrint, sizeof(ToPrint), "%T", request, idx, 		
				GetTransString(idx, p1),
				GetTransString(idx, p2));
		
		NDPC_PrintToChat(idx, pName, ToPrint);	
	}
}

stock void NDPC_PrintRequestS3(int team, const char[] pName, const char[] request, const char[] p1, const char[] p2, const char[] p3)
{
	LOOP_TEAM(idx, team) 
	{
		char ToPrint[128];
		Format(ToPrint, sizeof(ToPrint), "%T", request, idx, 		
				GetTransString(idx, p1),
				GetTransString(idx, p2),
				GetTransString(idx, p3));
				
		NDPC_PrintToChat(idx, pName, ToPrint);	
	}
}

/* Wrapper for printing a translation to client chat */
void NDPC_PrintToChat(int client, const char[] pName, const char[] sArgs)
{
	PrintToChat(client, "%s%t %s%s: %s%s",	TAG_COLOUR, "Translate Tag",
						NAME_COLOUR, pName, 
						MESSAGE_COLOUR, sArgs);
}

/* Convert no translation keyword phrases found to string, then print using colors wrapper */
void NDPC_PrintNoTransFound(int client)
{	
	//First segment is (Translator) in green. Second is "No keyword found" in olive
	PrintToChat(client, "%s%t %s%t.", TAG_COLOUR, "Translate Tag", MESSAGE_COLOUR, "No Translate Keyword");
}

/* Translation Strings */
char GetTransString(int client, const char[] tName)
{
	char trans[PHRASE_SIZE];
	Format(trans, PHRASE_SIZE, "%T", tName, client);
	return trans;
}
