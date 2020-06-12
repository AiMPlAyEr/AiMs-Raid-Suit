
ARS = ARS or {}

function ARS.SynergyUsed()
	local synergyName, iconFilename = GetSynergyInfo()

    if not synergyName then return end

    local id = GetAbilityId(synergyName)

    --blocking synergie if true
    if not ARS.savedblock[id] then
        SHARED_INFORMATION_AREA:SetHidden(SYNERGY, true)
        return true
    end
end

function GetAbilityId(abilityName)
    for k, v in pairs(ARS.BSynergies) do
        if v.name == abilityName then return k end
    end
end

local function BarSwap(_, didBarswap)
    if didBarswap then SYNERGY:OnSynergyAbilityChanged() end
  end

function ARS:InitializeBlockingSynergies(enabled)
    if not enabled then return end

    local defaults = {
        [134016] = false,
        [103489] = false,
        [56667] = false,
        [121216] = false,
    }

    ARS.BlockedSynergySettings()

    ARS.savedblock = ZO_SavedVars:NewCharacterIdSettings("BlockSaved", 1, nil, defaults)

    ZO_PreHook(SYNERGY, "OnSynergyAbilityChanged", ARS.SynergyUsed)
    EVENT_MANAGER:RegisterForEvent(ARS.name .. "BarSwap", EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED, BarSwap)
end