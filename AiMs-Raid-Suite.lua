ARS = ARS or {}
local ARS = ARS

ARS.name = "AiMs-Raid-Suite"
ARS.suitversion = "0.1"
ARS.default = {}

local alert_pool = {}
local pool
local zframe = WINDOW_MANAGER:CreateTopLevelWindow("ARSParent")
zframe:SetResizeToFitDescendents(true)
zframe:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
zframe:SetMovable(true)
zframe:SetMouseEnabled(true)

function ARS.Mechanics(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,combatEventLog,sourceUnitId,targetUnitId,abilityId)	
	--Trash
	if abilityId == 134196 and result == ACTION_RESULT_BEGIN then
		d("Crashing Wave. Block! "..targetType)
		UpdateMessage("|c03a9f4Crashing Wave|r in ", GetAbilityIcon(abilityId), 4000, 3000, "|cff0000Block or Dodge|r")
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_CRASHING_WAVE), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + hitValue,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if abilityId == 133936 and result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER then
		d("Exploding Spear Block!")
		UpdateMessage("|cffc107Exploding Spear|r. Block!", GetAbilityIcon(abilityId), 3000, 0,nil)
	end
	
	--First Boss
	if abilityId == 133045 and result == ACTION_RESULT_BEGIN then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_DRAGON_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if abilityId == 133513 and result == ACTION_RESULT_BEGIN then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_GARGOYLE_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133510 and result == ACTION_RESULT_BEGIN then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_Harpy_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133515 and result == ACTION_RESULT_BEGIN then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_CHAURUS_TOTEM), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 3000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 134023 and result == ACTION_RESULT_BEGIN then
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
	if abilityId == 140606 and result == ACTION_RESULT_BEGIN then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_METEOR), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 5000,
			hascountdown = false,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end

	if abilityId == 133808 and result == ACTION_RESULT_BEGIN then
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
	
	if abilityName == "Instability" then
		d("Instability! ID: "..abilityId.." RESULT: "..result)
	end
	
	if abilityId == 134856 and result == ACTION_RESULT_BEGIN then
		ability_settings = {
			abilityid = abilityId,
			message = zo_strformat(GetString(ARS_SANGUINE_GRASP), GetAbilityName(abilityId)),
			duration = GetGameTimeMilliseconds() + 10000,
			hascountdown = true,
			isnew = true,
		}
		table.insert(alert_pool, ability_settings)
	end
	
	if abilityId == 132470 and result == ACTION_RESULT_EFFECT_GAINED then
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
	
	if abilityId == 136315 and result == ACTION_RESULT_BEGIN then
		d("Blood Spear")
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
			PlaySound(SOUNDS.DUEL_START)
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

function ARS:Initialize()

	pool = ZO_ObjectPool:New(CreateAlert, RemoveAlert)
	
	ARS.debug = ZO_SavedVars:NewAccountWide("ARSAbilityLog", 1, nil, ARS.default)
	
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "Ability", EVENT_COMBAT_EVENT, ARS.Mechanics)
	EVENT_MANAGER:RegisterForEvent(ARS.name .. "Debuff", EVENT_EFFECT_CHANGED, ARS.Debuffs)

	EVENT_MANAGER:RegisterForUpdate(ARS.name.."UpdateAlerts", 50, UpdateAlerts)

	fragment = ZO_HUDFadeSceneFragment:New(zframe)
 
    HUD_SCENE:AddFragment(fragment)
    HUD_UI_SCENE:AddFragment(fragment)

    --ARS:InitializeSynergyTracker(true)
    --ARS:InitializeTracker(true)
end

function ARS.OnAddOnLoaded(event, addonName)
	if addonName ~= ARS.name then return end
        ARS:Initialize()
end

EVENT_MANAGER:RegisterForEvent(ARS.name, EVENT_ADD_ON_LOADED, ARS.OnAddOnLoaded)