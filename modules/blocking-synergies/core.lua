
ARS = ARS or {}

function ARS.SynergyUsed()
	local synergyName, iconFilename = GetSynergyInfo()

    if not synergyName then return end

    --blocking synergie if true
	if synergyName == "Conjurer's Portal" then
        SHARED_INFORMATION_AREA:SetHidden(SYNERGY, true)
        return true
    end
end

local function BarSwap(_, didBarswap)
    if didBarswap then SYNERGY:OnSynergyAbilityChanged() end
  end

function ARS:InitializeBlockingSynergies(enabled)
    if not enabled then return end

    ZO_PreHook(SYNERGY, "OnSynergyAbilityChanged", ARS.SynergyUsed)
    EVENT_MANAGER:RegisterForEvent(ARS.name .. "BarSwap", EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED, BarSwap)
end