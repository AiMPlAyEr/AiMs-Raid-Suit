ARS = ARS or {}
local ARS = ARS

ARS.name = "AiMs-Raid-Suite"
ARS.suiteversion = "0.2"
ARS.default = {}

function ARS:Initialize()
    ARS:InitializeSynergyTracker(true)
	ARS:InitializeTracker(true)
	
	ZO_PreHook(SYNERGY, "OnSynergyAbilityChanged", ARS.SynergyUsed)
end

function ARS.SynergyUsed()
	local synergyName, iconFilename = GetSynergyInfo()

	if not synergyName then return end

	if synergyName == "Feed" then
		SHARED_INFORMATION_AREA:SetHidden(SYNERGY, true)
		return true
	end
end

function ARS.OnAddOnLoaded(event, addonName)
	if addonName ~= ARS.name then return end
        ARS:Initialize()
end

EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_ADD_ON_LOADED, ARS.OnAddOnLoaded)