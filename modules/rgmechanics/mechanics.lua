ARS = ARS or {}

local pool

local function CreateNotification(pool)
    local name      = "ARSMechanic" .. pool:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, GuiRoot, "MechanicTemplate")

    container.mtext    = container:GetNamedChild('MechanicText')
    container.texture   = container:GetNamedChild("MechanicIcon")

    return container
end

local function RemoveBuff(control)
    control:SetHidden(true)
    control:ClearAnchors()
end

local function MechanicCheck(eventCode, result, _, abilityName, _, _, _, sourceType, _, targetType, _, _, _, _, sourceUnitId, targetUnitId, abilityId)
    if (sourceType == COMBAT_UNIT_TYPE_PLAYER or sourceType == COMBAT_UNIT_TYPE_GROUP or targetType == COMBAT_UNIT_TYPE_GROUP or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        
    end
end


function ARS:InitializeRGMechanics(enabled)
    d("Reee2")
    if not enabled then return end

    ARS.rgmechanics = ZO_SavedVars:NewCharacterIdSettings("ARSsaved", 1, "RGMechanics", defaults)

    pool = ZO_ObjectPool:New(CreateNotification, RemoveNotification)

    
    d("Reee1")

    for i = 1, 5 do
        d('Reee')
        if v then
            local trackerunit = pool:AcquireObject(1)
            trackerunit:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 500, 500)

            trackerunit:SetHidden(false)
            trackerunit.texture:SetTexture(v.name)
            trackerunit.mtext:SetText("GIB TEXT DU FICK NUGGET")
        end
    end

    EVENT_MANAGER:RegisterForEvent(ARS.name.."mechanic", EVENT_COMBAT_EVENT, MechanicCheck)
end