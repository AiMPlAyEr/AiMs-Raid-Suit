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
    local optionsData = {}

    table.insert(optionsData, {
        type = "checkbox",
        name = "Synergy Tracker",
        getFunc = function() return ARS.savedgeneral.synergytracker end,
        setFunc = function(value) 
            ARS.savedgeneral.synergytracker = value 
        end,
        warning = "Will need to reload the UI.",
    })

    table.insert(optionsData, {
        type = "checkbox",
        name = "Group Tracker",
        getFunc = function() return ARS.savedgeneral.grouptracker end,
        setFunc = function(value) 
            ARS.savedgeneral.grouptracker = value 
        end,
        warning = "Will need to reload the UI.",
    })
    table.insert(optionsData, {
        type = "checkbox",
        name = "Synergy Blocker",
        getFunc = function() return ARS.savedgeneral.synergyblocker end,
        setFunc = function(value) 
            ARS.savedgeneral.synergyblocker = value 
        end,
        warning = "Will need to reload the UI.",
    })

    if ARS.savedgeneral.synergytracker then
        table.insert(optionsData, {
            type = "submenu",
            name = "Solo Tracker",
            controls = {
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
        })
    end

    if ARS.savedgeneral.grouptracker then
        table.insert(optionsData, {
            type = "submenu",
            name = "Group Tracker",
            controls = {
                {
                    type = "dropdown",
                    name = "Primary Synergy",
                    choices = ARS.GroupSynergyList,
                    choicesValues = ARS.GroupSynergyListValues,
                    getFunc = function() return ARS.savedgroup.primarysynergy end,
                    setFunc = function(var) 
                        ARS.savedgroup.primarysynergy = var 
                        ARS.UpdateGroup()
                    end
                },
                {
                    type = "dropdown",
                    name = "Secondary Synergy",
                    choices = ARS.GroupSynergyList,
                    choicesValues = ARS.GroupSynergyListValues,
                    getFunc = function() return ARS.savedgroup.secondarysynergy end,
                    setFunc = function(var) 
                        ARS.savedgroup.secondarysynergy = var 
                        ARS.UpdateGroup()
                    end
                },
                {
                    type = "dropdown",
                    name = "Tertiary Synergy",
                    choices = ARS.GroupSynergyList,
                    choicesValues = ARS.GroupSynergyListValues,
                    getFunc = function() return ARS.savedgroup.tertiarysynergy end,
                    setFunc = function(var) 
                        ARS.savedgroup.tertiarysynergy = var 
                        ARS.UpdateGroup()
                    end
                },
                {
                    type = "dropdown",
                    name = "Quaternary Synergy",
                    choices = ARS.GroupSynergyList,
                    choicesValues = ARS.GroupSynergyListValues,
                    getFunc = function() return ARS.savedgroup.quaternarysynergy end,
                    setFunc = function(var) 
                        ARS.savedgroup.quaternarysynergy = var 
                        ARS.UpdateGroup()
                    end
                },
            }
        })
    end

    if ARS.savedgeneral.synergyblocker then
        table.insert(optionsData, {
            type = "submenu",
            name ="Trial Synergy Blocker",
            controls = {
                {
                    type = "header",
                    name = "Kynes Aegis"
                },
                {
                    type = "checkbox",
                    name = GetAbilityName(134016),
                    getFunc = function() return ARS.savedblock[134016] end,
                    setFunc = function(value) 
                        ARS.savedblock[134016] = value 
                    end
                },
                {
                    type = "header",
                    name = "Cloudrest"
                },
                {
                    type = "checkbox",
                    name = GetAbilityName(103489),
                    getFunc = function() return ARS.savedblock[103489] end,
                    setFunc = function(value) 
                        ARS.savedblock[103489] = value 
                    end
                },
                {
                    type = "header",
                    name = "Hel Ra Citadel"
                },
                {
                    type = "checkbox",
                    name = GetAbilityName(56667),
                    getFunc = function() return ARS.savedblock[56667] end,
                    setFunc = function(value) 
                        ARS.savedblock[56667] = value 
                    end
                },
                {
                    type = "header",
                    name = "Sunspire"
                },
                {
                    type = "checkbox",
                    name = GetAbilityName(121216),
                    getFunc = function() return ARS.savedblock[121216] end,
                    setFunc = function(value) 
                        ARS.savedblock[121216] = value 
                    end
                },
            }
        })
    end

    LAM:RegisterOptionControls(panelName, optionsData)
end