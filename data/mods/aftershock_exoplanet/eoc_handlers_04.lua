local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_VALUE_ADDED"] = function(ctx)
    if (H.var_num(H.u(ctx), "afs_electrokin_personal_battery_count") > 0) then
        H.set_var("actor", H.npc(ctx), ctx, "afs_electrokin_charging_value_counter", (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter")) + (((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") / 5) + 1) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))) / H.var_num(H.u(ctx), "afs_electrokin_personal_battery_count"))))
    end
    return true
    end
    COND["EOC_AFS_LECTROKIN_PERSONAL_BATTERY_INV_SCANNER_CHARGER"] = function(ctx)
        return ((H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 1)) == true
    end
    EOC["EOC_AFS_LECTROKIN_PERSONAL_BATTERY_INV_SCANNER_CHARGER"] = function(ctx)
    if ((H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 1)) then
        if (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 5) then
            H.set_bionic_power(H.npc(ctx), 5, "+=")
            H.set_var("actor", H.npc(ctx), ctx, "afs_electrokin_charging_value_counter", (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter")) - (5))
        else
            if (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 4) then
                H.set_bionic_power(H.npc(ctx), 4, "+=")
                H.set_var("actor", H.npc(ctx), ctx, "afs_electrokin_charging_value_counter", (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter")) - (4))
            else
                if (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 3) then
                    H.set_bionic_power(H.npc(ctx), 3, "+=")
                    H.set_var("actor", H.npc(ctx), ctx, "afs_electrokin_charging_value_counter", (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter")) - (3))
                else
                    if (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 2) then
                        H.set_bionic_power(H.npc(ctx), 2, "+=")
                        H.set_var("actor", H.npc(ctx), ctx, "afs_electrokin_charging_value_counter", (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter")) - (2))
                    else
                        if (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter") >= 1) then
                            H.set_bionic_power(H.npc(ctx), 1, "+=")
                            H.set_var("actor", H.npc(ctx), ctx, "afs_electrokin_charging_value_counter", (H.var_num(H.npc(ctx), "afs_electrokin_charging_value_counter")) - (1))
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_FINALIZATION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_FINALIZATION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_VALUE_ADDED", "EOC_AFS_LECTROKIN_PERSONAL_BATTERY_INV_SCANNER_CHARGER" }, {  })
        return true
    end
    return false
    end
    COND["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_electrokinetic_personal_battery", false))
        do local _a, _sp = H.u(ctx), "afs_electrokinetic_personal_battery"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 45) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), 14400)), math.floor(math.min((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 90) + 1800) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), 14400)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_PRECOG_DANGER_SENSE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_PRECOG_DANGER_SENSE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You become preternaturally aware of possible dangers.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_precog_danger_sense", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 303) + 1174) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 1002) + 2232) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_DANGER_SENSE_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_DANGER_SENSE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PRECOG_REMOVE_DANGER_SENSE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_REMOVE_DANGER_SENSE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_DANGER_SENSE_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_DANGER_SENSE_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_danger_sense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_precog_danger_sense", false))
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "afs_precog_danger_sense"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 303) + 1174) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") * 1002) + 2232) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_DANGER_SENSE_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_PRECOG_RANGED_ENHANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_PRECOG_RANGED_ENHANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your enemies seem highlighted against the terrain as you tighten your grip on your weapon.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_MELEE_ENHANCE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_DODGE_BONUS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_precog_ranged_enhance", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 8) + 210) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 25) + 640) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_RANGED_ENHANCE_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PRECOG_REMOVE_RANGED_ENHANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_REMOVE_RANGED_ENHANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_RANGED_ENHANCE_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_RANGED_ENHANCE_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_ranged_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_precog_ranged_enhance", false))
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "afs_precog_ranged_enhance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 8) + 210) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") * 25) + 640) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_RANGED_ENHANCE_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_PRECOG_DODGE_BONUS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_PRECOG_DODGE_BONUS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You can see a premonition of your enemies' attacks like a ghostly image.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_MELEE_ENHANCE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_precog_dodge_bonus", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 9) + 120) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 17) + 450) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_DODGE_BONUS_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_DODGE_BONUS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PRECOG_REMOVE_DODGE_BONUS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_REMOVE_DODGE_BONUS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_DODGE_BONUS_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_DODGE_BONUS_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_dodge_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_precog_dodge_bonus", false))
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "afs_precog_dodge_bonus"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 9) + 120) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") * 17) + 450) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_DODGE_BONUS_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_PRECOG_CRAFT_BONUS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_PRECOG_CRAFT_BONUS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You can see how it all fits together, and how it *should* fit together.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_CRAFT_BONUS_SWITCHER", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_precog_craft_bonus", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 250) + 1215) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 600) + 2700) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_CRAFT_BONUS_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_CRAFT_BONUS", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_AFS_PRECOG_CRAFT_BONUS_SWITCHER"] = function(ctx)
    do
        local _sw11 = H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus")
        if _sw11 == 0 then
            do local _g = H.safe_id('mutation', "AFS_PRECOG_CRAFT_BONUS_01"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw11 == 4 then
            do local _g = H.safe_id('mutation', "AFS_PRECOG_CRAFT_BONUS_02"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw11 == 8 then
            do local _g = H.safe_id('mutation', "AFS_PRECOG_CRAFT_BONUS_03"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw11 == 12 then
            do local _g = H.safe_id('mutation', "AFS_PRECOG_CRAFT_BONUS_04"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw11 == 16 then
            do local _g = H.safe_id('mutation', "AFS_PRECOG_CRAFT_BONUS_05"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        elseif _sw11 == 20 then
            do local _g = H.safe_id('mutation', "AFS_PRECOG_CRAFT_BONUS_06"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        end
    end
    return true
    end
    COND["EOC_AFS_PRECOG_REMOVE_CRAFT_BONUS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_REMOVE_CRAFT_BONUS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_afs_precog_craft_bonus_blindness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.lose_trait(H.u(ctx), "AFS_PRECOG_CRAFT_BONUS_01")
        H.lose_trait(H.u(ctx), "AFS_PRECOG_CRAFT_BONUS_02")
        H.lose_trait(H.u(ctx), "AFS_PRECOG_CRAFT_BONUS_03")
        H.lose_trait(H.u(ctx), "AFS_PRECOG_CRAFT_BONUS_04")
        H.lose_trait(H.u(ctx), "AFS_PRECOG_CRAFT_BONUS_05")
        H.lose_trait(H.u(ctx), "AFS_PRECOG_CRAFT_BONUS_06")
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_CRAFT_BONUS_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_CRAFT_BONUS_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_precog_craft_bonus", false))
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "afs_precog_craft_bonus"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 250) + 1215) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") * 600) + 2700) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_CRAFT_BONUS_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_PRECOG_MELEE_ENHANCE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_PRECOG_MELEE_ENHANCE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Distances seem to narrow and your enemies' movements seem to slow as their vulnerabilities are laid bare.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_RANGED_ENHANCE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_DODGE_BONUS", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_precog_melee_enhance", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 9) + 240) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 28) + 690) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_MELEE_ENHANCE_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_PRECOG_REMOVE_MELEE_ENHANCE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_PRECOG_REMOVE_MELEE_ENHANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_REMOVE_MELEE_ENHANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_MELEE_ENHANCE_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_MELEE_ENHANCE_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_melee_enhance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_precog_melee_enhance", false))
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "afs_precog_melee_enhance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 9) + 240) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") * 28) + 690) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_PRECOG_MELEE_ENHANCE_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_PRECOG_FOREWARNING_REMOVE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_precog_damage_foresee"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_PRECOG_FOREWARNING_REMOVE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_precog_damage_foresee"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_afs_precog_damage_foresee"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_AFS_PRECOG_CRAFTING_ADD_BLINDNESS_WHEN_CRAFTING"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_afs_precog_craft_bonus_blindness", 43200, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You close your eyes as the visions overtake you.")), "mixed")
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus_blindness"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) == true
    end
    EOC["EOC_AFS_PRECOG_CRAFTING_REMOVE_BLINDNESS_WHEN_DONE_CRAFTING"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_afs_precog_craft_bonus_blindness"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))))) then
        do local _eg = H.safe_id('effect', "effect_afs_precog_craft_bonus_blindness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("You open your eyes as the visions fade.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEKIN_MOMENTUM_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_TELEKIN_MOMENTUM_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The air around you feels more yielding.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_telekinetic_momentum", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 10) + 90) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 20) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEKIN_MOMENTUM_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_TELEKIN_REMOVE_MOMENTUM", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_TELEKIN_REMOVE_MOMENTUM"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEKIN_REMOVE_MOMENTUM"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEKIN_MOMENTUM_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEKIN_MOMENTUM_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_telekinetic_momentum", false))
        do local _a, _sp = H.u(ctx), "afs_telekinetic_momentum"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 10) + 90) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") * 20) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEKIN_MOMENTUM_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PULL"] == nil or E.cond["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PULL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Pull")), description = ctx:expand_text(services.translate("Pull a set of items to you.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PULL" end end
        do local _en = (E.cond["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PUSH"] == nil or E.cond["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PUSH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Push")), description = ctx:expand_text(services.translate("Push a set of items away from you.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PUSH" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PULL"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "afs_telekinetic_item_pull_real", false, { targeted = true })
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_FAR_HAND_SELECTOR_PUSH"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "afs_telekinetic_item_push_real", false, { targeted = true })
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"] == nil or E.cond["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Push")), description = ctx:expand_text(services.translate("Shove a target away from you.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH" end end
        do local _en = (E.cond["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"] == nil or E.cond["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Pull")), description = ctx:expand_text(services.translate("Grab a target and pull them towards you.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "afs_telekinetic_force_shove_away_target", false, { targeted = true })
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "afs_telekinetic_force_shove_toward_target", false, { targeted = true })
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_PUSH_DIRECTION_PICKER"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "u_pos", nil, nil, nil, nil, nil, false, true, {  }, {  })
    services.messages.add(ctx:expand_text(services.translate("Select direction.")), "neutral")
    do local c, r = H.get_tripoint_var("context", nil, ctx, "u_pos"), H.get_tripoint_var("context", nil, ctx, "push_direction_incorrect"); if c and r then local mp = services.coords.tripoint_abs_ms(2*(c.x or 0)-(r.x or 0), 2*(c.y or 0)-(r.y or 0), c.z or 0); H.set_var("context", nil, ctx, "push_direction_correct", mp) end end
    if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor(H.var_num(H.u(ctx), "afs_telekinesis_shove_spell_level")), stun = math.floor(1), dam_mult = math.floor(2), direction = H.get_tripoint_var("context", nil, ctx, "push_direction_correct") }) end
    return true
    end
    EOC["EOC_AFS_TELEKINETIC_FORCE_SHOVE_PUSH_CHECKER"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", H.char_spell_level(H.npc(ctx), "afs_telekinetic_move_creature"))
    H.set_var("actor", H.u(ctx), ctx, "weight_ratio", ((((H.var_num(H.u(ctx), "telekinesis_power_level") * 25) * H.var_num(H.u(ctx), "telekinesis_intelligence")) + 10) / (H.creature_weight(H.u(ctx)) / 1000000)))
    H.set_var("actor", H.u(ctx), ctx, "afs_telekinesis_shove_spell_level", H.clamp_num(((H.var_num(H.u(ctx), "weight_ratio") - 1) * 2), 0, 30))
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if (H.var_num(H.u(ctx), "afs_telekinesis_shove_spell_level") < 1) then
        H.run_eoc("EOC_AFS_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
    else
        if ((H.char_snap(H.npc(ctx)) or {}).avatar == true) then
            services.messages.add(ctx:expand_text(services.translate("You hurl your target.")), "good")
            H.run_eoc("EOC_AFS_TELEKINETIC_PUSH_DIRECTION_PICKER", ctx, nil, nil, nil)
        else
            do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "afs_telekinetic_force_shove_away", (cs and cs.kind == 'monster'), { target = H.get_tripoint_var("context", nil, ctx, "loc"), min_level = math.floor(H.var_num(H.u(ctx), "telekinesis_shove_spell_level")) }) end end
            H.run_eoc("EOC_AFS_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
        end
    end
    return true
    end
    COND["EOC_AFS_TELEKINETIC_PUSH_DOWN_CHECKER"] = function(ctx)
        return (services.random.native_probability(((H.var_num(H.u(ctx), "weight_ratio") * 1000)), (1000))) == true
    end
    EOC["EOC_AFS_TELEKINETIC_PUSH_DOWN_CHECKER"] = function(ctx)
    if (services.random.native_probability(((H.var_num(H.u(ctx), "weight_ratio") * 1000)), (1000))) then
        H.eoc_add_effect(H.u(ctx), "downed", 2, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You shove your target off their feet.")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You attempt to shove your target but they are too heavy!")), "bad")
        return false
    end
    end
    EOC["EOC_AFS_TELEKINETIC_FORCE_SHOVE_PULL_CHECKER"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", H.char_spell_level(H.npc(ctx), "afs_telekinetic_move_creature"))
    H.set_var("actor", H.u(ctx), ctx, "weight_ratio", ((((H.var_num(H.u(ctx), "telekinesis_power_level") * 25) * H.var_num(H.u(ctx), "telekinesis_intelligence")) + 10) / (H.creature_weight(H.u(ctx)) / 1000000)))
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_pull_spell_level", H.clamp_num(((H.var_num(H.u(ctx), "weight_ratio") - 1) * 2), 0, 30))
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if (H.var_num(H.u(ctx), "telekinesis_pull_spell_level") < 1) then
        H.run_eoc("EOC_AFS_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
    else
        do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "afs_telekinetic_force_shove_toward", (cs and cs.kind == 'monster'), { target = H.get_tripoint_var("context", nil, ctx, "loc"), min_level = math.floor(H.var_num(H.u(ctx), "telekinesis_shove_spell_level")) }) end end
        services.messages.add(ctx:expand_text(services.translate("You pull your target towards you.")), "good")
        H.run_eoc("EOC_AFS_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
    end
    return true
    end
    COND["EOC_AFS_TELEKIN_WAVE_TARGETS"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_AFS_TELEKIN_WAVE_TARGETS"] = function(ctx)
    if (ctx:has_speaker()) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", H.char_spell_level(H.npc(ctx), "afs_telekinetic_wave"))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_weight_ratio", 55)
        H.set_var("actor", H.u(ctx), ctx, "weight_ratio", ((((H.var_num(H.u(ctx), "telekinesis_power_level") * H.var_num(H.u(ctx), "telekinesis_weight_ratio")) * H.var_num(H.u(ctx), "telekinesis_intelligence")) + (H.var_num(H.u(ctx), "telekinesis_weight_ratio") / 2)) / (H.creature_weight(H.u(ctx)) / 1000000)))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_shove_spell_level", H.clamp_num(((H.var_num(H.u(ctx), "weight_ratio") - 1) * 2), 0, 30))
        if services.random.native_probability(((H.var_num(H.u(ctx), "weight_ratio") * 1000)), (1000)) then
            H.eoc_add_effect(H.u(ctx), "downed", 2, nil, nil, nil)
        end
        if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor(H.var_num(H.u(ctx), "telekinesis_shove_spell_level")), stun = math.floor(2), dam_mult = math.floor((1 + (H.var_num(H.u(ctx), "telekinesis_shove_spell_level") * 0.4))), direction = H.get_tripoint_var("context", nil, ctx, "player_position") }) end
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEPATH_SHIELD_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_TELEPATH_SHIELD_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin shielding your thoughts.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_telepathic_psi_armor", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 15) + 180) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 36) + 720) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEPATH_SHIELD_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SHIELD", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SHIELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SHIELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEPATH_SHIELD_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEPATH_SHIELD_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_telepathic_shield", false))
        do local _a, _sp = H.u(ctx), "afs_telepathic_shield"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 15) + 180) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_shield") * 36) + 720) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEPATH_SHIELD_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_TELEPATH_SENSE_MINDS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_TELEPATH_SENSE_MINDS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You reach out with your powers, looking for nearby minds.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_telepath_sense_minds", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 26) + 90) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 131) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEPATH_SENSE_MINDS_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_TELEPATH_REMOVE_SENSE_MINDS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_TELEPATH_REMOVE_SENSE_MINDS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEPATH_REMOVE_SENSE_MINDS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEPATH_SENSE_MINDS_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEPATH_SENSE_MINDS_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_telepathic_mind_sense", false))
        do local _a, _sp = H.u(ctx), "afs_telepathic_mind_sense"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 26) + 90) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") * 131) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEPATH_SENSE_MINDS_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_TELEPATH_SUGGESTION_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_TELEPATH_SUGGESTION_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You prepare to subtly influence others' thoughts.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_telepathic_suggestion", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 381) + 981) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 899) + 2520) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEPATH_SUGGESTION_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SUGGESTION", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SUGGESTION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEPATH_REMOVE_TELEPATHIC_SUGGESTION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEPATH_SUGGESTION_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_TELEPATH_SUGGESTION_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_telepathic_suggestion"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_telepathic_suggestion", false))
        do local _a, _sp = H.u(ctx), "afs_telepathic_suggestion"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 381) + 981) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") * 899) + 2520) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_TELEPATH_SUGGESTION_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
end
