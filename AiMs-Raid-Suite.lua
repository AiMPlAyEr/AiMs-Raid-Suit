ARS = ARS or {}
local ARS = ARS

ARS.name = "AiMs-Raid-Suite"
ARS.suitversion = "0.1"
ARS.default = {}

local log = {}

function ARS.Mechanics(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)	
	--Trash
	if abilityId == 134196 and result == 2200 then
		d("Crashing Wave. Block! "..targetType)
		UpdateMessage("|c03a9f4Crashing Wave|r in ", GetAbilityIcon(abilityId), 4000, 3000, "|cff0000Block or Dodge|r")
	end
	
	if abilityId == 133936 and result == 2200 and targetType == COMBAT_UNIT_TYPE_PLAYER then
		d("Exploding Spear Block!")
		UpdateMessage("|cffc107Exploding Spear|r. Block!", GetAbilityIcon(abilityId), 3000, 0,nil)
	end
	
	--First Boss
	if abilityId == 133045 and result == 2200 then
		UpdateMessage("|cff9800Dragon Totem|r spawns!", GetAbilityIcon(abilityId), 3000, 0, nil)
	end
	
	if abilityId == 133513 and result == 2200 then
		UpdateMessage("|c795548Gargoyle Totem|r spawns! Block!", GetAbilityIcon(abilityId), 3000, 0, nil)
	end

	if abilityId == 133510 and result == 2200 then
		UpdateMessage("|c795548Harpy Totem|r spawns!", GetAbilityIcon(abilityId), 3000, 0, nil)
	end

	if abilityId == 133515 and result == 2200 then
		UpdateMessage("|c795548Chaurus Totem|r spawns! Don't Stack!", GetAbilityIcon(abilityId), 3000, 0, nil)
	end

	if abilityId == 134023 and result == 2200 then
		UpdateMessage("Incoming |cffa500Meteor|r on you. Block!", GetAbilityIcon(abilityId), 3000, 0, nil)
	end
	
	--Second Boss
	if abilityId == 140606 and result == ACTION_RESULT_EFFECT_GAINED and targetType == COMBAT_UNIT_TYPE_PLAYER then
		d("meteor on you. block!")
		UpdateMessage("Incoming |cffa500Meteor|r on you. Block!", GetAbilityIcon(abilityId), 3000, 0)
	end

	if abilityId == 133808 then
		d("frigid fog! result: "..result)
	end

	if abilityId == 133913 and result == 2200 then
		UpdateMessage(GetString(ARS_FRIGID_FOG), GetAbilityIcon(abilityId), 3000, 0)
	end
	
	--Endboss
	
	if abilityId == 140942 then
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

function ARS:Initialize()
	
	ARS.debug = ZO_SavedVars:NewAccountWide("ARSAbilityLog", 1, nil, ARS.default)
	
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "Ability" , EVENT_COMBAT_EVENT, ARS.Mechanics)

	zframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSAlertFrame")
	zframe:SetResizeToFitDescendents(true)
	zframe:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	zframe:SetMovable(true)
	zframe:SetMouseEnabled(true)

	test = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)ARSTest", zframe, "ARSTest")
	test:SetHidden(false)
	test:SetAnchor(CENTER, nil, CENTER, 0, -250)
	test:SetResizeToFitDescendents(true)
	test:GetNamedChild("AlertTexture"):SetTexture(GetAbilityIcon(22095))
	test:GetNamedChild("AlertMessage"):SetText(zo_strformat(GetString(ARS_CRASHING_WAVE), GetAbilityName(22095)))
	test:GetNamedChild("AlertTimer"):SetText("3.0s")

    --ARS:InitializeSynergyTracker(true)
    --ARS:InitializeTracker(true)
end

function ARS.OnAddOnLoaded(event, addonName)
	if addonName ~= ARS.name then return end
        ARS:Initialize()
end

EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_ADD_ON_LOADED, ARS.OnAddOnLoaded)