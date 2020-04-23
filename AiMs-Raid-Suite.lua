ARS = ARS or {}
local ARS = ARS

ARS.name = "AiMs-Raid-Suite"
ARS.suitversion = "0.1"
ARS.default = {}

local zframe = nil
local test = nil

ARS.ActionResults = 
{
	ACTION_RESULT_DAMAGE,
	ACTION_RESULT_BEGIN,
	ACTION_RESULT_BEGIN_CHANNEL,
	ACTION_RESULT_EFFECT_GAINED,
	ACTION_RESULT_EFFECT_GAINED_DURATION,
	ACTION_RESULT_EFFECT_FADED,
	ACTION_RESULT_INTERRUPT, 
	ACTION_RESULT_DIED,
	--ACTION_RESULT_DIED_XP, -- only interested in spawns/minions, which don't give exp??
}

local log = {}

for _, result in ipairs(ARS.ActionResults) do
	log[result] = {}
end

function ARS.Mechanics(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)
	if not log[result] then
		return
	end

	if sType == COMBAT_UNIT_TYPE_PLAYER then
		return
	end

	if abilityId < 130000 then
		return
	end

	if (not log[result][abilityId] and targetType == COMBAT_UNIT_TYPE_PLAYER and (sourceType == COMBAT_UNIT_TYPE_OTHER or sourceType == COMBAT_UNIT_TYPE_NONE)) then
		new_ability = {
			name = GetAbilityName(abilityId),
			source = sourceName,
			target = targetName,
			source_type = sourceType,
			count = 0
		}

		log[result][abilityId] = new_ability
		
		log[result][abilityId].count = log[result][abilityId].count + 1

		ARS.debug.data[result][abilityId] = new_ability --writing updated log into saved variables

		d("Found new ability [#"..abilityId..","..GetAbilityName(abilityId).."] MOB: "..sourceName.." RESULT: "..result)
	end
	
	--Trash
	if abilityId == 134196 and result == 2200 then
		d("Crashing Wave. Block!")
		UpdateMessage("|c03a9f4Crashing Wave|r. Dodge or Block!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	if abilityId == 133936 and result == 2200 then
		d("Exploding Spear Block!")
		UpdateMessage("|cffc107Exploding Spear|r. Block!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	--First Boss
	if abilityId == 133285 and result == 2240 then
		d("Dragon Totem. Begins!")
		UpdateMessage("|cff9800 Dragon Totem|r spawns!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	if abilityId == 133285 and result == 2250 then
		d("Dragon Totem ends")
	end
	
	if abilityId == 136873 and result == 2240 then
		d("Gargoyle Totem. Begins!")
		UpdateMessage("|c795548 Gargoyle Totem|r spawns!", GetAbilityIcon(abilityId), 3000, 0)
	end

	if abilityId == 134023 and result == ACTION_RESULT_EFFECT_GAINED then
		d("Meteor on you. block!")
		UpdateMessage("Incoming |cffa500Meteor|r on you. Move out and Block!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	--Second Boss
	if abilityId == 140606 and result == ACTION_RESULT_EFFECT_GAINED then
		d("meteor on you. block!")
		UpdateMessage("Incoming |cffa500Meteor|r on you. Move out and Block!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	--Endboss
	
	if abilityId == 140941 and result == 2240 then
		d("Instability. Move out! PLAYERS: "..targetName)
		UpdateMessage("|cffeb3bInstability|r on you. Move out!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	if abilityId == 134856 and result == 2240 then
		d("Sanguine Grasp. Kite around!")
		UpdateMessage("|ce91e63Sanguine Grasp|r. Kite around!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	if abilityId == 132470 and result == 2240 then
		d("Sanguine Prison. Kill it!")
		UpdateMessage("|cff9800Sanguine Prison|r on |cffeb3b"..targetName.."|r!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	if abilityId == 136315 and result == 2200 then
		d("Blood Spear")
		UpdateMessage("|ce51c23Blood Spear|r. Don't Stack!", GetAbilityIcon(abilityId), 3000, 0)
	end
	
	if abilityId == 2240 and result == 2240 then
		d("Hemorrhage")
		UpdateMessage("|c9c27b0Hemorrhage|r begins!", GetAbilityIcon(abilityId), 3000, 0)
	end
end

function UpdateMessage(message, texture, duration, countdown)
	test:GetNamedChild("AlertTexture"):SetTexture(texture)
    test:GetNamedChild("AlertMessage"):SetText(message)
	test:SetHidden(false)
	PlaySound(SOUNDS.DUEL_START)
	zo_callLater(function()
		test:SetHidden(true)
	end, duration)
end

function ARS:Initialize()
	--Saved Variables
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "Ability" , EVENT_COMBAT_EVENT, ARS.Mechanics)
	
	ARS.debug = ZO_SavedVars:NewAccountWide("ARSAbilityLog", 1, nil, ARS.default)

	zframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSAlertFrame")
	zframe:SetResizeToFitDescendents(true)
	zframe:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	zframe:SetMovable(true)
	zframe:SetMouseEnabled(true)

	test = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)ARSTest", zframe, "ARSTest")
	test:SetHidden(true)
	test:SetAnchor(CENTER, nil, CENTER, 0, -250)
	test:SetResizeToFitDescendents(true)

    --ARS:InitializeSynergyTracker(true)
    --ARS:InitializeTracker(true)
end

function ARS.OnAddOnLoaded(event, addonName)
	if addonName ~= ARS.name then return end
        ARS:Initialize()
end

EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_ADD_ON_LOADED, ARS.OnAddOnLoaded)