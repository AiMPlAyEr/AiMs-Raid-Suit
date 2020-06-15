
ARS = ARS or {}

function ARS.SynergyUsed()
	local synergyName, iconFilename = GetSynergyInfo()

    if synergyName and iconFilename then

        local id = GetAbilityId(synergyName)

        if ARS.savedblock[id] ~= nil then
            --blocking synergie if false
            if ARS.savedblock[id] == false then d(ARS.savedblock[id]) SHARED_INFORMATION_AREA:SetHidden(SYNERGY, true) return true end

        else
            return false
        end
    end
end

function GetAbilityId(abilityName)
    for k, v in pairs(ARS.BSynergies) do
        if v.name == abilityName then return k end
    end
end

local function BarSwap(_, didBarswap)
    if didBarswap then 
        SYNERGY:OnSynergyAbilityChanged() 
    end
end

function ARS:InitializeBlockingSynergies(enabled)
    if not enabled then return end

    local defaults = {
        [134016] = true,
        [103489] = true,
        [56667] = true,
        [121216] = true,
    }

    ARS.savedblock = ZO_SavedVars:NewCharacterIdSettings("ARSsaved", 1, "SynergyBlocker", defaults)

    ZO_PreHook(SYNERGY, "OnSynergyAbilityChanged", ARS.SynergyUsed)
    EVENT_MANAGER:RegisterForEvent(ARS.name .. "BarSwap", EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED, BarSwap)
end