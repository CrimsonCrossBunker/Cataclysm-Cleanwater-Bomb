local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_SUMMON_ZOMBIE"] = function(ctx)
    do
        local _sw1 = H.char_spell_level(H.u(ctx), "summon_undead")
        if _sw1 == 0 then
            H.eoc_cast_spell(H.u(ctx), "summon_zombie", false, nil)
        elseif _sw1 == 7 then
            H.eoc_cast_spell(H.u(ctx), "summon_tough_zombie", false, nil)
        elseif _sw1 == 14 then
            H.eoc_cast_spell(H.u(ctx), "summon_zombie_brute", false, nil)
        elseif _sw1 == 21 then
            H.eoc_cast_spell(H.u(ctx), "summon_skeleton", false, nil)
        elseif _sw1 == 28 then
            H.eoc_cast_spell(H.u(ctx), "summon_skeleton_brute", false, nil)
        elseif _sw1 == 35 then
            H.eoc_cast_spell(H.u(ctx), "summon_skeleton_hulk", false, nil)
        end
    end
    return true
    end
    EOC["EOC_SUMMON_ZOMBIE_SWARM"] = function(ctx)
    do
        local _sw2 = H.char_spell_level(H.u(ctx), "summon_undead_swarm")
        if _sw2 == 0 then
            H.eoc_cast_spell(H.u(ctx), "summon_zombie_dog", false, nil)
        elseif _sw2 == 5 then
            H.eoc_cast_spell(H.u(ctx), "summon_dog_skeleton", false, nil)
        elseif _sw2 == 10 then
            H.eoc_cast_spell(H.u(ctx), "summon_zougar", false, nil)
        elseif _sw2 == 15 then
            H.eoc_cast_spell(H.u(ctx), "summon_wolf_skeleton", false, nil)
        elseif _sw2 == 20 then
            H.eoc_cast_spell(H.u(ctx), "summon_dog_zombie_brute", false, nil)
        elseif _sw2 == 25 then
            H.eoc_cast_spell(H.u(ctx), "summon_dog_skeleton_brute", false, nil)
        elseif _sw2 == 30 then
            H.eoc_cast_spell(H.u(ctx), "summon_dog_zombie_hulk", false, nil)
        elseif _sw2 == 35 then
            H.eoc_cast_spell(H.u(ctx), "summon_zougar_hunter", false, nil)
        end
    end
    return true
    end
    EOC["EOC_ANIMIST_SPIRIT_WALKING"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_spirit_walking", ((30 + (H.char_spell_level(H.u(ctx), "animist_spirit_walking") * 3)) * H._jm_enhancement_proficiency_modifier(ctx)), nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "incorporeal", ((30 + (H.char_spell_level(H.u(ctx), "animist_spirit_walking") * 3)) * H._jm_enhancement_proficiency_modifier(ctx)), nil, nil, nil)
    do local _g = H.safe_id('mutation', "ANIMIST_BODY_OF_SPIRIT_APPEARANCE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    COND["EOC_ANIMIST_SPIRIT_WALKING_LOSE_APPEARANCE"] = function(ctx)
        return ((((("effect_spirit_walking") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_ANIMIST_SPIRIT_WALKING_LOSE_APPEARANCE"] = function(ctx)
    if ((((("effect_spirit_walking") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.lose_trait(H.u(ctx), "ANIMIST_BODY_OF_SPIRIT_APPEARANCE")
        return true
    end
    return false
    end
    EOC["EOC_ANIMIST_SLOW_FOOD_ROTTING_SPELL_ITEM"] = function(ctx)
    do local _g = H.safe_id('json_flag', "IRRADIATED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    do local _g = H.safe_id('json_flag', "NO_PARASITES"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
    EOC["EOC_ANIMIST_SLOW_FOOD_ROTTING_SPELL"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual_mult", nil, { { category = "food" }, { category = "drink" } }, { "EOC_ANIMIST_SLOW_FOOD_ROTTING_SPELL_ITEM" }, {  })
    return true
    end
    COND["EOC_DEMON_POSSESSION"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "HUGE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HUGE_OK") == 1))))) == true
    end
    EOC["EOC_DEMON_POSSESSION"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "HUGE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HUGE_OK") == 1))))) then
        services.messages.add(ctx:expand_text(services.translate("Your body swells and warps as your size increases!")), "good")
        H.set_var("actor", H.u(ctx), ctx, "preshift_size", H.char_val_extra(H.u(ctx), "size"))
        do
            local _sw3 = H.var_num(H.u(ctx), "preshift_size")
            if _sw3 == 1 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw3 == 2 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw3 == 3 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw3 == 4 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw3 == 5 then
            end
        end
        H.eoc_cast_spell(H.u(ctx), "demonic_possession_real", false, nil)
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "demonic_possession") * 309) + 3600))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DEMON_POSSESSION_REMOVE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your body fills with demonic power!")), "good")
        H.eoc_cast_spell(H.u(ctx), "demonic_possession_real", false, nil)
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "demonic_possession") * 309) + 3600))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DEMON_POSSESSION_REMOVE"), nil) end end
        return false
    end
    end
    EOC["EOC_DEMON_POSSESSION_REMOVE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your body shrinks and warps as your size decreases!")), "bad")
    do
        local _sw4 = H.var_num(H.u(ctx), "preshift_size")
        if _sw4 == 1 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw4 == 2 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw4 == 3 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw4 == 4 then
            do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        elseif _sw4 == 5 then
        end
    end
    return true
    end
    COND["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_burning_trail"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_burning_trail"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "effect_burning_trail", -1, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_flame_immunity", 2, nil, nil, nil)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_2"), nil) end end
        return true
    else
        do local _eg = H.safe_id('effect', "effect_burning_trail"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor(2)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_CLEANUP"), nil) end end
        return false
    end
    end
    COND["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_3"] = function(ctx)
        return ((H.char_mana(H.u(ctx), "current") >= 1)) == true
    end
    EOC["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_3"] = function(ctx)
    if ((H.char_mana(H.u(ctx), "current") >= 1)) then
        local _a5 = H.u(ctx)
        if _a5 then services.spells.set_mana_raw(_a5, math.floor((H.char_mana(_a5, "current")) - (1))) end
        H.eoc_add_effect(H.u(ctx), "effect_flame_immunity", 2, nil, nil, nil)
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('field', "fd_fire"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(0), intensity = math.floor(1) }) end end
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_2"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You do not have enough mana to fuel your searing footsteps!")), "bad")
        do local _eg = H.safe_id('effect', "effect_burning_trail"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor(2)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_CLEANUP"), nil) end end
        return false
    end
    end
    COND["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_2"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_burning_trail"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_2"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_burning_trail"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_3", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_CLEANSING_FLAME_FIRE_FOOSTEPS_CLEANUP"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_flame_immunity"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_SOUL_AFTERBURNER"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "soul_burn"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_SOUL_AFTERBURNER"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "soul_burn"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You gain a sudden burst of speed!")), "good")
        H.eoc_cast_spell(H.u(ctx), "soul_afterburner_real", false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Burning your soul before it healed only resulted in some damage to your body.")), "bad")
        H.eoc_cast_spell(H.u(ctx), "soul_afterburner_cooldown_backlash", false, nil)
        return false
    end
    end
    COND["EOC_GIANT_GROWTH_MUTATION"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "HUGE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HUGE_OK") == 1))) and (not ((H.char_has_trait(H.u(ctx), "BIO_GIANT_GROWTH") == 1))))) == true
    end
    EOC["EOC_GIANT_GROWTH_MUTATION"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "HUGE") == 1))) and (not ((H.char_has_trait(H.u(ctx), "HUGE_OK") == 1))) and (not ((H.char_has_trait(H.u(ctx), "BIO_GIANT_GROWTH") == 1))))) then
        services.messages.add(ctx:expand_text(services.translate("Your body swells and warps as your size increases!")), "good")
        H.set_var("actor", H.u(ctx), ctx, "preshift_size", H.char_val_extra(H.u(ctx), "size"))
        do
            local _sw6 = H.var_num(H.u(ctx), "preshift_size")
            if _sw6 == 1 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw6 == 2 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw6 == 3 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw6 == 4 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw6 == 5 then
            end
        end
        do local _g = H.safe_id('mutation', "BIO_GIANT_GROWTH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor((((H.char_spell_level(H.u(ctx), "biomancer_giant_growth") * 40) + 300) * H._jm_transformation_proficiency_modifier(ctx)))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_GIANT_GROWTH_MUTATION_REMOVE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You are already enormous--the spell cannot make you any larger!")), "neutral")
        return false
    end
    end
    COND["EOC_GIANT_GROWTH_MUTATION_REMOVE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "BIO_GIANT_GROWTH") == 1)) == true
    end
    EOC["EOC_GIANT_GROWTH_MUTATION_REMOVE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "BIO_GIANT_GROWTH") == 1)) then
        services.messages.add(ctx:expand_text(services.translate("Your body shrinks and warps as your size decreases!")), "bad")
        do
            local _sw7 = H.var_num(H.u(ctx), "preshift_size")
            if _sw7 == 1 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw7 == 2 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw7 == 3 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw7 == 4 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw7 == 5 then
            end
        end
        H.lose_trait(H.u(ctx), "BIO_GIANT_GROWTH")
        return true
    end
    return false
    end
    COND["EOC_BIOMANCER_SLOW_BLEEDING"] = function(ctx)
        return ((not (H.char_has_flag(H.u(ctx), "BLOCK_SUPERNATURAL_HEALING")))) == true
    end
    EOC["EOC_BIOMANCER_SLOW_BLEEDING"] = function(ctx)
    if ((not (H.char_has_flag(H.u(ctx), "BLOCK_SUPERNATURAL_HEALING")))) then
        do
            local _sw8 = H.char_spell_level(H.u(ctx), "biomancer_slow_bleeding")
            if _sw8 == 0 then
                H.eoc_add_effect(H.u(ctx), "effect_biomancer_slow_bleeding_01", (((H.char_spell_level(H.u(ctx), "biomancer_slow_bleeding") * 360) + 900) * H._jm_enhancement_proficiency_modifier(ctx)), nil, nil, nil)
            elseif _sw8 == 8 then
                H.eoc_add_effect(H.u(ctx), "effect_biomancer_slow_bleeding_02", (((H.char_spell_level(H.u(ctx), "biomancer_slow_bleeding") * 360) + 900) * H._jm_enhancement_proficiency_modifier(ctx)), nil, nil, nil)
            elseif _sw8 == 15 then
                H.eoc_add_effect(H.u(ctx), "effect_biomancer_slow_bleeding_03", (((H.char_spell_level(H.u(ctx), "biomancer_slow_bleeding") * 360) + 900) * H._jm_enhancement_proficiency_modifier(ctx)), nil, nil, nil)
            end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your healing spell has no effect!")), "bad")
        return false
    end
    end
    EOC["EOC_BIO_GET_MORE_BLOOD"] = function(ctx)
    if (H.char_vitamin(H.u(ctx), "blood") < 0) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (300 + (H.char_spell_level(H.u(ctx), "biomancer_get_more_blood") * 150)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    if (H.char_vitamin(H.u(ctx), "redcells") < 0) then
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (300 + (H.char_spell_level(H.u(ctx), "biomancer_get_more_blood") * 150)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    end
    return true
    end
    COND["EOC_BIOMANCER_BALEFUL_POLYMORPH_NPCS"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_BIOMANCER_BALEFUL_POLYMORPH_NPCS"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.set_var("context", nil, ctx, "lower_damage_limit", (((H.char_spell_level(H.npc(ctx), "biomancer_baleful_polymorph") * 1.5) + 10) * H._jm_magiclysm_spell_failure_transformation_proficiency_adjustments_damage_npc(ctx)))
        H.set_var("context", nil, ctx, "upper_damage_limit", (((H.char_spell_level(H.npc(ctx), "biomancer_baleful_polymorph") * 3.6) + 25) * H._jm_magiclysm_spell_failure_transformation_proficiency_adjustments_damage_npc(ctx)))
        H.set_var("actor", H.u(ctx), ctx, "baleful_polymorph_damage", services.random.native_float((ctx:get_number("lower_damage_limit") or 0), (ctx:get_number("upper_damage_limit") or 0)))
        H.set_var("actor", H.u(ctx), ctx, "health_comparison", ((((((H.char_hp(H.u(ctx), "arm_l", false) + H.char_hp(H.u(ctx), "arm_r", false)) + H.char_hp(H.u(ctx), "leg_l", false)) + H.char_hp(H.u(ctx), "leg_r", false)) + H.char_hp(H.u(ctx), "torso", false)) + H.char_hp(H.u(ctx), "head", false)) / 3))
        if ((H.var_num(H.u(ctx), "baleful_polymorph_damage") > H.var_num(H.u(ctx), "health_comparison")) and (not ((H.char_has_trait(H.u(ctx), "BIOMANCER_NPC_WRETCH_POLYMORPH") == 1)))) then
            services.messages.add(ctx:expand_text(services.translate("<u_name> transforms into a fleshwarped wretch.")), "neutral")
            do local _g = H.safe_id('mutation', "BIOMANCER_NPC_WRETCH_POLYMORPH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        end
        return true
    end
    return false
    end
    COND["EOC_CLASSLESS_CREATE_ORB_OF_LIGHT"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_classless_magic_light"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_CLASSLESS_CREATE_ORB_OF_LIGHT"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_classless_magic_light"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "effect_classless_magic_light", (((H.char_spell_level(H.u(ctx), "create_atomic_light") * 450) + 1000) * H._jm_summoning_proficiency_modifier(ctx)), nil, nil, nil)
        return true
    else
        do local _eg = H.safe_id('effect', "effect_classless_magic_light"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_CLASSLESS_ETHEREAL_GRASP"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_CLASSLESS_ETHEREAL_GRASP"] = function(ctx)
    if (ctx:has_speaker()) then
        H.set_var("actor", H.u(ctx), ctx, "ethereal_grasp_affected_level", H.char_spell_level(H.npc(ctx), "ethereal_grasp"))
        H.set_var("actor", H.u(ctx), ctx, "evocation_spell_affected_proficiency", (((1 + ((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_evocation_beginner").value) == true) and 1 or 0) * 0.1)) + ((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_evocation_apprentice").value) == true) and 1 or 0) * 0.1)) + ((((H.npc(ctx) and services.proficiencies.has_id_text(H.npc(ctx), "prof_magic_evocation_master").value) == true) and 1 or 0) * 0.1)))
        H.eoc_add_effect(H.u(ctx), "effect_ethereal_grasp", (10 + (H.var_num(H.u(ctx), "ethereal_grasp_affected_level") * 2)), nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_CLASSLESS_CLEAN_CLOTHING_AND_SELF_ITEMS"] = function(ctx)
    do local _g = H.safe_id('json_flag', "FILTHY"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    EOC["EOC_CLASSLESS_CLEAN_CLOTHING_AND_SELF"] = function(ctx)
    do local _eg = H.safe_id('effect', "bile_irritant"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "bile_stink"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "boomered"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "skunk_spray"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _eg = H.safe_id('effect', "wet"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _g = H.safe_id('morale', "morale_bile"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true }, {  } }, { "EOC_CLASSLESS_CLEAN_CLOTHING_AND_SELF_ITEMS" }, {  })
    return true
    end
    COND["eoc_crystal_spawn"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MANA_CRYST_MANA") == 1)) == true
    end
    EOC["eoc_crystal_spawn"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MANA_CRYST_MANA") == 1)) then
        H.eoc_cast_spell(H.u(ctx), "crystallize_mana_crystal_5", false, nil)
        return true
    else
        H.eoc_cast_spell(H.u(ctx), "crystallize_mana_1", false, nil)
        return false
    end
    end
    COND["EOC_DRUID_TRAVERSE_THE_WILDS_REMOVER"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_druid_traverse_the_wilds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or ((not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "YOUNG"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(1)) end)())))) == true
    end
    EOC["EOC_DRUID_TRAVERSE_THE_WILDS_REMOVER"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_druid_traverse_the_wilds"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or ((not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "YOUNG"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(1)) end)())))) then
        do local _eg = H.safe_id('effect', "effect_druid_traverse_the_wilds"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("As you approach civilization, your spell fades.")), "bad")
        return true
    end
    return false
    end
    EOC["EOC_EARTHSHAPER_UTILITY_MOLDING"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_HAMMER"] == nil or E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_HAMMER"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Summon Hammer")), description = ctx:expand_text(services.translate("Transform the living earth into a hammer.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_EARTHSHAPER_UTILITY_MOLDING_HAMMER" end end
        do local _en = (E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_PICKAXE"] == nil or E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_PICKAXE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Summon Pickaxe")), description = ctx:expand_text(services.translate("Transform the living earth into a pickaxe.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_EARTHSHAPER_UTILITY_MOLDING_PICKAXE" end end
        do local _en = (E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_AXE"] == nil or E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_AXE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Summon Axe")), description = ctx:expand_text(services.translate("Transform the living earth into an axe.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_EARTHSHAPER_UTILITY_MOLDING_AXE" end end
        do local _en = (E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_KNIFE"] == nil or E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_KNIFE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Summon Knife")), description = ctx:expand_text(services.translate("Transform the living earth into a knife.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_EARTHSHAPER_UTILITY_MOLDING_KNIFE" end end
        do local _en = (E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_SHOVEL"] == nil or E.cond["EOC_EARTHSHAPER_UTILITY_MOLDING_SHOVEL"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Summon Shovel")), description = ctx:expand_text(services.translate("Transform the living earth into a shovel.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_EARTHSHAPER_UTILITY_MOLDING_SHOVEL" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_EARTHSHAPER_UTILITY_MOLDING_HAMMER"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "eshaper_spawn_hammer", false, nil)
    return true
    end
    EOC["EOC_EARTHSHAPER_UTILITY_MOLDING_PICKAXE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "eshaper_spawn_pickaxe", false, nil)
    return true
    end
    EOC["EOC_EARTHSHAPER_UTILITY_MOLDING_AXE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "eshaper_spawn_axe", false, nil)
    return true
    end
    EOC["EOC_EARTHSHAPER_UTILITY_MOLDING_KNIFE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "eshaper_spawn_knife", false, nil)
    return true
    end
    EOC["EOC_EARTHSHAPER_UTILITY_MOLDING_SHOVEL"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "eshaper_spawn_shovel", false, nil)
    return true
    end
    COND["EOC_EARTHSHAPER_MAP"] = function(ctx)
        return ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= 0)) == true
    end
    EOC["EOC_EARTHSHAPER_MAP"] = function(ctx)
    if ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= 0)) then
        do
            local _sw9 = H.char_spell_level(H.u(ctx), "earthshaper_reveal_world_map")
            if _sw9 == 0 then
                H.eoc_spawn_item(H.u(ctx), "item_earthshaper_map_01", 1, false, false, nil)
                H.run_eoc("EOC_EARTHSHAPER_MAP_ITEM_01", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_earthshaper_map_01"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw9 == 3 then
                H.eoc_spawn_item(H.u(ctx), "item_earthshaper_map_02", 1, false, false, nil)
                H.run_eoc("EOC_EARTHSHAPER_MAP_ITEM_02", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_earthshaper_map_02"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw9 == 6 then
                H.eoc_spawn_item(H.u(ctx), "item_earthshaper_map_03", 1, false, false, nil)
                H.run_eoc("EOC_EARTHSHAPER_MAP_ITEM_03", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_earthshaper_map_03"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw9 == 9 then
                H.eoc_spawn_item(H.u(ctx), "item_earthshaper_map_04", 1, false, false, nil)
                H.run_eoc("EOC_EARTHSHAPER_MAP_ITEM_04", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_earthshaper_map_04"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw9 == 12 then
                H.eoc_spawn_item(H.u(ctx), "item_earthshaper_map_05", 1, false, false, nil)
                H.run_eoc("EOC_EARTHSHAPER_MAP_ITEM_05", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_earthshaper_map_05"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            elseif _sw9 == 15 then
                H.eoc_spawn_item(H.u(ctx), "item_earthshaper_map_06", 1, false, false, nil)
                H.run_eoc("EOC_EARTHSHAPER_MAP_ITEM_06", ctx, nil, nil, nil)
                do local g = H.safe_id('item', "item_earthshaper_map_06"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
            end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Without a direct connection to the living earth, the spell fails.")), "neutral")
        return false
    end
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_01_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_01"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_earthshaper_map_01" } }, { "EOC_EARTHSHAPER_MAP_ITEM_01_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_02_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_02"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_earthshaper_map_02" } }, { "EOC_EARTHSHAPER_MAP_ITEM_02_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_03_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_03"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_earthshaper_map_03" } }, { "EOC_EARTHSHAPER_MAP_ITEM_03_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_04_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_04"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_earthshaper_map_04" } }, { "EOC_EARTHSHAPER_MAP_ITEM_04_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_05_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_05"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_earthshaper_map_05" } }, { "EOC_EARTHSHAPER_MAP_ITEM_05_ACTIVATE" }, {  })
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_06_ACTIVATE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
    end
    EOC["EOC_EARTHSHAPER_MAP_ITEM_06"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "item_earthshaper_map_06" } }, { "EOC_EARTHSHAPER_MAP_ITEM_06_ACTIVATE" }, {  })
    return true
    end
    COND["EOC_EARTHSHAPER_DANGERSENSE"] = function(ctx)
        return ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= 0)) == true
    end
    EOC["EOC_EARTHSHAPER_DANGERSENSE"] = function(ctx)
    if ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= 0)) then
        H.eoc_add_effect(H.u(ctx), "effect_tremorsense", ((H.char_spell_level(H.u(ctx), "earthshaper_danger_sense") * 300) * H._jm_channeling_proficiency_modifier(ctx)), nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Without a direct connection to the living earth, the spell fails.")), "bad")
        return false
    end
    end
    COND["EOC_EARTHSHAPER_DANGERSENSE_CHECKER"] = function(ctx)
        return (((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1) and ((function() local eg = H.safe_id('effect', "effect_tremorsense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_EARTHSHAPER_DANGERSENSE_CHECKER"] = function(ctx)
    if (((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1) and ((function() local eg = H.safe_id('effect', "effect_tremorsense"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _eg = H.safe_id('effect', "effect_tremorsense"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("As you break your connection to the living earth, your magical senses fade away.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_EARTHSHAPER_GRANITE_AEGIS"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_clay" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_claymound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_claymound_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sandmound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmoundfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_tall" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_dead" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_white" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_moss" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_soil" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_region_soil" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_shallow" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_puddle_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mud" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mud_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_concrete_y" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_concrete" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_y_olight" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_warning" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_y" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_r" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_strconc_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_strconc_floor_olight" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_strconc_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= 0))) == true
    end
    EOC["EOC_EARTHSHAPER_GRANITE_AEGIS"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtfloor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_clay" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_claymound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_claymound_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_sandmound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmoundfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_tall" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_dead" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_white" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_forestfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_moss" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_soil" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirtmound" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_region_soil" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_shallow" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_puddle_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mud" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mud_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_concrete_y" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_concrete" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_y_olight" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_warning" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_y" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_r" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_thconc_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_strconc_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_strconc_floor_olight" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_strconc_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= 0))) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "earthshaper_granite_aegis_location", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0), outdoor_only = false }, nil, false, true, {  }, {  })
        do local _p, _g = H.get_tripoint_var("global", nil, ctx, "earthshaper_granite_aegis_location"), H.safe_id('terrain_furniture_transform', "earthshaper_granite_aegis_to_stone"); if _p and _g then services.world.transform_radius(_p, math.floor(1), _g, nil) end end
        do local _p, _g = H.get_tripoint_var("global", nil, ctx, "earthshaper_granite_aegis_location"), H.safe_id('terrain_furniture_transform', "earthshaper_granite_aegis_to_stone_safe"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, { delay = services.time.duration_from_turns(math.floor((function() local a, b = math.floor(0), math.floor(0); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())) }) end end
        do local _p, _g = H.get_tripoint_var("global", nil, ctx, "earthshaper_granite_aegis_location"), H.safe_id('terrain_furniture_transform', "earthshaper_granite_aegis_from_stone"); if _p and _g then services.world.transform_radius(_p, math.floor(1), _g, { delay = services.time.duration_from_turns(math.floor((function() local a, b = math.floor(5), math.floor(20); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())) }) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Without a connection to the living earth or a flat surface of solid rock, the spell fails.")), "neutral")
        return false
    end
    end
    COND["EOC_EARTHSHAPER_SLEEP_IN_EARTH_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_smooth" end)()) or (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)())))))) == true
    end
    EOC["EOC_EARTHSHAPER_SLEEP_IN_EARTH_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_smooth" end)()) or (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_alien" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_vitrified_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_pit_corpsed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_fungus" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_glassed_sand" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rubber_mulch" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_surf" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_woodchips" end)())))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "earthshaper_sleep_in_earth", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, { dz = math.floor(-9) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "earthshaper_sleep_in_earth_return", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        if ((function() local p = H.get_tripoint_var("actor", H.u(ctx), ctx, "earthshaper_sleep_in_earth"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_rock" end)()) then
            services.messages.add(ctx:expand_text(services.translate("As you complete the spell, the earth parts beneath you and you sink down into the stone.")), "good")
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "earthshaper_sleep_in_earth"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            do local _g = H.safe_id('mutation', "EARTHSHAPER_STONE_SLEEP"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        else
            services.messages.add(ctx:expand_text(services.translate("As you nearly complete the spell, you stop in your tracks.  There's something odd about the ground below you, and sinking into it would be too dangerous.")), "mixed")
            local _a10 = H.u(ctx)
            if _a10 then services.spells.set_mana_raw(_a10, math.floor((H.char_mana(_a10, "current")) + ((800 * (1 / H._jm_enhancement_proficiency_modifier(ctx)))))) end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be standing on the living earth to sink into the stone!")), "bad")
        return false
    end
    end
    COND["EOC_EARTHSHAPER_SLEEP_IN_EARTH"] = function(ctx)
        return ((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9))))) == true
    end
    EOC["EOC_EARTHSHAPER_SLEEP_IN_EARTH"] = function(ctx)
    if ((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9))))) then
        H.run_eoc("EOC_EARTHSHAPER_SLEEP_IN_EARTH_2", ctx, nil, nil, nil)
        return true
    else
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "earthshaper_sleep_in_earth_return"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        services.messages.add(ctx:expand_text(services.translate("As you recite the words of release, you feel yourself rising until you stand in the clear air once again.")), "good")
        return false
    end
    end
    COND["EOC_EARTHSHAPER_SLEEP_IN_EARTH_REMOVER"] = function(ctx)
        return (((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9)))) and (H.char_has_trait(H.u(ctx), "EARTHSHAPER_STONE_SLEEP") == 1))) == true
    end
    EOC["EOC_EARTHSHAPER_SLEEP_IN_EARTH_REMOVER"] = function(ctx)
    if (((not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == (-9)))) and (H.char_has_trait(H.u(ctx), "EARTHSHAPER_STONE_SLEEP") == 1))) then
        H.lose_trait(H.u(ctx), "EARTHSHAPER_STONE_SLEEP")
        return true
    end
    return false
    end
    COND["EOC_EARTHSHAPER_REPAIR_METAL_STONE_ITEM"] = function(ctx)
        return ((not (H.char_has_flag(H.npc(ctx), "NO_REPAIR")))) == true
    end
    EOC["EOC_EARTHSHAPER_REPAIR_METAL_STONE_ITEM"] = function(ctx)
    if ((not (H.char_has_flag(H.npc(ctx), "NO_REPAIR")))) then
        H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.npc(ctx), "bp_null", true) * ((H.char_spell_level(H.u(ctx), "earthshaper_repair_metal_stone") * 0.03) + 0.1)) * H._jm_channeling_proficiency_modifier(ctx)), "+=")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The magic simply does not take hold.  The item cannot be repaired, even with sorcery.")), "bad")
        return false
    end
    end
    EOC["EOC_EARTHSHAPER_REPAIR_METAL_STONE"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", nil, { { wielded_only = true }, {  }, {  }, {  }, {  }, {  }, {  }, {  }, {  } }, { "EOC_EARTHSHAPER_REPAIR_METAL_STONE_ITEM" }, {  })
    return true
    end
    EOC["EOC_EARTHSHAPER_EARTH_GATE_TELEPORT_CHECK"] = function(ctx)
    if ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("Select nearby earth to gate to.")), "neutral")
        if H.truthy((H.var_exists("context", nil, ctx, "earthshaper_earth_gate_location") and 1 or 0)) then
            if ((function() local p = H.get_tripoint_var("context", nil, ctx, "earthshaper_earth_gate_location"); local fg = H.safe_id('json_flag', "DIGGABLE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) then
                do local _p = H.get_tripoint_var("context", nil, ctx, "earthshaper_earth_gate_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
                services.messages.add(ctx:expand_text(services.translate("You sink into the earth and re-emerge nearby.")), "neutral")
            else
                services.messages.add(ctx:expand_text(services.translate("You must select a patch of earth to transport to.")), "neutral")
            end
        else
            services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
        end
    else
        services.messages.add(ctx:expand_text(services.translate("You must be on the living earth to use Earth Gate.")), "bad")
    end
    return true
    end
    EOC["EOC_EARTHSHAPER_REMOVE_CORPSES_HIT_CORPSES"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    EOC["EOC_EARTHSHAPER_REMOVE_CORPSES_PER_TILE"] = function(ctx)
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", H.get_tripoint_var("context", nil, ctx, "earthshaper_digging_point"), 0, 0, nil, { {  } }, { "EOC_EARTHSHAPER_REMOVE_CORPSES_HIT_CORPSES" })
    return true
    end
    EOC["EOC_EARTHSHAPER_REMOVE_CORPSES"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select diggable ground.")), "neutral")
    do local _o = H.get_tripoint_var("context", nil, ctx, "earthshaper_target_point"); if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(((H.char_spell_level(H.u(ctx), "earthshaper_remove_corpses") * 0.15) + 1)) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "earthshaper_digging_point", _p); if ((((function() local p = H.get_tripoint_var("context", nil, ctx, "earthshaper_target_point"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_rock_floor_no_roof" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "earthshaper_target_point"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_rock_floor" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "earthshaper_target_point"); local fg = H.safe_id('json_flag', "DIGGABLE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()))) then for _, _eid in ipairs({ "EOC_EARTHSHAPER_REMOVE_CORPSES_PER_TILE" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
    return true
    end
    COND["EOC_FERAL_MAGUS_PUSH_NEARBY_ENEMIES_BACK"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_FERAL_MAGUS_PUSH_NEARBY_ENEMIES_BACK"] = function(ctx)
    if (ctx:has_speaker()) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("context", nil, ctx, "push_nearby_enemies_power_level", 8)
        H.set_var("context", nil, ctx, "telekinesis_weight_ratio", 55)
        H.set_var("context", nil, ctx, "weight_ratio", ((((ctx:get_number("push_nearby_enemies_power_level") or 0) * (ctx:get_number("telekinesis_weight_ratio") or 0)) + ((ctx:get_number("telekinesis_weight_ratio") or 0) / 2)) / (H.creature_weight(H.u(ctx)) / 1000000)))
        H.set_var("context", nil, ctx, "telekinesis_shove_spell_level", H.clamp_num((((ctx:get_number("weight_ratio") or 0) - 1) * 1.5), 0, 20))
        if services.random.native_probability((((ctx:get_number("weight_ratio") or 0) * 1000)), (1000)) then
            H.eoc_add_effect(H.u(ctx), "downed", 2, nil, nil, nil)
        end
        if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor((ctx:get_number("telekinesis_shove_spell_level") or 0)), stun = math.floor(2), dam_mult = math.floor((1 + ((ctx:get_number("telekinesis_shove_spell_level") or 0) * 0.4))), direction = H.get_tripoint_var("context", nil, ctx, "player_position") }) end
        return true
    end
    return false
    end
    EOC["EOC_STAG_BEETLE_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_CALL_STAG_BEETLE"] == nil or E.cond["EOC_CALL_STAG_BEETLE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Call stag beetle for riding")), description = ctx:expand_text(services.translate("Call a stag beetle for riding.  Will respond if you haven't called for one in awhile.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_CALL_STAG_BEETLE" end end
        do local _en = (E.cond["EOC_CALL_FORAGING_BEETLES"] == nil or E.cond["EOC_CALL_FORAGING_BEETLES"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Call beetles for foraging")), description = ctx:expand_text(services.translate("Call local beetles to forage hidden areas around you.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_CALL_FORAGING_BEETLES" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_CALL_STAG_BEETLE"] = function(ctx)
    do local _g = H.safe_id('mutation', "MAG_STAG_BEETLE_BOND"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    do local _g = H.safe_id('mutation', "MAG_STAG_BEETLE_BOND"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, true) end end
    services.messages.add(ctx:expand_text(services.translate("The wildwood beetle makes its call.  You feel something large coming, and it is coming fast.")), "good")
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(5), math.floor(50); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SUMMON_STAG_BEETLE"), nil) end end
    do local _t = math.max(1, math.floor(28800)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_LOSE_STAG_BEETLE_BOND"), nil) end end
    do local _t = math.max(1, math.floor((function() local a, b = math.floor(25), math.floor(50); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SUMMON_MUSHROOMS"), nil) end end
    services.messages.add(ctx:expand_text(services.translate("The wildwood beetle makes its call, but only some small beetles respond.  They'll bring you a small gift.")), "good")
    return true
    end
    EOC["EOC_SUMMON_STAG_BEETLE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "mag_call_stag_beetle_real", false, { targeted = true, min_level = math.floor(1) })
    services.messages.add(ctx:expand_text(services.translate("The stag beetle arrives, it is massive and powerful.  It can be used to carry you and your belongings so long as you have a wildwood rune and the skill to ride it.")), "good")
    return true
    end
    EOC["EOC_SUMMON_MUSHROOMS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "mag_summon_mushrooms", false, { min_level = math.floor(1) })
    return true
    end
end
