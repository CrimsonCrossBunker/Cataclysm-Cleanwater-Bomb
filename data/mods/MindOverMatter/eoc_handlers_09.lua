local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_PHOTOKIN_BLINDING_GLARE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_BLINDING_GLARE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You begin glowing as brightly as the sun!")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokin_blinding_glare", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_blinding_glare") * 11) + 59) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_blinding_glare") * 47) + 178) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_BLINDING_GLARE_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_BLINDING_GLARE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_BLINDING_GLARE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_BLINDING_GLARE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_BLINDING_GLARE_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_BLINDING_GLARE_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_blinding_glare"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 7)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "photokinetic_blinding_glare"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_blinding_glare") * 11) + 59) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_blinding_glare") * 47) + 178) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_BLINDING_GLARE_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PHOTOKIN_LIGHT_ARMY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_photokin_light_army"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_ARMY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_photokin_light_army"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("A myriad of duplicates of yourself appear nearby!")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_photokin_light_army", -1, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.set_var("context", nil, ctx, "real_count_low", (((H.char_spell_level(H.u(ctx), "photokinetic_light_army") * 0.75) + 2) * H._jm_psionic_power_modifiers(ctx)))
        H.set_var("context", nil, ctx, "real_count_high", (((H.char_spell_level(H.u(ctx), "photokinetic_light_army") * 1.5) + 5) * H._jm_psionic_power_modifiers(ctx)))
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_photokin_army_image") or H.safe_id('monster_group', "mon_photokin_army_image"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(((function() local _a, _b = (ctx:get_number("real_count_low") or 0), (ctx:get_number("real_count_high") or 0); if _a > _b then _a, _b = _b, _a end; return services.random.native_float(_a, _b) end)())), min_radius = math.floor(1), max_radius = math.floor(8), lifespan = services.time.duration_from_turns(math.floor(900)) }); 
        end end
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_photokin_army_image") or H.safe_id('monster_group', "mon_photokin_army_image"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(((function() local _a, _b = ((ctx:get_number("real_count_low") or 0) / 1.5), ((ctx:get_number("real_count_high") or 0) / 1.5); if _a > _b then _a, _b = _b, _a end; return services.random.native_float(_a, _b) end)())), min_radius = math.floor(8), max_radius = math.floor(25), lifespan = services.time.duration_from_turns(math.floor(900)) }); 
        end end
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_photokin_army_image") or H.safe_id('monster_group', "mon_photokin_army_image"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(((function() local _a, _b = ((ctx:get_number("real_count_low") or 0) / 2.5), ((ctx:get_number("real_count_high") or 0) / 2.5); if _a > _b then _a, _b = _b, _a end; return services.random.native_float(_a, _b) end)())), min_radius = math.floor(25), max_radius = math.floor(40), lifespan = services.time.duration_from_turns(math.floor(900)) }); 
        end end
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_ARMY_CONTINUING_CHECK"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_army") * 4.5) + 37.4) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_army") * 11) + 96.5) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_ARMY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PHOTOKIN_REMOVE_LIGHT_ARMY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PHOTOKIN_REMOVE_LIGHT_ARMY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_light_army"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_LIGHT_ARMY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_light_army"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_light_army"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_cast_spell(H.u(ctx), "photokinetic_light_army_remove", false, { message = ctx:expand_text(services.translate("The remaining light duplicates disappear.")) })
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_LIGHT_ARMY_CONTINUING_CHECK"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), { "mon_photokin_army_image" }, 1000, nil) >= 1)) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_ARMY_CONTINUING_CHECK"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), { "mon_photokin_army_image" }, 1000, nil) >= 1)) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_ARMY_CONTINUING_CHECK"), nil) end end
        return true
    else
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_photokin_light_army"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_PHOTOKIN_LIGHT_ARMY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_light_army"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_ARMY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_light_army"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 9)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "photokinetic_light_army"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_army") * 4.5) + 37.4) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "photokinetic_light_army") * 11) + 96.5) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_LIGHT_ARMY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_PHOTOKIN_LIGHT_UP_ENEMY_TARGET"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "photokinesis_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
    H.set_var("actor", H.u(ctx), ctx, "photokinesis_power_level", H.char_spell_level(H.npc(ctx), "photokinetic_light_up_enemy"))
    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_photokinesis_scaling", H.var_num(H.npc(ctx), "nether_attunement_power_scaling"))
    H.eoc_add_effect(H.u(ctx), "effect_photokin_enemy_light", (function() local a, b = math.floor(((((H.var_num(H.u(ctx), "photokinesis_power_level") * 18) + 66) * H.var_num(H.u(ctx), "photokinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_photokinesis_scaling"))), math.floor(((((H.var_num(H.u(ctx), "photokinesis_power_level") * 71) + 184) * H.var_num(H.u(ctx), "photokinesis_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_photokinesis_scaling"))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    return true
    end
    COND["EOC_PHOTOKIN_HIDE_UGLY_REMOVE_GODCO_VARS"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH", "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME", "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT", "THRESH_ELFA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN", "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN" })) == true
    end
    EOC["EOC_PHOTOKIN_HIDE_UGLY_REMOVE_GODCO_VARS"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH", "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME", "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT", "THRESH_ELFA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN", "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN" })) then
        H.set_var("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", nil)
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_HIDE_UGLY_GRANT_GODCO_VARS"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH", "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME", "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT", "THRESH_ELPHA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN", "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN" })) == true
    end
    EOC["EOC_PHOTOKIN_HIDE_UGLY_GRANT_GODCO_VARS"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "THRESH_LIZARD", "THRESH_GASTROPOD", "THRESH_BIRD", "THRESH_FISH", "THRESH_BEAST", "THRESH_FELINE", "THRESH_LUPINE", "THRESH_URSINE", "THRESH_CATTLE", "THRESH_INSECT", "THRESH_PLANT", "THRESH_SLIME", "THRESH_TROGLOBITE", "THRESH_CEPHALOPOD", "THRESH_SPIDER", "THRESH_RAT", "THRESH_ELPHA", "THRESH_CHIMERA", "THRESH_RAPTOR", "THRESH_BATRACHIAN", "THRESH_MOUSE", "THRESH_MARLOSS", "THRESH_MYCUS", "THRESH_CRUSTACEAN" })) then
        H.set_var("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", "yes")
        return true
    end
    return false
    end
    EOC["EOC_PHOTOKIN_CREATE_LIGHT_SWITCH"] = function(ctx)
    do
        local _sw36 = H.char_spell_level(H.u(ctx), "photokinetic_create_light")
        if _sw36 == 0 then
            H.eoc_cast_spell(H.u(ctx), "photokinetic_create_light_01", false, { targeted = true })
        elseif _sw36 == 8 then
            H.eoc_cast_spell(H.u(ctx), "photokinetic_create_light_02", false, { targeted = true })
        elseif _sw36 == 16 then
            H.eoc_cast_spell(H.u(ctx), "photokinetic_create_light_03", false, { targeted = true })
        end
    end
    return true
    end
    EOC["EOC_PHOTOKINETIC_STERILIZE_FOODS_PREP"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "photokinetic_sterilize_item_weight_in_grams", (H.var_num(H.u(ctx), "photokinetic_sterilize_item_weight_in_grams")) + ((H.creature_weight(H.npc(ctx)) / 1000)))
    do local _g = H.safe_id('json_flag', "PHOTOKIN_IRRADIATION_READY"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
    EOC["EOC_PHOTOKINETIC_STERILIZE_FOODS"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "photokinetic_sterilize_item_weight_in_grams", 0)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual_mult", ctx:expand_text(services.translate("What food or drink do you want to sterilize?")), { { category = "food" }, { category = "drink" } }, { "EOC_PHOTOKINETIC_STERILIZE_FOODS_PREP" }, {  })
    H.set_var("actor", H.u(ctx), ctx, "photokinetic_sterilize_item_weight_in_grams", (H.var_num(H.u(ctx), "photokinetic_sterilize_item_weight_in_grams")) / (40))
    H.eoc_add_effect(H.u(ctx), "effect_photokin_sterilization", math.max((H.var_num(H.u(ctx), "photokinetic_sterilize_item_weight_in_grams") + 1), 1), nil, nil, nil)
    do local _g = H.safe_id('activity', "ACT_PSI_PHOTOKIN_RADIATION_STERILIZATION"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(math.max((H.var_num(H.u(ctx), "photokinetic_sterilize_item_weight_in_grams") + 1), 1))))) end end
    H.run_eoc("EOC_PHOTOKIN_RADIATION_STERILIZATION_COST", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_PHOTOKIN_RADIATION_STERILIZATION_COST"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_sterilization"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_RADIATION_STERILIZATION_COST"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_sterilization"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((services.random.native_int(0, H.round_half_away(2)) + 1) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (services.random.native_int(0, H.round_half_away(2)) + 1); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(10), math.floor(15); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PHOTOKIN_RADIATION_STERILIZATION_COST"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_REMOVE_INVISIBILITY_MELEE_CHARACTER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_INVISIBILITY_MELEE_CHARACTER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_photokin_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_REMOVE_INVISIBILITY_MELEE_MONSTER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PHOTOKIN_REMOVE_INVISIBILITY_MELEE_MONSTER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_photokin_invisibility"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_photokin_invisibility"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PHOTOKIN_LIGHT_ARMY_DISAPPEAR_MONSTERS"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_PHOTOKIN_LIGHT_ARMY_DISAPPEAR_MONSTERS"] = function(ctx)
    if (ctx:has_speaker()) then
        if H.u(ctx) then services.characters.die(H.u(ctx), { remove_corpse = true, suppress_message = true }) end
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CALL_FLAME_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PYROKIN_CALL_FLAME_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Flames begin dancing in the air above your hand.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_PYROKIN_CALL_FLAME_GRANT_ITEM", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_pyrokinetic_fire_tool", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames") + H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames_knack")) * 50) + 500) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames") + H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames_knack")) * 160) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CALL_FLAME_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PYRO_REMOVE_FIRE_TOOL", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYROKIN_CALL_FLAME_GRANT_ITEM_3"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARM_TENTACLES_4") == 1)) == true
    end
    EOC["EOC_PYROKIN_CALL_FLAME_GRANT_ITEM_3"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARM_TENTACLES_4") == 1)) then
        H.eoc_spawn_item(H.u(ctx), "pyrokinetic_fire_tool_four_arms", 1, false, true, nil)
        return true
    else
        H.eoc_spawn_item(H.u(ctx), "pyrokinetic_fire_tool", 1, false, true, nil)
        return false
    end
    end
    COND["EOC_PYROKIN_CALL_FLAME_GRANT_ITEM_2"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARACHNID_ARMS_OK") == 1)) == true
    end
    EOC["EOC_PYROKIN_CALL_FLAME_GRANT_ITEM_2"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARACHNID_ARMS_OK") == 1)) then
        H.eoc_spawn_item(H.u(ctx), "pyrokinetic_fire_tool_six_arms", 1, false, true, nil)
        return true
    else
        H.run_eoc("EOC_PYROKIN_CALL_FLAME_GRANT_ITEM_3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYROKIN_CALL_FLAME_GRANT_ITEM"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARM_TENTACLES_8") == 1)) == true
    end
    EOC["EOC_PYROKIN_CALL_FLAME_GRANT_ITEM"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARM_TENTACLES_8") == 1)) then
        H.eoc_spawn_item(H.u(ctx), "pyrokinetic_fire_tool_eight_arms", 1, false, true, nil)
        return true
    else
        H.run_eoc("EOC_PYROKIN_CALL_FLAME_GRANT_ITEM_2", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYRO_REMOVE_FIRE_TOOL"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYRO_REMOVE_FIRE_TOOL"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("The flames over your hand gutter and die out.")), "bad")
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local g = H.safe_id('item', "pyrokinetic_fire_tool"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "pyrokinetic_fire_tool_four_arms"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "pyrokinetic_fire_tool_six_arms"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "pyrokinetic_fire_tool_eight_arms"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CALL_FLAME_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYROKIN_CALL_FLAME_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_fire_tool"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "pyrokinetic_call_flames", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "pyrokinetic_call_flames_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames") >= 1) then
            do local _a, _sp = H.u(ctx), "pyrokinetic_call_flames"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "pyrokinetic_call_flames_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames") + H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames_knack")) * 50) + 500) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames") + H.char_spell_level(H.u(ctx), "pyrokinetic_call_flames_knack")) * 160) + 1800) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CALL_FLAME_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PYROKIN_WARMTH_CLOAK_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PYROKIN_WARMTH_CLOAK_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You heat the nearby air to a comfortable temperature.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_pyrokinetic_cloak", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_cloak") + H.char_spell_level(H.u(ctx), "pyrokinetic_cloak_knack")) * 29) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_cloak") + H.char_spell_level(H.u(ctx), "pyrokinetic_cloak_knack")) * 192) + 1440) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_WARMTH_CLOAK_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PYRO_REMOVE_WARMTH_CLOAK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYRO_REMOVE_WARMTH_CLOAK"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYRO_REMOVE_WARMTH_CLOAK"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_WARMTH_CLOAK_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYROKIN_WARMTH_CLOAK_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "pyrokinetic_cloak") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "pyrokinetic_cloak", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "pyrokinetic_cloak_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "pyrokinetic_cloak") >= 1) then
            do local _a, _sp = H.u(ctx), "pyrokinetic_cloak"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "pyrokinetic_cloak_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_cloak") + H.char_spell_level(H.u(ctx), "pyrokinetic_cloak_knack")) * 29) + 180) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_cloak") + H.char_spell_level(H.u(ctx), "pyrokinetic_cloak_knack")) * 192) + 1440) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_WARMTH_CLOAK_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PYROKIN_TORCH_WELD_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_torch_weld"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PYROKIN_TORCH_WELD_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_torch_weld"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("A searing line of flame springs forth from your finger.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_pyrokinetic_torch_weld", -1, nil, nil, nil)
        H.eoc_spawn_item(H.u(ctx), "pyrokinetic_torch_weld", 1, false, true, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_lance") * 114) + 205) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_lance") * 492) + 2460) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_TORCH_WELD_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PYRO_REMOVE_TORCH_WELD", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYRO_REMOVE_TORCH_WELD"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_torch_weld"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYRO_REMOVE_TORCH_WELD"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_torch_weld"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("The line of fire vanishes in an instant.")), "bad")
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local g = H.safe_id('item', "pyrokinetic_torch_weld"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_pyrokinetic_torch_weld"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_TORCH_WELD_DRAIN"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "pyrokinetic_torch_weld")) == true
    end
    EOC["EOC_PYROKIN_TORCH_WELD_DRAIN"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "pyrokinetic_torch_weld")) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 5)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "pyrokinetic_lance"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_lance") * 114) + 205) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_lance") * 492) + 2460) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_TORCH_WELD_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PYROKIN_BLAZING_AURA_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PYROKIN_BLAZING_AURA_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You set the air around yourself ablaze.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_pyrokinetic_aura", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_aura") + H.char_spell_level(H.u(ctx), "pyrokinetic_aura_knack")) * 7) + 45) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_aura") + H.char_spell_level(H.u(ctx), "pyrokinetic_aura_knack")) * 19) + 180) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_BLAZING_AURA_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PYROKIN_REMOVE_BLAZING_AURA", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYROKIN_REMOVE_BLAZING_AURA"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYROKIN_REMOVE_BLAZING_AURA"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_BLAZING_AURA_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYROKIN_BLAZING_AURA_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_aura"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        if (H.char_spell_level(H.u(ctx), "pyrokinetic_aura") >= 1) then
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "pyrokinetic_aura", false))
        else
            H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "pyrokinetic_aura_knack", false))
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        if (H.char_spell_level(H.u(ctx), "pyrokinetic_aura") >= 1) then
            do local _a, _sp = H.u(ctx), "pyrokinetic_aura"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        else
            do local _a, _sp = H.u(ctx), "pyrokinetic_aura_knack"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        end
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_aura") + H.char_spell_level(H.u(ctx), "pyrokinetic_aura_knack")) * 7) + 45) * H._jm_psionic_power_modifiers(ctx))), math.floor(((((H.char_spell_level(H.u(ctx), "pyrokinetic_aura") + H.char_spell_level(H.u(ctx), "pyrokinetic_aura_knack")) * 19) + 180) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_BLAZING_AURA_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_PYROKIN_FLAME_IMMUNITY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PYROKIN_FLAME_IMMUNITY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The nearby air loses any heat.")), "good")
        H.run_eoc("EOC_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_pyrokinetic_flame_immunity", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_flame_immunity") * 11) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_flame_immunity") * 47) + 570) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_FLAME_IMMUNITY_DRAIN"), nil) end end
        return true
    else
        H.run_eoc("EOC_PYROKIN_REMOVE_FLAME_IMMUNITY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PYROKIN_REMOVE_FLAME_IMMUNITY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYROKIN_REMOVE_FLAME_IMMUNITY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_FLAME_IMMUNITY_DRAIN"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PYROKIN_FLAME_IMMUNITY_DRAIN"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_pyrokinetic_flame_immunity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", 7)
        H.run_eoc("EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_2", ctx, nil, nil, nil)
        H.run_eoc("EOC_PSI_MAINTENANCE_CALORIE_COST_CALCULATOR", ctx, nil, nil, nil)
        do local _a, _sp = H.u(ctx), "pyrokinetic_flame_immunity"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_flame_immunity") * 11) + 90) * H._jm_psionic_power_modifiers(ctx))), math.floor((((H.char_spell_level(H.u(ctx), "pyrokinetic_flame_immunity") * 47) + 570) * H._jm_psionic_power_modifiers(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_FLAME_IMMUNITY_DRAIN"), nil) end end
        return true
    else
        return false
    end
    end
    EOC["EOC_PYROKIN_INTENSIFY_FLAMES"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Choose target.")), "neutral")
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "pyrokin_intensify_flames_target"); local fg = H.safe_id('field', "fd_fire"); return p ~= nil and fg ~= nil and services.gameplay.environment.field_exists(p, fg, true) end)()) then
        do local _p, _g = H.get_tripoint_var("context", nil, ctx, "pyrokin_intensify_flames_target"), H.safe_id('field', "fd_fire"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(0), intensity = math.floor(1) }) end end
    end
    H.eoc_cast_spell(H.u(ctx), "pyrokinetic_intensify_flames_target_creature", false, { target = H.get_tripoint_var("context", nil, ctx, "pyrokin_intensify_flames_target") })
    return true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_PYROKIN_CAUTERIZE_LEFT_ARM"] == nil or E.cond["EOC_PYROKIN_CAUTERIZE_LEFT_ARM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Left Arm")), description = ctx:expand_text(services.translate("Cauterize wounds on the left arm.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_PYROKIN_CAUTERIZE_LEFT_ARM" end end
        do local _en = (E.cond["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM"] == nil or E.cond["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Right Arm")), description = ctx:expand_text(services.translate("Cauterize wounds on the right arm.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_PYROKIN_CAUTERIZE_RIGHT_ARM" end end
        do local _en = (E.cond["EOC_PYROKIN_CAUTERIZE_HEAD"] == nil or E.cond["EOC_PYROKIN_CAUTERIZE_HEAD"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Head")), description = ctx:expand_text(services.translate("Cauterize wounds on the head.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_PYROKIN_CAUTERIZE_HEAD" end end
        do local _en = (E.cond["EOC_PYROKIN_CAUTERIZE_LEFT_LEG"] == nil or E.cond["EOC_PYROKIN_CAUTERIZE_LEFT_LEG"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Left Leg")), description = ctx:expand_text(services.translate("Cauterize wounds on the left leg.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_PYROKIN_CAUTERIZE_LEFT_LEG" end end
        do local _en = (E.cond["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG"] == nil or E.cond["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Right Leg")), description = ctx:expand_text(services.translate("Cauterize wounds on the right leg.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_PYROKIN_CAUTERIZE_RIGHT_LEG" end end
        do local _en = (E.cond["EOC_PYROKIN_CAUTERIZE_BODY"] == nil or E.cond["EOC_PYROKIN_CAUTERIZE_BODY"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Torso")), description = ctx:expand_text(services.translate("Cauterize wounds on the torso.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_PYROKIN_CAUTERIZE_BODY" end end
        do local _en = (E.cond["EOC_MOM_NO_EFFECT"] == nil or E.cond["EOC_MOM_NO_EFFECT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Nevermind.")), description = ctx:expand_text(services.translate("Do nothing for now.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "EOC_MOM_NO_EFFECT" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_ARM_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_ARM_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) then
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, and when you look at the wound, The bleeding has stopped.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "arm_l", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "arm_l") + 1), nil)
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "arm_l", 1, "-=")
        local _a37 = H.u(ctx)
        if _a37 then services.characters.adjust(_a37, { pain = math.floor(services.random.native_float(1, 2)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, but when you look at the wound, you're still bleeding.  You'll have to try again.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "arm_l", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "arm_l") + 1), nil)
        H.set_char_hp(H.u(ctx), "arm_l", 3, "-=")
        local _a38 = H.u(ctx)
        if _a38 then services.characters.adjust(_a38, { pain = math.floor(services.random.native_float(1, 3)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_ARM"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") <= 29)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_ARM"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") <= 29)) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_LEFT_ARM_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The bleeding is too much for you to stop with your powers.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) then
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, and when you look at the wound, The bleeding has stopped.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "arm_r", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "arm_r") + 1), nil)
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "arm_r", 1, "-=")
        local _a39 = H.u(ctx)
        if _a39 then services.characters.adjust(_a39, { pain = math.floor(services.random.native_float(1, 2)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, but when you look at the wound, you're still bleeding.  You'll have to try again.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "arm_r", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "arm_r") + 1), nil)
        H.set_char_hp(H.u(ctx), "arm_r", 3, "-=")
        local _a40 = H.u(ctx)
        if _a40 then services.characters.adjust(_a40, { pain = math.floor(services.random.native_float(1, 3)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") <= 29)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") <= 29)) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The bleeding is too much for you to stop with your powers.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_HEAD_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_HEAD_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) then
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, and when you look at the wound, The bleeding has stopped.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "head", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "head") + 1), nil)
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("head" ~= nil) and H.safe_id('body_part', "head") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "head", 1, "-=")
        local _a41 = H.u(ctx)
        if _a41 then services.characters.adjust(_a41, { pain = math.floor(services.random.native_float(1, 4)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, but when you look at the wound, you're still bleeding.  You'll have to try again.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "head", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "head") + 1), nil)
        H.set_char_hp(H.u(ctx), "head", 3, "-=")
        local _a42 = H.u(ctx)
        if _a42 then services.characters.adjust(_a42, { pain = math.floor(services.random.native_float(2, 6)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_HEAD"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "bleed", "head") <= 29)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_HEAD"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "bleed", "head") <= 29)) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_HEAD_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The bleeding is too much for you to stop with your powers.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_LEG_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_LEG_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) then
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, and when you look at the wound, The bleeding has stopped.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "leg_l", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "leg_r") + 1), nil)
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("leg_l" ~= nil) and H.safe_id('body_part', "leg_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "leg_l", 1, "-=")
        local _a43 = H.u(ctx)
        if _a43 then services.characters.adjust(_a43, { pain = math.floor(services.random.native_float(1, 2)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, but when you look at the wound, you're still bleeding.  You'll have to try again.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "leg_l", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "leg_l") + 1), nil)
        H.set_char_hp(H.u(ctx), "leg_l", 3, "-=")
        local _a44 = H.u(ctx)
        if _a44 then services.characters.adjust(_a44, { pain = math.floor(services.random.native_float(1, 3)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_LEG"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") <= 29)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_LEG"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") <= 29)) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_LEFT_LEG_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The bleeding is too much for you to stop with your powers.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) then
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, and when you look at the wound, The bleeding has stopped.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "leg_r", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "leg_r") + 1), nil)
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("leg_r" ~= nil) and H.safe_id('body_part', "leg_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "leg_r", 1, "-=")
        local _a45 = H.u(ctx)
        if _a45 then services.characters.adjust(_a45, { pain = math.floor(services.random.native_float(1, 2)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, but when you look at the wound, you're still bleeding.  You'll have to try again.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "leg_r", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "leg_r") + 1), nil)
        H.set_char_hp(H.u(ctx), "leg_r", 3, "-=")
        local _a46 = H.u(ctx)
        if _a46 then services.characters.adjust(_a46, { pain = math.floor(services.random.native_float(1, 3)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") <= 29)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") <= 29)) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The bleeding is too much for you to stop with your powers.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_BODY_2"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_BODY_2"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_MED") == 1) or (services.proficiencies.has_id_text(H.u(ctx), "prof_burn_care").value == true) or ((services.random.native_int(1, math.floor(10)) + (H.char_skill(H.u(ctx), "firstaid"))) > (7)))) then
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, and when you look at the wound, The bleeding has stopped.")), "good")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "torso", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "torso") + 1), nil)
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("torso" ~= nil) and H.safe_id('body_part', "torso") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.set_char_hp(H.u(ctx), "torso", 1, "-=")
        local _a47 = H.u(ctx)
        if _a47 then services.characters.adjust(_a47, { pain = math.floor(services.random.native_float(1, 3)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("There is a moment of searing pain, but when you look at the wound, you're still bleeding.  You'll have to try again.")), "bad")
        H.eoc_add_effect(H.u(ctx), "effect_psi_post_cauterize", (services.random.native_int(0, H.round_half_away(10800)) + 3600), "torso", (H.creature_effect_intensity(H.u(ctx), "effect_psi_post_cauterize", "torso") + 1), nil)
        H.set_char_hp(H.u(ctx), "torso", 3, "-=")
        local _a48 = H.u(ctx)
        if _a48 then services.characters.adjust(_a48, { pain = math.floor(services.random.native_float(1, 3)) }) end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(21600), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK"), nil) end end
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_BODY"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "bleed", "torso") <= 29)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_BODY"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "bleed", "torso") <= 29)) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_BODY_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The bleeding is too much for you to stop with your powers.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK_2"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "infected", "arm_l") >= 1)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK_2"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "infected", "arm_l") >= 1)) then
        H.eoc_add_effect(H.u(ctx), "infected", -1, "arm_l", (H.creature_effect_intensity(H.u(ctx), "infected", "arm_l") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("The infection on your left arm is getting worse.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "infected", -1, "arm_l", 1, nil)
        services.messages.add(ctx:expand_text(services.translate("The wound on your left arm you tried to cauterize is starting to itch and swell.  It's probably infected.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (15))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (15))) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_LEFT_ARM_INFECTION_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK_2"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "infected", "arm_r") >= 1)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK_2"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "infected", "arm_r") >= 1)) then
        H.eoc_add_effect(H.u(ctx), "infected", -1, "arm_r", (H.creature_effect_intensity(H.u(ctx), "infected", "arm_r") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("The infection on your right arm is getting worse.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "infected", -1, "arm_r", 1, nil)
        services.messages.add(ctx:expand_text(services.translate("The wound on your right arm you tried to cauterize is starting to itch and swell.  It's probably infected.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (15))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (15))) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_RIGHT_ARM_INFECTION_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK_CHECK_2"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "infected", "head") >= 1)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK_CHECK_2"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "infected", "head") >= 1)) then
        H.eoc_add_effect(H.u(ctx), "infected", -1, "head", (H.creature_effect_intensity(H.u(ctx), "infected", "head") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("The infection on your head is getting worse.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "infected", -1, "head", 1, nil)
        services.messages.add(ctx:expand_text(services.translate("The wound on your head you tried to cauterize is starting to itch and swell.  It's probably infected.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (15))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (15))) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_HEAD_INFECTION_CHECK_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK_2"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "infected", "leg_l") >= 1)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK_2"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "infected", "leg_l") >= 1)) then
        H.eoc_add_effect(H.u(ctx), "infected", -1, "leg_l", (H.creature_effect_intensity(H.u(ctx), "infected", "leg_l") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("The infection on your left leg is getting worse.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "infected", -1, "leg_l", 1, nil)
        services.messages.add(ctx:expand_text(services.translate("The wound on your left leg you tried to cauterize is starting to itch and swell.  It's probably infected.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (15))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (15))) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_LEFT_LEG_INFECTION_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK_2"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "infected", "leg_r") >= 1)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK_2"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "infected", "leg_r") >= 1)) then
        H.eoc_add_effect(H.u(ctx), "infected", -1, "leg_r", (H.creature_effect_intensity(H.u(ctx), "infected", "leg_r") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("The infection on your right leg is getting worse.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "infected", -1, "leg_r", 1, nil)
        services.messages.add(ctx:expand_text(services.translate("The wound on your right leg you tried to cauterize is starting to itch and swell.  It's probably infected.")), "bad")
        return false
    end
    end
    COND["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (15))) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (15))) then
        H.run_eoc("EOC_PYROKIN_CAUTERIZE_RIGHT_LEG_INFECTION_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK_2"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "infected", "torso") >= 1)) == true
    end
    EOC["EOC_PYROKIN_CAUTERIZE_TORSO_INFECTION_CHECK_2"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "infected", "torso") >= 1)) then
        H.eoc_add_effect(H.u(ctx), "infected", -1, "torso", (H.creature_effect_intensity(H.u(ctx), "infected", "torso") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("The infection on your torso is getting worse.")), "bad")
        return true
    else
        H.eoc_add_effect(H.u(ctx), "infected", -1, "torso", 1, nil)
        services.messages.add(ctx:expand_text(services.translate("The wound on your torso you tried to cauterize is starting to itch and swell.  It's probably infected.")), "bad")
        return false
    end
    end
end
