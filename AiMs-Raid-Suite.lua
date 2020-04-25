ARS = ARS or {}
local ARS = ARS

ARS.name = "AiMs-Raid-Suite"
ARS.suiteversion = "0.2"
ARS.default = {}

function ARS:Initialize()

    ARS:InitializeSynergyTracker(true)
	ARS:InitializeTracker(true)
	
	ARS:InitializeKATracker(true)
end

function ARS.OnAddOnLoaded(event, addonName)
	if addonName ~= ARS.name then return end
        ARS:Initialize()
end

EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_ADD_ON_LOADED, ARS.OnAddOnLoaded)