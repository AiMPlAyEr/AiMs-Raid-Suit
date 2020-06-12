ARS = ARS or {}

function ARS.SynergyTrackerSettings()
    local LAM = LibAddonMenu2
    local panelName = "AiM's-Synergy-Tracker"
    
    local panelData = {
        type = "panel",
        name = "AiM's-Synergy-Tracker",
        author = "AiMPlAyEr[EU]",
    }
    local panel = LAM:RegisterAddonPanel(panelName, panelData)
    local optionsData = {
        {
            type = "texture",
            image = ARS.SynergyTexture[1],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Combustion",
            getFunc = function() return ARS.savedsolo.synergies[1] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[1] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[2],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Conduit",
            getFunc = function() return ARS.savedsolo.synergies[2] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[2] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[3],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Purge",
            getFunc = function() return ARS.savedsolo.synergies[3] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[3] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[4],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Harvest",
            getFunc = function() return ARS.savedsolo.synergies[4] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[4] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[5],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Bone Wall",
            getFunc = function() return ARS.savedsolo.synergies[5] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[5] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[6],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Blood Altar",
            getFunc = function() return ARS.savedsolo.synergies[6] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[6] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[7],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Trapping Webs",
            getFunc = function() return ARS.savedsolo.synergies[7] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[7] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[8],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Radiate",
            getFunc = function() return ARS.savedsolo.synergies[8] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[8] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[9],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Atronach",
            getFunc = function() return ARS.savedsolo.synergies[9] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[9] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[10],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Shackle",
            getFunc = function() return ARS.savedsolo.synergies[10] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[10] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[11],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Ignite",
            getFunc = function() return ARS.savedsolo.synergies[11] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[11] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[12],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Nova",
            getFunc = function() return ARS.savedsolo.synergies[12] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[12] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[13],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Hidden Refresh",
            getFunc = function() return ARS.savedsolo.synergies[13] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[13] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[14],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Soul Leech",
            getFunc = function() return ARS.savedsolo.synergies[14] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[14] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[15],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Grave Robber",
            getFunc = function() return ARS.savedsolo.synergies[15] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[15] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[16],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Pure Agony",
            getFunc = function() return ARS.savedsolo.synergies[16] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[16] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        },
        {
            type = "texture",
            image = ARS.SynergyTexture[17],
            imageWidth = "32",
            imageHeight = "32",
            width = "half"
        },
        {
            type = "checkbox",
            name = "Icy Escape",
            getFunc = function() return ARS.savedsolo.synergies[17] end,
            setFunc = function(value) 
                ARS.savedsolo.synergies[17] = value 
                ARS.UpdateTracker()
            end,
            width = "half"
        }  
    }
    LAM:RegisterOptionControls(panelName, optionsData)
end