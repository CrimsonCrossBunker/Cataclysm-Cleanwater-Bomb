local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["ISO_REGEN_CLOCK"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, 10, nil) == 0)) == true
    end
    EOC["ISO_REGEN_CLOCK"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, 10, nil) == 0)) then
        H.set_char_hp(H.u(ctx), "torso", 2, "+=")
        H.set_char_hp(H.u(ctx), "head", 2, "+=")
        H.set_char_hp(H.u(ctx), "arm_l", 2, "+=")
        H.set_char_hp(H.u(ctx), "arm_r", 2, "+=")
        H.set_char_hp(H.u(ctx), "leg_l", 2, "+=")
        H.set_char_hp(H.u(ctx), "leg_r", 2, "+=")
        local _a1 = H.u(ctx)
        if _a1 then services.characters.adjust(_a1, { pain = math.floor(-(4)) }) end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        if (H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1) then
            local _a2 = H.u(ctx)
            if _a2 then services.spells.set_mana_raw(_a2, math.floor((H.char_mana(_a2, "current")) + (25))) end
        end
        return true
    end
    return false
    end
    COND["ISO_PAIN_CEILING"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) > 40)) == true
    end
    EOC["ISO_PAIN_CEILING"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) > 40)) then
        local _a3 = H.u(ctx)
        if _a3 then services.characters.adjust(_a3, { pain = math.floor((40) - (H.char_pain(_a3))) }) end
        return true
    end
    return false
    end
    COND["EOC_on_kill_balthazar_aid"] = function(ctx)
        return ((H.char_val_extra(H.npc(ctx), "difficulty") >= 30)) == true
    end
    EOC["EOC_on_kill_balthazar_aid"] = function(ctx)
    if ((H.char_val_extra(H.npc(ctx), "difficulty") >= 30)) then
        H.set_var("global", nil, ctx, "iso_balthazar_aid_value", H._jm_iso_balthazar_aid(ctx, 1))
        return true
    end
    return false
    end
    EOC["EOC_start_bcontrol"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<BALTHAZAR_CONTROL_PLAYER>")), "neutral")
    H.set_var("global", nil, ctx, "iso_balthazar_aid_value", (H.global_var_num("iso_balthazar_aid_value")) - (12))
    H.set_var("global", nil, ctx, "balthazar_control", 1)
    do local _t = math.max(1, math.floor(120)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_end_bcontrol"), nil) end end
    return true
    end
    EOC["EOC_end_bcontrol"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<BALTHAZAR_CONTROL_TERMINATED>")), "neutral")
    H.set_var("global", nil, ctx, "balthazar_control", 0)
    return true
    end
    EOC["EOC_start_shield"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<BALTHAZAR_SHIELD>")), "neutral")
    H.set_var("global", nil, ctx, "iso_balthazar_aid_value", (H.global_var_num("iso_balthazar_aid_value")) - (20))
    H.eoc_cast_spell(H.u(ctx), "spawn_blackfire_shield", false, { hit_self = true })
    return true
    end
    EOC["EOC_start_blackfire"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<BALTHAZAR_COMBAT_STARTED>")), "neutral")
    H.set_var("global", nil, ctx, "iso_balthazar_aid_value", (H.global_var_num("iso_balthazar_aid_value")) - (25))
    if (H.global_var_num("bossfight_active") == 1) then
        services.messages.add(ctx:expand_text(services.translate("<BALTHAZAR_COMBAT_TARGET_BOSS>")), "neutral")
        do local _t = math.max(1, math.floor(120)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_blackfire_execute"), nil) end end
    else
        do local _t = math.max(1, math.floor(2)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_blackfire_execute"), nil) end end
    end
    return true
    end
    EOC["EOC_blackfire_execute"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("<BALTHAZAR_BLACKFIRE_COMPLETED>")))
    H.eoc_cast_spell(H.u(ctx), "iso_blackfire_blast", false, { hit_self = true, min_level = math.floor(2) })
    return true
    end
    COND["EOC_balthazar_prevent_death"] = function(ctx)
        return ((H.global_var_num("iso_balthazar_aid_value") > 30)) == true
    end
    EOC["EOC_balthazar_prevent_death"] = function(ctx)
    if ((H.global_var_num("iso_balthazar_aid_value") > 30)) then
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        H.set_char_hp(H.u(ctx), "ALL", 999, "=")
        H.run_eoc("EOC_healextras", ctx, nil, nil, nil)
        H.set_var("global", nil, ctx, "iso_balthazar_aid_value", (H.global_var_num("iso_balthazar_aid_value")) - (30))
        H.eoc_cast_spell(H.u(ctx), "iso_blackfire_blast", false, { hit_self = true, min_level = math.floor(1) })
        services.messages.add(ctx:expand_text(services.translate("You convulse violently as Balthazar tears you from the jaws of death.")), "neutral")
        ccb.presentation.notice(ctx:expand_text(services.translate("<BALTHAZAR_REVIVE_PLAYER>")))
        return true
    end
    return false
    end
    EOC["EOC_healextras"] = function(ctx)
    do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(math.max((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0), 9000) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = math.max((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0), 9000); local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    H.set_char_val_extra(H.u(ctx), "thirst", math.min((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0), 800), "=")
    do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "bad_food"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "instability"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    local _a4 = H.u(ctx)
    if _a4 then services.characters.adjust(_a4, { pain = math.floor((0) - (H.char_pain(_a4))) }) end
    H.set_char_val_extra(H.u(ctx), "rad", 0, "=")
    H.set_char_val_extra(H.u(ctx), "pkill", 0, "=")
    H.eoc_add_effect(H.u(ctx), "panacea", 30, nil, 1, nil)
    do local _eg = H.safe_id('effect', "corroding"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "onfire"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "formication"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "blisters"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "frostbite"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "frostbite_recovery"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "wet"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "slimed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "migo_atmosphere"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "fetid_goop"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "sap"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "nausea"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "fungus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "dermatik"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "bloodworms"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "paincysts"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "brainworms"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "tapeworm"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "poison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_dmg"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "venom_weaken"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "stung"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "badpoison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "foodpoison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "paralyzepoison"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "tetanus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "rat_bite_fever"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "infected"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "asthma"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "common_cold"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "flu"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pre_flu"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "pre_common_cold"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "VITRIFYING"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    services.time.reschedule("vitrified_farm_escape_key", services.time.duration_from_turns(0))
    H.run_eoc("EOC_FIX_MAGICLYSM_PROBLEMS", ctx, nil, nil, nil)
    H.run_eoc("EOC_FIX_MIND_OVER_MATTER_PROBLEMS", ctx, nil, nil, nil)
    H.run_eoc("EOC_FIX_XEDRA_EVOLVED_PROBLEMS", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_FIX_MAGICLYSM_PROBLEMS"] = function(ctx)
    return true
    end
    EOC["EOC_FIX_MIND_OVER_MATTER_PROBLEMS"] = function(ctx)
    return true
    end
    EOC["EOC_FIX_XEDRA_EVOLVED_PROBLEMS"] = function(ctx)
    return true
    end
    COND["ISO_DANGER_CLOCK"] = function(ctx)
        return ((not ((H.char_at_om_location(H.u(ctx), "iso_hallway_safe") or H.char_at_om_location(H.u(ctx), "iso_elevator_safe") or (H.var_num(H.u(ctx), "bossfight_complete") == 1))))) == true
    end
    EOC["ISO_DANGER_CLOCK"] = function(ctx)
    if ((not ((H.char_at_om_location(H.u(ctx), "iso_hallway_safe") or H.char_at_om_location(H.u(ctx), "iso_elevator_safe") or (H.var_num(H.u(ctx), "bossfight_complete") == 1))))) then
        H.set_var("actor", H.u(ctx), ctx, "ISO_CURRENT_LEVEL_DANGER", (H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER")) + (1))
        H.set_var("actor", H.u(ctx), ctx, "ISO_DANGER", (H.var_num(H.u(ctx), "ISO_DANGER")) + (1))
        return true
    end
    return false
    end
    COND["ISO_CURRENT_LEVEL_DANGER_low"] = function(ctx)
        return ((H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER") >= 15)) == true
    end
    EOC["ISO_CURRENT_LEVEL_DANGER_low"] = function(ctx)
    if ((H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER") >= 15)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_shadow") or H.safe_id('monster_group', "mon_shadow"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(10), min_radius = math.floor(20), max_radius = math.floor(40) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("The lab grows unnaturally dark.")), 'warning') end
        end end
        return true
    end
    return false
    end
    COND["ISO_CURRENT_LEVEL_DANGER_medium"] = function(ctx)
        return ((H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER") >= 20)) == true
    end
    EOC["ISO_CURRENT_LEVEL_DANGER_medium"] = function(ctx)
    if ((H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER") >= 20)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_darkman") or H.safe_id('monster_group', "mon_darkman"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(3), min_radius = math.floor(20), max_radius = math.floor(40) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("The room's shadows merge into menacing shapes.")), 'warning') end
        end end
        return true
    else
        H.run_eoc("ISO_CURRENT_LEVEL_DANGER_low", ctx, nil, nil, nil)
        return false
    end
    end
    COND["ISO_DANGER_LEVEL_SPAWNER"] = function(ctx)
        return ((H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER") >= 25)) == true
    end
    EOC["ISO_DANGER_LEVEL_SPAWNER"] = function(ctx)
    if ((H.var_num(H.u(ctx), "ISO_CURRENT_LEVEL_DANGER") >= 25)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_tindalos") or H.safe_id('monster_group', "mon_tindalos"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(2), min_radius = math.floor(20), max_radius = math.floor(40) }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Hungry shadows peer at you from the darkness.")), 'warning') end
        end end
        return true
    else
        H.run_eoc("ISO_CURRENT_LEVEL_DANGER_medium", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_ISO_RECORD_MANA_FOR_LAST_SCION"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) == true
    end
    EOC["EOC_ISO_RECORD_MANA_FOR_LAST_SCION"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "last_scion_mana", H.char_mana(H.u(ctx), "current"))
        H.set_var("actor", H.u(ctx), ctx, "last_scion_max_mana", H.char_mana(H.u(ctx), "maximum"))
        H.set_var("actor", H.u(ctx), ctx, "last_scion_max_percent", ((function() local m, mx = H.char_mana(H.u(ctx), 'current'), H.char_mana(H.u(ctx), 'maximum'); if mx == 0 then return 0 end; return m * 100.0 / mx end)()))
        return true
    end
    return false
    end
    COND["EOC_ISO_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) == true
    end
    EOC["EOC_ISO_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_r" ~= nil) and H.safe_id('body_part', "arm_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("arm_l" ~= nil) and H.safe_id('body_part', "arm_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) then
        H.set_spell_adj(H.u(ctx), "difficulty", "iso_eldritch_sorcery", "", "", ((H.creature_effect_intensity(H.u(ctx), "grabbed", "arm_l") + H.creature_effect_intensity(H.u(ctx), "grabbed", "arm_r")) / 10), "=")
        return true
    end
    return false
    end
    COND["EOC_ISO_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_r" ~= nil) and H.safe_id('body_part', "hand_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_l" ~= nil) and H.safe_id('body_part', "hand_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) == true
    end
    EOC["EOC_ISO_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_r" ~= nil) and H.safe_id('body_part', "hand_r") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "grabbed"); local bpg = ("hand_l" ~= nil) and H.safe_id('body_part', "hand_l") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (not (H.char_has_flag(H.u(ctx), "SUBTLE_SPELL"))))) then
        H.set_spell_adj(H.u(ctx), "difficulty", "iso_eldritch_sorcery", "", "", ((H.creature_effect_intensity(H.u(ctx), "grabbed", "hand_l") + H.creature_effect_intensity(H.u(ctx), "grabbed", "hand_r")) / 5), "=")
        return true
    end
    return false
    end
    COND["EOC_ISO_NOT_WIELDING_STAFF_MAKES_SORCERY_HARDER"] = function(ctx)
        return ((not (((function() local fg = H.safe_id('json_flag', "MAGIC_FOCUS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())))) == true
    end
    EOC["EOC_ISO_NOT_WIELDING_STAFF_MAKES_SORCERY_HARDER"] = function(ctx)
    if ((not (((function() local fg = H.safe_id('json_flag', "MAGIC_FOCUS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())))) then
        H.set_spell_adj(H.u(ctx), "cost", "iso_eldritch_sorcery", "", "", 0.5, "=")
        H.set_spell_adj(H.u(ctx), "casting_time", "iso_eldritch_sorcery", "", "", 1, "=")
        return true
    end
    return false
    end
    COND["EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) == true
    end
    EOC["EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) then
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_stun_blind_deaf") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_stun_blind_deaf_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_stun_blind_deaf"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_summon_hindering_darkness") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_summon_hindering_darkness_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_summon_hindering_darkness"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_blink") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_blink_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_blink"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_damage_shield") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_damage_shield_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_damage_shield"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_line_biting_acid") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_line_biting_acid_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_line_biting_acid"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_cone_lightning") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_cone_lightning_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_cone_lightning"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_cold_damage_over_time") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_cold_damage_over_time_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_cold_damage_over_time"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_cold_damage_blast") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_cold_damage_blast_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_cold_damage_blast"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_summon_shadows") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_summon_shadows_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_summon_shadows"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_invisibile_and_intangible") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_invisibile_and_intangible_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_invisibile_and_intangible"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_cure_poison_disease_gas") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_cure_poison_disease_gas_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_cure_poison_disease_gas"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_polymorph") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_polymorph_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_polymorph"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_destroy_nether") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_destroy_nether_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_destroy_nether"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_imprisonment") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_imprisonment_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_imprisonment"))
        end
        if (H.char_spell_level(H.u(ctx), "iso_eldritch_mass_aoe_zombie_destruction") > 0) then
            H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_mass_aoe_zombie_destruction_stored_level", H.char_spell_level(H.u(ctx), "iso_eldritch_mass_aoe_zombie_destruction"))
        end
        return true
    end
    return false
    end
    COND["EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) == true
    end
    EOC["EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) then
        H.run_eoc("EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_ISO_LAST_SCION_DESTROY_GUN_WHEN_PICK_UP_GUN"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    COND["EOC_ISO_LAST_SCION_SPELL_GAINING_WHEN_PICK_UP_GUN_REMOVE_GUN"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) == true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_WHEN_PICK_UP_GUN_REMOVE_GUN"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true } }, { "EOC_ISO_LAST_SCION_DESTROY_GUN_WHEN_PICK_UP_GUN" }, {  })
        return true
    end
    return false
    end
    COND["EOC_ISO_LAST_SCION_SPELL_GAINING_WHEN_PICK_UP_GUN"] = function(ctx)
        return (((((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "shotgun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "launcher"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "gun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)())) and (H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1))) == true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_WHEN_PICK_UP_GUN"] = function(ctx)
    if (((((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "shotgun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "launcher"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) or ((function() local sg = H.safe_id('skill', "gun"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)())) and (H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1))) then
        if ((function() local ag = H.safe_id('ammunition', "9mm"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
            if (((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_stun_blind_deaf") == (-1))) then
                H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_stun_blind_deaf")
                H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Inescapable Tesseract of Thought")
                H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_stun_blind_deaf_stored_level"))
                H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
            end
            if (((function() local sg = H.safe_id('skill', "smg"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_summon_hindering_darkness") == (-1))) then
                H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_summon_hindering_darkness")
                H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Crawling Tendrils of Utternight")
                H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_summon_hindering_darkness_stored_level"))
                H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
            end
            if (((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_stun_blind_deaf") == (-1))) then
                H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_stun_blind_deaf")
                H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Inescapable Tesseract of Thought")
                H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_stun_blind_deaf_stored_level"))
                H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
            end
        end
        if ((function() local ag = H.safe_id('ammunition', "22"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
            if (((function() local sg = H.safe_id('skill', "pistol"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_blink") == (-1))) then
                H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_blink")
                H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Transportations of Immenar")
                H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_blink_stored_level"))
                H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
            end
            if (((function() local sg = H.safe_id('skill', "rifle"); return H.u(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.u(ctx), sg).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_damage_shield") == (-1))) then
                H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_damage_shield")
                H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Impenetrable Coruscating Scales of Vishkan")
                H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_damage_shield_stored_level"))
                H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
            end
        end
        if (((function() local ag = H.safe_id('ammunition', "223"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_line_biting_acid") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_line_biting_acid")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Thousandfold Maws of the Black Goat")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_line_biting_acid_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if (((function() local ag = H.safe_id('ammunition', "45"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_cone_lightning") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_cone_lightning")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Stormtenders' Fulminating Fury")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_cone_lightning_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if (((function() local ag = H.safe_id('ammunition', "380"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_cold_damage_over_time") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_cold_damage_over_time")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Ebon Bands of Ynthyr")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_cold_damage_over_time_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if ((function() local ag = H.safe_id('ammunition', "40"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if (((function() local ag = H.safe_id('ammunition', "762"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_cold_damage_blast") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_cold_damage_blast")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Frozen Heart of R'shothai")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_cold_damage_blast_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if ((function() local ag = H.safe_id('ammunition', "357mag"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "shot"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if (((function() local ag = H.safe_id('ammunition', "308"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_invisibile_and_intangible") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_invisibile_and_intangible")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Umbral Transfiguration")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_invisibile_and_intangible_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if ((function() local ag = H.safe_id('ammunition', "38"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if (((function() local ag = H.safe_id('ammunition', "44"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_cure_poison_disease_gas") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_cure_poison_disease_gas")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "To Walk Amidst the Fens")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_cure_poison_disease_gas_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if (((function() local ag = H.safe_id('ammunition', "3006"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_polymorph") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_polymorph")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Tsath's Horrific Metamorphosis")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_polymorph_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if (((function() local ag = H.safe_id('ammunition', "45colt"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_destroy_nether") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_destroy_nether")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "Thricefold Abjuration of the Outside")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_destroy_nether_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if (((function() local ag = H.safe_id('ammunition', "762R"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_imprisonment") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_imprisonment")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Adamantine Gaol of Emthys")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_imprisonment_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if ((function() local ag = H.safe_id('ammunition', "10mm"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if (((function() local ag = H.safe_id('ammunition', "270win"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_summon_shadows") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_summon_shadows")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Adamantine Gaol of Emthys")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_summon_shadows_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        if ((function() local ag = H.safe_id('ammunition', "410shot"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "123ln"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "300"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "303"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "30carbine"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "32"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "338lapua"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "357sig"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if ((function() local ag = H.safe_id('ammunition', "50"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) then
        end
        if (((function() local ag = H.safe_id('ammunition', "40x46mm"); return H.u(ctx) ~= nil and ag ~= nil and services.inventory.wielded_matches(H.u(ctx), ag).value == true end)()) and (H.char_spell_level(H.u(ctx), "iso_eldritch_mass_aoe_zombie_destruction") == (-1))) then
            H.set_var("global", nil, ctx, "new_last_scion_spell_id", "iso_eldritch_mass_aoe_zombie_destruction")
            H.set_var("global", nil, ctx, "new_last_scion_spell_name", "The Most Excellent Obliteration of Blasphemies")
            H.set_var("global", nil, ctx, "new_last_scion_spell_level", H.var_num(H.u(ctx), "iso_eldritch_mass_aoe_zombie_destruction_stored_level"))
            H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT", ctx, nil, nil, nil)
        end
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ISO_LAST_SCION_SPELL_GAINING_WHEN_PICK_UP_GUN_REMOVE_GUN"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_1"] == nil or E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_1"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Add <global_val:new_last_scion_spell_name> to Slot 1: <u_val:last_scion_spell_name_slot_one>")), description = nil, enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_1" end end
        do local _en = (E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_2"] == nil or E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_2"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Add <global_val:new_last_scion_spell_name> to Slot 2: <u_val:last_scion_spell_name_slot_two>")), description = nil, enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_2" end end
        do local _en = (E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_3"] == nil or E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_3"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Add <global_val:new_last_scion_spell_name> to Slot 3: <u_val:last_scion_spell_name_slot_three>")), description = nil, enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_3" end end
        do local _en = (E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_4"] == nil or E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_4"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Add <global_val:new_last_scion_spell_name> to Slot 4: <u_val:last_scion_spell_name_slot_four>")), description = nil, enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_4" end end
        do local _en = (E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_5"] == nil or E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_5"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Add <global_val:new_last_scion_spell_name> to Slot 5: <u_val:last_scion_spell_name_slot_five>")), description = nil, enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_5" end end
        do local _en = (E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_6"] == nil or E.cond["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_6"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Add <global_val:new_last_scion_spell_name> to Slot 6: <u_val:last_scion_spell_name_slot_six>")), description = nil, enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_6" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_1"] = function(ctx)
    H.copy_var("global", nil, "new_last_scion_spell_name", "actor", H.u(ctx), "last_scion_spell_name_slot_one", ctx)
    services.messages.add(ctx:expand_text(services.translate("Spell name for slot 1 is <u_val:last_scion_spell_name_slot_one>")), "debug")
    local _a5 = H.u(ctx)
    local _sn6 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_one", "")
    local _sg7 = (_sn6 ~= "") and H.safe_id("spell", _sn6) or nil
    if _a5 and _sg7 then services.spells.set_level(_a5, _sg7, math.floor((-1))) end
    H.copy_var("global", nil, "new_last_scion_spell_id", "actor", H.u(ctx), "last_scion_spell_id_slot_one", ctx)
    services.messages.add(ctx:expand_text(services.translate("Spell id for slot 1 is <u_val:last_scion_spell_id_slot_one>")), "debug")
    local _a8 = H.u(ctx)
    local _sn9 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_one", "")
    local _sg10 = (_sn9 ~= "") and H.safe_id("spell", _sn9) or nil
    if _a8 and _sg10 then services.spells.set_level(_a8, _sg10, math.floor(H.global_var_num("new_last_scion_spell_level"))) end
    return true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_2"] = function(ctx)
    H.copy_var("global", nil, "new_last_scion_spell_name", "actor", H.u(ctx), "last_scion_spell_name_slot_two", ctx)
    services.messages.add(ctx:expand_text(services.translate("Spell name for slot 2 is <u_val:last_scion_spell_name_slot_two>")), "debug")
    local _a11 = H.u(ctx)
    local _sn12 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_two", "")
    local _sg13 = (_sn12 ~= "") and H.safe_id("spell", _sn12) or nil
    if _a11 and _sg13 then services.spells.set_level(_a11, _sg13, math.floor((-1))) end
    H.copy_var("global", nil, "new_last_scion_spell_id", "actor", H.u(ctx), "last_scion_spell_id_slot_two", ctx)
    services.messages.add(ctx:expand_text(services.translate("Spell id for slot 2 is <u_val:last_scion_spell_id_slot_two>")), "debug")
    local _a14 = H.u(ctx)
    local _sn15 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_two", "")
    local _sg16 = (_sn15 ~= "") and H.safe_id("spell", _sn15) or nil
    if _a14 and _sg16 then services.spells.set_level(_a14, _sg16, math.floor(H.global_var_num("new_last_scion_spell_level"))) end
    return true
    end
    COND["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_3"] = function(ctx)
        return ((H.global_var_num("last_scion_number_of_spell_slots") >= 3)) == true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_3"] = function(ctx)
    if ((H.global_var_num("last_scion_number_of_spell_slots") >= 3)) then
        H.copy_var("global", nil, "new_last_scion_spell_name", "actor", H.u(ctx), "last_scion_spell_name_slot_three", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell name for slot 3 is <u_val:last_scion_spell_name_slot_three>")), "debug")
        local _a17 = H.u(ctx)
        local _sn18 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_three", "")
        local _sg19 = (_sn18 ~= "") and H.safe_id("spell", _sn18) or nil
        if _a17 and _sg19 then services.spells.set_level(_a17, _sg19, math.floor((-1))) end
        H.copy_var("global", nil, "new_last_scion_spell_id", "actor", H.u(ctx), "last_scion_spell_id_slot_three", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell id for slot 3 is <u_val:last_scion_spell_id_slot_three>")), "debug")
        local _a20 = H.u(ctx)
        local _sn21 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_three", "")
        local _sg22 = (_sn21 ~= "") and H.safe_id("spell", _sn21) or nil
        if _a20 and _sg22 then services.spells.set_level(_a20, _sg22, math.floor(H.global_var_num("new_last_scion_spell_level"))) end
        return true
    end
    return false
    end
    COND["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_4"] = function(ctx)
        return ((H.global_var_num("last_scion_number_of_spell_slots") >= 4)) == true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_4"] = function(ctx)
    if ((H.global_var_num("last_scion_number_of_spell_slots") >= 4)) then
        H.copy_var("global", nil, "new_last_scion_spell_name", "actor", H.u(ctx), "last_scion_spell_name_slot_four", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell name for slot 4 is <u_val:last_scion_spell_name_slot_four>")), "debug")
        local _a23 = H.u(ctx)
        local _sn24 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_four", "")
        local _sg25 = (_sn24 ~= "") and H.safe_id("spell", _sn24) or nil
        if _a23 and _sg25 then services.spells.set_level(_a23, _sg25, math.floor((-1))) end
        H.copy_var("global", nil, "new_last_scion_spell_id", "actor", H.u(ctx), "last_scion_spell_id_slot_four", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell id for slot 4 is <u_val:last_scion_spell_id_slot_four>")), "debug")
        local _a26 = H.u(ctx)
        local _sn27 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_four", "")
        local _sg28 = (_sn27 ~= "") and H.safe_id("spell", _sn27) or nil
        if _a26 and _sg28 then services.spells.set_level(_a26, _sg28, math.floor(H.global_var_num("new_last_scion_spell_level"))) end
        return true
    end
    return false
    end
    COND["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_5"] = function(ctx)
        return ((H.global_var_num("last_scion_number_of_spell_slots") >= 5)) == true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_5"] = function(ctx)
    if ((H.global_var_num("last_scion_number_of_spell_slots") >= 5)) then
        H.copy_var("global", nil, "new_last_scion_spell_name", "actor", H.u(ctx), "last_scion_spell_name_slot_five", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell name for slot 5 is <u_val:last_scion_spell_name_slot_five>")), "debug")
        local _a29 = H.u(ctx)
        local _sn30 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_five", "")
        local _sg31 = (_sn30 ~= "") and H.safe_id("spell", _sn30) or nil
        if _a29 and _sg31 then services.spells.set_level(_a29, _sg31, math.floor((-1))) end
        H.copy_var("global", nil, "new_last_scion_spell_id", "actor", H.u(ctx), "last_scion_spell_id_slot_five", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell id for slot 5 is <u_val:last_scion_spell_id_slot_five>")), "debug")
        local _a32 = H.u(ctx)
        local _sn33 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_five", "")
        local _sg34 = (_sn33 ~= "") and H.safe_id("spell", _sn33) or nil
        if _a32 and _sg34 then services.spells.set_level(_a32, _sg34, math.floor(H.global_var_num("new_last_scion_spell_level"))) end
        return true
    end
    return false
    end
    COND["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_6"] = function(ctx)
        return ((H.global_var_num("last_scion_number_of_spell_slots") >= 6)) == true
    end
    EOC["EOC_ISO_LAST_SCION_SPELL_GAINING_CHOOSE_SLOT_6"] = function(ctx)
    if ((H.global_var_num("last_scion_number_of_spell_slots") >= 6)) then
        H.copy_var("global", nil, "new_last_scion_spell_name", "actor", H.u(ctx), "last_scion_spell_name_slot_six", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell name for slot 6 is <u_val:last_scion_spell_name_slot_six>")), "debug")
        local _a35 = H.u(ctx)
        local _sn36 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_six", "")
        local _sg37 = (_sn36 ~= "") and H.safe_id("spell", _sn36) or nil
        if _a35 and _sg37 then services.spells.set_level(_a35, _sg37, math.floor((-1))) end
        H.copy_var("global", nil, "new_last_scion_spell_id", "actor", H.u(ctx), "last_scion_spell_id_slot_six", ctx)
        services.messages.add(ctx:expand_text(services.translate("Spell id for slot 6 is <u_val:last_scion_spell_id_slot_six>")), "debug")
        local _a38 = H.u(ctx)
        local _sn39 = H.var_str("actor", H.u(ctx), ctx, "last_scion_spell_id_slot_six", "")
        local _sg40 = (_sn39 ~= "") and H.safe_id("spell", _sn39) or nil
        if _a38 and _sg40 then services.spells.set_level(_a38, _sg40, math.floor(H.global_var_num("new_last_scion_spell_level"))) end
        return true
    end
    return false
    end
    EOC["EOC_talk_balthazar_finish_integration"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "ISO_BALTHAZAR_INTEGRATED") end
    return true
    end
    COND["iso_robolove"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "iso_robolove") == 1) and services.random.native_probability(1, (6)))) == true
    end
    EOC["iso_robolove"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "iso_robolove") == 1) and services.random.native_probability(1, (6)))) then
        H.eoc_cast_spell(H.u(ctx), "iso_robolove_charm_1", false, { hit_self = true })
        return true
    end
    return false
    end
    COND["EOC_ISO_HYPO_O"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "iso_hypo_o") == 1) and (((("bandaged") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("disinfected") == (H.var_str("context", nil, ctx, "effect", ""))))))) == true
    end
    EOC["EOC_ISO_HYPO_O"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "iso_hypo_o") == 1) and (((("bandaged") == (H.var_str("context", nil, ctx, "effect", "")))) or ((("disinfected") == (H.var_str("context", nil, ctx, "effect", ""))))))) then
        H.copy_var("context", nil, "bodypart", "actor", H.u(ctx), "heal_part", ctx)
        H.eoc_add_effect(H.u(ctx), "iso_heal", 1, H.var_str("actor", H.u(ctx), ctx, "heal_part", ""), nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ISO_HYPO_DAM"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_hypo_o") == 1)) == true
    end
    EOC["EOC_ISO_HYPO_DAM"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_hypo_o") == 1)) then
        H.eoc_add_effect(H.u(ctx), "iso_eff_hypo_o", 2, nil, nil, nil)
        return true
    end
    return false
    end
    COND["_EOC_ISO_GEAS"] = function(ctx)
        return ((H.char_val_extra(H.u(ctx), "difficulty") >= 30)) == true
    end
    EOC["_EOC_ISO_GEAS"] = function(ctx)
    if ((H.char_val_extra(H.u(ctx), "difficulty") >= 30)) then
        H.run_eoc("geas_monster", ctx, nil, nil, services.characters.avatar())
        return true
    end
    return false
    end
    COND["EOC_ISO_GEAS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_geas") == 1)) == true
    end
    EOC["EOC_ISO_GEAS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_geas") == 1)) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "avatar_new_pos", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(65), nil); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "_EOC_ISO_GEAS" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "avatar_old_pos", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        return true
    end
    return false
    end
    EOC["geas_monster"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "new_distance", ((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()))
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "monster_pos", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "old_distance") and 1 or 0)) and (H.var_num(H.u(ctx), "new_distance") > H.var_num(H.u(ctx), "old_distance")) and ((function() local p = H.get_tripoint_var("actor", H.u(ctx), ctx, "monster_pos"); return H.npc(ctx) ~= nil and p ~= nil and services.characters.can_see_location(H.npc(ctx), p).value == true end)())) then
        do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.npc(ctx), ctx, "avatar_old_pos"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
        services.messages.add(ctx:expand_text(services.translate("You cannot flee from the abomination.")), "neutral")
        H.eoc_add_effect(H.npc(ctx), "iso_eff_geas_buff", 10, nil, nil, nil)
    else
        services.messages.add(ctx:expand_text(services.translate("Oh ho!  Then come as close as you like.")), "neutral")
        H.eoc_add_effect(H.npc(ctx), "iso_eff_geas_buff", 10, nil, nil, nil)
    end
    H.set_var("actor", H.u(ctx), ctx, "old_distance", ((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, (H.char_snap(H.npc(ctx)) or {}).creature.position; if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()))
    return true
    end
    COND["EOC_ISO_BIO_VAMPIRE_RESTORE"] = function(ctx)
        return (((H.var_num(H.u(ctx), "bionic_in_melee") == 1) and (H.char_has_trait(H.u(ctx), "iso_bionic_vampire") == 1))) == true
    end
    EOC["EOC_ISO_BIO_VAMPIRE_RESTORE"] = function(ctx)
    if (((H.var_num(H.u(ctx), "bionic_in_melee") == 1) and (H.char_has_trait(H.u(ctx), "iso_bionic_vampire") == 1))) then
        H.set_bionic_power(H.u(ctx), (1.75 * 1000000), "+=")
        if H.char_has_flag(H.npc(ctx), "PUSH_VEH") then
            H.set_bionic_power(H.u(ctx), (50 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "CORNERED_FIGHTER") then
            H.set_bionic_power(H.u(ctx), (0.5 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "PRIORITIZE_TARGETS") then
            H.set_bionic_power(H.u(ctx), (15 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "DROPS_AMMO") then
            H.set_bionic_power(H.u(ctx), (35 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "STUN_IMMUNE") then
            H.set_bionic_power(H.u(ctx), (2 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "HAS_MIND") then
            H.set_bionic_power(H.u(ctx), (10 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "ELECTRIC") then
            H.set_bionic_power(H.u(ctx), (5 * 1000000), "+=")
        end
        if H.char_has_flag(H.npc(ctx), "HARDTOSHOOT") then
            H.set_bionic_power(H.u(ctx), (20 * 1000000), "+=")
        end
        if (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))) then
            H.set_bionic_power(H.u(ctx), (25 * 1000000), "+=")
        end
        if (H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))) then
            H.set_bionic_power(H.u(ctx), (20 * 1000000), "+=")
        end
        if (H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))) then
            H.set_bionic_power(H.u(ctx), (5 * 1000000), "+=")
        end
        return true
    end
    return false
    end
    COND["EOC_ISO_BIO_VAMPIRE_RESTORE_IN_MELEE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_bionic_vampire") == 1)) == true
    end
    EOC["EOC_ISO_BIO_VAMPIRE_RESTORE_IN_MELEE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_bionic_vampire") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "bionic_in_melee", 1)
        return true
    end
    return false
    end
    COND["EOC_ISO_BIO_VAMPIRE_RESTORE_AT_RANGE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "iso_bionic_vampire") == 1)) == true
    end
    EOC["EOC_ISO_BIO_VAMPIRE_RESTORE_AT_RANGE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "iso_bionic_vampire") == 1)) then
        H.set_var("actor", H.u(ctx), ctx, "bionic_in_melee", 0)
        return true
    end
    return false
    end
    COND["EOC_ISO_ELDRITCH_DAMAGE_SHIELD_COUNTER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_iso_eldritch_damage_shield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_ISO_ELDRITCH_DAMAGE_SHIELD_COUNTER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_iso_eldritch_damage_shield"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "iso_eldritch_damage_shield_counter", (H.var_num(H.u(ctx), "iso_eldritch_damage_shield_counter")) + (1))
        if (H.var_num(H.u(ctx), "iso_eldritch_damage_shield_counter") > ((H.char_spell_level(H.u(ctx), "iso_eldritch_damage_shield") / 4) + 1)) then
            do local _eg = H.safe_id('effect', "effect_iso_eldritch_damage_shield"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        return true
    end
    return false
    end
    COND["EOC_ISO_ELDRITCH_MASS_AOE_ZOMBIE_DESTRUCTION_TAKE_DAMAGE"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_iso_eldritch_mass_aoe_zombie_destruction"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) / 2)), (100)))) == true
    end
    EOC["EOC_ISO_ELDRITCH_MASS_AOE_ZOMBIE_DESTRUCTION_TAKE_DAMAGE"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_iso_eldritch_mass_aoe_zombie_destruction"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((((((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0) / 2)), (100)))) then
        do local _eg = H.safe_id('effect', "effect_iso_eldritch_mass_aoe_zombie_destruction"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    EOC["EOC_BALTHAZAR_CHECK_PROGRESS"] = function(ctx)
    return true
    end
end
