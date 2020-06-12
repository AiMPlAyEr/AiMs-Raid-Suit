ARS = ARS or {}

local pool

local timer = {}

local pframe = nil

local function CreateBuff(pool)
    local name      = "ARSTracker" .. pool:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, pframe, "TrackerTemplate")

    container.stimer      = container:GetNamedChild('SynergyTimer')
    container.texture    = container:GetNamedChild("SynergyIcon")

    return container
end
 
local function RemoveBuff(control)
    control:SetHidden(true)
    control:ClearAnchors()
end

local function UpdateTracker()
    local index = 1
    for k, v in ipairs(ARS.savedsolo.synergies) do
        if not v then return end
        local trackerunit = pool:AcquireObject(k)
        trackerunit:SetAnchor(TOPLEFT, pframe, TOPLEFT, 55 * (index - 1), 0)

        trackerunit.texture:SetTexture(ARS.SynergyTexture[k])
        index = index + 1
    end
end

local function SetPosition()
    ARS.savedsolo.left = ARSSingleTrackerFrame:GetLeft()
    ARS.savedsolo.top = ARSSingleTrackerFrame:GetTop()
end

local function RestorePosition()
    ARSSingleTrackerFrame:ClearAnchors();
    ARSSingleTrackerFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, ARS.savedsolo.left, ARS.savedsolo.top)
end

local function AddToFragment(element)
    fragment = ZO_HUDFadeSceneFragment:New(element)
 
    HUD_SCENE:AddFragment(fragment)
    HUD_UI_SCENE:AddFragment(fragment)
end

function ARS.synergyCheck(eventCode, result, _, abilityName, _, _, _, sourceType, _, targetType, _, _, _, _, sourceUnitId, targetUnitId, abilityId)
    local start = GetFrameTimeSeconds()

    if (sourceType == COMBAT_UNIT_TYPE_PLAYER or sourceType == COMBAT_UNIT_TYPE_GROUP) then
        if ARS.Synergies[abilityId] then
            if ARS.savedsolo.synergies[ARS.Synergies[abilityId]] then 
                timer[ARS.Synergies[abilityId]] = start + 20
            end
        end
    end
end

function ARS.Cooldown()
    for k, v in pairs(timer) do

        unit = pool:AcquireObject(k)

        local rTime = math.floor(v - GetGameTimeSeconds())

        if rTime > 0 then
            unit.stimer:SetText(rTime)
            unit.texture:SetColor(0.5, 0.5, 0.5, 1)
        else
            unit.stimer:SetText('0')
            unit.texture:SetColor(1, 1, 1, 1)
            table.remove(timer, k)
        end
    end
end

function ARS:InitializeTracker(enabled)
    if not enabled then return end

    pframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSSingleTrackerFrame")
    pframe:SetResizeToFitDescendents(true)
    pframe:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 600, 600)
    pframe:SetMovable(true)
    pframe:SetMouseEnabled(true)
    pframe:SetHandler("OnMoveStop", SetPosition)

    local defaults = {
        synergies = {
            [1] = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = true,
            [6] = false,
            [7] = false,
            [8] = false,
            [9] = false,
            [10] = false,
            [11] = false,
            [12] = false,
            [13] = false,
            [14] = false,
            [15] = false,
            [16] = false,
            [17] = false,
        },
        top = 500,
        left = 500,

    }

    ARS.savedsolo = ZO_SavedVars:NewCharacterIdSettings("TrackerSaved", 1, nil, defaults)

    pool = ZO_ObjectPool:New(CreateBuff, RemoveBuff)

    AddToFragment(pframe)

    UpdateTracker()
    RestorePosition()

    EVENT_MANAGER:RegisterForEvent(ARS.name.."Synergy",EVENT_COMBAT_EVENT, ARS.synergyCheck)

    for k, v in pairs(ARS.Synergies) do
        EVENT_MANAGER:RegisterForEvent(ARS.name.."Synergy"..k,EVENT_COMBAT_EVENT , ARS.synergyCheck)
        EVENT_MANAGER:AddFilterForEvent(ARS.name.."Synergy"..k,EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, k)
    end

    EVENT_MANAGER:RegisterForUpdate(ARS.name .. "Cooldown", 100, ARS.Cooldown)
end