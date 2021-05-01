local ARS = ARS or {}

ARS.MechanicsData = {
    --Death Touch 2. Boss - purple glow around player
    [150078] = {
        name = GetAbilityName(150078),
        icon = GetAbilityIcon(150078),
        duration = GetAbilityDuration(150078)+1000,
        text = ARS_DEATH_TOUCH,
        notifySound = SOUNDS.DUEL_START,
        timer = true,
    },

    --noxious puddle 1.Boss - Giftsuppe
    [157859] = {
        name = GetAbilityName(150061),
        icon = GetAbilityIcon(150061),
        duration = 1000,
        text = ARS_NOXIOUS_PUDDLE,
        notifySound = SOUNDS.DUEL_START,
        timer = false,
    },

    --Prime Meteor Spawn + Time until Explosion 
    [153434] = {
        name = GetAbilityName(153434),
        icon = GetAbilityIcon(153434),
        duration = GetAbilityDuration(153434)-5000,
        text = ARS_PRIME_METEOR,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = true,

    },

    --Noxious Sludge
    [149193] = {
        name = GetAbilityName(157860),
        icon = GetAbilityIcon(157860),
        duration = 3000,
        text = ARS_NOXIOUS_SLUDGE,
        notifySound = SOUNDS.DUEL_START,
        timer = true,

    },

    --Meteor Crash 1. Boss
    [152365] = {
        name = GetAbilityName(152370),
        icon = GetAbilityIcon(152370),
        duration = GetAbilityDuration(152365),
        text = ARS_METEOR_CRASH,
        notifySound = SOUNDS.DUEL_START,
        timer = true,

    },


    --Savage Blitz 1. Boss - boss charge
    --149421 - if you are in his path
    --target type none
    [149414] = {
        name = GetAbilityName(149414),
        icon = GetAbilityIcon(149414),
        duration = 3500,
        text = ARS_SAVAGE_BLITZ,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = true,
    },

    [149421] = {
        name = GetAbilityName(149421),
        icon = GetAbilityIcon(149421),
        duration = 2000,
        text = ARS_SAVAGE_BLITZ_DODGE,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = true,
    },

    --Fiery Detonation 2. Boss - Flame Atro explosion
    --GET OUT Message
    [157346] = {
        name = GetAbilityName(157632),
        icon = GetAbilityIcon(157632),
        duration = GetAbilityDuration(157346)-2000,
        text = ARS_FIERY_DETONATION,
        notifySound = SOUNDS.DUEL_START,
        timer = true,
    },
    --Abomination spawns
    [152486] = {
        name = "Abomination",
        icon = GetAbilityIcon(152486),
        duration = GetAbilityDuration(152486),
        text = ARS_ABOMINATION_SPAWN,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = false,
    },
    [157243] = {
        name = "Taking Aim",
        icon = GetAbilityIcon(157243),
        duration = 3500,
        text = ARS_TAKING_AIM,
        notifySound = SOUNDS.DUEL_START,
        timer = true,
    },
    [155357] = {
        name = "Meteor",
        icon = GetAbilityIcon(155357),
        duration = GetAbilityDuration(155357),
        text = ARS_METEOR_SWARM,
        notifySound = SOUNDS.DUEL_START,
        timer = true,
    },
    [157466] = {
        name = GetAbilityName(157466),
        icon = GetAbilityIcon(157466),
        duration = 2000,
        text = ARS_SOUL_RESONANCE,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = false,
    },
    [149346] = {
        name = GetAbilityName(149346),
        icon = GetAbilityIcon(149346),
        duration = GetAbilityDuration(149346),
        text = ARS_IGNITED,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = true,
    },
    -----------------------------------------------------------
    -----------------------------------------------------------
    -----------------------------------------------------------
    -----------------------------------------------------------
    -----------------------------------------------------------

    --unstable wall of fire
    --[[[39053] = {
        name = "|cA7194B"..GetAbilityName(39053).."|r",
        icon = GetAbilityIcon(39053),
        duration = GetAbilityDuration(39053)+30000,
        text = ARS_ABOMINATION_SPAWN,
        notifySound = SOUNDS.OBJECTIVE_DISCOVERED,
        timer = false,
    },]]--
}