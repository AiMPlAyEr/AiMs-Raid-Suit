ARS = ARS or {}

local alert_pool = {}
local pool
local zframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSParent")
zframe:SetResizeToFitDescendents(true)
zframe:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
zframe:SetMovable(true)
zframe:SetMouseEnabled(true)

ARS.default = {
	--0 none, 1 self, 2 all
	mechanics = {
		crashing_wave 		= true,
		exploding_spear 	= true,
		dragon_totem 		= true,
		gargoyle_totem 		= true,
		harpy_totem 		= true,
		chaurus_totem 		= true,
		meteor_yandir 		= true,
		chaurus_bile 		= true,
		meteor_vrol 		= true,
		frigid_fog 			= false,
		instability 		= true,
		sanguine_grasp 		= true,
		sanguine_prison 	= true,
		blood_spear 		= true,
		hailstone_shield 	= false,
		shocking_harpoon	= true,
	},
	sound_played = SOUNDS.DUEL_START
}

function ARS.Mechanics(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)	
	--Trash 
	if abilityId > 132000 and abilityId ~= 140767 and result == ACTION_RESULT_BEGIN and ARS.sv.instability then
		d("["..GetAbilityName(abilityId).."] ID: "..abilityId.." RESULT: "..result)
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

	if abilityId == 133936 and result == ACTION_RESULT_BEGIN and ARS.sv.exploding_spear then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_EXPLODING_SPEAR), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = true,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	--First Boss
	if abilityId == 133045 and result == ACTION_RESULT_BEGIN and ARS.sv.dragon_totem then
		ability_settings = {
			abilityid = 133264,
			message = zo_strformat(GetString(ARS_DRAGON_TOTEM), GetAbilityName(133264)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if abilityId == 133513 and result == ACTION_RESULT_BEGIN and ARS.sv.gargoyle_totem then
		ability_settings = {
			abilityid = 133514,
			message = zo_strformat(GetString(ARS_GARGOYLE_TOTEM), GetAbilityName(133514)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133510 and result == ACTION_RESULT_BEGIN and ARS.sv.harpy_totem then
		ability_settings = {
			abilityid = 133511,
			message = zo_strformat(GetString(ARS_HARPY_TOTEM), GetAbilityName(133511)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133515 and result == ACTION_RESULT_BEGIN and ARS.sv.chaurus_totem then
		ability_settings = {
			abilityid = 133516,
			message = zo_strformat(GetString(ARS_CHAURUS_TOTEM), GetAbilityName(133516)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 140603 and result == ACTION_RESULT_BEGIN and ARS.sv.meteor_yandir then
		if hitValue == 3000 then 
			ability_settings = {
				abilityid = abilityId,
				message = zo_strformat(GetString(ARS_METEOR), GetAbilityName(abilityId)),
				duration = GetGameTimeMilliseconds() + 5000,
				hascountdown = true,
				isnew = true,
			}
			table.insert(alert_pool, ability_settings)
		end
	end

	if abilityId == 133004 and result == ACTION_RESULT_BEGIN and ARS.sv.hailstone_shield then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_HAILSTONE_SHIELD), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 5000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	--Second Boss
	if abilityId == 134023 and result == ACTION_RESULT_BEGIN and ARS.sv.meteor_vrol then
		if hitValue == 3000 then 
			ability_settings = {
				abilityid = abilityId,
				message = zo_strformat(GetString(ARS_METEOR), GetAbilityName(abilityId)),
				duration = GetGameTimeMilliseconds() + 5000,
				hascountdown = true,
				isnew = true,
			}
			table.insert(alert_pool, ability_settings)
		end
	end

	if abilityId == 133808 and result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and ARS.sv.frigid_fog then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_FRIGID_FOG), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133913 and result == ACTION_RESULT_BEGIN and ARS.sv.shocking_harpoon then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_SHOCKING_HARPOON), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	--Endboss
	if abilityId == 133846 and result == ACTION_RESULT_BEGIN and ARS.sv.instability then
		d("Instability! ID: "..abilityId.." Time: "..hitValue)
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_SANGUINE_GRASP), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 5000,
			hascountdown = true,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
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
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_SANGUINE_PRISON), GetAbilityName(abilityId), ARS.GetNameForUnitId(targetUnitId)),
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
	if abilityId == 139812 and result == EFFECT_RESULT_FADED then
		d("2Debuff has been cleansed!")
	elseif abilityId == 139812 and result == EFFECT_RESULT_GAINED then
		d("Debuff is active for "..stackCount.." seconds")
	end
end

function UpdateAlerts()
	pool:ReleaseAllObjects()

	local currTime = GetGameTimeMilliseconds()
	for k, v in ipairs(alert_pool) do
		control = pool:AcquireObject(k)

		if v.isnew then
			PlaySound(ARS.sv.sound_played)
			v.isnew = false
		end

		if v.isdebuff == nil then
			if currTime > v.duration then
				table.remove(alert_pool, k) --alert has expired, remove it from alert_pool
			else
				control:SetHidden(false)
				if v.texture ~= nil then
					control.texture:SetTexture(v.texture)
				else
					control.texture:SetTexture(GetAbilityIcon(v.abilityid))
				end
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