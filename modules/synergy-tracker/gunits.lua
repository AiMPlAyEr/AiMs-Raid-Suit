local ARS = ARS

ARS.gunit = {}

local function OnEffectChanged(_, _, _, _, _, _, _, _, _, _, _, _, _, unitName, unitId)
	unitName = zo_strformat("<<1>>", unitName)
	if unitName ~= "Offline" then
		if ARS.gunit[unitId] ~= unitName then
			ARS.gunit[unitId] = unitName
		end
	end
end

function ARS.GetNameForUnitId(unitId)
	return ARS.gunit[unitId] or ""
end

function ARS.RegisterUnitIndexing()
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "UpdateUnitList", EVENT_EFFECT_CHANGED, OnEffectChanged)
end
