ARS = ARS or {}

local pool
local headercontrol
local synergypool = {}

local pframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSTrackerFrame")
pframe:SetResizeToFitDescendents(true)
pframe:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 600, 100)
pframe:SetMovable(true)
pframe:SetMouseEnabled(true)

local function AddToFragment(element)
    fragment = ZO_HUDFadeSceneFragment:New(element)
 
    HUD_SCENE:AddFragment(fragment)
    HUD_UI_SCENE:AddFragment(fragment)
end

local function CreateFrameHeader()
    headercontrol = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)TrackerHeader", pframe, "TrackerHeaderTemplate")
    headercontrol:SetAnchor(TOPLEFT, pframe, TOPLEFT, 0, 0)
    headercontrol:GetNamedChild("PrimarySynergy"):SetTexture(ARS.SynergyTexture[1])
    headercontrol:GetNamedChild("SecondarySynergy"):SetTexture(ARS.SynergyTexture[2])
end
 
local function CreateBuff(pool)
    local name      = "ARSUnit" .. pool:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, pframe, "UnitTemplate")

    container.name              = container:GetNamedChild("UnitName")
    container.role              = container:GetNamedChild("Role")
    container.backdrop          = container:GetNamedChild("Backdrop")
    container.primarysynergy    = container:GetNamedChild("PrimarySynergy")
    container.secondarysynergy  = container:GetNamedChild("SecondarySynergy")

    return container
end
 
local function RemoveBuff(control)
    control:SetHidden(true)
    control:ClearAnchors()
end
 
local function UpdateGroup()
    UpdateTimer()

    if GetGroupSize() < 1 then
        headercontrol:SetHidden(true)
    else 
        headercontrol:SetHidden(false)
    end

    pool:ReleaseAllObjects()

    local UnitType = {
        [0] = "/esoui/art/contacts/social_status_offline.dds",
        [1] = "/esoui/art/lfg/lfg_icon_dps.dds",
        [2] = "/esoui/art/lfg/lfg_icon_tank.dds",
        [4] = "/esoui/art/lfg/lfg_icon_healer.dds",
    }
    local groupunit

    local position = 1
    for i = 1, GetGroupSize() + 1 do
        local accName = GetUnitDisplayName("group" .. i)
        local role = GetGroupMemberAssignedRole("group" .. i)

        if accName ~= nil and role ~= 0 then
            groupunit = pool:AcquireObject(i)

            groupunit:SetHidden(false)
            groupunit:SetAnchor(TOPLEFT, pframe, TOPLEFT, 0, 24 * position + 2)

            if HodorReflexes and HodorReflexes.player.GetIconForUserId(accName) ~= nil then
                groupunit.role:SetTexture(HodorReflexes.player.GetIconForUserId(accName))
            else
                groupunit.role:SetTexture(UnitType[role])
            end

            accName = accName:gsub('%@', '')
            groupunit.name:SetText(accName)

            --reseting timer if someone joins, leaves or disconnects
            groupunit.primarysynergy:SetText("0")
            groupunit.primarysynergy:SetColor(255, 255, 255)
            groupunit.secondarysynergy:SetText("0")
            groupunit.secondarysynergy:SetColor(255, 255, 255)
            position = position + 1
        end

    end
end

function GetSynergy(eventCode, result, _, _, _, _, _, _, _, _, _, _, _, _, _, targetUnitId, abilityId)
    if result ~= ACTION_RESULT_EFFECT_GAINED then return end

    local getunit = ARS.GetNameForUnitId(targetUnitId)

    for k, v in ipairs(synergypool) do
        if synergypool[k].name == getunit then
            if getunit ~= "" and ARS.Synergies[abilityId] == 1 then
                synergypool[k].primarysynergy = GetGameTimeSeconds() + 20
            elseif getunit ~= "" and ARS.Synergies[abilityId] == 2 then
                synergypool[k].secondarysynergy = GetGameTimeSeconds() + 20
            end
        end
    end
end

function UpdateTimer()
    local gsize = GetGroupSize()

    if gsize == 0 then return end

    for i = 1, gsize + 1 do
        local accName = GetUnitName("group" .. i)

        if accName ~= nil then
            synergypool[i]                  = {}
            synergypool[i].name             = accName
            synergypool[i].online           = GetGroupMemberAssignedRole("group" .. i)
            synergypool[i].primarysynergy   = "0"
            synergypool[i].secondarysynergy = "0"
        end
    end
end

function UpdateCooldown()
    for k, v in ipairs(synergypool) do
        if v.online ~= 0 then
            local pRemainingTime = math.floor(v.primarysynergy - GetGameTimeSeconds())
            local sRemainingTime = math.floor(v.secondarysynergy - GetGameTimeSeconds())

            groupunit = pool:AcquireObject(k)

            if pRemainingTime > 3 then
                groupunit.primarysynergy:SetColor(255, 0, 0)
                groupunit.primarysynergy:SetText(pRemainingTime)
            end

            if pRemainingTime < 4 and pRemainingTime > 0 then
                groupunit.primarysynergy:SetColor(255, 255, 0)
                groupunit.primarysynergy:SetText(pRemainingTime)
            end

            if pRemainingTime == 0 then
                groupunit.primarysynergy:SetColor(255, 255, 255)
                groupunit.primarysynergy:SetText("0")
            end

            if sRemainingTime > 3 then
                groupunit.secondarysynergy:SetColor(255, 0, 0)
                groupunit.secondarysynergy:SetText(sRemainingTime)
            end

            if sRemainingTime < 4 and sRemainingTime > 0 then
                groupunit.secondarysynergy:SetColor(255, 255, 0)
                groupunit.secondarysynergy:SetText(sRemainingTime)
            end

            if sRemainingTime == 0 then
                groupunit.secondarysynergy:SetColor(255, 255, 255)
                groupunit.secondarysynergy:SetText("0")
            end
        end
    end
end

function ARS:InitializeSynergyTracker(enabled)
    if not enabled then return end

    AddToFragment(pframe)
    CreateFrameHeader()

    pool = ZO_ObjectPool:New(CreateBuff, RemoveBuff)

    ARS.RegisterUnitCollectingEvent()

    UpdateTimer()
    UpdateGroup()

    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_JOINED , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_LEFT , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_ROLE_CHANGED , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_CONNECTED_STATUS , UpdateGroup)
    for k, v in pairs(ARS.Synergies) do
        EVENT_MANAGER:RegisterForEvent(ARS.name.."Synergy"..k, EVENT_COMBAT_EVENT, GetSynergy)
        EVENT_MANAGER:AddFilterForEvent(ARS.name.."Synergy"..k, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, k)
    end
    EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateCooldown", 250, UpdateCooldown)
end