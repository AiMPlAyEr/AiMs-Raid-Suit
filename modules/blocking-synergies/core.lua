
ARS = ARS or {}

function ARS.SynergyUsed()
	local synergyName, iconFilename = GetSynergyInfo()

	if not synergyName then return end

    --blocking synergie if true
	if ARS.BSynergies[synergyName] then
		SHARED_INFORMATION_AREA:SetHidden(SYNERGY, true)
		return true
	end
end

function ARS:InitializeBlockingSynergies(enabled)
    if not enabled then return end

    ZO_PreHook(SYNERGY, "OnSynergyAbilityChanged", ARS.SynergyUsed)
end