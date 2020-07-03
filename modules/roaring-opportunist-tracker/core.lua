
ARS = ARS or {}

local function SynergyCheck(eventCode, result, _, abilityName, _, _, _, sourceType, _, targetType, hitValue, _, _, _, sourceUnitId, targetUnitId, abilityId)
    if abilityId == 137985 or abilityId == 137986 then
        d("triggered! "..hitValue.." "..abilityId.." "..result)
    end
end


function ARS:InitializeRoaringTracker(enabled)
    if not enabled then return end

    ARS.savedblock = ZO_SavedVars:NewCharacterIdSettings("ARSsaved", 1, "SynergyBlocker", defaults)

    EVENT_MANAGER:RegisterForEvent(ARS.name.."roaring", EVENT_COMBAT_EVENT, SynergyCheck)
end