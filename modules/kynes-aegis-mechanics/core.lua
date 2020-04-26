ARS = ARS or {}

local alert_pool = {}
local pool
local zframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSParent")
zframe:SetResizeToFitDescendents(true)
zframe:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
zframe:SetMovable(true)
zframe:SetMouseEnabled(true)

ARS.default = {
	mechanics = {
		crashing_wave 		= true,
		exploding_spear 	= true,
		dragon_totem 		= true,
		gargoyle_toem 		= true,
		harpy_totem 		= true,
		chaurus_totem 		= true,
		meteor_yandir 		= true,
		chaurus_bile 		= true,
		meteor_vrol 		= true,
		frigid_fog 			= true,
		instability 		= true,
		sanguine_grasp 		= true,
		sanguine_prison 	= true,
		blood_spear 		= true
	},
	sound_played = SOUNDS.DUEL_START
}

function ARS.Mechanics(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)	
	--Trash 
	if abilityId == 22095 and result == 2240 then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_CRASHING_WAVE), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 5000,
			hascountdown = true,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	if abilityId == 134196 and result == ACTION_RESULT_BEGIN and ARS.sv.crashing_wave then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_CRASHING_WAVE), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + hitValue,
			hascountdown = true,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if string.match(abilityName, "Exploding") and ARS.sv.exploding_spear then
		d("Exploding Spear! ID: "..abilityId.." RESULT: "..result)
	end
	
	--First Boss
	if abilityId == 133045 and result == ACTION_RESULT_BEGIN and ARS.sv.dragon_totem then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_DRAGON_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if abilityId == 133513 and result == ACTION_RESULT_BEGIN and ARS.sv.gargoyle_toem then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_GARGOYLE_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133510 and result == ACTION_RESULT_BEGIN and ARS.sv.harpy_totem then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_Harpy_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133515 and result == ACTION_RESULT_BEGIN and ARS.sv.chaurus_totem then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_CHAURUS_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 134023 and result == ACTION_RESULT_BEGIN and ARS.sv.meteor_yandir then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_METEOR), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 5000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	--Second Boss
	if abilityId == 140606 and result == ACTION_RESULT_BEGIN and ARS.sv.meteor_vrol then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_METEOR), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 5000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133808 and result == ACTION_RESULT_BEGIN and ARS.sv.frigid_fog then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_FRIGID_FOG), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	--Endboss
	
	if string.match(abilityName, "Instability") and ARS.sv.instability then
		d("Instability! ID: "..abilityId.." RESULT: "..result)
	end
	
	if abilityId == 134856 and result == ACTION_RESULT_BEGIN and ARS.sv.sanguine_grasp then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_SANGUINE_GRASP), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 10000,
			hascountdown = true,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if abilityId == 132470 and result == ACTION_RESULT_EFFECT_GAINED and ARS.sv.sanguine_prison then
		d("Sanguine Prison. Kill it!")
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_SANGUINE_PRISON), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if string.match(abilityName, "Blood Spear") and ARS.sv.blood_spear then
		d("Blood Spear! ID: "..abilityId.." RESULT: "..result)
	end
end

function ARS.Debuffs(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceUnitType)
	if abilityId == 133559 and result == EFFECT_RESULT_FADED then
		d("1Debuff has been cleansed!")
	elseif abilityId == 133559 then
		d("1Debuff still active on "..stackCount)
	end

	if abilityId == 139812 and result == EFFECT_RESULT_FADED then
		d("2Debuff has been cleansed!")
	elseif abilityId == 139812 then
		d("2Debuff still active on "..stackCount)
	end
end

function UpdateAlerts()
	pool:ReleaseAllObjects()

	local currTime = GetGameTimeMilliseconds()
	for k, v in ipairs(alert_pool) do
		control = pool:AcquireObject(k)

		if v.isnew then
			d(ARS.sv.sound_played)
			PlaySound(ARS.sv.sound_played)
			v.isnew = false
		end

		if v.isdebuff == nil then
			if currTime > v.duration then
				table.remove(alert_pool, k) --alert has expired, remove it from alert_pool
			else
				control:SetHidden(false)
				control.texture:SetTexture(GetAbilityIcon(v.abilityid))
				control.message:SetText(v.message)
				if v.hascountdown then
					control.timer:SetText(string.format("%.1f", (v.duration - currTime) / 1000))
				else
					control.timer:SetText("")
				end
				control:SetAnchor(CENTER, nil, CENTER, 0, -250 + (60 * (k - 1)))
			end
		elseif v.isdebuff then
			if not v.ispurged then
				control:SetHidden(false)
				control.texture:SetTexture(GetAbilityIcon(v.abilityid))
				control.message:SetText(v.message)
			else
				table.remove(alert_pool, k) --debuff has expired, remove it from alert_pool
			end
		end
	end
end	

function CreateAlert(pool)
	local name      = "Alert" .. pool:GetNextControlId()
	control = WINDOW_MANAGER:CreateControlFromVirtual(name, zframe, "ARSTest")

	control.texture = control:GetNamedChild("AlertTexture")
	control.message = control:GetNamedChild("AlertMessage")
	control.timer = control:GetNamedChild("AlertTimer")

	return control
end

function RemoveAlert(control)
    control:SetHidden(true)
    control:ClearAnchors()
end

function ARS:InitializeKATracker(enabled)
	if not enabled then return end
	
	ARS.sv = ZO_SavedVars:NewAccountWide("KASaved", 1, nil, ARS.default)

    pool = ZO_ObjectPool:New(CreateAlert, RemoveAlert)
	
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "Ability", EVENT_COMBAT_EVENT, ARS.Mechanics)
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "Debuff", EVENT_EFFECT_CHANGED, ARS.Debuffs)

    EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateAlerts", 50, UpdateAlerts)
    
    fragment = ZO_HUDFadeSceneFragment:New(zframe)
 
    HUD_SCENE:AddFragment(fragment)
	HUD_UI_SCENE:AddFragment(fragment)
	
	ARS.KAMechanicsSettings()
end