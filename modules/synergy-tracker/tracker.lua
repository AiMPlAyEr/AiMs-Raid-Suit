ARS = ARS or {}

local pool

local pframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSSingleTrackerFrame")
pframe:SetResizeToFitDescendents(true)
pframe:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, 600, 600)
pframe:SetMovable(true)
pframe:SetMouseEnabled(true)

local function CreateBuff(pool)
    local name      = "ARSTracker" .. pool:GetNextControlId()
    local container = WINDOW_MANAGER:CreateControlFromVirtual(name, pframe, "TrackerTemplate")

    container.texture    = container:GetNamedChild("SynergyIcon")

    return container
end
 
local function RemoveBuff(control)
    control:SetHidden(true)
    control:ClearAnchors()
end

local function UpdateTracker()
    --z = 0
    for i = 1, 17 do
        local trackerunit = pool:AcquireObject(i)
        --trackerunit:SetAnchor(TOPLEFT, pframe, TOPLEFT, 52 * ((z % 4)), math.floor(z / 4) * 52)
        trackerunit:SetAnchor(TOPLEFT, pframe, TOPLEFT, 50 * (i - 1), 0)

        trackerunit.texture:SetTexture(ARS.SynergyTexture[i])
        --z = z + 1
    end
end

function ARS:InitializeTracker(enabled)
    if not enabled then return end

    pool = ZO_ObjectPool:New(CreateBuff, RemoveBuff)

    UpdateTracker()
end