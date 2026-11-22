local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_VAMPIRE_ZEPHYR_WATER_RUN_FOLLOWUP"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))))) == true
    end
    EOC["EOC_VAMPIRE_ZEPHYR_WATER_RUN_FOLLOWUP"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))))) then
        services.messages.add(ctx:expand_text(services.translate("You are moving too slowly and fall into the water.")), "bad")
        do local _eg = H.safe_id('effect', "haste_vampire_water_running"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_VAMPIRE_ZEPHYR_WATER_RUN"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "haste_vampire"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_VAST_WATER_BURN") == 1))))) == true
    end
    EOC["EOC_VAMPIRE_ZEPHYR_WATER_RUN"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "haste_vampire"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not ((H.char_has_trait(H.u(ctx), "VAMPIRE_WEAKNESS_VAST_WATER_BURN") == 1))))) then
        if ((function() local eg = H.safe_id('effect', "haste_vampire_water_running"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.run_eoc("EOC_VAMPIRE_ZEPHYR_WATER_RUN_FOLLOWUP", ctx, nil, nil, nil)
        else
            if (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SWIMMABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) then
                H.eoc_add_effect(H.u(ctx), "haste_vampire_water_running", -1, nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    COND["EOC_RUACH_DRAINED_AWAKENING_PENALTIES"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_lilin_ruach_drain_side_effects"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_RUACH_DRAINED_AWAKENING_PENALTIES"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_lilin_ruach_drain_side_effects"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", (40 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 20)), "+=")
        H.eoc_add_effect(H.u(ctx), "effect_lilin_health_effects_of_draining", (10 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * services.random.native_float(10, 20))), nil, nil, nil)
        if (H.var_num(H.u(ctx), "lilin_ruach_drained_recently") == 1) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_ruach_drained_recently", 0)
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "head") }) end end
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "arm_l") }) end end
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "arm_r") }) end end
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "torso") }) end end
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "leg_r") }) end end
            do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "leg_l") }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_LILIN_RUACH_DRAIN_SELF"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) == true
    end
    EOC["EOC_LILIN_RUACH_DRAIN_SELF"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) then
        H.run_eoc("EOC_LILIN_RUACH_DRAIN_SELF_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_RUACH_DRAIN_SELF_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1) and (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") >= 1))) == true
    end
    EOC["EOC_LILIN_RUACH_DRAIN_SELF_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1) and (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") >= 1))) then
        do local _eg = H.safe_id('effect', "effect_lilin_no_ruach"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") == 0) then
            H.eoc_add_effect(H.u(ctx), "effect_lilin_no_ruach", -1, nil, 1, nil)
        end
        H.run_eoc("EOC_LILIN_UPDATE_MAX_RUACH_LEVELS", ctx, nil, nil, nil)
        return true
    else
        if ((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") == 0) and (not (((function() local eg = H.safe_id('effect', "effect_lilin_no_ruach"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) then
            H.eoc_add_effect(H.u(ctx), "effect_lilin_no_ruach", -1, nil, 1, nil)
        end
        return false
    end
    end
    COND["EOC_LILIN_UPDATE_MAX_RUACH_LEVELS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") >= (((1680 + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH") * 1680)) + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_2") * 3360)) + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_3") * 5040)))) == true
    end
    EOC["EOC_LILIN_UPDATE_MAX_RUACH_LEVELS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") >= (((1680 + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH") * 1680)) + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_2") * 3360)) + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_3") * 5040)))) then
        if (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_3") == 1) then
            do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 6720; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        else
            if (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_2") == 1) then
                do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 5040; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            else
                if (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH") == 1) then
                    do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 3360; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                else
                    do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1680; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) == true
    end
    EOC["EOC_LILIN_GAIN_POWERS_AT_NIGHT_SETUP"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LILIN_GAIN_POWERS_AT_NIGHT_ACTIVE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_LILIN_GAIN_POWERS_AT_NIGHT_ACTIVE"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((not services.gameplay.environment.is_night()))) and services.random.native_probability((H.var_num(H.u(ctx), "lilin_amount_of_ruach_spent_for_powers")), (250)) and (not (((function() local eg = H.safe_id('effect', "effect_gained_lilin_power"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_LILIN_GAIN_POWERS_AT_NIGHT_ACTIVE"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((not services.gameplay.environment.is_night()))) and services.random.native_probability((H.var_num(H.u(ctx), "lilin_amount_of_ruach_spent_for_powers")), (250)) and (not (((function() local eg = H.safe_id('effect', "effect_gained_lilin_power"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        if (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") >= 1) then
            services.messages.add(ctx:expand_text(services.translate("Under the light of the moon, you realize a new way to use your stolen ruach to empower yourself.")), "good")
            do local _a, _v = H.u(ctx), "mutagen_lilin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
            do local _a, _v = H.u(ctx), "mutagen_lilin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            H.set_var("actor", H.u(ctx), ctx, "lilin_new_power_delay_timer", math.min((services.random.native_int(0, H.round_half_away(86400)) + (H.char_sum_traits_cat(H.u(ctx), "LILIN", "ALL") * 1200)), 604800))
            H.eoc_add_effect(H.u(ctx), "effect_gained_lilin_power", H.var_num(H.u(ctx), "lilin_new_power_delay_timer"), nil, nil, nil)
            H.set_var("actor", H.u(ctx), ctx, "lilin_amount_of_ruach_spent_for_powers", 0)
            H.set_var("actor", H.u(ctx), ctx, "lilin_amount_of_ruach_spent_for_powers_increaser", 1)
        end
        return true
    else
        if (not ((not services.gameplay.environment.is_night()))) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LILIN_GAIN_POWERS_AT_NIGHT_ACTIVE"), nil) end end
        end
        return false
    end
    end
    COND["EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE"] = function(ctx)
        return (((("LILIN_DRAIN_RUACH_LONG_DISTANCE") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE"] = function(ctx)
    if (((("LILIN_DRAIN_RUACH_LONG_DISTANCE") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        local _a41 = H.u(ctx)
        local _sn42 = "lilin_drain_ruach_short_ranged_spell"
        local _sg43 = (_sn42 ~= "") and H.safe_id("spell", _sn42) or nil
        if _a41 and _sg43 then services.spells.set_level(_a41, _sg43, math.floor((-1))) end
        return true
    end
    return false
    end
    COND["EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK_2"] = function(ctx)
        return ((H.char_spell_level(H.u(ctx), "lilin_drain_ruach_long_ranged_spell") >= 0)) == true
    end
    EOC["EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK_2"] = function(ctx)
    if ((H.char_spell_level(H.u(ctx), "lilin_drain_ruach_long_ranged_spell") >= 0)) then
        local _a44 = H.u(ctx)
        local _sn45 = "lilin_drain_ruach_short_ranged_spell"
        local _sg46 = (_sn45 ~= "") and H.safe_id("spell", _sn45) or nil
        if _a44 and _sg46 then services.spells.set_level(_a44, _sg46, math.floor((-1))) end
        return true
    end
    return false
    end
    COND["EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) == true
    end
    EOC["EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) then
        H.run_eoc("EOC_LILIN_DRAIN_RUACH_INCREASE_DISTANCE_FALLBACK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_INITIAL"] = function(ctx)
        return (((("LILIN_ATTRIBUTE_BONUSES") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_INITIAL"] = function(ctx)
    if (((("LILIN_ATTRIBUTE_BONUSES") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_STRENGTH"] == nil or E.cond["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_STRENGTH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Empower your Strength")), description = ctx:expand_text(services.translate("Gain strength bonuses when using From Strength to Strength.")), enabled = _en, hotkey = nil }); _targets[tostring(1)] = "EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_STRENGTH" end end
            do local _en = (E.cond["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_DEXTERITY"] == nil or E.cond["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_DEXTERITY"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Empower your Dexterity")), description = ctx:expand_text(services.translate("Gain dexterity and dodge bonuses when using From Strength to Strength.")), enabled = _en, hotkey = nil }); _targets[tostring(2)] = "EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_DEXTERITY" end end
            do local _en = (E.cond["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_PERCEPTION"] == nil or E.cond["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_PERCEPTION"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Empower your Perception")), description = ctx:expand_text(services.translate("Gain perception bonuses when using From Strength to Strength.")), enabled = _en, hotkey = nil }); _targets[tostring(3)] = "EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_PERCEPTION" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Pick a choice")), allow_cancel = false })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_STRENGTH"] = function(ctx)
    do local _g = H.safe_id('mutation', "LILIN_ATTRIBUTE_BONUSES_STRENGTH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_DEXTERITY"] = function(ctx)
    do local _g = H.safe_id('mutation', "LILIN_ATTRIBUTE_BONUSES_DEXTERITY"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_LILIN_GAINS_STRENGTH_TO_STRENGTH_CHOOSE_PERCEPTION"] = function(ctx)
    do local _g = H.safe_id('mutation', "LILIN_ATTRIBUTE_BONUSES_PERCEPTION"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    COND["EOC_LILIN_RUACH_UI_UPDATER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) == true
    end
    EOC["EOC_LILIN_RUACH_UI_UPDATER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) then
        if (not (H.char_has_any_trait(H.u(ctx), { "LILIN_HOLD_MORE_RUACH", "LILIN_HOLD_MORE_RUACH_2", "LILIN_HOLD_MORE_RUACH_3" }))) then
            H.set_var("actor", H.u(ctx), ctx, "ruach_amount_for_graph", math.min(H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin"), 1680))
        else
            if (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH") == 1) then
                H.set_var("actor", H.u(ctx), ctx, "ruach_amount_for_graph", math.min(H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin"), 3360))
            else
                if (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_2") == 1) then
                    H.set_var("actor", H.u(ctx), ctx, "ruach_amount_for_graph", math.min(H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin"), 5040))
                else
                    if (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_3") == 1) then
                        H.set_var("actor", H.u(ctx), ctx, "ruach_amount_for_graph", math.min(H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin"), 6720))
                    end
                end
            end
        end
        H.set_var("actor", H.u(ctx), ctx, "ruach_max_amount_for_graph", (((1680 + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH") * 1680)) + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_2") * 3360)) + (H.char_has_trait(H.u(ctx), "LILIN_HOLD_MORE_RUACH_3") * 5040)))
        H.set_var("actor", H.u(ctx), ctx, "ruach_days_left", ((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 240))))
        H.run_eoc("EOC_LILIN_UPDATE_MAX_RUACH_LEVELS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_LILIN_IN_CITY_ON_OMT_ENTER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) == true
    end
    EOC["EOC_CONDITION_CHECK_LILIN_IN_CITY_ON_OMT_ENTER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_TRAITS") == 1)) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "check_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
        if ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_loc"); return p ~= nil and services.overmap.is_in_city(p) == true end)()) then
            H.set_var("actor", H.u(ctx), ctx, "lilit_is_in_civilization", 1)
        else
            H.set_var("actor", H.u(ctx), ctx, "lilit_is_in_civilization", 0)
        end
        return true
    end
    return false
    end
    COND["EOC_LILIN_INCREMENTAL_SPEED_BOOST_SETUP"] = function(ctx)
        return (((("LILIN_INCREMENTAL_SPEED_BOOST") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_LILIN_INCREMENTAL_SPEED_BOOST_SETUP"] = function(ctx)
    if (((("LILIN_INCREMENTAL_SPEED_BOOST") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        do local _t = math.max(1, math.floor((H.time_until_named("night_time", false) / 1))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LILIN_INCREMENTAL_SPEED_BOOST_TRIGGER"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_LILIN_INCREMENTAL_SPEED_BOOST_TRIGGER"] = function(ctx)
    H.run_eoc("EOC_LILIN_INCREMENTAL_SPEED_BOOST", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_LILIN_INCREMENTAL_SPEED_BOOST"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_INCREMENTAL_SPEED_BOOST") == 1)) == true
    end
    EOC["EOC_LILIN_INCREMENTAL_SPEED_BOOST"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_INCREMENTAL_SPEED_BOOST") == 1)) then
        H.eoc_add_effect(H.u(ctx), "effect_lilin_incremental_speed_boost", -1, nil, (H.creature_effect_intensity(H.u(ctx), "effect_lilin_incremental_speed_boost") + 1), nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_ENHANCEMENT_DAMAGE") == 1)) == true
    end
    EOC["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_ENHANCEMENT_DAMAGE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_ENHANCEMENT_DAMAGE") == 1)) then
        H.run_eoc("EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_STEALTH_MODIFIER_IN_DARKNESS") == 1)) == true
    end
    EOC["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_STEALTH_MODIFIER_IN_DARKNESS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_STEALTH_MODIFIER_IN_DARKNESS") == 1)) then
        H.run_eoc("EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1)) == true
    end
    EOC["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_DISEASE_MELEE_STRIKES"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1)) then
        H.run_eoc("EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE"] = function(ctx)
        return ((H.chars_nearby(H.u(ctx), 30, "any") > 0)) == true
    end
    EOC["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE"] = function(ctx)
    if ((H.chars_nearby(H.u(ctx), 30, "any") > 0)) then
        do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_NPC" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
        do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_NPC" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
        return true
    end
    return false
    end
    EOC["EOC_LILIN_PLAGUE_DEMON_PROXIMITY_PLAGUE_NPC"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Running Lilit plague check on <u_name>.")), "debug")
    if ((H.char_health(H.u(ctx)) <= (-185)) and (H.creature_has_effect(H.u(ctx), "common_cold") or H.creature_has_effect(H.u(ctx), "influenza") or H.creature_has_effect(H.u(ctx), "tetanus") or H.creature_has_effect(H.u(ctx), "rat_bite_fever") or H.creature_has_effect(H.u(ctx), "infected") or H.creature_has_effect(H.u(ctx), "asthma")) and services.random.native_probability((1), (5))) then
        if H.u(ctx) then services.characters.die(H.u(ctx)) end
    end
    if (((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((((((1 + H.char_health(H.u(ctx))) <= (-0))) and (1) or (0))), (((3 + (H.char_has_trait(H.u(ctx), "DISRESISTANT") * 3)) + ((((H.u(ctx) and H.safe_id('json_flag', "NO_DISEASE") and services.characters.has_flag(H.u(ctx), H.safe_id('json_flag', "NO_DISEASE")).value) == true) and 1 or 0) * 1000))))) then
        services.messages.add(ctx:expand_text(services.translate("Infecting <u_name> with the flu.")), "debug")
        do local _eg = H.safe_id('effect', "pre_flu"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "influenza", (function() local a, b = math.floor(345600), math.floor(1036800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    end
    if (((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((((((1 + H.char_health(H.u(ctx))) <= (-0))) and (1) or (0))), (((3 + (H.char_has_trait(H.u(ctx), "DISRESISTANT") * 3)) + ((((H.u(ctx) and H.safe_id('json_flag', "NO_DISEASE") and services.characters.has_flag(H.u(ctx), H.safe_id('json_flag', "NO_DISEASE")).value) == true) and 1 or 0) * 1000))))) then
        services.messages.add(ctx:expand_text(services.translate("Infecting <u_name> with a cold.")), "debug")
        do local _eg = H.safe_id('effect', "pre_common_cold"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "common_cold", (function() local a, b = math.floor(345600), math.floor(1036800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    end
    if ((not ((H.creature_has_effect(H.u(ctx), "pre_common_cold") or H.creature_has_effect(H.u(ctx), "common_cold") or H.creature_has_effect(H.u(ctx), "pre_flu") or H.creature_has_effect(H.u(ctx), "influenza")))) and services.random.native_probability((((((1 + (((H.char_health(H.u(ctx)) <= 0)) and (1) or (0))) + (((H.char_health(H.u(ctx)) <= (-100))) and (1) or (0))) + (((H.char_health(H.u(ctx)) <= (-150))) and (1) or (0))) + (((H.char_health(H.u(ctx)) <= (-175))) and (1) or (0)))), (((6 + (H.char_has_trait(H.u(ctx), "DISRESISTANT") * 6)) + ((((H.u(ctx) and H.safe_id('json_flag', "NO_DISEASE") and services.characters.has_flag(H.u(ctx), H.safe_id('json_flag', "NO_DISEASE")).value) == true) and 1 or 0) * 5000))))) then
        if (services.random.native_int(0, H.round_half_away(1)) == 1) then
            services.messages.add(ctx:expand_text(services.translate("Infecting <u_name> with pre-cold.")), "debug")
            H.eoc_add_effect(H.u(ctx), "pre_common_cold", (function() local a, b = math.floor(432000), math.floor(777600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        else
            services.messages.add(ctx:expand_text(services.translate("Infecting <u_name> with pre-flu.")), "debug")
            H.eoc_add_effect(H.u(ctx), "pre_flu", (function() local a, b = math.floor(432000), math.floor(777600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        end
    end
    return true
    end
    COND["EOC_LILIN_DISEASE_MELEE_STRIKES_CHARACTER_ATTACK"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1) and services.random.native_probability((math.max((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 1000), 1)), (10)) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).has_weapon == true))) and ((ctx:get_number("hits") or 0) ~= H.global_var_num("false")))) == true
    end
    EOC["EOC_LILIN_DISEASE_MELEE_STRIKES_CHARACTER_ATTACK"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1) and services.random.native_probability((math.max((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 1000), 1)), (10)) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).has_weapon == true))) and ((ctx:get_number("hits") or 0) ~= H.global_var_num("false")))) then
        H.eoc_add_effect(H.npc(ctx), "effect_lilin_supernatural_disease", (function() local a, b = math.floor((1 + (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") * 0.09))), math.floor((15 + (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") * 0.24))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_DISEASE_MELEE_STRIKES_MONSTER_ATTACK"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1) and services.random.native_probability((math.max((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 1000), 1)), (10)) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).has_weapon == true))) and ((ctx:get_number("hits") or 0) ~= H.global_var_num("false")))) == true
    end
    EOC["EOC_LILIN_DISEASE_MELEE_STRIKES_MONSTER_ATTACK"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "LILIN_DISEASE_MELEE_STRIKES") == 1) and services.random.native_probability((math.max((H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") / 1000), 1)), (10)) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).has_weapon == true))) and ((ctx:get_number("hits") or 0) ~= H.global_var_num("false")))) then
        H.eoc_add_effect(H.npc(ctx), "effect_lilin_supernatural_disease", (function() local a, b = math.floor((1 + (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") * 0.09))), math.floor((15 + (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") * 0.24))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_PREVENT_DEATH_INITIATE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "LILIN_PREVENT_DEATH_TRIGGER") == 1) and (not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "onfire"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()))) and (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") > 0) and (not (((function() local eg = H.safe_id('effect', "lilit_prevent_death_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_LILIN_PREVENT_DEATH_INITIATE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "LILIN_PREVENT_DEATH_TRIGGER") == 1) and (not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "onfire"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()))) and (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") > 0) and (not (((function() local eg = H.safe_id('effect', "lilit_prevent_death_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        ccb.presentation.notice(ctx:expand_text(services.translate("As yours wounds overtake you, you cast forth your spirit in the form of an owl.")))
        H.run_eoc("EOC_LILIN_PREVENT_DEATH_PROCESSING", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_LILIN_PREVENT_DEATH_DAMAGE_TRACKER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_PREVENT_DEATH_TRIGGER") == 1)) == true
    end
    EOC["EOC_LILIN_PREVENT_DEATH_DAMAGE_TRACKER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_PREVENT_DEATH_TRIGGER") == 1)) then
        if (H.char_hp(H.u(ctx), "torso", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_return_from_death_hp_torso", H.char_hp(H.u(ctx), "torso", false))
        end
        if (H.char_hp(H.u(ctx), "head", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_return_from_death_hp_head", H.char_hp(H.u(ctx), "head", false))
        end
        if (H.char_hp(H.u(ctx), "arm_l", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_return_from_death_hp_arm_l", H.char_hp(H.u(ctx), "arm_l", false))
        end
        if (H.char_hp(H.u(ctx), "arm_r", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_return_from_death_hp_arm_r", H.char_hp(H.u(ctx), "arm_r", false))
        end
        if (H.char_hp(H.u(ctx), "leg_l", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_return_from_death_hp_leg_l", H.char_hp(H.u(ctx), "leg_l", false))
        end
        if (H.char_hp(H.u(ctx), "leg_r", false) > 0) then
            H.set_var("actor", H.u(ctx), ctx, "lilin_return_from_death_hp_leg_r", H.char_hp(H.u(ctx), "leg_r", false))
        end
        return true
    end
    return false
    end
    COND["EOC_LILIN_PREVENT_DEATH_PROCESSING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "LILIN_PREVENT_DEATH_TRIGGER") == 1)) == true
    end
    EOC["EOC_LILIN_PREVENT_DEATH_PROCESSING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "LILIN_PREVENT_DEATH_TRIGGER") == 1)) then
        if (H.char_vitamin(H.u(ctx), "lilin_ruach_vitamin") > (3000 * H._jm_lilin_has_ruach_efficiency(ctx))) then
            do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (3000 * H._jm_lilin_has_ruach_efficiency(ctx)); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        else
            do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        H.set_char_hp(H.u(ctx), "ALL_MINOR", 999, "=")
        H.set_char_hp(H.u(ctx), "torso", math.max(H.var_num(H.u(ctx), "lilin_return_from_death_hp_torso"), 10), "=")
        H.set_char_hp(H.u(ctx), "head", math.max(H.var_num(H.u(ctx), "lilin_return_from_death_hp_head"), 10), "=")
        H.set_char_hp(H.u(ctx), "arm_l", math.max(H.var_num(H.u(ctx), "lilin_return_from_death_hp_arm_l"), 10), "=")
        H.set_char_hp(H.u(ctx), "arm_r", math.max(H.var_num(H.u(ctx), "lilin_return_from_death_hp_arm_r"), 10), "=")
        H.set_char_hp(H.u(ctx), "leg_l", math.max(H.var_num(H.u(ctx), "lilin_return_from_death_hp_leg_l"), 10), "=")
        H.set_char_hp(H.u(ctx), "leg_r", math.max(H.var_num(H.u(ctx), "lilin_return_from_death_hp_leg_r"), 10), "=")
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "bad_food"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _eg = H.safe_id('effect', "corroding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "downed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "sap"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "staggered_character"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "nausea"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "deaf"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "grabbed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "tpollen"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "lilit_prevent_death_escape", 15, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "lilit_prevent_death_cooldown", 300, nil, nil, nil)
        do local _a, _v = H.u(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (360 * H._jm_lilin_has_ruach_efficiency(ctx)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _g = H.safe_id('mutation', "LILIN_TURN_INTO_OWL"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, true) end end
        return true
    end
    return false
    end
    EOC["EOC_LILIN_RUACH_DRAIN_DIALOGUE"] = function(ctx)
    do local _a, _v = H.npc(ctx), "lilin_ruach_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_float(200, 300); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    services.messages.add(ctx:expand_text(services.translate("You feel a rush of warmth as you absorb the ruach.")), "good")
    H.set_var("actor", H.u(ctx), ctx, "lilin_ruach_drained_recently", 1)
    H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS_DIALOGUE", ctx, nil, nil, nil)
    if (H.char_has_trait(H.npc(ctx), "LILIN_REDUCED_NEEDS_WITH_RUACH_AND_KCAL_DRAIN") == 1) then
        H.run_eoc("EOC_LILIN_RUACH_DRAIN_SIDE_GAIN_SUSTENANCE", ctx, nil, nil, nil)
    end
    return true
    end
    EOC["EOC_LILIN_RUACH_DRAIN_SIDE_EFFECTS_DIALOGUE"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_lilin_ruach_drain_side_effects", (function() local a, b = math.floor(259200), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") + 1), nil)
    if (((function() local eg = H.safe_id('effect', "effect_lilin_allowed_ruach_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 1)) then
        H.npc_mood_write(H.npc(ctx), "fear", (1 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2)), "+=")
    end
    if ((services.random.native_int(0, H.round_half_away(1)) == 1) and ((function() local eg = H.safe_id('effect', "effect_lilin_allowed_ruach_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 1)) then
        H.npc_mood_write(H.npc(ctx), "trust", (1 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2)), "-=")
    end
    if ((services.random.native_int(0, H.round_half_away(2)) == 2) and ((function() local eg = H.safe_id('effect', "effect_lilin_allowed_ruach_drain"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 2)) then
        H.npc_mood_write(H.npc(ctx), "value", (1 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2)), "-=")
    end
    do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "head") }) end end
    do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "arm_l") }) end end
    do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "arm_r") }) end end
    do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "torso") }) end end
    do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "leg_r") }) end end
    do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") / 2) - 3), 0), { body_part = H.safe_id('body_part', "leg_l") }) end end
    if ((services.random.native_int(0, H.round_half_away(1)) == 1) and (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 2)) then
        H.set_char_val_extra(H.u(ctx), "sleepiness", (2 + (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") * 1.5)), "+=")
    end
    if (H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") >= 4) then
        H.eoc_add_effect(H.u(ctx), "staggered_character", math.max(((H.creature_effect_intensity(H.u(ctx), "effect_lilin_ruach_drain_side_effects") - 3) * 2), 0), nil, 1, nil)
    end
    H.eoc_add_effect(H.u(ctx), "effect_lilin_allowed_ruach_drain", (function() local a, b = math.floor(259200), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    return true
    end
    COND["EOC_GAIN_COMMUNE_OAKS"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "TREE_COMMUNION") == 1)))) == true
    end
    EOC["EOC_GAIN_COMMUNE_OAKS"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "TREE_COMMUNION") == 1)))) then
        services.messages.add(ctx:expand_text(services.translate("The trees whisper their secrets to you.  [Check mutations to activate]")), "good")
        do local _g = H.safe_id('mutation', "TREE_COMMUNION"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(60), math.floor(60); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LOSE_COMMUNE_OAKS"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You are already in tune with the rhythms of the forest.  Further magic cannot deepen your bond.")), "good")
        return false
    end
    end
    EOC["EOC_LOSE_COMMUNE_OAKS"] = function(ctx)
    H.lose_trait(H.u(ctx), "TREE_COMMUNION")
    return true
    end
    EOC["EOC_MIGRATE_SPELL"] = function(ctx)
    local _a47 = H.u(ctx)
    local _sn48 = "summon_battery_gun"
    local _sg49 = (_sn48 ~= "") and H.safe_id("spell", _sn48) or nil
    if _a47 and _sg49 then services.spells.set_level(_a47, _sg49, math.floor((-1))) end
    local _a50 = H.u(ctx)
    local _sn51 = "summon_ray_gun"
    local _sg52 = (_sn51 ~= "") and H.safe_id("spell", _sn51) or nil
    if _a50 and _sg52 then services.spells.set_level(_a50, _sg52, math.floor((-1))) end
    local _a53 = H.u(ctx)
    local _sn54 = "summon_death_ray"
    local _sg55 = (_sn54 ~= "") and H.safe_id("spell", _sn54) or nil
    if _a53 and _sg55 then services.spells.set_level(_a53, _sg55, math.floor((-1))) end
    local _a56 = H.u(ctx)
    local _sn57 = "summon_mace_magic"
    local _sg58 = (_sn57 ~= "") and H.safe_id("spell", _sn57) or nil
    if _a56 and _sg58 then services.spells.set_level(_a56, _sg58, math.floor((-1))) end
    local _a59 = H.u(ctx)
    local _sn60 = "summon_bio_launcher"
    local _sg61 = (_sn60 ~= "") and H.safe_id("spell", _sn60) or nil
    if _a59 and _sg61 then services.spells.set_level(_a59, _sg61, math.floor((-1))) end
    local _a62 = H.u(ctx)
    local _sn63 = "summon_bio_warhead"
    local _sg64 = (_sn63 ~= "") and H.safe_id("spell", _sn63) or nil
    if _a62 and _sg64 then services.spells.set_level(_a62, _sg64, math.floor((-1))) end
    local _a65 = H.u(ctx)
    local _sn66 = "summon_rip_ticket"
    local _sg67 = (_sn66 ~= "") and H.safe_id("spell", _sn66) or nil
    if _a65 and _sg67 then services.spells.set_level(_a65, _sg67, math.floor((-1))) end
    local _a68 = H.u(ctx)
    local _sn69 = "summon_helmet_inventor"
    local _sg70 = (_sn69 ~= "") and H.safe_id("spell", _sn69) or nil
    if _a68 and _sg70 then services.spells.set_level(_a68, _sg70, math.floor((-1))) end
    local _a71 = H.u(ctx)
    local _sn72 = "summon_ion_gun"
    local _sg73 = (_sn72 ~= "") and H.safe_id("spell", _sn72) or nil
    if _a71 and _sg73 then services.spells.set_level(_a71, _sg73, math.floor((-1))) end
    local _a74 = H.u(ctx)
    local _sn75 = "spark_of_inspiration"
    local _sg76 = (_sn75 ~= "") and H.safe_id("spell", _sn75) or nil
    if _a74 and _sg76 then services.spells.set_level(_a74, _sg76, math.floor((-1))) end
    local _a77 = H.u(ctx)
    local _sn78 = "research_dreamdross"
    local _sg79 = (_sn78 ~= "") and H.safe_id("spell", _sn78) or nil
    if _a77 and _sg79 then services.spells.set_level(_a77, _sg79, math.floor((-1))) end
    local _a80 = H.u(ctx)
    local _sn81 = "forge_dreamdross"
    local _sg82 = (_sn81 ~= "") and H.safe_id("spell", _sn81) or nil
    if _a80 and _sg82 then services.spells.set_level(_a80, _sg82, math.floor((-1))) end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_REGAIN_BLOOD"] = function(ctx)
    H.set_var("context", nil, ctx, "blood_bonus", ((ctx:get_number("blood_bonus") or 0)) + (((50 * H._jm_bloodthorn_druid_traits_sum_as_npc(ctx)) + (25 * H.char_sum_traits_cat(H.npc(ctx), "ARVORE_ALCHEMY", "ALL")))))
    do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (ctx:get_number("blood_bonus") or 0); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (ctx:get_number("blood_bonus") or 0); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_1_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_1"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "bloodthorne_druid_bandage_01" } }, { "EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_1_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_2_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_2"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "bloodthorne_druid_bandage_02" } }, { "EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_2_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_3_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "heal", { target = _p }) end end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_3"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "bloodthorne_druid_bandage_03" } }, { "EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_3_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING"] = function(ctx)
    do
        local _sw83 = ((2 * H._jm_bloodthorn_druid_traits_sum(ctx)) + H.char_sum_traits_cat(H.u(ctx), "ARVORE_ALCHEMY", "ALL"))
        if _sw83 == 0 then
            H.eoc_spawn_item(H.u(ctx), "bloodthorne_druid_bandage_01", 1, false, false, nil)
            H.run_eoc("EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_1", ctx, nil, nil, nil)
            do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CLEANUP"), nil) end end
        elseif _sw83 == 20 then
            H.eoc_spawn_item(H.u(ctx), "bloodthorne_druid_bandage_02", 1, false, false, nil)
            H.run_eoc("EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_2", ctx, nil, nil, nil)
            do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CLEANUP"), nil) end end
        elseif _sw83 == 40 then
            H.eoc_spawn_item(H.u(ctx), "bloodthorne_druid_bandage_03", 1, false, false, nil)
            H.run_eoc("EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CASE_3", ctx, nil, nil, nil)
            do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CLEANUP"), nil) end end
        end
    end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_STOP_BLEEDING_CLEANUP"] = function(ctx)
    do local g = H.safe_id('item', "bloodthorne_druid_bandage_01"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "bloodthorne_druid_bandage_02"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "bloodthorne_druid_bandage_03"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    return true
    end
    COND["EOC_BLOODTHORNE_DRUID_PROTECT_FROM_VAMPIRISM"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_bloodthorne_druid_prevent_vampirism"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("vampire_virus") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_BLOODTHORNE_DRUID_PROTECT_FROM_VAMPIRISM"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_bloodthorne_druid_prevent_vampirism"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("vampire_virus") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        do local _eg = H.safe_id('effect', "effect_bloodthorne_druid_prevent_vampirism"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("As you feel the burning in your veins, your sapshield creaks to life.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_bloodthorne_druid_prevent_vampirism_active", (300 + ((20 * H._jm_bloodthorn_druid_traits_sum(ctx)) + (5 * H.char_sum_traits_cat(H.u(ctx), "ARVORE_ALCHEMY", "ALL")))), nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD_COUNT"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "blood_total_healing", (H.var_num(H.u(ctx), "blood_total_healing")) + (2))
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "bloody_terrain"), H.safe_id('terrain_furniture_transform', "ter_bloodthorne_druid_heal_from_spilled_blood"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD"] = function(ctx)
    do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(((2 + (0.2 * H._jm_bloodthorn_druid_traits_sum(ctx))) + (0.05 * H.char_sum_traits_cat(H.u(ctx), "ARVORE_ALCHEMY", "ALL")))) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "bloody_terrain", _p); if ((((function() local p = H.get_tripoint_var("context", nil, ctx, "bloody_terrain"); local fg = H.safe_id('field', "fd_blood"); return p ~= nil and fg ~= nil and services.gameplay.environment.field_exists(p, fg, true) end)()) and (((function() local p = H.get_tripoint_var("context", nil, ctx, "bloody_terrain"); local fg = H.safe_id('json_flag', "PLOWABLE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "bloody_terrain"); local fg = H.safe_id('json_flag', "SHRUB"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "bloody_terrain"); local fg = H.safe_id('json_flag', "YOUNG"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())))) then for _, _eid in ipairs({ "EOC_BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD_COUNT" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
    services.messages.add(ctx:expand_text(services.translate("There are <u_val:blood_total_healing> points worth of healing in nearby blood.")), "debug")
    if (H.var_num(H.u(ctx), "blood_total_healing") > 0) then
        if (H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) then
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) + (1))
        end
        if (H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) then
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) + (1))
        end
        if (H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) then
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) + (1))
        end
        if (H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) then
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) + (1))
        end
        if (H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) then
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) + (1))
        end
        if (H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true)) then
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) + (1))
        end
        H.set_var("context", nil, ctx, "total_healing_per_part", (H.var_num(H.u(ctx), "blood_total_healing") / (ctx:get_number("bodyparts_needing_healing") or 0)))
        H.set_var("actor", H.u(ctx), ctx, "blood_total_healing", 0)
        if ((H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) and ((ctx:get_number("bodyparts_needing_healing") or 0) > 0)) then
            H.set_char_hp(H.u(ctx), "arm_r", (ctx:get_number("total_healing_per_part") or 0), "+=")
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) - (1))
        end
        if ((H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) and ((ctx:get_number("bodyparts_needing_healing") or 0) > 0)) then
            H.set_char_hp(H.u(ctx), "arm_l", (ctx:get_number("total_healing_per_part") or 0), "+=")
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) - (1))
        end
        if ((H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) and ((ctx:get_number("bodyparts_needing_healing") or 0) > 0)) then
            H.set_char_hp(H.u(ctx), "leg_r", (ctx:get_number("total_healing_per_part") or 0), "+=")
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) - (1))
        end
        if ((H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) and ((ctx:get_number("bodyparts_needing_healing") or 0) > 0)) then
            H.set_char_hp(H.u(ctx), "leg_l", (ctx:get_number("total_healing_per_part") or 0), "+=")
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) - (1))
        end
        if ((H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) and ((ctx:get_number("bodyparts_needing_healing") or 0) > 0)) then
            H.set_char_hp(H.u(ctx), "torso", (ctx:get_number("total_healing_per_part") or 0), "+=")
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) - (1))
        end
        if ((H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true)) and ((ctx:get_number("bodyparts_needing_healing") or 0) > 0)) then
            H.set_char_hp(H.u(ctx), "head", (ctx:get_number("total_healing_per_part") or 0), "+=")
            H.set_var("context", nil, ctx, "bodyparts_needing_healing", ((ctx:get_number("bodyparts_needing_healing") or 0)) - (1))
        end
        services.messages.add(ctx:expand_text(services.translate("You draw on spilled blood and your wounds are healed.")), "good")
    else
        services.messages.add(ctx:expand_text(services.translate("You finish the spell but there is no spilled blood for you to draw on.")), "bad")
    end
    return true
    end
    EOC["EOC_BLOODTHORNE_DRUID_CREATE_THORN_PRISON"] = function(ctx)
    do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_arvore_summoned_brambles"); if _p and _g then services.world.transform_radius(_p, math.floor(2), _g, nil) end end
    if (H.u(ctx) ~= nil) then
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "torso", 5, nil)
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "head", 5, nil)
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "arm_l", 5, nil)
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "arm_r", 5, nil)
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "leg_l", 5, nil)
        H.eoc_add_effect(H.u(ctx), "bleed", 300, "leg_r", 5, nil)
    else
        H.eoc_add_effect(H.u(ctx), "bleed", 300, nil, 10, nil)
    end
    if ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1) or (H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE_ANATHEMA") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE_ANATHEMA")).value == true)))) then
        H.eoc_add_effect(H.u(ctx), "effect_bloodthorne_druid_thorn_prison", (10 + (H.char_sum_traits_cat(H.npc(ctx), "ARVORE_ALCHEMY", "ALL") / 3)), nil, nil, nil)
    end
    return true
    end
    EOC["EOC_XE_CHANGELING_SET_YRAX_ATTENTION_VARIABLE"] = function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "general_yrax_u_met_apeirohedra", "yes")
    return true
    end
    EOC["EOC_CHANGELING_AUTUMN_TOUCH_OF_FRAILTY"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", (((5.62 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 1.85)) + (H.char_skill(H.u(ctx), "gramarye") * 2.53)) * (((H.global_var_num("global_what_is_the_season") == 3)) and (3) or (1))))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", (((12.35 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 3.85)) + (H.char_skill(H.u(ctx), "gramarye") * 4.98)) * (((H.global_var_num("global_what_is_the_season") == 3)) and (3) or (1))))
    if (H.u(ctx) ~= nil) then
        do local _eg = H.safe_id('effect', "effect_changeling_autumn_touch_of_frailty_character"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_changeling_autumn_touch_of_frailty_character", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    else
        do local _eg = H.safe_id('effect', "effect_changeling_autumn_touch_of_frailty_monster"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_changeling_autumn_touch_of_frailty_monster", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    end
    return true
    end
    COND["EOC_CHANGELING_AUTUMN_SCARE_ANIMALS"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER_BURROWING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER_BURROWING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ABERRATION")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NIGHTMARE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NIGHTMARE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CHANGELING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ARVORE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HOMULLUS")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "IERDE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SALAMANDER")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SYLPH")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "UNDINE")).value == true))))))) == true
    end
    EOC["EOC_CHANGELING_AUTUMN_SCARE_ANIMALS"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER_BURROWING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER_BURROWING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "VAMPIRE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "VAMPIRE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "RENFIELD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "RENFIELD")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ABERRATION")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NIGHTMARE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NIGHTMARE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CHANGELING")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ARVORE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HOMULLUS")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "IERDE")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SALAMANDER")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SYLPH")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "UNDINE")).value == true))))))) then
        if (not (((function() local eg = H.safe_id('effect', "effect_changeling_autumn_scare_animals"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            H.set_char_val_extra(H.u(ctx), "morale", (((((25 + ((H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 2) + (H.char_skill(H.u(ctx), "gramarye") * 4))) * H.global_var_num("global_what_is_the_season")) == 1)) and (0.5) or (1)), "-=")
            H.eoc_add_effect(H.u(ctx), "effect_changeling_autumn_scare_animals", 300, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_AUTUMN_CHANGE_WEATHER_DENSE_FOG"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") ~= 1)) == true
    end
    EOC["EOC_CHANGELING_AUTUMN_CHANGE_WEATHER_DENSE_FOG"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") ~= 1)) then
        services.messages.add(ctx:expand_text(services.translate("A thick fog begins to rise.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 1)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_fog", 21600, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((458.12 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 79.52)) + (H.char_skill(H.u(ctx), "gramarye") * 153.71)) * (((H.global_var_num("global_what_is_the_season") == 1)) and (0.6) or (1)))), math.floor((((915.27 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 216.85)) + (H.char_skill(H.u(ctx), "gramarye") * 398.52)) * (((H.global_var_num("global_what_is_the_season") == 1)) and (0.4) or (1)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_AUTUMN_CHANGE_WEATHER_DENSE_FOG_REMOVE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You release your command over the fog and it begins to disperse.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        return false
    end
    end
    COND["EOC_CHANGELING_AUTUMN_CHANGE_WEATHER_DENSE_FOG_REMOVE"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") == 1)) == true
    end
    EOC["EOC_CHANGELING_AUTUMN_CHANGE_WEATHER_DENSE_FOG_REMOVE"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") == 1)) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("The thick fog begins to disperse.")), "neutral")
        end
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_AUTUMN_FREEZE_IN_PLACE"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_changeling_autumn_freeze_in_place_target", -1, nil, nil, nil)
    H.eoc_add_effect(H.npc(ctx), "effect_changeling_autumn_freeze_in_place_self", -1, nil, nil, nil)
    do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_NO_CASTING_OTHER_GLAMOURS_CHECKER"), nil) end end
    return true
    end
    COND["EOC_CHANGELING_AUTUMN_FREEZE_IN_PLACE_CANCEL"] = function(ctx)
        return (((("effect_changeling_autumn_freeze_in_place_self") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_CHANGELING_AUTUMN_FREEZE_IN_PLACE_CANCEL"] = function(ctx)
    if (((("effect_changeling_autumn_freeze_in_place_self") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.eoc_cast_spell(H.u(ctx), "changeling_autumn_freeze_in_place_remover", false, nil)
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_AUTUMN_TIME_FELLS_MIGHTY_WARRIOR"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", (((25.19 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 2.84)) + (H.char_skill(H.u(ctx), "gramarye") * 4.25)) * (((H.global_var_num("global_what_is_the_season") == 3)) and (3) or (1))))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", (((50.69 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_AUTUMN") * 6.18)) + (H.char_skill(H.u(ctx), "gramarye") * 11.14)) * (((H.global_var_num("global_what_is_the_season") == 3)) and (3) or (1))))
    if (H.u(ctx) ~= nil) then
        do local _eg = H.safe_id('effect', "effect_changeling_autumn_wither_with_time_character"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_changeling_autumn_wither_with_time_character", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    else
        do local _eg = H.safe_id('effect', "effect_changeling_autumn_wither_with_time_monster"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_changeling_autumn_wither_with_time_monster", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    end
    return true
    end
    COND["EOC_CHANGELING_SPRING_MINOR_RESTORE_STAMINA_AND_PAIN"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "PLOWABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()))) == true
    end
    EOC["EOC_CHANGELING_SPRING_MINOR_RESTORE_STAMINA_AND_PAIN"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "PLOWABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()))) then
        local _a84 = H.u(ctx)
        if _a84 then services.characters.adjust(_a84, { pain = math.floor(-((services.random.native_int(0, H.round_half_away(2)) + 1))) }) end
        H.set_char_val_extra(H.u(ctx), "stamina", (1000 + ((H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 30) - (H.char_skill(H.u(ctx), "gramarye") * 25))), "+=")
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_changeling_spring_verdant_vitality"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You need to be standing on vegetation to drawn on its vitality.")), "bad")
        return false
    end
    end
    EOC["EOC_CHANGELING_SPRING_SUMMON_FLOWER_WARRIORS"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((30.51 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 5.1)) + (H.char_skill(H.u(ctx), "gramarye") * 9.52)))
    H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((75.12 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 12.04)) + (H.char_skill(H.u(ctx), "gramarye") * 21.85)))
    services.messages.add(ctx:expand_text(services.translate("Select foliage.")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "changeling_spring_summon_flower_warriors_location") and 1 or 0)) then
        if (((function() local p = H.get_tripoint_var("context", nil, ctx, "changeling_spring_summon_flower_warriors_location"); local fg = H.safe_id('json_flag', "PLOWABLE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "changeling_spring_summon_flower_warriors_location"); local fg = H.safe_id('json_flag', "TREE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "changeling_spring_summon_flower_warriors_location"); local fg = H.safe_id('json_flag', "SHRUB"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "changeling_spring_summon_flower_warriors_location"); local fg = H.safe_id('json_flag', "YOUNG"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then
            do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_fetch_daffodil_warrior_player") or H.safe_id('monster_group', "mon_fetch_daffodil_warrior_player"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(math.min(((1 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 0.1)) + (H.char_skill(H.u(ctx), "gramarye") * 0.3)), 16)), min_radius = math.floor(1), max_radius = math.floor(4), lifespan = services.time.duration_from_turns(math.floor((services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")) * (((H.global_var_num("global_what_is_the_season") == 3)) and (0.6) or (1))))) }); 
                if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("The foliage grows and sprouts in a flash and a daffodil warrior steps forth.")), 'warning') end
            end end
        else
            services.messages.add(ctx:expand_text(services.translate("You must spin the daffodil warriors out of greenery.")), "bad")
        end
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_CHANGELING_SPRING_HEALING_INCREASE_WHILE_OUTSIDE_APPLY_EFFECT"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_changeling_spring_healing_increase_while_outside", services.random.native_float(H.var_num(H.u(ctx), "spell_low_duration"), H.var_num(H.u(ctx), "spell_high_duration")), nil, nil, nil)
    if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
        services.messages.add(ctx:expand_text(services.translate("You feel a warm sensation spread over your entire body.")), "good")
    end
    return true
    end
    COND["EOC_CHANGELING_SPRING_HEALING_INCREASE_WHILE_OUTSIDE_INITIATE"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).avatar == true)) == true
    end
    EOC["EOC_CHANGELING_SPRING_HEALING_INCREASE_WHILE_OUTSIDE_INITIATE"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).avatar == true)) then
        H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((846.12 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 129.52)) + (H.char_skill(H.u(ctx), "gramarye") * 185.42)))
        H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((1685.24 + (H.char_spell_count(H.u(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 348.15)) + (H.char_skill(H.u(ctx), "gramarye") * 498.51)))
        H.run_eoc("EOC_CHANGELING_SPRING_HEALING_INCREASE_WHILE_OUTSIDE_APPLY_EFFECT", ctx, nil, nil, nil)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "spring_magic_spell_count", H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING"))
        H.set_var("actor", H.u(ctx), ctx, "spring_magic_deduction_level", H.char_skill(H.npc(ctx), "gramarye"))
        H.set_var("actor", H.u(ctx), ctx, "spell_low_duration", ((846.12 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 129.52)) + (H.char_skill(H.npc(ctx), "gramarye") * 185.42)))
        H.set_var("actor", H.u(ctx), ctx, "spell_high_duration", ((1685.24 + (H.char_spell_count(H.npc(ctx), "CHANGELING_SEASONAL_MAGIC_SPRING") * 348.15)) + (H.char_skill(H.npc(ctx), "gramarye") * 498.51)))
        H.run_eoc("EOC_CHANGELING_SPRING_HEALING_INCREASE_WHILE_OUTSIDE_APPLY_EFFECT", ctx, nil, nil, nil)
        return false
    end
    end
end
