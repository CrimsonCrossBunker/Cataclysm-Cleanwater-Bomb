local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (15))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (15))) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_SPELL_PYROKIN_THERMOGENESIS_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_1"] == nil or E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_1"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Minor thermogenesis")), description = ctx:expand_text(services.translate("Raise the temperature a few degrees.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_SPELL_PYROKIN_SUMMON_HEAT_1" end end
        do local _en = (E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_2"] == nil or E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_2"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Lesser thermogenesis")), description = ctx:expand_text(services.translate("Raise the temperature from a summer night to a summer day.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_SPELL_PYROKIN_SUMMON_HEAT_2" end end
        do local _en = (E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_3"] == nil or E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_3"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Greater thermogenesis")), description = ctx:expand_text(services.translate("Raise the temperature from winter to early fall.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_SPELL_PYROKIN_SUMMON_HEAT_3" end end
        do local _en = (E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_4"] == nil or E.cond["EOC_SPELL_PYROKIN_SUMMON_HEAT_4"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Major thermogenesis")), description = ctx:expand_text(services.translate("Raise the temperature from winter to summer.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_SPELL_PYROKIN_SUMMON_HEAT_4" end end
        do local _en = (E.cond["EOC_SPELL_PYROKIN_BANISH_HEAT"] == nil or E.cond["EOC_SPELL_PYROKIN_BANISH_HEAT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Banish all thermogenesis nodes")), description = ctx:expand_text(services.translate("Stop all current thermogenesis.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_SPELL_PYROKIN_BANISH_HEAT" end end
        do local _en = (E.cond["EOC_MOM_NO_EFFECT"] == nil or E.cond["EOC_MOM_NO_EFFECT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Nevermind")), description = ctx:expand_text(services.translate("Do nothing for now.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_MOM_NO_EFFECT" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_SPELL_PYROKIN_SUMMON_HEAT_1"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "pyrokin_summon_thermogenesis_1", false, { targeted = true, message = ctx:expand_text(services.translate("The air nearby grows slightly warmer.")) })
    H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_two", false, { hit_self = true })
    return true
    end
    EOC["EOC_SPELL_PYROKIN_SUMMON_HEAT_2"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "pyrokin_summon_thermogenesis_2", false, { targeted = true, message = ctx:expand_text(services.translate("Warm air swirls from the spot.")) })
    H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_four", false, { hit_self = true })
    return true
    end
    EOC["EOC_SPELL_PYROKIN_SUMMON_HEAT_3"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "pyrokin_summon_thermogenesis_3", false, { targeted = true, message = ctx:expand_text(services.translate("Hot air swirls from the spot.")) })
    H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_six", false, { hit_self = true })
    return true
    end
    EOC["EOC_SPELL_PYROKIN_SUMMON_HEAT_4"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "pyrokin_summon_thermogenesis_4", false, { targeted = true, message = ctx:expand_text(services.translate("The air grows as hot as a summer day.")) })
    H.eoc_cast_spell(H.u(ctx), "psionic_drained_difficulty_eight", false, { hit_self = true })
    return true
    end
    EOC["EOC_SPELL_PYROKIN_BANISH_HEAT"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "pyrokin_banish_thermogenesis", false, nil)
    services.messages.add(ctx:expand_text(services.translate("The heated air you have been maintaining returns to normal.")), "neutral")
    return true
    end
    COND["EOC_TELEKIN_MOMENTUM_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_MOMENTUM_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The air around you feels more yielding.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_momentum", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_momentum") * 10) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_momentum") * 20) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_MOMENTUM_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_MOMENTUM", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_REMOVE_MOMENTUM"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_MOMENTUM"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telekinetic_momentum"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_MOMENTUM_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_MOMENTUM_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_momentum"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 3)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_momentum"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_momentum") * 10) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_momentum") * 20) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_MOMENTUM_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEKIN_WATER_WALKING"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_WATER_WALKING"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your steps feel very light on the ground.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_water_walking", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_water_walk") * 8) + 15) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_water_walk") * 26) + 75) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_WATER_WALKING_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_WATER_WALKING", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_REMOVE_WATER_WALKING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_WATER_WALKING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_WATER_WALKING_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_WATER_WALKING_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_water_walking"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 4)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_water_walk"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_water_walk") * 8) + 15) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_water_walk") * 26) + 75) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_WATER_WALKING_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEKIN_LIFTING_FIELD_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_LIFTING_FIELD_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You prepare to hover an item close to hand.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_lifting_field", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_TELEKIN_LIFTING_FIELD_SWITCHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_lifting_field") * 93) + 494) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_lifting_field") * 259) + 1674) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_LIFTING_FIELD_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_LIFTING_FIELD", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_LIFTING_FIELD_SWITCHER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_LIFTING_FIELD_SWITCHER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do
            local _sw49 = H.char_spell_level(H.u(ctx), "telekinetic_lifting_field")
            if _sw49 == 1 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_1"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 2 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_2"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 3 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_3"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 4 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_4"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 5 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_5"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 6 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_6"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 7 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_7"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 8 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_8"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 9 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_9"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 10 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_10"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 11 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_11"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 12 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_12"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 13 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_13"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 14 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_14"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 15 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_15"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 16 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_16"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 17 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_17"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 18 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_18"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 19 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_19"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 20 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_20"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 21 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_21"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 22 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_22"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 23 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_23"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 24 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_24"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 25 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_25"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 26 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_26"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 27 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_27"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 28 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_28"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 29 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_29"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            elseif _sw49 == 30 then
                do local _g = H.safe_id('mutation', "TELEKINETIC_LIFTER_30"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_REMOVE_LIFTING_FIELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_LIFTING_FIELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_TELEKIN_LIFTING_FIELD_SWITCHER_REMOVE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_LIFTING_FIELD_SWITCHER_REMOVE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1)) == true
    end
    EOC["EOC_TELEKIN_LIFTING_FIELD_SWITCHER_REMOVE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1)) then
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_30")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_29")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_28")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_27")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_26")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_25")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_24")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_23")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_22")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_21")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_20")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_19")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_18")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_17")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_16")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_15")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_14")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_13")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_12")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_11")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_10")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_9")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_8")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_7")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_6")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_5")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_4")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_3")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_2")
        H.lose_trait(H.u(ctx), "TELEKINETIC_LIFTER_1")
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_LIFTING_FIELD_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_LIFTING_FIELD_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_lifting_field"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 4)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_lifting_field"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_lifting_field") * 93) + 494) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_lifting_field") * 259) + 1674) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_LIFTING_FIELD_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEKIN_STRENGTH_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_STRENGTH_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You concentrate and prepare to lift something heavy.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_strength", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_strength") * 15) + 30) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_strength") * 30) + 120) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_STRENGTH_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_TELEKINETIC_STRENGTH"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telekinetic_strength"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_STRENGTH_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_STRENGTH_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_strength"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 5)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_strength"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_strength") * 30) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_strength") * 60) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_STRENGTH_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEKIN_SHIELD_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_SHIELD_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The air around you shimmers slightly.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_armor", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_shield") * 15) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_shield") * 25) + 900) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_SHIELD_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_SHIELD", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_REMOVE_SHIELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_SHIELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telekinetic_armor"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_SHIELD_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_SHIELD_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_shield"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_shield") * 15) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_shield") * 25) + 900) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_SHIELD_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEKIN_SUMMON_JACKING_TOOL_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_SUMMON_JACKING_TOOL_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You ready yourself to lift a car just enough to work on it.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_vehicle_lift", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_TELEKIN_SUMMON_JACKING_TOOL_SWITCHER", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_vehicle_lift") * 180) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_vehicle_lift") * 360) + 1200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_SUMMON_JACKING_TOOL_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_JACKING_TOOL", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_REMOVE_JACKING_TOOL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_JACKING_TOOL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("You let the vehicle settle gently to the ground.")), "bad")
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local g = H.safe_id('item', "telekin_lifting_jack_1"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_2"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_3"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_4"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_5"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_6"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_7"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_8"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_9"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_10"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_11"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_12"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_13"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_14"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_15"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_16"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_17"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_18"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_19"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "telekin_lifting_jack_20"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_TELEKIN_SUMMON_JACKING_TOOL_SWITCHER"] = function(ctx)
    do
        local _sw50 = H.char_spell_level(H.u(ctx), "telekinetic_vehicle_lift")
        if _sw50 == 1 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_1", 1, false, true, nil)
        elseif _sw50 == 2 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_2", 1, false, true, nil)
        elseif _sw50 == 3 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_3", 1, false, true, nil)
        elseif _sw50 == 4 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_4", 1, false, true, nil)
        elseif _sw50 == 5 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_5", 1, false, true, nil)
        elseif _sw50 == 6 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_6", 1, false, true, nil)
        elseif _sw50 == 7 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_7", 1, false, true, nil)
        elseif _sw50 == 8 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_8", 1, false, true, nil)
        elseif _sw50 == 9 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_9", 1, false, true, nil)
        elseif _sw50 == 10 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_10", 1, false, true, nil)
        elseif _sw50 == 11 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_11", 1, false, true, nil)
        elseif _sw50 == 12 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_12", 1, false, true, nil)
        elseif _sw50 == 13 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_13", 1, false, true, nil)
        elseif _sw50 == 14 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_14", 1, false, true, nil)
        elseif _sw50 == 15 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_15", 1, false, true, nil)
        elseif _sw50 == 16 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_16", 1, false, true, nil)
        elseif _sw50 == 17 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_17", 1, false, true, nil)
        elseif _sw50 == 18 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_18", 1, false, true, nil)
        elseif _sw50 == 19 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_19", 1, false, true, nil)
        elseif _sw50 == 20 then
            H.eoc_spawn_item(H.u(ctx), "telekin_lifting_jack_20", 1, false, true, nil)
        end
    end
    return true
    end
    COND["EOC_TELEKIN_SUMMON_JACKING_TOOL_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_SUMMON_JACKING_TOOL_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_vehicle_lift"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 6)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_vehicle_lift"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_vehicle_lift") * 180) + 600) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_vehicle_lift") * 360) + 1200) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_SUMMON_JACKING_TOOL_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEKIN_LEVITATION_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEKIN_LEVITATION_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin floating a hand's breadth above the ground.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telekinetic_levitation", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_levitation") * 0.75) + 1) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_levitation") * 2) + 5) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_LEVITATION_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEKIN_REMOVE_LEVITATION", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEKIN_REMOVE_LEVITATION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_REMOVE_LEVITATION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telekinetic_levitation"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEKIN_LEVITATION_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEKIN_LEVITATION_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telekinetic_levitation"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 7)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telekinetic_levitation"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_levitation") * 0.75) + 1) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telekinetic_levitation") * 2) + 5) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEKIN_LEVITATION_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_TELEKINETIC_PUSH_DIRECTION_PICKER"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "u_pos", nil, nil, nil, nil, nil, false, true, {  }, {  })
    services.messages.add(ctx:expand_text(services.translate("Select direction.")), "neutral")
    do local c, r = H.get_tripoint_var("context", nil, ctx, "u_pos"), H.get_tripoint_var("context", nil, ctx, "push_direction_incorrect"); if c and r then local mp = services.coords.tripoint_abs_ms(2*(c.x or 0)-(r.x or 0), 2*(c.y or 0)-(r.y or 0), c.z or 0); H.set_var("context", nil, ctx, "push_direction_correct", mp) end end
    if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor(H.var_num(H.u(ctx), "telekinesis_shove_spell_level")), stun = math.floor(1), dam_mult = math.floor((1 + (H.var_num(H.u(ctx), "telekinesis_shove_spell_level") * 0.4))), direction = H.get_tripoint_var("context", nil, ctx, "push_direction_correct") }) end
    return true
    end
    COND["EOC_TELEKINETIC_THROW_WEIGHT_HANDLER"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "TELEKIN_PUSH_PULL_IMMUNE"))) and (not (H.char_has_flag(H.u(ctx), "TELEKIN_SHIELD"))))) == true
    end
    EOC["EOC_TELEKINETIC_THROW_WEIGHT_HANDLER"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "TELEKIN_PUSH_PULL_IMMUNE"))) and (not (H.char_has_flag(H.u(ctx), "TELEKIN_SHIELD"))))) then
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_telekinesis_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "weight_ratio", (((((H.var_num(H.u(ctx), "telekinesis_power_level") * H.var_num(H.u(ctx), "telekinesis_weight_ratio")) * H.var_num(H.u(ctx), "telekinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telekinesis_scaling")) + (H.var_num(H.u(ctx), "telekinesis_weight_ratio") / 2)) / (H.creature_weight(H.u(ctx)) / 1000000)))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_shove_spell_level", H.clamp_num(((H.var_num(H.u(ctx), "weight_ratio") - 1) * 2), 0, 30))
        services.messages.add(ctx:expand_text(services.translate("The weight ratio is <u_val:weight_ratio>.")), "debug")
        services.messages.add(ctx:expand_text(services.translate("The effective spell level is <u_val:telekinesis_shove_spell_level>.")), "debug")
        H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
        if (H.var_num(H.u(ctx), "telekinesis_shove_spell_level") < 1) then
            H.run_eoc("EOC_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
        else
            if (H.var_num(H.u(ctx), "telekinesis_push_pull_selector") == (-1)) then
                H.set_var("actor", H.u(ctx), ctx, "telekinesis_shove_spell_level", (H.var_num(H.u(ctx), "telekinesis_shove_spell_level")) * (H.var_num(H.u(ctx), "telekinesis_push_pull_selector")))
                services.messages.add(ctx:expand_text(services.translate("The effective spell level for pulling is <u_val:telekinesis_shove_spell_level>.")), "debug")
                H.set_var("actor", H.npc(ctx), ctx, "telekinesis_shove_spell_level", H.var_num(H.u(ctx), "telekinesis_shove_spell_level"))
                do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "telekinetic_force_shove_real", (cs and cs.kind == 'monster'), { target = H.get_tripoint_var("context", nil, ctx, "loc") }) end end
                H.run_eoc("EOC_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
            else
                if ((H.char_snap(H.npc(ctx)) or {}).avatar == true) then
                    services.messages.add(ctx:expand_text(services.translate("You hurl your target.")), "good")
                    H.run_eoc("EOC_TELEKINETIC_PUSH_DIRECTION_PICKER", ctx, nil, nil, nil)
                else
                    do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "telekinetic_force_shove_real", (cs and cs.kind == 'monster'), { target = H.get_tripoint_var("context", nil, ctx, "loc") }) end end
                    H.run_eoc("EOC_TELEKINETIC_PUSH_DOWN_CHECKER", ctx, nil, nil, nil)
                end
            end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You can't get a hold of the target!")), "bad")
        return false
    end
    end
    EOC["EOC_TELEKINETIC_FAR_HAND_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_TELEKINETIC_FAR_HAND_SELECTOR_PULL"] == nil or E.cond["EOC_TELEKINETIC_FAR_HAND_SELECTOR_PULL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Pull")), description = ctx:expand_text(services.translate("Pull a set of items to you.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEKINETIC_FAR_HAND_SELECTOR_PULL" end end
        do local _en = (E.cond["EOC_TELEKINETIC_FAR_HAND_SELECTOR_PUSH"] == nil or E.cond["EOC_TELEKINETIC_FAR_HAND_SELECTOR_PUSH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Push")), description = ctx:expand_text(services.translate("Push a set of items away from you.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEKINETIC_FAR_HAND_SELECTOR_PUSH" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_TELEKINETIC_FAR_HAND_SELECTOR_PULL"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "telekinetic_item_pull_real", false, { targeted = true })
    return true
    end
    EOC["EOC_TELEKINETIC_FAR_HAND_SELECTOR_PUSH"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "telekinetic_item_push_real", false, { targeted = true })
    return true
    end
    COND["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR"] = function(ctx)
        return (((H.char_snap(H.npc(ctx)) or {}).avatar == true)) == true
    end
    EOC["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR"] = function(ctx)
    if (((H.char_snap(H.npc(ctx)) or {}).avatar == true)) then
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", (H.char_spell_level(H.npc(ctx), "telekinetic_push") + H.char_spell_level(H.npc(ctx), "telekinetic_push_knack")))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_weight_ratio", 25)
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"] == nil or E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Shove")), description = ctx:expand_text(services.translate("Shove a target in a particular direction.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH" end end
            do local _en = (E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"] == nil or E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Pull")), description = ctx:expand_text(services.translate("Grab a target and pull them towards you.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", (H.char_spell_level(H.npc(ctx), "telekinetic_push") + H.char_spell_level(H.npc(ctx), "telekinetic_push_knack")))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_weight_ratio", 25)
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_push_pull_selector", 1)
        H.run_eoc("EOC_TELEKINETIC_THROW_WEIGHT_HANDLER", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_push_pull_selector", 1)
    H.run_eoc("EOC_TELEKINETIC_THROW_WEIGHT_HANDLER", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_push_pull_selector", (-1))
    H.run_eoc("EOC_TELEKINETIC_THROW_WEIGHT_HANDLER", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_TELEKINETIC_PUSH_DOWN_CHECKER"] = function(ctx)
        return (services.random.native_probability(((H.var_num(H.u(ctx), "weight_ratio") * 1000)), (1000))) == true
    end
    EOC["EOC_TELEKINETIC_PUSH_DOWN_CHECKER"] = function(ctx)
    if (services.random.native_probability(((H.var_num(H.u(ctx), "weight_ratio") * 1000)), (1000))) then
        H.eoc_add_effect(H.u(ctx), "downed", 2, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("You shove your target off their feet.")), "good")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You attempt to shove your target but they are too heavy!")), "bad")
        return false
    end
    end
    COND["EOC_TELEKIN_WAVE_TARGETS"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_TELEKIN_WAVE_TARGETS"] = function(ctx)
    if (ctx:has_speaker()) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", (H.char_spell_level(H.npc(ctx), "telekinetic_wave") + H.char_spell_level(H.npc(ctx), "telekinetic_wave_knack")))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_telekinesis_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_weight_ratio", 55)
        H.set_var("actor", H.u(ctx), ctx, "weight_ratio", (((((H.var_num(H.u(ctx), "telekinesis_power_level") * H.var_num(H.u(ctx), "telekinesis_weight_ratio")) * H.var_num(H.u(ctx), "telekinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telekinesis_scaling")) + (H.var_num(H.u(ctx), "telekinesis_weight_ratio") / 2)) / (H.creature_weight(H.u(ctx)) / 1000000)))
        H.set_var("actor", H.u(ctx), ctx, "telekinesis_shove_spell_level", H.clamp_num(((H.var_num(H.u(ctx), "weight_ratio") - 1) * 2), 0, 30))
        if services.random.native_probability(((H.var_num(H.u(ctx), "weight_ratio") * 1000)), (1000)) then
            H.eoc_add_effect(H.u(ctx), "downed", 2, nil, nil, nil)
        end
        if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor(H.var_num(H.u(ctx), "telekinesis_shove_spell_level")), stun = math.floor(2), dam_mult = math.floor((1 + (H.var_num(H.u(ctx), "telekinesis_shove_spell_level") * 0.4))), direction = H.get_tripoint_var("context", nil, ctx, "player_position") }) end
        return true
    end
    return false
    end
    EOC["EOC_TELEKINETIC_MOVE_LARGE_WEIGHT_SELECTOR"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_power_level", H.char_spell_level(H.npc(ctx), "telekinetic_move_large_weight"))
    H.set_var("actor", H.u(ctx), ctx, "telekinesis_weight_ratio", 150)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"] == nil or E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Shove")), description = ctx:expand_text(services.translate("Shove a target in a particular direction.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PUSH" end end
        do local _en = (E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"] == nil or E.cond["EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Pull")), description = ctx:expand_text(services.translate("Pull something toward you.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_TELEKINETIC_FORCE_SHOVE_SELECTOR_PULL" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_TELEPATH_CONCENTRATION_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_CONCENTRATION_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your vision narrows to what is directly in front of you as you concentrate.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_VITAKIN_REMOVE_NO_NEED_FOR_SLEEP", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telepathic_learning_bonus", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telepathic_concentration") * 132) + 560) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telepathic_concentration") * 605) + 1033) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_CONCENTRATION_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_REMOVE_TELEPATHIC_CONCENTRATION"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_CONCENTRATION_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_CONCENTRATION_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepathic_learning_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_concentration", false))
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "telepathic_concentration"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "telepathic_concentration") * 132) + 560) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "telepathic_concentration") * 605) + 1033) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_CONCENTRATION_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPATH_SHIELD_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_SHIELD_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin shielding your thoughts.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telepathic_psi_armor", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) * 15) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) * 36) + 720) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_SHIELD_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_REMOVE_TELEPATHIC_SHIELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_SHIELD_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_SHIELD_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "telepathic_shield") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_shield", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_shield_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "telepathic_shield") >= 1) then
            do local _a, _sp = H.u(ctx), "telepathic_shield"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "telepathic_shield_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) * 15) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) * 36) + 720) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_SHIELD_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPATH_SENSE_MINDS_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_SENSE_MINDS_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You reach out with your powers, looking for nearby minds.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telepath_sense_minds", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_mind_sense") + H.char_spell_level(H.u(ctx), "telepathic_mind_sense_knack")) * 26) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_mind_sense") + H.char_spell_level(H.u(ctx), "telepathic_mind_sense_knack")) * 131) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_SENSE_MINDS_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPATH_REMOVE_SENSE_MINDS", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPATH_REMOVE_SENSE_MINDS"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_REMOVE_SENSE_MINDS"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telepath_sense_minds"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_SENSE_MINDS_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_SENSE_MINDS_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepath_sense_minds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "telepathic_mind_sense") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_mind_sense", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_mind_sense_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "telepathic_mind_sense") >= 1) then
            do local _a, _sp = H.u(ctx), "telepathic_mind_sense"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "telepathic_mind_sense_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_mind_sense") + H.char_spell_level(H.u(ctx), "telepathic_mind_sense_knack")) * 26) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_mind_sense") + H.char_spell_level(H.u(ctx), "telepathic_mind_sense_knack")) * 131) + 600) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_SENSE_MINDS_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPATH_MORALE_INITIATE_SELF"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_TELEPATH_MORALE_INITIATE_SELF"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_telepathic_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin to edit out your discouraging thoughts.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_telepathic_morale", -1, nil, nil, nil)
        do local _g = H.safe_id('morale', "morale_telepathy"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 1) + 10) * H._jm_psionic_power_modifiers(ctx))), math.floor(35), { duration = services.time.duration_from_turns(math.floor(services.random.native_float(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 381) + 981) * H._jm_psionic_power_modifiers(ctx)), (((H.char_spell_level(H.u(ctx), "telepathic_morale") * 899) + 2520) * H._jm_psionic_power_modifiers(ctx))))), decay_start = services.time.duration_from_turns(math.floor((services.random.native_float(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 381) + 981) * H._jm_psionic_power_modifiers(ctx)), (((H.char_spell_level(H.u(ctx), "telepathic_morale") * 899) + 2520) * H._jm_psionic_power_modifiers(ctx))) / 2))) }) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 381) + 981) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 899) + 2520) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_MORALE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepathic_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_REMOVE_TELEPATHIC_MORALE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepathic_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_telepathic_morale"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_MORALE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_telepathic_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_TELEPATH_MORALE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_telepathic_morale"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "telepathic_morale") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_morale", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "telepathic_morale_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "telepathic_morale") >= 1) then
            do local _a, _sp = H.u(ctx), "telepathic_morale"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "telepathic_morale_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _g = H.safe_id('morale', "morale_telepathy"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 1) + 10) * H._jm_psionic_power_modifiers(ctx))), math.floor(35), { duration = services.time.duration_from_turns(math.floor(services.random.native_float(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 381) + 981) * H._jm_psionic_power_modifiers(ctx)), (((H.char_spell_level(H.u(ctx), "telepathic_morale") * 899) + 2520) * H._jm_psionic_power_modifiers(ctx))))), decay_start = services.time.duration_from_turns(math.floor((services.random.native_float(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 381) + 981) * H._jm_psionic_power_modifiers(ctx)), (((H.char_spell_level(H.u(ctx), "telepathic_morale") * 899) + 2520) * H._jm_psionic_power_modifiers(ctx))) / 2))) }) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 381) + 981) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) * 899) + 2520) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_TELEPATH_MORALE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_TELEPATH_MESMERIZE_2"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_TELEPATH_MESMERIZE_2"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        if (not (services.random.native_probability((((math.min(((((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0) + (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0)), 30) + (services.random.native_int(0, H.round_half_away(9)) + 1)) + (services.random.native_int(0, H.round_half_away(9)) + 1))), (40)))) then
            H.eoc_add_effect(H.u(ctx), "psi_stunned", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_telepath_mesmerize_tracker", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You mesmerize your target and they stand in a daze.")), "good")
        else
            services.messages.add(ctx:expand_text(services.translate("Your target resists the mesmerism!")), "bad")
        end
        return true
    else
        if (services.random.native_probability((1), (2)) and ((H.u(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MIGO")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))))) then
            H.eoc_add_effect(H.u(ctx), "psi_stunned", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_telepath_mesmerize_tracker", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You mesmerize the alien creature and it stands in a daze.")), "good")
        else
            services.messages.add(ctx:expand_text(services.translate("Your target resists the mesmerism!")), "bad")
        end
        if (services.random.native_probability((19), (20)) and (H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true)))) then
            H.eoc_add_effect(H.u(ctx), "psi_stunned", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_telepath_mesmerize_tracker", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You mesmerize the feral human and they stand in a daze.")), "good")
        else
            services.messages.add(ctx:expand_text(services.translate("Your target resists the mesmerism!")), "bad")
        end
        if ((not ((H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "NETHER")).value == true)))))) then
            H.eoc_add_effect(H.u(ctx), "psi_stunned", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_telepath_mesmerize_tracker", H.var_num(H.u(ctx), "telepath_mesmerism_duration"), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You mesmerize your target and they stand in a daze.")), "good")
        end
        return false
    end
    end
    COND["EOC_TELEPATH_MESMERIZE"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and ((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) >= (H.char_spell_level(H.npc(ctx), "telepathic_mesmerize") + H.char_spell_level(H.npc(ctx), "telepathic_mesmerize_knack")))))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))))) == true
    end
    EOC["EOC_TELEPATH_MESMERIZE"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and ((H.char_spell_level(H.u(ctx), "telepathic_shield") + H.char_spell_level(H.u(ctx), "telepathic_shield_knack")) >= (H.char_spell_level(H.npc(ctx), "telepathic_mesmerize") + H.char_spell_level(H.npc(ctx), "telepathic_mesmerize_knack")))))) and (not ((H.char_has_flag(H.u(ctx), "TEEPSHIELD") and (H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))))) then
        H.set_var("actor", H.u(ctx), ctx, "telepathy_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "telepathy_mesmer_power_level", (H.char_spell_level(H.npc(ctx), "telepathic_mesmerize") + H.char_spell_level(H.npc(ctx), "telepathic_mesmerize_knack")))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_telepathy_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "telepath_mesmerism_duration", services.random.native_float(((((H.var_num(H.u(ctx), "telepathy_mesmer_power_level") * 2) + 8) * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling")), ((((H.var_num(H.u(ctx), "telepathy_mesmer_power_level") * 5) + 20) * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling"))))
        H.run_eoc("EOC_TELEPATH_MESMERIZE_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_MESMERISM_REMOVAL_CHARACTER"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "psi_stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_telepath_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_TELEPATH_MESMERISM_REMOVAL_CHARACTER"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "psi_stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_telepath_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_telepath_mesmerize_tracker"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "psi_stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_MESMERISM_REMOVAL_MONSTER"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "psi_stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_telepath_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_TELEPATH_MESMERISM_REMOVAL_MONSTER"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "psi_stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "effect_telepath_mesmerize_tracker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_telepath_mesmerize_tracker"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "psi_stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_TELEPATH_MORALE_INITIATE_NPC_CHECK"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).npc == true)) == true
    end
    EOC["EOC_TELEPATH_MORALE_INITIATE_NPC_CHECK"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).npc == true)) then
        H.set_var("actor", H.u(ctx), ctx, "telepathy_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "telepathy_power_level", (H.char_spell_level(H.npc(ctx), "telepathic_morale") + H.char_spell_level(H.npc(ctx), "telepathic_morale_knack")))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_telepathy_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "mood_stabilized_power_level", ((H.var_num(H.u(ctx), "telepathy_power_level") * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling")))
        H.run_eoc("EOC_TELEPATH_MORALE_MODIFY_NPC_VALUES", ctx, nil, nil, nil)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "telepathy_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "telepathy_power_level", (H.char_spell_level(H.npc(ctx), "telepathic_morale") + H.char_spell_level(H.npc(ctx), "telepathic_morale_knack")))
        H.set_var("actor", H.u(ctx), ctx, "nether_attunement_telepathy_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
        H.set_var("actor", H.u(ctx), ctx, "mood_stabilized_power_level", ((H.var_num(H.u(ctx), "telepathy_power_level") * H.var_num(H.u(ctx), "telepathy_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_telepathy_scaling")))
        H.run_eoc("EOC_TELEPATH_MORALE_MODIFY_MONSTER_VALUES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_TELEPATH_MORALE_INITIATE"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).avatar == true)) == true
    end
    EOC["EOC_TELEPATH_MORALE_INITIATE"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).avatar == true)) then
        H.run_eoc("EOC_TELEPATH_MORALE_INITIATE_SELF", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_TELEPATH_MORALE_INITIATE_NPC_CHECK", ctx, nil, nil, nil)
        return false
    end
    end
end
