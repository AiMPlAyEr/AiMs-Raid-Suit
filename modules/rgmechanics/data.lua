local ARS = ARS or {}

ARS.MechanicsData = {
    --Death Touch 2. Boss - purple glow around player
    [150078] = {
        name = GetAbilityName(150078),
        icon = GetAbilityIcon(150078),
        duration = GetAbilityDuration(150078)+1000,
        text = ARS_DEATH_TOUCH
    },

    --noxious puddle 1.Boss - Giftsuppe
    [157859] = {
        name = GetAbilityName(150061),
        icon = GetAbilityIcon(150061),
        duration = 2000, --might need adjustments
        text = ARS_NOXIOUS_PUDDLE
    },

    --Prime Meteor Spawn + Time until Explosion 2. Boss -- slime like thingy at 15%
    --wird im trash nach dem zweiten boss angezeigt
    --zweiter trash pull, wurde zwei mal angezeigt
    [153434] = {
        name = GetAbilityName(153434),
        icon = GetAbilityIcon(153434),
        duration = GetAbilityDuration(153434)-5000,
        text = ARS_PRIME_METEOR

    },

    --Noxious Sludge get out!
    [149193] = {
        name = GetAbilityName(157860),
        icon = GetAbilityIcon(157860),
        duration = 3000,
        text = ARS_NOXIOUS_SLUDGE

    },

    --Meteor Crash 1. Boss
    [152365] = {
        name = GetAbilityName(152370),
        icon = GetAbilityIcon(152370),
        duration = GetAbilityDuration(152365),
        text = ARS_METEOR_CRASH

    },


    --Savage Blitz 1. Boss - boss charge
    --149421 - if he is charging at you
    --target type none
    [149414] = {
        name = GetAbilityName(149414),
        icon = GetAbilityIcon(149414),
        duration = 3500,
        text = ARS_SAVAGE_BLITZ
    },

    --Fiery Detonation 2. Boss - Flame Atro explosion
    --GET OUT Message
    [157632] = {
        name = GetAbilityName(157632),
        icon = GetAbilityIcon(157632),
        duration = GetAbilityDuration(157632),
        text = ARS_FIERY_DETONATION
    },

    --Abomination spawns
    [152486] = {
        name = "Abomination",
        icon = GetAbilityIcon(152486),
        duration = GetAbilityDuration(152486),
        text = ARS_ABOMINATION_SPAWN
    },

    -----------------------------------------------------------
    -----------------------------------------------------------
    -----------------------------------------------------------
    -----------------------------------------------------------
    -----------------------------------------------------------

    --[[Fiery Detonation 2. Boss - Flame Atro explosion
    --GET OUT Message
    [157632] = {
        name = "|cFD5308"..GetAbilityName(157632).."|r",
        icon = GetAbilityIcon(157632),
        duration = GetAbilityDuration(157632),
    },
    --Luminous Eruption Explosion 2. Boss - Slime
    [152738] = {
        name = "|c"..GetAbilityName(152738).."|r",
        icon = GetAbilityIcon(152738),
        duration = GetAbilityDuration(152738)+2000,
    },
    ]]--

    --Noxious Sludge on you
    --kann ggf. gelöscht werden
    --[[[149190] = {
        name = "|c26980c"..GetAbilityName(157860).."|r. Cleans yourself!",
        icon = GetAbilityIcon(157860),
        duration = 3000,
        type = nil,

    },]]--

    --unstable wall of fire
    --[[[39053] = {
        name = "|cA7194B"..GetAbilityName(39053).."|r",
        icon = GetAbilityIcon(39053),
        duration = GetAbilityDuration(39053)+30000
    },]]--
}