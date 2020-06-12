ARS = ARS or {}

function ARS.BlockedSynergySettings()
    local LAM = LibAddonMenu2
    local panelName = "Blocking-Trial-Synergies"
    
    local panelData = {
        type = "panel",
        name = "Blocking-Trial-Synergies",
        author = "AiMPlAyEr[EU]",
    }
    local panel = LAM:RegisterAddonPanel(panelName, panelData)
    local optionsData = {
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
    LAM:RegisterOptionControls(panelName, optionsData)
end