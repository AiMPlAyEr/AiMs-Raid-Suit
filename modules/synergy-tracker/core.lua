ARS = ARS or {}

local pool
local headercontrol

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
    --checking if user is in a group or not
    if GetGroupSize() < 1 then
        headercontrol:SetHidden(true)
    else 
        headercontrol:SetHidden(false)
    end

    pool:ReleaseAllObjects()

    local UnitType = {
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
    if ARS.GetNameForUnitId(targetUnitId) ~= "" then
        --d("Group: "..ARS.GetNameForUnitId(targetUnitId))
    end
end

function ARS:InitializeSynergyTracker(enable)
    if not enable then return end

    AddToFragment(pframe)
    CreateFrameHeader()

    pool = ZO_ObjectPool:New(CreateBuff, RemoveBuff)

    ARS.RegisterUnitIndexing()

    UpdateGroup()

    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_JOINED , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_LEFT , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_ROLE_CHANGED , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_CONNECTED_STATUS , UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."Synergy", EVENT_COMBAT_EVENT, GetSynergy)
    --EVENT_MANAGER:RegisterForEvent("MyAddon", EVENT_COMBAT_EVENT, UpdateBuffs)
end