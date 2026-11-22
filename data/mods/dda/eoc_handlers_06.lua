local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_PORTAL_DEPENDENT_STUN"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("For a brief moment, you feel rejected by the world.")), "bad")
    H.eoc_add_effect(H.u(ctx), "stunned", 1, nil, nil, nil)
    return true
    end
    COND["EOC_PORTAL_DEPENDENT_DOWNED"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_DOWNED"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Gravity suddenly exerts immense pressure, forcing you to the ground!")), "bad")
        H.eoc_add_effect(H.u(ctx), "downed", 1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_DAMAGE_CONSTANT"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_DAMAGE_CONSTANT"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Your vision suddenly fills with cold sparks.  You feel so alone…")), "bad")
        H.eoc_add_effect(H.u(ctx), "pd_rejection", 900, nil, 2, nil)
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_PAIN_CONSTANT"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_PAIN_CONSTANT"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("Faint sparks surround your body as you suffer with every action you take, as if you weren't intended to do them.")), "bad")
        H.eoc_add_effect(H.u(ctx), "pd_rejection", 420, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_DEPENDENT_PAIN"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Faint sparks suddenly appear and disappear around you, as if rejecting your very existence.  Pain flares across your body.")), "bad")
    local _a18 = H.u(ctx)
    if _a18 then services.characters.adjust(_a18, { pain = math.floor(10) }) end
    return true
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_BAD_AWAKE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_BAD_AWAKE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_VARIED_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_STR_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_DEX_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_PER_BAD"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "EOC_PORTAL_DEPENDENT_MESSAGES_INT_BAD"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    else
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_DREAMS") or ''), "mixed")
        return false
    end
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_BAD"] = function(ctx)
    H.run_eoc("EOC_PORTAL_DEPENDENT_MESSAGES_BAD_AWAKE", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_VARIED_BAD"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_VARIED_BAD"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_VARIED_BAD") or ''), "mixed")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_STR_BAD"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_STR_BAD"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_STR_BAD") or ''), "mixed")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_DEX_BAD"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_DEX_BAD"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_DEX_BAD") or ''), "mixed")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_PER_BAD"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_PER_BAD"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_PER_BAD") or ''), "mixed")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_MESSAGES_INT_BAD"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_MESSAGES_INT_BAD"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        services.messages.add((services.snippets.native_random("PORTAL_DEPENDENT_MESSAGES_INT_BAD") or ''), "mixed")
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD"] = function(ctx)
    do
        local _sw19 = H.global_var_num("portal_dungeon_level")
        if _sw19 == 0 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_0"); table.insert(_wts, math.max(0, 16))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_1"); table.insert(_wts, math.max(0, 3))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_2"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw19 == 1 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_0"); table.insert(_wts, math.max(0, 6))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_1"); table.insert(_wts, math.max(0, 12))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_2"); table.insert(_wts, math.max(0, 2))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw19 == 2 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_0"); table.insert(_wts, math.max(0, 1))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_1"); table.insert(_wts, math.max(0, 5))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_2"); table.insert(_wts, math.max(0, 12))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"); table.insert(_wts, math.max(0, 2))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw19 == 3 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_1"); table.insert(_wts, math.max(0, 2))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_2"); table.insert(_wts, math.max(0, 5))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"); table.insert(_wts, math.max(0, 12))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw19 == 4 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_2"); table.insert(_wts, math.max(0, 2))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"); table.insert(_wts, math.max(0, 6))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"); table.insert(_wts, math.max(0, 12))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        end
    end
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_0"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You feel invigorated by what you just experienced, so…  What is this feeling of regret for leaving that place?")), "good")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(40), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_1"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You feel like the shackles of your body are loosening a little.  The world seems to accept your distorted presence for now.  You wonder if what you currently feel would have been greater if only you had gone deeper…")), "good")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(40), { duration = services.time.duration_from_turns(math.floor(10800)), decay_start = services.time.duration_from_turns(math.floor(4800)) }) end end
    H.eoc_add_effect(H.u(ctx), "pd_strengthened_reality", 172800, nil, nil, nil)
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_2"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel in calm, your body a little faster, and your surroundings less hostile than what you remember.  Before this new sensation passes away though, you hear a little voice in your head saying \"deeper…\"")), "good")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(40), { duration = services.time.duration_from_turns(math.floor(14400)), decay_start = services.time.duration_from_turns(math.floor(6000)) }) end end
    H.eoc_add_effect(H.u(ctx), "pd_strengthened_reality", 432000, nil, 2, nil)
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You return to your reality with a sense of ecstasy, your body feels great, your shackles have come loose and you feel powerful because of it.  But you can feel it, this exhilarating feeling is only the beginning, you need to go deeper…")), "good")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(25), math.floor(40), { duration = services.time.duration_from_turns(math.floor(15600)), decay_start = services.time.duration_from_turns(math.floor(7200)) }) end end
    H.eoc_add_effect(H.u(ctx), "pd_strengthened_reality", 691200, nil, 3, nil)
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You feel in communion with the world around you, the world is no longer rejecting you, at least for now, YOU are rejecting IT.  Your whole body craves for what you could have gained if only you had gone a little deeper…")), "good")
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(25), math.floor(40), { duration = services.time.duration_from_turns(math.floor(16800)), decay_start = services.time.duration_from_turns(math.floor(8400)) }) end end
    H.eoc_add_effect(H.u(ctx), "pd_strengthened_reality", 950400, nil, 4, nil)
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_FINAL_REWARD"] = function(ctx)
    do
        local _sw20 = H.global_var_num("portal_dungeon_level")
        if _sw20 == 5 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"); table.insert(_wts, math.max(0, 6))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"); table.insert(_wts, math.max(0, 10))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_5"); table.insert(_wts, math.max(0, 4))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw20 == 6 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"); table.insert(_wts, math.max(0, 4))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"); table.insert(_wts, math.max(0, 8))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_5"); table.insert(_wts, math.max(0, 8))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw20 == 7 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_3"); table.insert(_wts, math.max(0, 1))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"); table.insert(_wts, math.max(0, 6))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_5"); table.insert(_wts, math.max(0, 13))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw20 == 8 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_4"); table.insert(_wts, math.max(0, 2))
                table.insert(_ids, "EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_5"); table.insert(_wts, math.max(0, 18))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
        elseif _sw20 == 9 then
            H.run_eoc("EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_5", ctx, nil, nil, nil)
        end
    end
    return true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON_REWARD_5"] = function(ctx)
    if (not ((H.char_has_trait(H.u(ctx), "REALITY_GRASP") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("You suddenly feel a profound sense of belonging take root inside you, spreading throughout your body.  It fades quickly, but something warm remains…")), "good")
        do local _g = H.safe_id('mutation', "REALITY_GRASP"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    else
        services.messages.add(ctx:expand_text(services.translate("You suddenly feel a profound sense of belonging take root inside you, temporally amplifying your grasp of reality.  For some time you will be the master of your surroundings.")), "good")
        H.eoc_add_effect(H.u(ctx), "pd_strengthened_reality", 1209600, nil, 4, nil)
    end
    do local _g = H.safe_id('morale', "morale_feeling_good"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(30), math.floor(60), { duration = services.time.duration_from_turns(math.floor(18000)), decay_start = services.time.duration_from_turns(math.floor(9000)) }) end end
    return true
    end
    COND["EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF"] = function(ctx)
        return ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))) == true
    end
    EOC["EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF"] = function(ctx)
    if ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "PORTAL_PROOF") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "PORTAL_PROOF")).value == true)))) then
        return true
    end
    return false
    end
    COND["EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR"] = function(ctx)
        return ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true)))) == true
    end
    EOC["EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR"] = function(ctx)
    if ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true)))) then
        return true
    end
    return false
    end
    COND["EOC_CANCEL_PORTAL_STORM"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or (H.global_var_num("cause_portal_storm") == 1) or (H.global_var_num("cause_early_portal_storm") == 1))) == true
    end
    EOC["EOC_CANCEL_PORTAL_STORM"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or (H.global_var_num("cause_portal_storm") == 1) or (H.global_var_num("cause_early_portal_storm") == 1))) then
        H.set_var("global", nil, ctx, "cause_portal_storm", 0)
        H.set_var("global", nil, ctx, "cause_early_portal_storm", 0)
        H.set_var("global", nil, ctx, "portal_dungeon_slow_strength", 0)
        H.set_var("global", nil, ctx, "portal_dungeon_carry_strength", 0)
        H.set_var("global", nil, ctx, "portal_dungeon_reflect_strength", 0)
        services.weather.request_update()
        services.messages.add(ctx:expand_text(services.translate("As suddenly as it began, the portal storm fades.  Reality returns to normal.  Hopefully the scarring is minimal…")), "good")
        H.set_var("actor", H.u(ctx), ctx, "global_portal_storms_u_witnessed_portal_storm", "yes")
        H.run_eoc("EOC_WORSEN_PORTAL_STORM", ctx, nil, nil, nil)
        H.run_eoc("EOC_PORTAL_STORM_DUNGEON_EXIT", ctx, nil, nil, nil)
        do local _mid = "MISSION_INVESTIGATE_PORTAL_DUNGEON"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        do local _mid = "MISSION_INVESTIGATE_PORTAL_STORM_CENTER"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        services.time.reschedule("portal_dungeon_entrance", services.time.duration_from_turns(0))
        H.set_var("actor", H.u(ctx), ctx, "counter_portal_storm_counter", (H.var_num(H.u(ctx), "counter_portal_storm_counter")) + (1))
        H.set_var("global", nil, ctx, "talked_to_storm", 0)
        services.native_events.emit("u_var_changed", { "portal_storm_counter", H.var_str("actor", H.u(ctx), ctx, "counter_portal_storm_counter", "") })
        return true
    end
    return false
    end
    EOC["EOC_WORSEN_PORTAL_STORM"] = function(ctx)
    do
        local _ids, _wts = {}, {}
        table.insert(_ids, "EOC_PORTAL_STRENGTHEN"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "EOC_PORTAL_LENGTHEN"); table.insert(_wts, math.max(0, 1))
        table.insert(_ids, "EOC_PORTAL_EXPAND"); table.insert(_wts, math.max(0, 3))
        local _wi = services.random.weighted_index(_wts)
        if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
    end
    return true
    end
    EOC["EOC_PORTAL_STRENGTHEN"] = function(ctx)
    H.set_var("global", nil, ctx, "ps_base_str", math.min((H.global_var_num("ps_base_str") + 1), 8))
    return true
    end
    EOC["EOC_PORTAL_LENGTHEN"] = function(ctx)
    H.set_var("global", nil, ctx, "ps_min_length", math.min(14400, ((H.var_exists("global", nil, ctx, "ps_min_length") and H.global_var_num("ps_min_length") or (7200)) + 900)))
    H.set_var("global", nil, ctx, "ps_max_length", math.min(21600, ((H.var_exists("global", nil, ctx, "ps_max_length") and H.global_var_num("ps_max_length") or (14400)) + 900)))
    return true
    end
    COND["EOC_PORTAL_EXPAND"] = function(ctx)
        return ((H.global_var_num("portal_storm_distance") ~= 0)) == true
    end
    EOC["EOC_PORTAL_EXPAND"] = function(ctx)
    if ((H.global_var_num("portal_storm_distance") ~= 0)) then
        H.set_var("global", nil, ctx, "portal_storm_distant_distance", (H.global_var_num("portal_storm_distant_distance")) + (1))
        H.set_var("global", nil, ctx, "portal_storm_close_distance", (H.global_var_num("portal_storm_close_distance")) + (1))
        H.set_var("global", nil, ctx, "portal_storm_distance", (H.global_var_num("portal_storm_distance")) + (1))
        return true
    else
        H.set_var("global", nil, ctx, "portal_storm_distant_distance", 201)
        H.set_var("global", nil, ctx, "portal_storm_close_distance", 101)
        H.set_var("global", nil, ctx, "portal_storm_distance", 51)
        return false
    end
    end
    COND["EOC_PORTAL_TELEPORT_STUCK_START"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_PORTAL_TELEPORT_STUCK_START"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "stuck_teleport", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.run_eoc("EOC_PORTAL_TELEPORT_STUCK", ctx, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("The moment feels thick, as if it's not quite over.")), "bad")
        H.set_var("actor", H.u(ctx), ctx, "ire", (H.var_num(H.u(ctx), "ire")) - (2))
        return true
    end
    return false
    end
    COND["EOC_PORTAL_TELEPORT_STUCK_LOOP"] = function(ctx)
        return ((services.random.native_probability((3), (4)) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_PORTAL_TELEPORT_STUCK_LOOP"] = function(ctx)
    if ((services.random.native_probability((3), (4)) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        H.run_eoc("EOC_PORTAL_TELEPORT_STUCK", ctx, nil, nil, nil)
        return true
    else
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "stuck_teleport"); if _p then services.sound.emit(_p, math.floor(80), "alert", ctx:expand_text(services.translate("a loud tearing sound.")), false) end end
        return false
    end
    end
    COND["EOC_PORTAL_TELEPORT_STUCK"] = function(ctx)
        return (((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (H.global_var_num("portal_dungeon_level") == 0))) == true
    end
    EOC["EOC_PORTAL_TELEPORT_STUCK"] = function(ctx)
    if (((not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (H.global_var_num("portal_dungeon_level") == 0))) then
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "stuck_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(3), math.floor(5); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_TELEPORT_STUCK_LOOP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_INCORPOREAL"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_PORTAL_INCORPOREAL"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel stretched, as if part of you was elsewhere.  You are not solid enough to affect matter, and your equipment falls through you.")))
        H.eoc_add_effect(H.u(ctx), "incorporeal", (H.global_var_num("ps_str") * 1), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PORTAL_STORM_POPUP"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and services.random.native_probability((1), (250)))) == true
    end
    EOC["EOC_PORTAL_STORM_POPUP"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and services.random.native_probability((1), (250)))) then
        services.messages.add((services.snippets.native_random("PORTAL_STORM_POPUP") or ''), "neutral")
        services.activities.offer_interruption((services.snippets.native_random("PORTAL_STORM_POPUP") or ''))
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_STORM_CELL_TELEPORT"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "in_portal_cell", 0)
    do local _p = H.get_tripoint_var("global", nil, ctx, "original_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    services.messages.add(ctx:expand_text(services.translate("You came back.  This time.")), "neutral")
    return true
    end
    COND["EOC_PORTAL_STORM_CELL"] = function(ctx)
        return (((H.var_num(H.u(ctx), "in_portal_cell") == 0) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_PORTAL_STORM_CELL"] = function(ctx)
    if (((H.var_num(H.u(ctx), "in_portal_cell") == 0) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "global", "original_loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "cell_loc", nil, nil, nil, nil, { dz = math.floor(6) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "cell_roof_loc", nil, nil, nil, nil, { dz = math.floor(7) }, true, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "cell_time", (300 + services.random.native_int(0, H.round_half_away(60))))
        H.set_var("actor", H.u(ctx), ctx, "in_portal_cell", 1)
        do local _p = H.get_tripoint_var("global", nil, ctx, "cell_loc"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor((((H.var_num(H.u(ctx), "cell_time")) ~= 0) and (H.var_num(H.u(ctx), "cell_time")) or 60))), "") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "cell_loc"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = (((H.var_num(H.u(ctx), "cell_time")) ~= 0) and (H.var_num(H.u(ctx), "cell_time")) or 60); if _tr.ok and _tr.value then for _, _uid in ipairs({ "portal_cell_cleanup" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "place_name", ((function() local _t = { services.translate("Somewhere"), services.translate("Nowhere"), services.translate("Everywhere"), services.translate("Yesterday"), services.translate("Tomorrow") }; return _t[services.random.native_int(1, #_t)] end)()))
        services.world.override_place_name(H.var_str("global", nil, ctx, "place_name", "1 minutes"), services.time.duration_from_turns(math.floor((((H.var_num(H.u(ctx), "cell_time")) ~= 0) and (H.var_num(H.u(ctx), "cell_time")) or 60))))
        do local _p = H.get_tripoint_var("global", nil, ctx, "cell_roof_loc"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor((((H.var_num(H.u(ctx), "cell_time")) ~= 0) and (H.var_num(H.u(ctx), "cell_time")) or 60))), "") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "cell_roof_loc"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "portal_cell_roof" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "cell_loc"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "portal_cell" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "cell_start"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _t = math.max(1, math.floor((((H.var_num(H.u(ctx), "cell_time")) ~= 0) and (H.var_num(H.u(ctx), "cell_time")) or 60))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PORTAL_STORM_CELL_TELEPORT"), nil) end end
        services.messages.add(ctx:expand_text(services.translate("You are trapped in <global_val:place_name>!")), "neutral")
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_STORM_MAPGEN"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "portal_dungeon", { terrain = "field" }, { z = math.floor(0), min_distance = math.floor(3) }, nil, nil, nil, false, true, {  }, {  })
    services.messages.add(ctx:expand_text(services.translate("You can feel the presence of something nearby, cracked in a way you can't put into words (check mission log for details).")), "neutral")
    do local _g = H.safe_id('mission', "MISSION_INVESTIGATE_PORTAL_DUNGEON"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
    do local _p = H.get_tripoint_var("global", nil, ctx, "portal_dungeon"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "portal_dungeon_entrance") end end
    do local _p = H.get_tripoint_var("global", nil, ctx, "portal_dungeon"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "portal_dungeon_entrance" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    COND["EOC_PORTAL_STORM_SHADOW_SPAWN"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TAINTED_SHADOW") == 1) and (H.mons_nearby(H.u(ctx), { "mon_tainted_shadow" }, 1000, nil) < 1))) == true
    end
    EOC["EOC_PORTAL_STORM_SHADOW_SPAWN"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TAINTED_SHADOW") == 1) and (H.mons_nearby(H.u(ctx), { "mon_tainted_shadow" }, 1000, nil) < 1))) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_tainted_shadow") or H.safe_id('monster_group', "mon_tainted_shadow"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(2), max_radius = math.floor(3), friendly = true }); 
            if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("Your shadow is no longer attached to you.")), 'warning') end
        end end
        return true
    end
    return false
    end
    COND["EOC_PORTAL_DEPENDENT_DUNGEON"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1)) == true
    end
    EOC["EOC_PORTAL_DEPENDENT_DUNGEON"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1)) then
        H.run_eoc("EOC_PORTAL_DEPENDENT_DUNGEON_REWARD", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_DUNGEON_REWARD"] = function(ctx)
    do
        local _sw21 = H.global_var_num("portal_dungeon_level")
        if _sw21 == 15 then
            do
                local _ids, _wts = {}, {}
                table.insert(_ids, "EOC_PORTAL_DUNGEON_REWARD_WEAKENED_INERTIA"); table.insert(_wts, math.max(0, 1))
                table.insert(_ids, "EOC_PORTAL_DUNGEON_REWARD_WARPED_VIEWPOINT"); table.insert(_wts, math.max(0, 1))
                table.insert(_ids, "EOC_PORTAL_DUNGEON_REWARD_WEAKENED_GRAVITY"); table.insert(_wts, math.max(0, 1))
                local _wi = services.random.weighted_index(_wts)
                if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
            end
            H.run_eoc("EOC_PORTAL_DEPENDENT_DUNGEON", ctx, nil, nil, nil)
        end
    end
    return true
    end
    EOC["EOC_PORTAL_DUNGEON_REWARD_WEAKENED_INERTIA"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "weakened_inertia", ((H.global_var_num("portal_dungeon_level") + services.random.native_float((-1), 1)) * 86400), nil, nil, nil)
    return true
    end
    EOC["EOC_PORTAL_DUNGEON_REWARD_WARPED_VIEWPOINT"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "warped_viewpoint", ((H.global_var_num("portal_dungeon_level") + services.random.native_float((-1), 1)) * 86400), nil, nil, nil)
    return true
    end
    EOC["EOC_PORTAL_DUNGEON_REWARD_WEAKENED_GRAVITY"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "weakened_gravity", ((H.global_var_num("portal_dungeon_level") + services.random.native_float((-1), 1)) * 86400), nil, nil, nil)
    return true
    end
    COND["EOC_PORTAL_TELEPORT_UNSTABLE_RIFT"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_PORTAL_TELEPORT_UNSTABLE_RIFT"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "unstable_teleport", nil, nil, nil, { min_radius = math.floor(30), max_radius = math.floor(70) }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "unstable_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        H.run_eoc("EOC_PORTAL_DUNGEON_PUNISHMENT", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PORTAL_DUNGEON_PUNISHMENT"] = function(ctx)
    H.set_var("global", nil, ctx, "ps_effect_length", 10800)
    do
        local _ids, _wts = {}, {}
        table.insert(_ids, "EOC_PORTAL_DUNGEON_PUNISHMENT_STRENGTHENED_INERTIA"); table.insert(_wts, math.max(0, 10))
        table.insert(_ids, "EOC_PORTAL_DUNGEON_PUNISHMENT_NARROW_VIEWPOINT"); table.insert(_wts, math.max(0, 10))
        local _wi = services.random.weighted_index(_wts)
        if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
    end
    return true
    end
    EOC["EOC_PORTAL_DUNGEON_PUNISHMENT_STRENGTHENED_INERTIA"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "strengthened_inertia", H.global_var_num("ps_effect_length"), nil, nil, nil)
    return true
    end
    EOC["EOC_PORTAL_DUNGEON_PUNISHMENT_NARROW_VIEWPOINT"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "narrow_viewpoint", H.global_var_num("ps_effect_length"), nil, nil, nil)
    return true
    end
    COND["cat_ears_portal_storm"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "FELINE_EARS") == 1)))) == true
    end
    EOC["cat_ears_portal_storm"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "FELINE_EARS") == 1)))) then
        services.messages.add(ctx:expand_text(services.translate("It didn't take very long for the ears to be back.")), "info")
        do local _g = H.safe_id('mutation', "FELINE_EARS"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["MAKAYLA_MUTATOR_portal_storm"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") and (H.char_has_trait(H.u(ctx), "MAKAYLA_MUTATOR") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["MAKAYLA_MUTATOR_portal_storm"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") and (H.char_has_trait(H.u(ctx), "MAKAYLA_MUTATOR") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        services.messages.add(ctx:expand_text(services.translate("Everything feels fuzzy.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_feline"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 450; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 750; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.run_eoc("cat_ears_portal_storm", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["capture_generic_nre_anomaly"] = function(ctx)
        return ((H.char_has_items(H.u(ctx), "nre_recorder", math.floor(0), math.floor(1)) or H.char_has_items(H.u(ctx), "robofac_mobile_weather_station", math.floor(0), math.floor(1)))) == true
    end
    EOC["capture_generic_nre_anomaly"] = function(ctx)
    if ((H.char_has_items(H.u(ctx), "nre_recorder", math.floor(0), math.floor(1)) or H.char_has_items(H.u(ctx), "robofac_mobile_weather_station", math.floor(0), math.floor(1)))) then
        H.set_var("actor", H.u(ctx), ctx, "generic_nre_anomaly", (H.var_num(H.u(ctx), "generic_nre_anomaly")) + (1))
        services.messages.add(ctx:expand_text(services.translate("The NRE recorder emits a sharp beep!")), "info")
        return true
    end
    return false
    end
    COND["EOC_PORTAL_INNER_CABINS"] = function(ctx)
        return ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) == true
    end
    EOC["EOC_PORTAL_INNER_CABINS"] = function(ctx)
    if ((H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_DIMENSIONAL_ANCHOR", ctx) and (not ((((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true))))) then
        do local _dr = services.relocation.travel_to_dimension("inner_cabins", { npc_travel_radius = math.floor(0), npc_travel_filter = "none" })
            if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("Your surroundings warp and fold.")), 'good') end
            if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("You experience brief vertigo, but nothing dangerous seems to happen.")), 'bad') end
        end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "inner_cabins_home_loc", { terrain = "inner_cabins_cabin" }, { special = H.safe_id('overmap_special', "inner_cabins_cabin") }, { kind = "furniture", id = H.safe_id("furniture", "f_bed") }, { target_max_radius = math.floor(20) }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "inner_cabins_home_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        ccb.presentation.notice(ctx:expand_text(services.translate("You dream you can fly over a vast plain of grass, mist in the air, clouds obscuring the sun.  You see \"home,\" whatever that means.  But there are other places.  Sad places.  And a dark place.\n\nAre you a traveler?  An explorer?  Do you find them?  Or do you enjoy your time here?  Do you just sleep it away?\n\nYou awake in bed.")))
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(300), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_1"), nil) end end
        H.set_var("global", nil, ctx, "interstice_counter", 600)
        H.set_var("global", nil, ctx, "previous_interstice_counter", 600)
        do local _g = H.safe_id('mutation', "INTERSTICE_SHRINKING"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(60), math.floor(120); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_INTERSTICE_COUNTER"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_1"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_1"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_2"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  This place look exactly like you remember.  Yet, you don't recall ever being here.  Something has changed from how it was just a moment ago.  You feel it.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  This place look exactly like you remember.  Yet, you don't recall ever being here.  Something has changed from how it was just a moment ago.  You feel it.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_2"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_2"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_3"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  The sky here is a perfect grey gradient.  It doesn't change, only deepens.  The world has transformed in some way.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  The sky here is a perfect grey gradient.  It doesn't change, only deepens.  The world has transformed in some way.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_3"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_3"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_3" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_4"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  Something creaks in your mind's ear.  It sounds more like settling than aging.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  Something creaks in your mind's ear.  It sounds more like settling than aging.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_4"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_4"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_4" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_5"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  The air here smells clean.  Just… clean.  Something has changed.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  The air here smells clean.  Just… clean.  Something has changed.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_5"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_5"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_5" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_6"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  For a moment, you feel like you're supposed to think about something.  It passes.  Something is different.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  For a moment, you feel like you're supposed to think about something.  It passes.  Something is different.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_6"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_6"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_6" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_7"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  It's warmer today.  Emotionally.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  It's warmer today.  Emotionally.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_7"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_7"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_7" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_8"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  There's a faint sense of waiting.  Not yours.  Something in this place has changed.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  There's a faint sense of waiting.  Not yours.  Something in this place has changed.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_8"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_8"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_8" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_9"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  Lights soften a moment and stays there.  This place spites the dark, as if it has just transformed itself.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  Lights soften a moment and stays there.  This place spites the dark, as if it has just transformed itself.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_9"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_9"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_9" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_10"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  You think about leaving, but the world doesn't suggest a direction.  Yet, something is different, today.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  You think about leaving, but the world doesn't suggest a direction.  Yet, something is different, today.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_10"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_10"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_10" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(172800), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_UPDATE_EXIT_11"), nil) end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  You feel like you've been here longer than you have.  Have you?  Something has changed in this world.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  You feel like you've been here longer than you have.  Have you?  Something has changed in this world.")))
        return true
    end
    return false
    end
    COND["EOC_INNER_CABINS_UPDATE_EXIT_11"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_UPDATE_EXIT_11"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "inner_cabins_void_exit"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "inner_cabins_void_exit_11" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Something causes you to stop and reflect.  This place seems exactly the same, today.  You almost wish it didn't.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("Something causes you to stop and reflect.  This place seems exactly the same, today.  You almost wish it didn't.")))
        return true
    end
    return false
    end
end
