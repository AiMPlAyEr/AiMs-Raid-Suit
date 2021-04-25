ARS = ARS or {}

local pool2
local mechanics = {}
local noxiousPuddleCooldown = 0

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

local function MechanicCheck(eventCode, result, _, abilityName, _, _, _, sourceType, _, targetType, _, _, _, _, sourceUnitId, targetUnitId, abilityId)
    local currentTime = GetGameTimeMilliseconds()

    if abilityId == 150078 and targetType == COMBAT_UNIT_TYPE_PLAYER and result == ACTION_RESULT_EFFECT_GAINED_DURATION then --funktioniert
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = true }
    elseif abilityId == 149193 and targetType == COMBAT_UNIT_TYPE_PLAYER then --funktioniert
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = false }
    elseif abilityId == 152365 and result == ACTION_RESULT_BEGIN then --funktioniert
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = true }
    elseif abilityId == 153434 and result == ACTION_RESULT_BEGIN then --funktioniert (result muss aber noch im Auge behalten werden)
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = true }
    elseif abilityId == 157859 and targetType == COMBAT_UNIT_TYPE_PLAYER then --result muss noch getestet werden
        if noxiousPuddleCooldown <= currentTime then
            mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = false }
            noxiousPuddleCooldown = currentTime + 2000
        end
    elseif abilityId == 149414 and result == ACTION_RESULT_BEGIN then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = true }
    elseif abilityId == 157337 and result == ACTION_RESULT_EFFECT_GAINED_DURATION then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = true }
    elseif abilityId == 152486 and result == ACTION_RESULT_EFFECT_GAINED then
        mechanics[abilityId] = { duration = currentTime + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = false }
    end

    --[[if abilityId == 39053 then
        mechanics[abilityId] = { duration = GetGameTimeMilliseconds() + ARS.MechanicsData[abilityId].duration, name = ARS.MechanicsData[abilityId].name, icon = ARS.MechanicsData[abilityId].icon, notifySound = true, countdown = true }
    end]]--

    if abilityId == 149417 then
        d("Savage Blitz is targeting you! ("..abilityId..")".." result: "..result)
    end

    if abilityId == 152716 then
        d("Meteor Bomb ("..abilityId..")".." result: "..result)
    end

    if abilityId == 153434 then
        d("Prime Meteor ("..abilityId..")".." result: "..result)
    end

    if abilityId == 152737 or abilityId == 152738 then
        d("luminous eruption ("..abilityId..")".." result: "..result)
    end
end

function ARS.UpdateRemainingTime()
    local i = 0
    for k, v in pairs(mechanics) do
        local remainingTime = (v.duration - GetGameTimeMilliseconds()) / 1000
        if remainingTime > 0 then
            if v.notifySound then
                PlaySound(SOUNDS.DUEL_START)
                v.notifySound = false
            end
            local trackerunit = pool2:AcquireObject(k)
            trackerunit:SetAnchor(TOPLEFT, ARSMechanicFrame, TOPLEFT, 0, 60 * i)
            trackerunit:SetHidden(false)
            trackerunit.texture:SetTexture(v.icon)
            if v.countdown then
                trackerunit.mtext:SetText(v.name..string.format("%.1f", remainingTime))
            else
                trackerunit.mtext:SetText(v.name)
            end
            i=i+1
        elseif remainingTime <= 0 then
            local trackerunit = pool2:AcquireObject(k)
            trackerunit:SetHidden(true)
            mechanics[k] = nil
        end
    end
end

local function CombatState(event, inCombat)
    if inCombat then
        EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateRemainingTime", 100, ARS.UpdateRemainingTime)
    else
        EVENT_MANAGER:UnregisterForUpdate(ARS.name.."UpdateRemainingTime")
        pool2:ReleaseAllObjects()
        mechanics = {}
    end
end


function ARS:InitializeRGMechanics(enabled)
    if not enabled then return end

    ARS.rgmechanics = ZO_SavedVars:NewCharacterIdSettings("ARSsaved", 1, "RGMechanics", defaults)

    pool2 = ZO_ObjectPool:New(CreateNotification, RemoveNotification)

    EVENT_MANAGER:RegisterForEvent(ARS.name.."mechanic", EVENT_COMBAT_EVENT, MechanicCheck)
    EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_PLAYER_COMBAT_STATE, CombatState)
end