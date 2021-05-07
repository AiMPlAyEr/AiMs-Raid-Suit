ARS = ARS or {}

local pool2
local mechanics = {}
local noxiousPuddleCooldown = 0
local isBossOaxiltso = false
local isBossBahsei = false
local isBossXalvakka = false

local nextSavageBlitz = 0
local nextNoxiouSludge = 0

local defaults = {
    takingaim = true,
    primemeteor = true,
    soulresonance = true,
    ignited = true,
    noxiouspuddle = true,
    noxiousludge = true,
    meteorcrash = true,
    savageblitz = true,
    deathtouch = true,
    fierydetonation = true,
    abomination = true,
    meteorswarm = true,
    cindercleave = true,
    creepingmanifold = false,
    sunhammer = true,
}

local function CreateNotification(pool2)
    local name      = "ARSMechanic" .. pool2:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, ARSMechanicFrame, "ARSMechanicTemplate")

    container.mtext    = container:GetNamedChild('MechanicText')
    container.texture   = container:GetNamedChild("MechanicIcon")

    return container
end

local function RemoveNotification(control)
    control:SetHidden(true)
    control:ClearAnchors()
end

local function MechanicCheck(eventCode, result, _, abilityName, _, _, _, sourceType, _, targetType, hitValue, _, _, _, sourceUnitId, targetUnitId, abilityId)
    local currentTime = GetGameTimeMilliseconds()

    if abilityId == 150078 and targetType == COMBAT_UNIT_TYPE_PLAYER and result == ACTION_RESULT_EFFECT_GAINED_DURATION and ARS.rgmechanics.deathtouch then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 149190 and targetType == COMBAT_UNIT_TYPE_PLAYER and result == ACTION_RESULT_BEGIN and ARS.rgmechanics.noxiousludge then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 152365 and result == ACTION_RESULT_BEGIN and ARS.rgmechanics.meteorcrash then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 153434 and result == ACTION_RESULT_EFFECT_GAINED and ARS.rgmechanics.primemeteor then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 157859 and targetType == COMBAT_UNIT_TYPE_PLAYER and ARS.rgmechanics.noxiouspuddle then
        if noxiousPuddleCooldown <= currentTime then
            mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
            noxiousPuddleCooldown = currentTime + 1000
        end
    elseif (abilityId == 149414 or abilityId == 157932) and result == ACTION_RESULT_BEGIN and ARS.rgmechanics.savageblitz then
        mechanics[149414] = { duration = currentTime + ARS.MechanicsData[149414].duration, notifySound = true, target = ARS.GetAccountForUnitId(targetUnitId) }
    elseif abilityId == 152486 and result == ACTION_RESULT_EFFECT_GAINED and ARS.rgmechanics.abomination then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 157346 and result == ACTION_RESULT_EFFECT_GAINED and ARS.rgmechanics.fierydetonation then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 157243 and result == ACTION_RESULT_BEGIN and ARS.rgmechanics.takingaim then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 155357 and result == ACTION_RESULT_EFFECT_GAINED_DURATION and ARS.rgmechanics.meteorswarm then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif (abilityId == 157466 or abilityId == 149089) and result == ACTION_RESULT_EFFECT_GAINED and ARS.rgmechanics.soulresonance then
        mechanics[157466] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 149346 and result == ACTION_RESULT_EFFECT_GAINED_DURATION and ARS.rgmechanics.ignited then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 152688 and result == ACTION_RESULT_BEGIN and ARS.rgmechanics.cindercleave then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true, target = ARS.GetAccountForUnitId(targetUnitId) }
    elseif abilityId == 153181 and result == 2240 then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, notifySound = true }
    elseif abilityId == 153181 and result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and ARS.rgmechanics.sunhammer then
        mechanics[abilityId] = { duration = currentTime + hitValue, notifySound = true }
    end

    if isBossOaxiltso then
        if abilityId == 149414 and result == ACTION_RESULT_BEGIN then
            nextSavageBlitz = currentTime + 35000
        end

        if abilityId == 149190 and result == ACTION_RESULT_BEGIN then
            nextNoxiouSludge = currentTime + 30000
        end
    end
end

function ARS.RemoveAlert(abilityId)

    mechanics[abilityId] = nil
end

function ARS.UpdateRemainingTime()
    local i = 0
    for k, v in pairs(mechanics) do
        local remainingTime = (v.duration - GetGameTimeMilliseconds()) / 1000
        if remainingTime > 0 then
            if v.notifySound then
                PlaySound(ARS.MechanicsData[k].notifySound)
                v.notifySound = false
            end
            local trackerunit = pool2:AcquireObject(k)
            trackerunit:SetAnchor(TOPLEFT, ARSMechanicFrame, TOPLEFT, 0, 60 * i)
            trackerunit:SetHidden(false)
            trackerunit.texture:SetTexture(ARS.MechanicsData[k].icon)
            trackerunit.mtext:SetText(zo_strformat(GetString(ARS.MechanicsData[k].text), ARS.MechanicsData[k].name, remainingTime, v.target))
            i=i+1
        elseif remainingTime <= 0 then
            local trackerunit = pool2:AcquireObject(k)
            RemoveNotification(trackerunit)
            mechanics[k] = nil
        end
    end

    if isBossOaxiltso then
        local rSavageBlitz = (nextSavageBlitz - GetGameTimeMilliseconds()) / 1000
        local rNoxiousSludge = (nextNoxiouSludge - GetGameTimeMilliseconds()) / 1000

        if rSavageBlitz >= 0 then
            ARSStatusPanelBlitzTimer:SetText(math.floor(rSavageBlitz).."s")
        else 
            ARSStatusPanelBlitzTimer:SetText("Soon")
        end

        if rNoxiousSludge >= 0 then
            ARSStatusPanelPoisonTimer:SetText(math.floor(rNoxiousSludge).."s")
        else
            ARSStatusPanelPoisonTimer:SetText("Soon")
        end
    end
end

function ARS.BossChanged()
    local getBossName = string.lower(GetUnitName("boss1"))

    isBossOaxiltso = false
    isBossBahsei = false
    isBossXalvakka = false

    if (string.match(getBossName, "oaxiltso")) then
        isBossOaxiltso = true
    elseif (string.match(getBossName, "bahsei")) then
        isBossBahsei = true
    elseif (string.match( getBossName,"xalvakka")) then
        isBossXalvakka = true
    end
end

function ARS.InitPanel()
    if isBossOaxiltso then
        ARSStatusPanel:SetHidden(false)
        ARSStatusPanelBlitzTimer:SetText(0)
        ARSStatusPanelPoisonTimer:SetText(0)
        nextSavageBlitz = 0
        nextNoxiouSludge = 0
    else
        ARSStatusPanel:SetHidden(true)
    end
end

local function CombatState(event, inCombat)
    if inCombat then
        EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateRemainingTime", 100, ARS.UpdateRemainingTime)

        ARS.InitPanel()
    else
        EVENT_MANAGER:UnregisterForUpdate(ARS.name.."UpdateRemainingTime")
        pool2:ReleaseAllObjects()
        mechanics = {}
        ARS.InitPanel()
    end
end


function ARS:InitializeRGMechanics(enabled)
    if not enabled then return end

    ARS.rgmechanics = ZO_SavedVars:NewCharacterIdSettings("ARSsaved", 1, "RGMechanics", defaults)

    pool2 = ZO_ObjectPool:New(CreateNotification, RemoveNotification)

    EVENT_MANAGER:RegisterForEvent(ARS.name.."mechanic", EVENT_COMBAT_EVENT, MechanicCheck)
    EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_PLAYER_COMBAT_STATE, CombatState)
    EVENT_MANAGER:UnregisterForEvent(ARS.name .. "BossChanged", EVENT_BOSSES_CHANGED, ARS.BossChanged)
    EVENT_MANAGER:RegisterForEvent(ARS.name .. "BossChanged", EVENT_BOSSES_CHANGED, ARS.BossChanged)
end