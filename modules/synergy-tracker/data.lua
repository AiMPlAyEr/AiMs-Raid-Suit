local ARS = ARS or {}

local COMBUSTION_SYNERGY        = 1     -- orb and shard
local CONDUIT_SYNERGY           = 2     -- liquid lightning
local PURGE_SYNERGY             = 3     -- extended ritual
local HEALING_SYNERGY           = 4     -- healing seed
local BONE_SYNERGY              = 5     -- bone shield
local BLOOD_SYNERGY             = 6     -- blood altar
local TRAPPING_SYNERGY          = 7     -- trapping webs
local RADIATE_SYNERGY           = 8     -- radiate
local ATRONACH_SYNERGY          = 9     -- summon storm atronach
local SHACKLE_SYNERGY           = 10    -- Dragonknight Standard
local IGNITE_SYNERGY            = 11    -- Dark Talons
local NOVA_SYNERGY              = 12    -- Nova and Supernova
local HIDDEN_REFRESH_SYNERGY    = 13    -- Consuming Darkness
local SOUL_LEECH_SYNERGY        = 14    -- Soul Shred
local GRAVE_ROBBER_SYNERGY      = 15    -- Grave Robber
local PURE_AGONY_SYNERGY        = 16    -- Pure Agony
local ICY_ESCAPE                = 17    -- Icy Escape
local SANGUINE_BURST			= 18	-- Sanguine Burst

ARS.Synergies = {
    [108782]    = BLOOD_SYNERGY,                -- Blood Funnel Synergy     (Blood Altar)
    [108787]    = BLOOD_SYNERGY,                -- Blood Feast Synergy      (Overflowing Altar)
    [108788]    = TRAPPING_SYNERGY,             -- Spawn Broodlings Synergy (Trapping Webs)
    [108791]    = TRAPPING_SYNERGY,             -- Black Widows Synergy     (Shadow Silk)
    [108792]    = TRAPPING_SYNERGY,             -- Arachnophobia Synergy    (Tangling Webs)
    [108793]    = RADIATE_SYNERGY,              -- Radiate Synergy          (Inner Fire)
    [108794]    = BONE_SYNERGY,                 -- Bone Wall Synergy        (Bone Shield)
    [108797]    = BONE_SYNERGY,                 -- Spinal Surge Synergy     (Bone Surge)
    [108799]    = COMBUSTION_SYNERGY,           -- Combustion Synergy       (Necrotic Orb)
    [108802]    = COMBUSTION_SYNERGY,           -- Combustion Synergy       (Energy Orb)
    [108821]    = COMBUSTION_SYNERGY,           -- Holy Shards Synergy      (Luminous Shards)
    [108924]    = COMBUSTION_SYNERGY,           -- Blessed Shards Synergy   (Spear Shards)
    [108607]    = CONDUIT_SYNERGY,              -- Conduit Synergy          (Lightning Splash)
    [108826]    = HEALING_SYNERGY,              -- Harvest Synergy          (Healing Seed)
    [108824]    = PURGE_SYNERGY,                -- Purge Synergy            (Extended Ritual)
    [102321]    = ATRONACH_SYNERGY,             -- Charged Lightning        (Summon Storm Atronach)
    [108805]    = SHACKLE_SYNERGY,              -- Shackle Synergy          (Dragonknight Standard)
    [108807]    = IGNITE_SYNERGY,               -- Ignite Synergy           (Dark Talons)
    [108822]    = NOVA_SYNERGY,                 -- Supernova Synergy        (Nova)
    [108823]    = NOVA_SYNERGY,                 -- Gravity Crush Synergy    (Supernova)
    [108808]    = HIDDEN_REFRESH_SYNERGY,       -- Hidden Refresh Synergy   (Consuming Darkness)
    [108814]    = SOUL_LEECH_SYNERGY,           -- Soul Leech Synergy       (Soul Shred)
    [115567]    = GRAVE_ROBBER_SYNERGY,         -- Boneyard Synergy         (Grave Robber)
    [115571]    = GRAVE_ROBBER_SYNERGY,         -- Avid Boneyard Synergy    (Grave Robber)
    [118610]    = PURE_AGONY_SYNERGY,           -- Agony Totem Synergy      (Pure Agony)
    [108950]    = ICY_ESCAPE,                   -- Icy Escape Synergy       (Frozen Retreat)
    [142318]	= SANGUINE_BURST                -- Sanguine Burst Synergy   (Lady Thorn)
}

ARS.SynergyTexture = {
    [COMBUSTION_SYNERGY]     = "/esoui/art/icons/ability_undaunted_004b.dds",
    [CONDUIT_SYNERGY]        = "/esoui/art/icons/ability_sorcerer_liquid_lightning.dds",
    [PURGE_SYNERGY]          = "/esoui/art/icons/ability_templar_extended_ritual.dds",
    [HEALING_SYNERGY]        = "/esoui/art/icons/ability_warden_007.dds",
    [BONE_SYNERGY]           = "/esoui/art/icons/ability_undaunted_005b.dds",
    [BLOOD_SYNERGY]          = "/esoui/art/icons/ability_undaunted_001_b.dds",
    [TRAPPING_SYNERGY]       = "/esoui/art/icons/ability_undaunted_003_b.dds",
    [RADIATE_SYNERGY]        = "/esoui/art/icons/ability_undaunted_002_b.dds",
    [ATRONACH_SYNERGY]       = "/esoui/art/icons/ability_sorcerer_storm_atronach.dds",
    [SHACKLE_SYNERGY]        = "/esoui/art/icons/ability_dragonknight_006.dds",
    [IGNITE_SYNERGY]         = "/esoui/art/icons/ability_dragonknight_010.dds",
    [NOVA_SYNERGY]           = "/esoui/art/icons/ability_templar_solar_disturbance.dds",
    [HIDDEN_REFRESH_SYNERGY] = "/esoui/art/icons/ability_nightblade_015.dds",
    [SOUL_LEECH_SYNERGY]     = "/esoui/art/icons/ability_nightblade_018.dds",
    [GRAVE_ROBBER_SYNERGY]   = "/esoui/art/icons/ability_necromancer_004_b.dds",
    [PURE_AGONY_SYNERGY]     = "/esoui/art/icons/ability_necromancer_010_b.dds",
    [ICY_ESCAPE]             = "/esoui/art/icons/ability_warden_005_b.dds",
    [SANGUINE_BURST]		 = "/esoui/art/icons/ability_u23_bloodball_chokeonit.dds",
}

ARS.GroupSynergyList = {
	"Nothing",
    GetAbilityName(39489), 
    GetAbilityName(42020), 
    GetAbilityName(39379), 
    GetAbilityName(39301), 
    GetAbilityName(23196), 
    GetAbilityName(85577), 
    GetAbilityName(26305), 
    GetAbilityName(31597),
    GetAbilityName(115548),
    GetAbilityName(118604),
    GetAbilityName(141920),
}

ARS.GroupSynergyListValues = {
	99,
    6, 
    7, 
    5, 
    1, 
    2, 
    4, 
    3, 
    12,
    15,
    16,
    18,
}