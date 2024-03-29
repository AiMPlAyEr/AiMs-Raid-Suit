ARS = ARS or {}

function ARS.SynergyTrackerSettings()
    local LAM = LibAddonMenu2
    local panelName = "AiM's-Synergy-Tracker"
    
    local panelData = {
        type = "panel",
        name = "AiM's-Synergy-Tracker",
        author = "|cfd6a02AiMPlAyEr[EU]|r",
        version = ARS.version,
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
    if ARS.savedgeneral.synergytracker then
        table.insert(optionsData, {
            type = "submenu",
            name = "Solo Tracker",
            controls = {
                {
                    type = "description",
                    text = [[The |cff0000Solo Tracker|r shows you the cooldowns of your synergies.]],               
                },
                {
                    type = "header",
                    name = "Synergies"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[1].."|t "..GetAbilityName(39301),
                    getFunc = function() return ARS.savedsolo.synergies[1] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[1] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[2].."|t "..GetAbilityName(23196),
                    getFunc = function() return ARS.savedsolo.synergies[2] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[2] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[3].."|t "..GetAbilityName(26305),
                    getFunc = function() return ARS.savedsolo.synergies[3] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[3] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[4].."|t "..GetAbilityName(85577),
                    getFunc = function() return ARS.savedsolo.synergies[4] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[4] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[5].."|t "..GetAbilityName(39379),
                    getFunc = function() return ARS.savedsolo.synergies[5] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[5] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[6].."|t "..GetAbilityName(39489),
                    getFunc = function() return ARS.savedsolo.synergies[6] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[6] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[7].."|t "..GetAbilityName(42020),
                    getFunc = function() return ARS.savedsolo.synergies[7] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[7] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[8].."|t "..GetAbilityName(41838),
                    getFunc = function() return ARS.savedsolo.synergies[8] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[8] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[9].."|t "..GetAbilityName(48076),
                    getFunc = function() return ARS.savedsolo.synergies[9] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[9] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[10].."|t "..GetAbilityName(32905),
                    getFunc = function() return ARS.savedsolo.synergies[10] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[10] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[11].."|t "..GetAbilityName(32974),
                    getFunc = function() return ARS.savedsolo.synergies[11] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[11] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[12].."|t "..GetAbilityName(31597),
                    getFunc = function() return ARS.savedsolo.synergies[12] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[12] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[13].."|t "..GetAbilityName(37729),
                    getFunc = function() return ARS.savedsolo.synergies[13] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[13] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[14].."|t "..GetAbilityName(25170),
                    getFunc = function() return ARS.savedsolo.synergies[14] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[14] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[15].."|t "..GetAbilityName(115548),
                    getFunc = function() return ARS.savedsolo.synergies[15] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[15] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[16].."|t "..GetAbilityName(118604),
                    getFunc = function() return ARS.savedsolo.synergies[16] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[16] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[17].."|t "..GetAbilityName(88884),
                    getFunc = function() return ARS.savedsolo.synergies[17] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[17] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
                },
                {
                    type = "checkbox",
                    name = "|t32:32:"..ARS.SynergyTexture[18].."|t "..GetAbilityName(141920),
                    getFunc = function() return ARS.savedsolo.synergies[18] end,
                    setFunc = function(value) 
                        ARS.savedsolo.synergies[18] = value 
                        ARS.UpdateTracker()
                    end,
                    width = "full"
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
                    type = "description",
                    text = [[The |c0000ffGroup Tracker|r shows cooldowns of synergies for yourself and your group.]],               
                },
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
                {
                    type = "checkbox",
                    name = "Highlight Alkosh User",
                    getFunc = function() return ARS.savedgroup.halkosh end,
                    setFunc = function(value) 
                        ARS.savedgroup.halkosh = value 
                    end,
                    width = "full"
                },
            }
        })
    end


    LAM:RegisterOptionControls(panelName, optionsData)
end