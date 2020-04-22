ARS = ARS or {}
local ARS = ARS

ARS.name = "AiMs-Raid-Suite"
ARS.suitversion = "0.1"

function ARS.Mechanics(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)
    
    
    if sourceType == COMBAT_UNIT_TYPE_PLAYER then
        return
    end

    --d("Found new ability [%d], %s (%s)", abilityId, targetName, GetAbilityName(abilityId))
end

function ARS:Initialize()
	--Saved Variables
    EVENT_MANAGER:RegisterForEvent(ARS.name .. "Ability" , EVENT_COMBAT_EVENT, ARS.Mechanics)

    ARS:InitializeSynergyTracker(true)
    ARS:InitializeTracker(true)
end

function ARS.OnAddOnLoaded(event, addonName)
	if addonName ~= ARS.name then return end
        ARS:Initialize()
end

EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_ADD_ON_LOADED, ARS.OnAddOnLoaded)