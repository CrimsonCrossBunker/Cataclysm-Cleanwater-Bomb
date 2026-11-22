local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["bio_green_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "green" }, nil, nil)
    return true
    end
    EOC["bio_red_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "red" }, nil, nil)
    return true
    end
    EOC["bio_pink_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "pink" }, nil, nil)
    return true
    end
    EOC["bio_white_hair_dye"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You adjust the color of your artificial hair.")), "neutral")
    H.run_eoc("bio_change_hair_color", ctx, { ["color_id"] = "white" }, nil, nil)
    return true
    end
    COND["bio_change_hair_color"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "color_id"))) == true
    end
    EOC["bio_change_hair_color"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "color_id"))) then
        if (H.char_has_trait(H.u(ctx), "artificial_hair_buzzcut") == 1) then
            H.lose_trait(H.u(ctx), "artificial_hair_buzzcut")
            do local _g = H.safe_id('mutation', "artificial_hair_buzzcut"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
        else
            if (H.char_has_trait(H.u(ctx), "artificial_hair_crewcut") == 1) then
                H.lose_trait(H.u(ctx), "artificial_hair_crewcut")
                do local _g = H.safe_id('mutation', "artificial_hair_crewcut"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
            else
                if (H.char_has_trait(H.u(ctx), "artificial_hair_short") == 1) then
                    H.lose_trait(H.u(ctx), "artificial_hair_short")
                    do local _g = H.safe_id('mutation', "artificial_hair_short"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                else
                    if (H.char_has_trait(H.u(ctx), "artificial_hair_short_no_fringe") == 1) then
                        H.lose_trait(H.u(ctx), "artificial_hair_short_no_fringe")
                        do local _g = H.safe_id('mutation', "artificial_hair_short_no_fringe"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                    else
                        if (H.char_has_trait(H.u(ctx), "artificial_hair_short_over_eye") == 1) then
                            H.lose_trait(H.u(ctx), "artificial_hair_short_over_eye")
                            do local _g = H.safe_id('mutation', "artificial_hair_short_over_eye"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                        else
                            if ((H.char_has_trait(H.u(ctx), "artificial_hair_medium") == 1)) then
                                H.lose_trait(H.u(ctx), "artificial_hair_medium")
                                do local _g = H.safe_id('mutation', "artificial_hair_medium"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                            else
                                if (H.char_has_trait(H.u(ctx), "artificial_hair_mohawk") == 1) then
                                    H.lose_trait(H.u(ctx), "artificial_hair_mohawk")
                                    do local _g = H.safe_id('mutation', "artificial_hair_mohawk"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                else
                                    if (H.char_has_trait(H.u(ctx), "artificial_hair_long") == 1) then
                                        H.lose_trait(H.u(ctx), "artificial_hair_long")
                                        do local _g = H.safe_id('mutation', "artificial_hair_long"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                    else
                                        if (H.char_has_trait(H.u(ctx), "artificial_hair_long_mohawk") == 1) then
                                            H.lose_trait(H.u(ctx), "artificial_hair_long_mohawk")
                                            do local _g = H.safe_id('mutation', "artificial_hair_long_mohawk"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                        else
                                            if (H.char_has_trait(H.u(ctx), "artificial_hair_mullet") == 1) then
                                                H.lose_trait(H.u(ctx), "artificial_hair_mullet")
                                                do local _g = H.safe_id('mutation', "artificial_hair_mullet"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                            else
                                                if (H.char_has_trait(H.u(ctx), "artificial_hair_long_over_eye") == 1) then
                                                    H.lose_trait(H.u(ctx), "artificial_hair_long_over_eye")
                                                    do local _g = H.safe_id('mutation', "artificial_hair_long_over_eye"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                else
                                                    if ((H.char_has_trait(H.u(ctx), "artificial_hair_messy") == 1)) then
                                                        H.lose_trait(H.u(ctx), "artificial_hair_messy")
                                                        do local _g = H.safe_id('mutation', "artificial_hair_messy"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                    else
                                                        if ((H.char_has_trait(H.u(ctx), "artificial_hair_very_long") == 1)) then
                                                            H.lose_trait(H.u(ctx), "artificial_hair_very_long")
                                                            do local _g = H.safe_id('mutation', "artificial_hair_very_long"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                        else
                                                            if ((H.char_has_trait(H.u(ctx), "artificial_hair_extremely_long") == 1)) then
                                                                H.lose_trait(H.u(ctx), "artificial_hair_extremely_long")
                                                                do local _g = H.safe_id('mutation', "artificial_hair_extremely_long"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                            else
                                                                if ((H.char_has_trait(H.u(ctx), "artificial_hair_body_length") == 1)) then
                                                                    H.lose_trait(H.u(ctx), "artificial_hair_body_length")
                                                                    do local _g = H.safe_id('mutation', "artificial_hair_body_length"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    EOC["bio_barber_beard"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_BIO_ADJUST_YOUR_BEARD") end
    return true
    end
    COND["EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK"] = function(ctx)
        return (services.gameplay.mods.is_loaded("xedra_evolved")) == true
    end
    EOC["EOC_CONDITION_XE_YOU_ARE_FAIR_FOLK"] = function(ctx)
    if (services.gameplay.mods.is_loaded("xedra_evolved")) then
        return true
    end
    return false
    end
    EOC["EOC_RESET_DREAM_COUNTER"] = function(ctx)
    H.set_var("global", nil, ctx, "dream_counter", 0)
    return true
    end
    COND["EOC_GIVE_NIGHTMARES"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.global_var_num("dream_counter") == 0))) == true
    end
    EOC["EOC_GIVE_NIGHTMARES"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "nightmares"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.global_var_num("dream_counter") == 0))) then
        services.messages.add((services.snippets.native_random("nightmares") or ''), "bad")
        do local _g = H.safe_id('morale', "morale_nightmare"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(services.random.native_int(-30, -15)), math.floor(-30), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_GIVE_HEALTH_MESSAGE"] = function(ctx)
        return ((((not (((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) and (H.global_var_num("dream_counter") == 0))) == true
    end
    EOC["EOC_GIVE_HEALTH_MESSAGE"] = function(ctx)
    if ((((not (((function() local eg = H.safe_id('effect', "pre_common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "common_cold"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "pre_flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "flu"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) and (H.global_var_num("dream_counter") == 0))) then
        do
            local _sw4 = H.char_health(H.u(ctx))
            if _sw4 == -100 then
                services.messages.add((services.snippets.native_random("health_horrible") or ''), "bad")
            elseif _sw4 == -50 then
                services.messages.add((services.snippets.native_random("health_very_bad") or ''), "bad")
            elseif _sw4 == -10 then
                services.messages.add((services.snippets.native_random("health_bad") or ''), "bad")
            elseif _sw4 == 10 then
                services.messages.add(ctx:expand_text(services.translate("")), "neutral")
            elseif _sw4 == 50 then
                services.messages.add((services.snippets.native_random("health_good") or ''), "good")
            elseif _sw4 == 100 then
                services.messages.add((services.snippets.native_random("health_very_good") or ''), "good")
            elseif _sw4 == 200 then
                services.messages.add((services.snippets.native_random("health_great") or ''), "good")
            end
        end
        H.set_var("global", nil, ctx, "dream_counter", 1)
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_RESET_DREAM_COUNTER"), nil) end end
        return true
    end
    return false
    end
    COND["bad_food_mood_debuff"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "bad_food_ennui"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["bad_food_mood_debuff"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "bad_food_ennui"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _g = H.safe_id('morale', "morale_bad_protein_bar"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor((H.char_vitamin(H.u(ctx), "bad_food") / (-10))), math.floor((H.char_vitamin(H.u(ctx), "bad_food") / (-4))), { duration = services.time.duration_from_turns(math.floor(86400)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
        return true
    else
        do local _g = H.safe_id('morale', "morale_bad_protein_bar"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
        return false
    end
    end
    COND["eoc_social_satisfied"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CANNIBAL") == 1) and (H.char_has_trait(H.u(ctx), "PSYCHOPATH") == 1))) == true
    end
    EOC["eoc_social_satisfied"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CANNIBAL") == 1) and (H.char_has_trait(H.u(ctx), "PSYCHOPATH") == 1))) then
        do local _g = H.safe_id('morale', "morale_social"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(6), math.floor(6), { duration = services.time.duration_from_turns(math.floor(86400)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
        return true
    else
        do local _g = H.safe_id('morale', "morale_social"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
        return false
    end
    end
    COND["eoc_social_dissatisfied"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["eoc_social_dissatisfied"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _g = H.safe_id('morale', "morale_asocial"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor((H.creature_effect_intensity(H.u(ctx), "social_dissatisfied") * (-7))), math.floor(-21), { duration = services.time.duration_from_turns(math.floor(86400)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
        return true
    else
        do local _g = H.safe_id('morale', "morale_social_dissatisfied"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
        return false
    end
    end
    COND["eoc_asocial_satisfied"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "asocial_satisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["eoc_asocial_satisfied"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "asocial_satisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _g = H.safe_id('morale', "morale_asocial"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(10), math.floor(10), { duration = services.time.duration_from_turns(math.floor(86400)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
        return true
    else
        do local _g = H.safe_id('morale', "morale_asocial"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
        return false
    end
    end
    COND["eoc_asocial_dissatisfied"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "asocial_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["eoc_asocial_dissatisfied"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "asocial_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _g = H.safe_id('morale', "morale_social"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor((H.creature_effect_intensity(H.u(ctx), "asocial_dissatisfied") * (-7))), math.floor(-21), { duration = services.time.duration_from_turns(math.floor(86400)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
        return true
    else
        do local _g = H.safe_id('morale', "morale_asocial_dissatisfied"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
        return false
    end
    end
    COND["eoc_conjunctivitis_sting"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "conjunctivitis"); local bpg = ("eyes" ~= nil) and H.safe_id('body_part', "eyes") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["eoc_conjunctivitis_sting"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "conjunctivitis"); local bpg = ("eyes" ~= nil) and H.safe_id('body_part', "eyes") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "smoke_eyes", 300, "eyes", (H.creature_effect_intensity(H.u(ctx), "smoke_eyes", "eyes") + 1), nil)
        return true
    end
    return false
    end
    COND["EOC_dermatik_visible_INIT"] = function(ctx)
        return (((("dermatik") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_dermatik_visible_INIT"] = function(ctx)
    if (((("dermatik") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.copy_var("context", nil, "bodypart", "global", nil, "IMPREGNATED_BODYPART", ctx)
        return true
    end
    return false
    end
    COND["EOC_DERMATIK_BIRTH_INIT"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "dermatik_larva_size") >= 1440) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_DERMATIK_BIRTH_INIT"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "dermatik_larva_size") >= 1440) and services.random.native_probability((1), (3)))) then
        do local _eg = H.safe_id('effect', "dermatik"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_DERMATIK_BIRTH"] = function(ctx)
        return (((("dermatik") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_DERMATIK_BIRTH"] = function(ctx)
    if (((("dermatik") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        if (H.char_vitamin(H.u(ctx), "dermatik_larva_size") >= 1440) then
            if ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
                do local _eg = H.safe_id('effect', "sleep"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            end
            H.set_var("global", nil, ctx, "NUM_LARVA", H.char_val_extra(H.u(ctx), "size"))
            services.messages.add(ctx:expand_text(services.translate("<global_val:NUM_LARVA> dermatik larvae bursts out of the bulge of flesh on your <global_val:IMPREGNATED_BODYPART>!")), "bad")
            do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_dermatik_larva") or H.safe_id('monster_group', "mon_dermatik_larva"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(H.global_var_num("NUM_LARVA")), min_radius = math.floor(1), max_radius = math.floor(4) }); 
            end end
            do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('field', "fd_blood"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(1), intensity = math.floor(3) }) end end
            local _u5 = H.u(ctx)
            if _u5 then services.characters.adjust(_u5, { moves = -math.floor((6) * 100) }) end
            H.set_var("global", nil, ctx, "HOW_MUCH_WILL_THIS_SUCK", services.random.native_float(21, 30))
            do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (H.global_var_num("HOW_MUCH_WILL_THIS_SUCK") * 100); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (H.global_var_num("HOW_MUCH_WILL_THIS_SUCK") * 100); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            H.eoc_add_effect(H.u(ctx), "bleed", (H.global_var_num("HOW_MUCH_WILL_THIS_SUCK") * 60), H.var_str("global", nil, ctx, "IMPREGNATED_BODYPART", ""), nil, nil)
            local _a6 = H.u(ctx)
            if _a6 then services.characters.adjust(_a6, { pain = math.floor((H.global_var_num("HOW_MUCH_WILL_THIS_SUCK") * 2)) }) end
            H.set_char_hp(H.u(ctx), H.var_str("global", nil, ctx, "IMPREGNATED_BODYPART", ""), (H.global_var_num("HOW_MUCH_WILL_THIS_SUCK") * 2), "-=")
        else
            do local _a, _v = H.u(ctx), "mutant_toxin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (H.char_vitamin(H.u(ctx), "dermatik_larva_size") / 3); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        do local _eg = H.safe_id('effect', "dermatik_visible"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _a, _v = H.u(ctx), "dermatik_larva_size"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_DERMATIK_FORMICATION"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "dermatik"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and services.random.native_probability((1), (math.max(360, (2000 - H.char_vitamin(H.u(ctx), "dermatik_larva_size"))))))) == true
    end
    EOC["EOC_DERMATIK_FORMICATION"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "dermatik"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and services.random.native_probability((1), (math.max(360, (2000 - H.char_vitamin(H.u(ctx), "dermatik_larva_size"))))))) then
        services.messages.add(ctx:expand_text(services.translate("The growth in your <global_val:IMPREGNATED_BODYPART> itches!")), "bad")
        H.eoc_add_effect(H.u(ctx), "formication", 360, H.var_str("global", nil, ctx, "IMPREGNATED_BODYPART", ""), H.creature_effect_intensity(H.u(ctx), "dermatik_visible", H.var_str("global", nil, ctx, "IMPREGNATED_BODYPART", "")), nil)
        return true
    end
    return false
    end
    EOC["EOC_selector_test"] = function(ctx)
    H.set_var("context", nil, ctx, "title", services.translate("EOC Selector Test"))
    H.set_var("context", nil, ctx, "name", "name_3")
    H.set_var("context", nil, ctx, "description", services.translate("option 3"))
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_selector_test_1"] == nil or E.cond["EOC_selector_test_1"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("name_1")), description = ctx:expand_text(services.translate("option 1")), enabled = _en, hotkey = "a" }); _targets[tostring(1)] = "EOC_selector_test_1" end end
        do local _en = (E.cond["EOC_selector_test_2"] == nil or E.cond["EOC_selector_test_2"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("name_2")), description = ctx:expand_text(services.translate("option 2")), enabled = _en, hotkey = "b" }); _targets[tostring(2)] = "EOC_selector_test_2" end end
        do local _en = (E.cond["EOC_selector_test_3"] == nil or E.cond["EOC_selector_test_3"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("<context_val:name>")), description = ctx:expand_text(services.translate("<context_val:description>")), enabled = _en, hotkey = "c" }); _targets[tostring(3)] = "EOC_selector_test_3" end end
        do local _en = (E.cond["EOC_selector_test_4"] == nil or E.cond["EOC_selector_test_4"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("should_fail")), description = ctx:expand_text(services.translate("should not be available")), enabled = _en, hotkey = "d" }); _targets[tostring(4)] = "EOC_selector_test_4" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("<context_val:title>")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_selector_test_1"] = function(ctx)
    H.set_var("global", nil, ctx, "key1", 1)
    return true
    end
    EOC["EOC_selector_test_2"] = function(ctx)
    H.set_var("global", nil, ctx, "key1", 2)
    return true
    end
    EOC["EOC_selector_test_3"] = function(ctx)
    H.set_var("global", nil, ctx, "key1", (ctx:get_number("val") or 0))
    return true
    end
    COND["EOC_selector_test_4"] = function(ctx)
        return ((1 < 0)) == true
    end
    EOC["EOC_selector_test_4"] = function(ctx)
    if ((1 < 0)) then
        H.set_var("global", nil, ctx, "key1", (ctx:get_number("val") or 0))
        return true
    end
    return false
    end
    EOC["EOC_selector_test_hidden"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_selector_test_1"] == nil or E.cond["EOC_selector_test_1"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("name_1")), description = ctx:expand_text(services.translate("option 1")), enabled = _en, hotkey = "a" }); _targets[tostring(1)] = "EOC_selector_test_1" end end
        do local _en = (E.cond["EOC_selector_test_2"] == nil or E.cond["EOC_selector_test_2"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("name_2")), description = ctx:expand_text(services.translate("option 2")), enabled = _en, hotkey = "b" }); _targets[tostring(2)] = "EOC_selector_test_2" end end
        do local _en = (E.cond["EOC_selector_test_3"] == nil or E.cond["EOC_selector_test_3"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("name_3")), description = ctx:expand_text(services.translate("option 3")), enabled = _en, hotkey = "c" }); _targets[tostring(3)] = "EOC_selector_test_3" end end
        do local _en = (E.cond["EOC_selector_test_4"] == nil or E.cond["EOC_selector_test_4"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("should_fail")), description = ctx:expand_text(services.translate("should not be available")), enabled = _en, hotkey = "d" }); _targets[tostring(4)] = "EOC_selector_test_4" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_item_transporter_test"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_item_transporter_test_1"] == nil or E.cond["EOC_item_transporter_test_1"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Set coordinates")), description = ctx:expand_text(services.translate("Target current coordinates.")), enabled = _en, hotkey = "a" }); _targets[tostring(1)] = "EOC_item_transporter_test_1" end end
        do local _en = (E.cond["EOC_item_transporter_test_2"] == nil or E.cond["EOC_item_transporter_test_2"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Execute transport")), description = ctx:expand_text(services.translate("Transport items to target coordinates")), enabled = _en, hotkey = "b" }); _targets[tostring(2)] = "EOC_item_transporter_test_2" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_item_transporter_test_1"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "eoc_sample_item_transporter_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.set_var("actor", H.u(ctx), ctx, "eoc_sample_item_transporter_set_coordinates", "yes")
    services.messages.add(ctx:expand_text(services.translate("Set coordinates: <u_val:eoc_sample_item_transporter_loc>")), "neutral")
    return true
    end
    EOC["EOC_item_transporter_test_2_run"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Transported: <npc_name>")), "neutral")
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("actor", H.u(ctx), ctx, "eoc_sample_item_transporter_loc"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    return true
    end
    COND["EOC_item_transporter_test_2"] = function(ctx)
        return (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "eoc_sample_item_transporter_set_coordinates", ""))))) == true
    end
    EOC["EOC_item_transporter_test_2"] = function(ctx)
    if (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "eoc_sample_item_transporter_set_coordinates", ""))))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual_mult", ctx:expand_text(services.translate("Transport what?")), nil, { "EOC_item_transporter_test_2_run" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_variable_test"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("[Skill experience test]")), "neutral")
    H.set_var("actor", H.u(ctx), ctx, "skill_test", H.char_skill_exp(H.u(ctx), "swimming", false))
    services.messages.add(ctx:expand_text(services.translate("Swimming skill experience before: <u_val:skill_test>")), "neutral")
    local _a7 = H.u(ctx)
    local _sg8 = H.safe_id("skill", "swimming")
    if _a7 and _sg8 then services.skills.set(_a7, _sg8, { exercise_percent = math.floor((H.char_skill_exp(_a7, "swimming", false)) + (10)) }) end
    H.set_var("actor", H.u(ctx), ctx, "skill_test", H.char_skill_exp(H.u(ctx), "swimming", false))
    services.messages.add(ctx:expand_text(services.translate("Swimming skill experience after: <u_val:skill_test>")), "neutral")
    services.messages.add(ctx:expand_text(services.translate("[Weight and volume test]")), "neutral")
    H.run_eoc("EOC_variable_weight_volume_test1", ctx, nil, nil, nil)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, nil, { "EOC_variable_weight_volume_test2" }, {  })
    return true
    end
    EOC["EOC_variable_weight_volume_test1"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "weight_test", H.creature_weight(H.u(ctx)))
    H.set_var("actor", H.u(ctx), ctx, "volume_test", H.creature_volume(H.u(ctx)))
    services.messages.add(ctx:expand_text(services.translate("<u_name> weight: <u_val:weight_test> volume: <u_val:volume_test>")), "neutral")
    return true
    end
    EOC["EOC_variable_weight_volume_test2"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "weight_test", H.creature_weight(H.npc(ctx)))
    H.set_var("actor", H.u(ctx), ctx, "volume_test", H.creature_volume(H.npc(ctx)))
    services.messages.add(ctx:expand_text(services.translate("<npc_name> weight: <u_val:weight_test> volume: <u_val:volume_test>")), "neutral")
    return true
    end
    EOC["EOC_if_else_test"] = function(ctx)
    if ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "eoc_sample_if_else_test", "")))) then
        services.messages.add(ctx:expand_text(services.translate("You have variable.")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have variable.")), "neutral")
        if (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "eoc_sample_if_else_test", "")))))) then
            H.set_var("actor", H.u(ctx), ctx, "eoc_sample_if_else_test", "yes")
            services.messages.add(ctx:expand_text(services.translate("Variable added.")), "neutral")
        end
    end
    return true
    end
    COND["EOC_has_any_test"] = function(ctx)
        return (((function() local bpg = H.safe_id('body_part', "torso"); return (H.safe_id('effect', "hot") ~= nil and services.effects.has(H.u(ctx), H.safe_id('effect', "hot"), bpg).value == true) or (H.safe_id('effect', "cold") ~= nil and services.effects.has(H.u(ctx), H.safe_id('effect', "cold"), bpg).value == true) end)())) == true
    end
    EOC["EOC_has_any_test"] = function(ctx)
    if (((function() local bpg = H.safe_id('body_part', "torso"); return (H.safe_id('effect', "hot") ~= nil and services.effects.has(H.u(ctx), H.safe_id('effect', "hot"), bpg).value == true) or (H.safe_id('effect', "cold") ~= nil and services.effects.has(H.u(ctx), H.safe_id('effect', "cold"), bpg).value == true) end)())) then
        services.messages.add(ctx:expand_text(services.translate("You are hot or cold.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You are not hot or cold.")), "neutral")
        return false
    end
    end
    EOC["EOC_spawn_npc_test"] = function(ctx)
    H.spawn_npc(H.u(ctx), "NPC_debug", { min_radius = math.floor(1), max_radius = math.floor(3) }, nil)
    return true
    end
    COND["EOC_event_character_dies_test"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DEBUG_PREVENT_DEATH") == 1)) == true
    end
    EOC["EOC_event_character_dies_test"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DEBUG_PREVENT_DEATH") == 1)) then
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        return true
    end
    return false
    end
    EOC["EOC_map_item_test_run"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("context", nil, ctx, "loc"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    return true
    end
    EOC["EOC_map_item_test1"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "manual_mult", H.get_tripoint_var("context", nil, ctx, "loc"), 1, 10, ctx:expand_text(services.translate("Test: Item collection")), nil, { "EOC_map_item_test_run" })
    services.messages.add(ctx:expand_text(services.translate("Items rolled at your feet.")), "neutral")
    return true
    end
    EOC["EOC_map_item_test2"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, { dy = math.floor(1) }, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("context", nil, ctx, "loc"); local _g = H.safe_id('item', "bottle_plastic"); if _p and _g then services.world.spawn_item(_p, _g, math.floor(1)) end end
    return true
    end
    EOC["EOC_map_condition_test"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "check_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_loc"); return p ~= nil and services.overmap.is_in_city(p) == true end)()) then
        services.messages.add(ctx:expand_text(services.translate("Inside city")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Outside city")), "neutral")
    end
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, { dy = math.floor(-1) }, false, true, {  }, {  })
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("North terrain: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("North terrain: Not TRANSPARENT")), "neutral")
    end
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.furniture_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("North furniture: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("North furniture: Not TRANSPARENT")), "neutral")
    end
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, { dx = math.floor(1) }, false, true, {  }, {  })
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("East terrain: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("East terrain: Not TRANSPARENT")), "neutral")
    end
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.furniture_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("East furniture: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("East furniture: Not TRANSPARENT")), "neutral")
    end
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, { dy = math.floor(1) }, false, true, {  }, {  })
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("South terrain: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("South terrain: Not TRANSPARENT")), "neutral")
    end
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.furniture_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("South furniture: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("South furniture: Not TRANSPARENT")), "neutral")
    end
    H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, nil, { dx = math.floor(-1) }, false, true, {  }, {  })
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("West terrain: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("West terrain: Not TRANSPARENT")), "neutral")
    end
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "loc"); local fg = H.safe_id('json_flag', "TRANSPARENT"); return p ~= nil and fg ~= nil and services.gameplay.environment.furniture_has_flag(p, fg) end)()) then
        services.messages.add(ctx:expand_text(services.translate("West furniture: TRANSPARENT")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("West furniture: Not TRANSPARENT")), "neutral")
    end
    return true
    end
    EOC["EOC_foreach_test"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("[foreach_test]id of flags")), "neutral")
    do
        local _arr = {}; local _pg = services.registry.list("json_flag", { limit = 5000 }); if _pg and _pg.items then for _, e in ipairs(_pg.items) do table.insert(_arr, e.id and e.id.value or tostring(e)) end end
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "id", _v)
            services.messages.add(ctx:expand_text(services.translate("<context_val:id>")), "neutral")
        end
    end
    services.messages.add(ctx:expand_text(services.translate("[foreach_test]item group")), "neutral")
    do
        local _arr = {}; local _g = H.safe_id('item_group', "forest"); if _g then for _, e in ipairs(services.items.possible_from_group(_g) or {}) do table.insert(_arr, e.value or tostring(e)) end end
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "id", _v)
            services.messages.add(ctx:expand_text(services.translate("<context_val:id>")), "neutral")
        end
    end
    services.messages.add(ctx:expand_text(services.translate("[foreach_test]monster group")), "neutral")
    do
        local _arr = {}; local _g = H.safe_id('monster_group', "GROUP_ANIMALPOUND_DOGS"); if _g then local r = services.spawns.group_members(_g); if r.ok and r.value then for _, e in ipairs(r.value) do table.insert(_arr, e.id and e.id.value or tostring(e)) end end end
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "id", _v)
            services.messages.add(ctx:expand_text(services.translate("<context_val:id>")), "neutral")
        end
    end
    services.messages.add(ctx:expand_text(services.translate("[foreach_test]string array")), "neutral")
    do
        local _arr = { "a", "b", "c", "d", "e" }
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "id", _v)
            services.messages.add(ctx:expand_text(services.translate("<context_val:id>")), "neutral")
        end
    end
    return true
    end
    EOC["EOC_armor_info_test_nested"] = function(ctx)
    H.set_var("context", nil, ctx, "coverage", H.char_coverage(H.npc(ctx), H.var_str("context", nil, ctx, "id", "")))
    H.set_var("context", nil, ctx, "encumbrance", H.char_encumbrance(H.npc(ctx), H.var_str("context", nil, ctx, "id", "")))
    if ((ctx:get_number("coverage") or 0) > 0) then
        services.messages.add(ctx:expand_text(services.translate("  <npc_name>")), "neutral")
        services.messages.add(ctx:expand_text(services.translate("  coverage:<context_val:coverage>")), "neutral")
        services.messages.add(ctx:expand_text(services.translate("  encumbrance:<context_val:encumbrance>")), "neutral")
    end
    return true
    end
    EOC["EOC_armor_info_test"] = function(ctx)
    do
        local _arr = {}; local _pg = services.registry.list("body_part", { limit = 5000 }); if _pg and _pg.items then for _, e in ipairs(_pg.items) do table.insert(_arr, e.id and e.id.value or tostring(e)) end end
        for _, _v in ipairs(_arr) do
            H.set_var("context", nil, ctx, "id", _v)
            services.messages.add(ctx:expand_text(services.translate("[<context_val:id>]")), "neutral")
            H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "EOC_armor_info_test_nested" }, {  })
        end
    end
    return true
    end
    EOC["EOC_query_tile_test_anywhere"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select point")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "pos") and 1 or 0)) then
        services.messages.add(ctx:expand_text(services.translate("<context_val:pos>")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_query_tile_test_line_of_sight"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select point")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "pos") and 1 or 0)) then
        services.messages.add(ctx:expand_text(services.translate("<context_val:pos>")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_query_tile_test_around"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Choose direction")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "pos") and 1 or 0)) then
        services.messages.add(ctx:expand_text(services.translate("<context_val:pos>")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    COND["EOC_player_see_test_nest"] = function(ctx)
        return ((H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true)) == true
    end
    EOC["EOC_player_see_test_nest"] = function(ctx)
    if ((H.u(ctx) ~= nil and services.creatures.player_can_see(H.u(ctx)).value == true)) then
        services.messages.add(ctx:expand_text(services.translate("You can see <u_name>.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You can't see <u_name>.")), "neutral")
        return false
    end
    end
    EOC["EOC_player_see_test"] = function(ctx)
    do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_player_see_test_nest" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
    return true
    end
    COND["EOC_can_see_location_test_nest"] = function(ctx)
        return (((function() local p = H.get_tripoint_var("context", nil, ctx, "pos"); return H.u(ctx) ~= nil and p ~= nil and services.characters.can_see_location(H.u(ctx), p).value == true end)())) == true
    end
    EOC["EOC_can_see_location_test_nest"] = function(ctx)
    if (((function() local p = H.get_tripoint_var("context", nil, ctx, "pos"); return H.u(ctx) ~= nil and p ~= nil and services.characters.can_see_location(H.u(ctx), p).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("<u_name> can see <context_val:pos>.")), "neutral")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("<u_name> can't see <context_val:pos>.")), "neutral")
        return false
    end
    end
    EOC["EOC_can_see_location_test"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select point")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "pos") and 1 or 0)) then
        if ((function() local p = H.get_tripoint_var("context", nil, ctx, "pos"); return H.u(ctx) ~= nil and p ~= nil and services.characters.can_see_location(H.u(ctx), p).value == true end)()) then
            services.messages.add(ctx:expand_text(services.translate("You can see <context_val:pos>.")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("You can't see <context_val:pos>.")), "neutral")
        end
        do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_can_see_location_test_nest" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_teleport_test"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_teleport_test_setloc"] == nil or E.cond["EOC_teleport_test_setloc"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Set location")), description = ctx:expand_text(services.translate("Set location")), enabled = _en, hotkey = "a" }); _targets[tostring(1)] = "EOC_teleport_test_setloc" end end
        do local _en = (E.cond["EOC_teleport_test_do"] == nil or E.cond["EOC_teleport_test_do"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Teleport")), description = ctx:expand_text(services.translate("Teleport")), enabled = _en, hotkey = "b" }); _targets[tostring(2)] = "EOC_teleport_test_do" end end
        do local _en = (E.cond["EOC_teleport_test_other"] == nil or E.cond["EOC_teleport_test_other"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Teleport other")), description = ctx:expand_text(services.translate("Teleport other")), enabled = _en, hotkey = "c" }); _targets[tostring(3)] = "EOC_teleport_test_other" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_teleport_test_setloc"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select point")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "teleport_test_pos") and 1 or 0)) then
        services.messages.add(ctx:expand_text(services.translate("<context_val:pos>")), "neutral")
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_teleport_test_do"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "teleport_test_pos"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    EOC["EOC_teleport_test_other_do"] = function(ctx)
    do local _t, _p = H.npc(ctx), H.get_tripoint_var("global", nil, ctx, "teleport_test_pos"); if _t and _p then local cs = H.creature_snap(_t); if cs then services.relocation.teleport_creature(_t, _p, nil) else services.relocation.teleport_item(_t, _p) end end end
    return true
    end
    EOC["EOC_teleport_test_other"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select point")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "loc") and 1 or 0)) then
        H.run_eoc("EOC_teleport_test_other_do", ctx, nil, nil, nil)
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["EOC_control_npc_test"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_control_npc"] == nil or E.cond["EOC_control_npc"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Control an NPC")), description = ctx:expand_text(services.translate("Control an NPC")), enabled = _en, hotkey = "a" }); _targets[tostring(1)] = "EOC_control_npc" end end
        do local _en = (E.cond["EOC_return_to_player"] == nil or E.cond["EOC_return_to_player"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Return to Player")), description = ctx:expand_text(services.translate("Return to Player")), enabled = _en, hotkey = "b" }); _targets[tostring(2)] = "EOC_return_to_player" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["_EOC_control_npc_do"] = function(ctx)
    if ((H.char_snap(H.npc(ctx)) or {}).npc == true) then
        H.run_eoc("follow", ctx)
        H.run_eoc("take_control", ctx)
    else
        services.messages.add(ctx:expand_text(services.translate("Please select an NPC.")), "neutral")
    end
    return true
    end
    EOC["EOC_control_npc"] = function(ctx)
    do local _s = H.char_snap(H.u(ctx)); if _s and _s.id then H.set_var("global", nil, ctx, "player_id", _s.id) end end
    services.messages.add(ctx:expand_text(services.translate("Select point")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "loc") and 1 or 0)) then
        H.run_eoc("_EOC_control_npc_do", ctx, nil, nil, nil)
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    return true
    end
    EOC["_EOC_return_to_player_do"] = function(ctx)
    H.run_eoc("follow", ctx)
    H.run_eoc("take_control", ctx)
    return true
    end
end
