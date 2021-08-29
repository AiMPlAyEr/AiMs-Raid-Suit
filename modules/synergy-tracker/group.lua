ARS = ARS or {}

local pool
local headercontrol
local synergypool = {}

local alkosh_user;

local function AddToFragment(element)
    fragment = ZO_HUDFadeSceneFragment:New(element)
 
    HUD_SCENE:AddFragment(fragment)
    HUD_UI_SCENE:AddFragment(fragment)
end

local function CreateFrameHeader()
    headercontrol = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)TrackerHeader", ARSTrackerFrame, "TrackerHeaderTemplate")
    headercontrol:SetAnchor(TOPLEFT, ARSTrackerFrame, TOPLEFT, 0, 0)
end
 
local function CreateBuff(pool)
    local name      = "ARSUnit" .. pool:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, ARSTrackerFrame, "UnitTemplate")

    container.name              = container:GetNamedChild("UnitName")
    container.role              = container:GetNamedChild("Role")
    container.backdrop          = container:GetNamedChild("Backdrop")
    container.primarysynergy    = container:GetNamedChild("PrimarySynergy")
    container.secondarysynergy  = container:GetNamedChild("SecondarySynergy")
    container.tertiarysynergy    = container:GetNamedChild("TertiarySynergy")
    container.quaternarysynergy  = container:GetNamedChild("QuaternarySynergy")

    return container
end
 
local function RemoveBuff(control)
    control:SetHidden(true)
    control:ClearAnchors()
end
 
function ARS.UpdateGroup()
    UpdateTimer()
    
    local indexer = 0

    if ARS.savedgroup.primarysynergy ~= 99 then
        headercontrol:GetNamedChild("PrimarySynergy"):SetTexture(ARS.SynergyTexture[ARS.savedgroup.primarysynergy])
        headercontrol:GetNamedChild("PrimarySynergy"):SetHidden(false)
        headercontrol:GetNamedChild("PrimarySynergy"):SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 168 + (30 * indexer), 0)
        indexer = indexer + 1
    else
        headercontrol:GetNamedChild("PrimarySynergy"):SetHidden(true)
    end

    if ARS.savedgroup.secondarysynergy ~= 99 then
        headercontrol:GetNamedChild("SecondarySynergy"):SetTexture(ARS.SynergyTexture[ARS.savedgroup.secondarysynergy])
        headercontrol:GetNamedChild("SecondarySynergy"):SetHidden(false)
        headercontrol:GetNamedChild("SecondarySynergy"):SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 168 + (30 * indexer), 0)
        indexer = indexer + 1
    else
        headercontrol:GetNamedChild("SecondarySynergy"):SetHidden(true)
    end

    if ARS.savedgroup.tertiarysynergy ~= 99 then
        headercontrol:GetNamedChild("TertiarySynergy"):SetTexture(ARS.SynergyTexture[ARS.savedgroup.tertiarysynergy])
        headercontrol:GetNamedChild("TertiarySynergy"):SetHidden(false)
        headercontrol:GetNamedChild("TertiarySynergy"):SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 168 + (30 * indexer), 0)
        indexer = indexer + 1
    else
        headercontrol:GetNamedChild("TertiarySynergy"):SetHidden(true)
    end

    if ARS.savedgroup.quaternarysynergy ~= 99 then
        headercontrol:GetNamedChild("QuaternarySynergy"):SetTexture(ARS.SynergyTexture[ARS.savedgroup.quaternarysynergy])
        headercontrol:GetNamedChild("QuaternarySynergy"):SetHidden(false)
        headercontrol:GetNamedChild("QuaternarySynergy"):SetAnchor(TOPLEFT, headercontrol, TOPLEFT, 168 + (30 * indexer), 0)
        indexer = indexer + 1
    else
        headercontrol:GetNamedChild("QuaternarySynergy"):SetHidden(true)
    end

    headercontrol:GetNamedChild("Backdrop"):SetDimensions(168 + (30 * indexer), 26)

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

            local unitIndexer = 0

            groupunit:SetHidden(false)
            groupunit:SetAnchor(TOPLEFT, ARSTrackerFrame, TOPLEFT, 0, 24 * position + 2)

            if alkosh_user == accName then
                groupunit.backdrop:SetColor(255, 255, 0, ARS.savedgroup.bgopacity);
            else
                groupunit.backdrop:SetColor(0, 0, 0, ARS.savedgroup.bgopacity);
            end

            if HodorReflexes and HodorReflexes.player.GetIconForUserId(accName) ~= nil then
                groupunit.role:SetTexture(HodorReflexes.player.GetIconForUserId(accName))
                groupunit.name:SetText(HodorReflexes.player.GetAliasForUserId(accName, true))
            else
                groupunit.role:SetTexture(UnitType[role])
                accName = accName:gsub('%@', '')
                groupunit.name:SetText(accName)
            end

            --reseting timer if someone joins, leaves or disconnects

            if ARS.savedgroup.primarysynergy ~= 99 then
                groupunit.primarysynergy:SetText("0")
                groupunit.primarysynergy:SetColor(255, 255, 255)
                groupunit.primarysynergy:SetHidden(false)
                groupunit.primarysynergy:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 168 + (30 * unitIndexer), 0)
                unitIndexer = unitIndexer + 1
            else
                groupunit.primarysynergy:SetHidden(true)
            end

            if ARS.savedgroup.secondarysynergy ~= 99 then
                groupunit.secondarysynergy:SetText("0")
                groupunit.secondarysynergy:SetColor(255, 255, 255)
                groupunit.secondarysynergy:SetHidden(false)
                groupunit.secondarysynergy:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 168 + (30 * unitIndexer), 0)
                unitIndexer = unitIndexer + 1
            else
                groupunit.secondarysynergy:SetHidden(true)
            end

            if ARS.savedgroup.tertiarysynergy ~= 99 then
                groupunit.tertiarysynergy:SetText("0")
                groupunit.tertiarysynergy:SetColor(255, 255, 255)
                groupunit.tertiarysynergy:SetHidden(false)
                groupunit.tertiarysynergy:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 168 + (30 * unitIndexer), 0)
                unitIndexer = unitIndexer + 1
            else
                groupunit.tertiarysynergy:SetHidden(true)
            end

            if ARS.savedgroup.quaternarysynergy ~= 99 then
                groupunit.quaternarysynergy:SetText("0")
                groupunit.quaternarysynergy:SetColor(255, 255, 255)
                groupunit.quaternarysynergy:SetHidden(false)
                groupunit.quaternarysynergy:SetAnchor(TOPLEFT, groupunit, TOPLEFT, 168 + (30 * unitIndexer), 0)
                unitIndexer = unitIndexer + 1
            else
                groupunit.quaternarysynergy:SetHidden(true)
            end

            groupunit.backdrop:SetDimensions(168 + (30 * unitIndexer), 24)

            position = position + 1
        end

    end
end

function GetSynergy(eventCode, result, _, abilityName, _, _, _, _, _, _, _, _, _, _, sourceUnitId, targetUnitId, abilityId)
    if result ~= ACTION_RESULT_EFFECT_GAINED then return end

    local getunit = ARS.GetNameForUnitId(targetUnitId)
    local getSource = ARS.GetNameForUnitId(sourceUnitId)

    for k, v in ipairs(synergypool) do
        --checking if this works in a group
        if synergypool[k].name == getunit or synergypool[k].name == getSource then
            if ARS.Synergies[abilityId] == ARS.savedgroup.primarysynergy then
                synergypool[k].primarysynergy = GetGameTimeSeconds() + 20
            elseif ARS.Synergies[abilityId] == ARS.savedgroup.secondarysynergy then
                synergypool[k].secondarysynergy = GetGameTimeSeconds() + 20
            elseif ARS.Synergies[abilityId] == ARS.savedgroup.tertiarysynergy then
                synergypool[k].tertiarysynergy = GetGameTimeSeconds() + 20
            elseif ARS.Synergies[abilityId] == ARS.savedgroup.quaternarysynergy then
                synergypool[k].quaternarysynergy = GetGameTimeSeconds() + 20
            end

            if abilityId == 75753 and ARS.savedgroup.halkosh then
                alkosh_user = getSource;
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
            synergypool[i].tertiarysynergy  = "0"
            synergypool[i].quaternarysynergy = "0"
        end
    end
end

function UpdateCooldown()
    for k, v in ipairs(synergypool) do
        if v.online ~= 0 then
            local pRemainingTime = math.floor(v.primarysynergy - GetGameTimeSeconds())
            local sRemainingTime = math.floor(v.secondarysynergy - GetGameTimeSeconds())
            local tRemainingTime = math.floor(v.tertiarysynergy - GetGameTimeSeconds())
            local qRemainingTime = math.floor(v.quaternarysynergy - GetGameTimeSeconds())

            groupunit = pool:AcquireObject(k)

            if alkosh_user == v.name and ARS.savedgroup.halkosh then
                groupunit.backdrop:SetColor(255, 255, 0, ARS.savedgroup.bgopacity);
            else

            end

            --primary
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

            --secondary
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

            --tertiary
            if tRemainingTime > 3 then
                groupunit.tertiarysynergy:SetColor(255, 0, 0)
                groupunit.tertiarysynergy:SetText(tRemainingTime)
            end

            if tRemainingTime < 4 and tRemainingTime > 0 then
                groupunit.tertiarysynergy:SetColor(255, 255, 0)
                groupunit.tertiarysynergy:SetText(tRemainingTime)
            end

            if tRemainingTime == 0 then
                groupunit.tertiarysynergy:SetColor(255, 255, 255)
                groupunit.tertiarysynergy:SetText("0")
            end

            --quarternary
            if qRemainingTime > 3 then
                groupunit.quaternarysynergy:SetColor(255, 0, 0)
                groupunit.quaternarysynergy:SetText(qRemainingTime)
            end

            if qRemainingTime < 4 and qRemainingTime > 0 then
                groupunit.quaternarysynergy:SetColor(255, 255, 0)
                groupunit.quaternarysynergy:SetText(qRemainingTime)
            end

            if qRemainingTime == 0 then
                groupunit.quaternarysynergy:SetColor(255, 255, 255)
                groupunit.quaternarysynergy:SetText("0")
            end
        end
    end
end

function ARS.SetGroupPosition()
    ARS.savedgroup.left = ARSTrackerFrame:GetLeft()
    ARS.savedgroup.top = ARSTrackerFrame:GetTop()
end

local function RestorePosition()
    ARSTrackerFrame:ClearAnchors();
    ARSTrackerFrame:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, ARS.savedgroup.left, ARS.savedgroup.top)
end

function ARS:InitializeSynergyTracker(enabled)
    if not enabled then return end

    defaults = {
        top                 = 500,
        left                = 500,
        primarysynergy      = 1,
        secondarysynergy    = 2,
        tertiarysynergy     = 3,
        quaternarysynergy   = 4,
        bgopacity           = 0.5,
    }

    ARS.savedgroup = ZO_SavedVars:NewCharacterIdSettings("ARSsaved", 1, "GroupTracker", defaults)

    AddToFragment(ARSTrackerFrame)
    CreateFrameHeader()

    pool = ZO_ObjectPool:New(CreateBuff, RemoveBuff)

    UpdateTimer()
    ARS.UpdateGroup()
    RestorePosition()

    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_JOINED , ARS.UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_LEFT , ARS.UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_ROLE_CHANGED , ARS.UpdateGroup)
    EVENT_MANAGER:RegisterForEvent(ARS.name.."GroupUpdate",EVENT_GROUP_MEMBER_CONNECTED_STATUS , ARS.UpdateGroup)

    EVENT_MANAGER:RegisterForEvent(ARS.name.."Synergy", EVENT_COMBAT_EVENT, GetSynergy)
    --[[for k, v in pairs(ARS.Synergies) do
        EVENT_MANAGER:RegisterForEvent(ARS.name.."Synergy"..k, EVENT_COMBAT_EVENT, GetSynergy)
        EVENT_MANAGER:AddFilterForEvent(ARS.name.."Synergy"..k, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, k)
    end]]--
    EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateCooldown", 250, UpdateCooldown)
end