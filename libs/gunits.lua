local ARS = ARS

ARS.gunit = {}
ARS.accName = {}

local function OnEffectChanged(_, result, _, _, unitTag, _, _, _, _, _, _, _, _, unitName, unitId)
	if unitName == "" then return end
	if not result == EFFECT_RESULT_GAINED then return end
	if ARS.gunit[unitId] ~= nil or ARS.accName[unitId] ~= nil then return end
	
	unitName = zo_strformat("<<1>>", unitName)
	if unitName ~= "offline" then

		if ARS.gunit[unitId] ~= unitName then
			ARS.gunit[unitId] = unitName
		end
	end

	if unitTag ~= ""  then
		ARS.accName[unitId] = GetUnitDisplayName(unitTag)
	end
end

function ARS.GetNameForUnitId(unitId)
	return ARS.gunit[unitId] or ""
end

function ARS.GetAccountForUnitId(unitId)
	return ARS.accName[unitId] or ""
end

function ARS.RegisterUnitCollectingEvent()
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "UpdateUnitList", EVENT_EFFECT_CHANGED, OnEffectChanged)
end
