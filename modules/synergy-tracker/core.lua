ARS = ARS or {}

local pool
local headercontrol

local pframe = WINDOW_MANAGER:CreateTopLevelWindow("TrackerUITest")
pframe:SetResizeToFitDescendents(true)
pframe:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 600, 100)
pframe:SetMovable(true)
pframe:SetMouseEnabled(true)

local UnitType = {
    [1]      = "/esoui/art/lfg/lfg_icon_dps.dds",
    [2]      = "/esoui/art/lfg/lfg_icon_tank.dds",
    [4]      = "/esoui/art/lfg/lfg_icon_healer.dds",
}

local function AddToFragment(element)
    fragment = ZO_HUDFadeSceneFragment:New(element)
 
    HUD_SCENE:AddFragment(fragment)
    HUD_UI_SCENE:AddFragment(fragment)
end

local function CreateFrameHeader()
    headercontrol = WINDOW_MANAGER:CreateControl("$(parent)TrackerHeader", pframe, CT_CONTROL)
    headercontrol:SetAnchor(TOPLEFT, pframe, TOPLEFT, 0, 0)

    local headerbackdrop = WINDOW_MANAGER:CreateControl("$(parent)backdrop", headercontrol, CT_BACKDROP)
    headerbackdrop:SetEdgeColor(0.4,0.4,0.4,0)
    headerbackdrop:SetCenterColor(0, 0, 0)
    headerbackdrop:SetAlpha("0.8")
    headerbackdrop:SetDimensions(225, 26)
    headerbackdrop:SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 0, 0)

    local psynergy = WINDOW_MANAGER:CreateControl("$(parent)PrimarySynergy", headercontrol, CT_TEXTURE)
    psynergy:SetDimensions(24, 24)
    psynergy:SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 165, 1)
    psynergy:SetTexture("/esoui/art/icons/ability_undaunted_004b.dds") --default icon

    local ssynergy = WINDOW_MANAGER:CreateControl("$(parent)SecondarySynergy", headercontrol, CT_TEXTURE)
    ssynergy:SetDimensions(24, 24)
    ssynergy:SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 195, 1)
    ssynergy:SetTexture("/esoui/art/icons/ability_sorcerer_liquid_lightning.dds") --default icon
end
 
local function CreateBuff(pool)
    local name      = "ARSUnit" .. pool:GetNextControlId()
    local container = pframe:CreateControl(name, CT_CONTROL)
    local name      = container:CreateControl("$(parent)Template", CT_LABEL)

    local role              = container:CreateControl("$(parent)Role", CT_TEXTURE)
    local backdrop          = container:CreateControl("$(parent)bdBackDrop", CT_BACKDROP)
    local primarysynergy    = container:CreateControl("$(parent)PrimarySynergy", CT_LABEL)
    local secondarysynergy  = container:CreateControl("$(parent)SecondarySynergy", CT_LABEL)

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
    if GetGroupSize() < 1 then
        headercontrol:SetHidden(true)
    else 
        headercontrol:SetHidden(false)
    end
    pool:ReleaseAllObjects()
     local groupunit
     local position = 1
     for i = 1, GetGroupSize() + 1 do
        local accName = GetUnitDisplayName("group" .. i)
        local role = GetGroupMemberAssignedRole("group" .. i)

        if accName ~= nil and role ~= 0 then
            groupunit = pool:AcquireObject(i)

            groupunit:SetHidden(false)
            groupunit:SetAnchor(TOPLEFT, pframe, TOPLEFT, 0, 24 * position + 2)
            groupunit.backdrop:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 0, 0)
            groupunit.backdrop:SetEdgeColor(0.4,0.4,0.4,0)
            groupunit.backdrop:SetCenterColor(0, 0, 0)
            groupunit.backdrop:SetDimensions(225, 24)
            groupunit.backdrop:SetAlpha("0.5")
            groupunit.backdrop:SetDrawLayer(0)

            groupunit.role:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 2, 0)
            if HodorReflexes and HodorReflexes.player.GetIconForUserId(accName) ~= nil then
                groupunit.role:SetTexture(HodorReflexes.player.GetIconForUserId(accName))
            else
                groupunit.role:SetTexture(UnitType[role])
            end
            groupunit.role:SetDimensions(24,24)
            groupunit.role:SetDrawLayer(1)

            groupunit.name:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 30, 0)
            groupunit.name:SetText(accName)
            groupunit.name:SetColor(255, 255, 255, 1)
            groupunit.name:SetDrawLayer(1)
            groupunit.name:SetWrapMode(TEX_MODE_CLAMP)
            groupunit.name:SetDimensions(130, 24)
            groupunit.name:SetFont(string.format("$(%s)|$(KB_%s)|%s", "MEDIUM_FONT", 16, "soft-shadow-thin"))

            groupunit.primarysynergy:SetAnchor(CENTER, groupunit, TOPLEFT, 176, 12)
            groupunit.primarysynergy:SetText("0")
            groupunit.primarysynergy:SetFont(string.format("$(%s)|$(KB_%s)|%s", "MEDIUM_FONT", 16, "soft-shadow-thin"))
            groupunit.primarysynergy:SetColor(255, 255, 255)

            groupunit.secondarysynergy:SetAnchor(CENTER, groupunit, TOPLEFT, 206, 12)
            groupunit.secondarysynergy:SetText("0")
            groupunit.secondarysynergy:SetFont(string.format("$(%s)|$(KB_%s)|%s", "MEDIUM_FONT", 16, "soft-shadow-thin"))

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