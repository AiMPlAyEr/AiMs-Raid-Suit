ARS = ARS or {}

function ARS.KAMechanicsSettings()
    local LAM = LibAddonMenu2
    local panelName = ARS.name
    
    local panelData = {
        type = "panel",
        name = "Kynes-Aegis-Mechanics",
        displayName = "Kynes-Aegis-Mechanics",
        author = "|cfd6a02AiMPlAyEr[EU]|r",
        version = ARS.suiteversion,
    }
    local panel = LAM:RegisterAddonPanel(panelName, panelData)
    local optionsData = {}

    table.insert(optionsData, {
        type = "submenu",
        name = "Trash",
        controls = {
            [1] = {
                type = "checkbox",
                name = "Crashing Wave",
                tooltip = "Ability of Half-Giant Tidebreaker",
                getFunc = function() return ARS.sv.crashing_wave end,
                setFunc = function(value) ARS.sv.crashing_wave = value end,
            },
            [2] = {
                type = "checkbox",
                name = "Exploding Spear",
                tooltip = "",
                getFunc = function() return ARS.sv.exploding_spear end,
                setFunc = function(value) ARS.sv.exploding_spear = value end,
            }
        },
    })

    table.insert(optionsData, {
        type = "submenu",
        name = "Yandir the Butcher",
        controls = {
            [1] = {
                type = "checkbox",
                name = "Dragon Totem",
                tooltip = "",
                getFunc = function() return ARS.sv.dragon_totem end,
                setFunc = function(value) ARS.sv.dragon_totem = value end,
            },
            [2] = {
                type = "checkbox",
                name = "Gargoyle Totem",
                tooltip = "",
                getFunc = function() return ARS.sv.gargoyle_totem end,
                setFunc = function(value) ARS.sv.gargoyle_totem = value end,
            },
            [3] = {
                type = "checkbox",
                name = "Harpy Totem",
                tooltip = "",
                getFunc = function() return ARS.sv.harpy_totem end,
                setFunc = function(value) ARS.sv.harpy_totem = value end,
            },
            [4] = {
                type = "checkbox",
                name = "Chaurus Totem",
                tooltip = "",
                getFunc = function() return ARS.sv.chaurus_totem end,
                setFunc = function(value) ARS.sv.chaurus_totem = value end,
            },
            [5] = {
                type = "checkbox",
                name = "Meteor",
                tooltip = "",
                getFunc = function() return ARS.sv.meteor_yandir end,
                setFunc = function(value) ARS.sv.meteor_yandir = value end,
            },
            [6] = {
                type = "checkbox",
                name = "Chaurus Bile",
                tooltip = "",
                getFunc = function() return ARS.sv.chaurus_bile end,
                setFunc = function(value) ARS.sv.chaurus_bile = value end,
            },
        },
    })

    table.insert(optionsData, {
        type = "submenu",
        name = "Captain Vrol",
        controls = {
            [1] = {
                type = "checkbox",
                name = "Meteor",
                tooltip = "",
                getFunc = function() return ARS.sv.meteor_vrol end,
                setFunc = function(value) ARS.sv.meteor_vrol = value end,
            },
            [2] = {
                type = "checkbox",
                name = "Frigid Fog",
                tooltip = "",
                getFunc = function() return ARS.sv.frigid_fog end,
                setFunc = function(value) ARS.sv.frigid_fog = value end,
            },
        },
    })

    table.insert(optionsData, {
        type = "submenu",
        name = "Lord Falgravn",
        controls = {
            [1] = {
                type = "checkbox",
                name = "Instability",
                tooltip = "",
                getFunc = function() return ARS.sv.instability end,
                setFunc = function(value) ARS.sv.instability = value end,
            },
            [2] = {
                type = "checkbox",
                name = "Sanguine Grasp",
                tooltip = "",
                getFunc = function() return ARS.sv.sanguine_grasp end,
                setFunc = function(value) ARS.sv.sanguine_grasp = value end,
            },
            [3] = {
                type = "checkbox",
                name = "Sanguine Prison",
                tooltip = "",
                getFunc = function() return ARS.sv.sanguine_prison end,
                setFunc = function(value) ARS.sv.sanguine_prison = value end,
            },
            [4] = {
                type = "checkbox",
                name = "Blood Spear",
                tooltip = "",
                getFunc = function() return ARS.sv.blood_spear end,
                setFunc = function(value) ARS.sv.blood_spear = value end,
            },
        },
    })

    LAM:RegisterOptionControls(panelName, optionsData)
end