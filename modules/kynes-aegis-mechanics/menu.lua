ARS = ARS or {}

function ARS.KAMechanicsSettings()
    local LAM = LibAddonMenu2
    local saveData = {} -- TODO this should be a reference to your actual saved variables table
    local panelName = ARS.name
    
    local panelData = {
        type = "panel",
        name = "Kynes-Aegis-Mechanics",
        displayName = "Kynes-Aegis-Mechanics",
        author = "|cfd6a02AiMPlAyEr[EU]|r",
        version = ARS.version,
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
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [2] = {
                type = "checkbox",
                name = "Exploding Spear",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
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
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [2] = {
                type = "checkbox",
                name = "Gargoyle Totem",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [3] = {
                type = "checkbox",
                name = "Harpy Totem",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [4] = {
                type = "checkbox",
                name = "Chaurus Totem",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [5] = {
                type = "checkbox",
                name = "Meteor",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
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
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [2] = {
                type = "checkbox",
                name = "Frigid Fog",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
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
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [2] = {
                type = "checkbox",
                name = "Sanguine Grasp",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [3] = {
                type = "checkbox",
                name = "Sanguine Prison",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
            [4] = {
                type = "checkbox",
                name = "Blood Spear",
                tooltip = "",
                getFunc = function() return true end,
                setFunc = function(value) end,
            },
        },
    })

    LAM:RegisterOptionControls(panelName, optionsData)
end