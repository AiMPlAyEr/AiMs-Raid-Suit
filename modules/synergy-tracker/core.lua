ARS = ARS or {}

local pool
local headercontrol
local synergypool

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
    --probably merging headercontrol and pframe in controls.xml
    headercontrol = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)TrackerHeader", pframe, "TrackerHeaderTemplate")
    headercontrol:SetAnchor(TOPLEFT, pframe, TOPLEFT, 0, 0)
    headercontrol:GetNamedChild("PrimarySynergy"):SetTexture(ARS.SynergyTexture[1])
    headercontrol:GetNamedChild("SecondarySynergy"):SetTexture(ARS.SynergyTexture[2])

end
 
local function CreateBuff(pool)
    local name      = "ARSUnit" .. pool:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, pframe, "UnitTemplate")

    local name              = container:GetNamedChild("UnitName")
    local role              = container:GetNamedChild("Role")
    local backdrop          = container:GetNamedChild("Backdrop")
    local primarysynergy    = container:GetNamedChild("PrimarySynergy")
    local secondarysynergy  = container:GetNamedChild("SecondarySynergy")

    container.name              = name
    container.role              = role
    container.backdrop          = backdrop
    container.primarysynergy    = primarysynergy
    container.secondarysynergy  = secondarysynergy

    return container
end
 
local function RemoveBuff(control)
    control:SetHidden(true)
    control:ClearAnchors()
end
 
local function UpdateGroup()
    --calling UpdateTimer function
    UpdateTimer()
    --checking if user is in a group or not
    if GetGroupSize() < 1 then
        headercontrol:SetHidden(true)
    else 
        headercontrol:SetHidden(false)
    end

    --hiding all objects before asigning them again
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

        --role 0 equals offline
        if accName ~= nil and role ~= 0 then
            groupunit = pool:AcquireObject(i)

            groupunit:SetHidden(false)
            groupunit:SetAnchor(TOPLEFT, pframe, TOPLEFT, 0, 24 * position + 2)

            if HodorReflexes and HodorReflexes.player.GetIconForUserId(accName) ~= nil then
                groupunit.role:SetTexture(HodorReflexes.player.GetIconForUserId(accName))
            else
                groupunit.role:SetTexture(UnitType[role])
            end

            --set name of unit
            groupunit.name:SetText(accName)

            position = position + 1
        end

    end
end

local function GetSynergy(eventCode, result, _, abilityName, _, _, _, sourceType, _, targetType, _, _, _, _, sourceUnitId, targetUnitId, abilityId)

    local getunit = ARS.GetNameForUnitId(targetUnitId)
    d(getunit)

    --adding unit to synergypool
    for k, v in ipairs(synergypool) do
        if v.name == getunit then
            if getunit ~= "" and ARS.Synergies[abilityId] == 1 then
                synergypool[k].primarysynergy = GetGameTimeSeconds() + 20
            elseif getunit ~= "" and ARS.Synergies[abilityId] == 2 then
                synergypool[k].secondarysynergy = GetGameTimeSeconds() + 20
            end
        end
    end
end

--UpdateTimer is being called as soon as there is a change in the group
--note: I may have to remove EVENT_GROUP_MEMBER_CONNECTED_STATUS because otherwise it will reset each time someone goes offline/has a disconnect or is logging in again
function UpdateTimer()
    -- resetting synergypool
    synergypool = {}

    local gsize = GetGroupSize()

    if gsize == 0 then return end

    for i = 1, gsize + 1 do
        local accName   = GetRawUnitName("group" .. i)
        accName = zo_strformat("<<1>>", accName)
        local role      = GetGroupMemberAssignedRole("group" .. i)

        if accName ~= nil then
            synergypool[i]                  = {}
            synergypool[i].name             = accName
            synergypool[i].online           = role
            synergypool[i].primarysynergy   = "0"
            synergypool[i].secondarysynergy = "0"
        end
    end
end

function roundNum(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

function UpdateCooldown()
    for k, v in ipairs(synergypool) do
        local pRemainingTime = roundNum(v.primarysynergy - GetGameTimeSeconds())
        local sRemainingTime = roundNum(v.secondarysynergy - GetGameTimeSeconds())

        groupunit = pool:AcquireObject(k)

        if pRemainingTime > 5 then
            groupunit.primarysynergy:SetColor(255, 0, 0)
            groupunit.primarysynergy:SetText(pRemainingTime)
        end

        if pRemainingTime < 6 and pRemainingTime > 0 then
            groupunit.primarysynergy:SetColor(255, 255, 0)
            groupunit.primarysynergy:SetText(pRemainingTime)
        end

        if pRemainingTime == 0 then
            groupunit.primarysynergy:SetColor(255, 255, 255)
            groupunit.primarysynergy:SetText("0")
        end

        if sRemainingTime > 5 then
            groupunit.secondarysynergy:SetColor(220, 20, 60)
            groupunit.secondarysynergy:SetText(sRemainingTime)
        end

        if sRemainingTime < 6 and sRemainingTime > 0 then
            groupunit.secondarysynergy:SetColor(255, 255, 0)
            groupunit.secondarysynergy:SetText(sRemainingTime)
        end

        if sRemainingTime == 0 then
            groupunit.secondarysynergy:SetColor(255, 255, 255)
            groupunit.secondarysynergy:SetText("0")
        end
    end
end

function ARS:InitializeSynergyTracker(enable)
    if not enable then return end

    AddToFragment(pframe)
    CreateFrameHeader()

    pool = ZO_ObjectPool:New(CreateBuff, RemoveBuff)

    ARS.RegisterUnitIndexing()

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
    EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateCooldown", 100, UpdateCooldown)
    --EVENT_MANAGER:RegisterForEvent("MyAddon", EVENT_COMBAT_EVENT, UpdateBuffs)
end