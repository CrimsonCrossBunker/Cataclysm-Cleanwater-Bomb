local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_boomer_bile_affliction"] = function(ctx)
        return ((((("boomered") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_boomer_bile_affliction"] = function(ctx)
    if ((((("boomered") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        H.set_var("global", nil, ctx, "BILE_STINK_DURATION", (((H.char_effect_dur(H.u(ctx), "bile_stink", "") > 0)) and ((H.char_effect_dur(H.u(ctx), "bile_stink", "") + 300)) or (600)))
        H.set_var("global", nil, ctx, "MORALE_MULTIPLIER", ((H.truthy(H.char_has_trait(H.u(ctx), "SQUEAMISH"))) and ((-2)) or ((-1))))
        H.eoc_add_effect(H.u(ctx), "bile_stink", H.global_var_num("BILE_STINK_DURATION"), nil, nil, nil)
        if (not ((H.char_has_flag(H.u(ctx), "IRRITANT_IMMUNE") or (H.u(ctx) ~= nil and H.safe_id('json_flag', "IRRITANT_IMMUNE") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "IRRITANT_IMMUNE")).value == true)))) then
            H.set_var("global", nil, ctx, "BILE_IRRITANT_DURATION", (((H.char_effect_dur(H.u(ctx), "bile_irritant", "") > 0)) and (((H.char_effect_dur(H.u(ctx), "bile_irritant", "") + 120) + services.random.native_int(0, H.round_half_away(90)))) or ((240 + services.random.native_int(0, H.round_half_away(180))))))
            H.set_var("global", nil, ctx, "MORALE_MULTIPLIER", (H.global_var_num("MORALE_MULTIPLIER")) * (((H.truthy(H.char_has_trait(H.u(ctx), "SQUEAMISH"))) and (4) or (2))))
            H.eoc_add_effect(H.u(ctx), "bile_irritant", H.global_var_num("BILE_IRRITANT_DURATION"), nil, nil, nil)
        end
        if (not (H.char_has_any_trait(H.u(ctx), { "SAPROVORE", "EATDEAD", "THRESH_SLIME" }))) then
            do local _g = H.safe_id('morale', "morale_bile"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor((H.global_var_num("MORALE_MULTIPLIER") * 3)), math.floor((H.global_var_num("MORALE_MULTIPLIER") * 6)), { duration = services.time.duration_from_turns(math.floor(H.global_var_num("BILE_STINK_DURATION"))), decay_start = services.time.duration_from_turns(math.floor((H.global_var_num("BILE_STINK_DURATION") / 2))) }) end end
        else
            do local _g = H.safe_id('morale', "morale_bile"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(H.global_var_num("MORALE_MULTIPLIER")), math.floor((H.global_var_num("MORALE_MULTIPLIER") * 2)), { duration = services.time.duration_from_turns(math.floor((H.global_var_num("BILE_STINK_DURATION") / 2))), decay_start = services.time.duration_from_turns(math.floor((H.global_var_num("BILE_STINK_DURATION") / 4))) }) end end
        end
        return true
    end
    return false
    end
    COND["sunrise_morale_buff"] = function(ctx)
        return (((services.gameplay.environment.dimension() == "default") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and H.test_eoc("EOC_CONDITION_XE_SUNRISE_MORALE_OVERRIDES", ctx))) == true
    end
    EOC["sunrise_morale_buff"] = function(ctx)
    if (((services.gameplay.environment.dimension() == "default") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and H.test_eoc("EOC_CONDITION_XE_SUNRISE_MORALE_OVERRIDES", ctx))) then
        if (((services.weather.current().weather and services.weather.current().weather.value) == "sunny") or ((services.weather.current().weather and services.weather.current().weather.value) == "clear")) then
            if ((H.char_has_trait(H.u(ctx), "SPIRITUAL") == 1) and services.random.native_probability((1), (2))) then
                services.messages.add(ctx:expand_text(services.translate("As you gaze upon the sunrise, you feel enraptured by its ethereal beauty.")), "good")
                do local _g = H.safe_id('morale', "morale_sunrise"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(15), math.floor(15), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
            else
                if services.random.native_probability((1), (5)) then
                    services.messages.add(ctx:expand_text(services.translate("The sunrise is especially beautiful today.")), "good")
                    do local _g = H.safe_id('morale', "morale_sunrise"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(15), math.floor(15), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
                else
                    services.messages.add(ctx:expand_text(services.translate("The sunrise always makes you a feel a little bit better.")), "good")
                    do local _g = H.safe_id('morale', "morale_sunrise"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(10), math.floor(10), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
                end
            end
        else
            services.messages.add(ctx:expand_text(services.translate("The sunrise is hidden behind clouds, but it is still a bright, new day.")), "good")
            do local _g = H.safe_id('morale', "morale_sunrise"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(5), math.floor(5), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_CONDITION_XE_SUNRISE_MORALE_OVERRIDES"] = function(ctx)
        return ((0 == 0)) == true
    end
    EOC["EOC_CONDITION_XE_SUNRISE_MORALE_OVERRIDES"] = function(ctx)
    if ((0 == 0)) then
        return true
    end
    return false
    end
    COND["sunset_morale_buff"] = function(ctx)
        return (((services.gameplay.environment.dimension() == "default") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and H.test_eoc("EOC_CONDITION_XE_SUNSET_MORALE_OVERRIDES", ctx))) == true
    end
    EOC["sunset_morale_buff"] = function(ctx)
    if (((services.gameplay.environment.dimension() == "default") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and H.test_eoc("EOC_CONDITION_XE_SUNSET_MORALE_OVERRIDES", ctx))) then
        if (((services.weather.current().weather and services.weather.current().weather.value) == "sunny") or ((services.weather.current().weather and services.weather.current().weather.value) == "clear")) then
            if ((H.char_has_trait(H.u(ctx), "SPIRITUAL") == 1) and services.random.native_probability((1), (2))) then
                services.messages.add(ctx:expand_text(services.translate("As you gaze upon the sunset, you feel enraptured by its ethereal beauty.")), "good")
                do local _g = H.safe_id('morale', "morale_sunset"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(15), math.floor(15), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
            else
                if services.random.native_probability((1), (5)) then
                    services.messages.add(ctx:expand_text(services.translate("The sunset is especially beautiful today.")), "good")
                    do local _g = H.safe_id('morale', "morale_sunset"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(15), math.floor(15), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
                else
                    services.messages.add(ctx:expand_text(services.translate("The sunset always makes you a feel a little bit better.")), "good")
                    do local _g = H.safe_id('morale', "morale_sunset"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(10), math.floor(10), { duration = services.time.duration_from_turns(math.floor(7200)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
                end
            end
        else
            services.messages.add(ctx:expand_text(services.translate("The sunset is hidden behind clouds, but you can still see the pretty amber hue.")), "good")
            do local _g = H.safe_id('morale', "morale_sunset"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(5), math.floor(5), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_CONDITION_XE_SUNSET_MORALE_OVERRIDES"] = function(ctx)
        return ((0 == 0)) == true
    end
    EOC["EOC_CONDITION_XE_SUNSET_MORALE_OVERRIDES"] = function(ctx)
    if ((0 == 0)) then
        return true
    end
    return false
    end
    COND["target_valid_drink"] = function(ctx)
        return (((not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MAMMAL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "BIRD")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "REPTILE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FISH")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "KRAKEN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MUTANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MUTANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CENTIPEDE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SPIDER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MOLLUSK")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "WORM")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))))))) == true
    end
    EOC["target_valid_drink"] = function(ctx)
    if (((not (H.char_has_flag(H.npc(ctx), "BLEED_IMMUNE"))) and (not ((H.char_has_trait(H.npc(ctx), "ACIDBLOOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CRUSTACEAN") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_INSECT") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_CEPHALOPOD") == 1))) and (not ((H.char_has_trait(H.npc(ctx), "THRESH_GASTROPOD") == 1))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MAMMAL")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "BIRD")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "REPTILE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FISH")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "KRAKEN") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "KRAKEN")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MUTANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MUTANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "FUNGUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "FUNGUS")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SLIME") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SLIME")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CENTIPEDE")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SPIDER")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MOLLUSK")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "WORM")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "HORROR") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HORROR")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ABERRATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ABERRATION")).value == true))))))) then
        return true
    end
    return false
    end
    COND["changing_initiate_check"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "mutagen") >= 450) and (not (H.char_has_flag(H.u(ctx), "CHANGING"))))) == true
    end
    EOC["changing_initiate_check"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "mutagen") >= 450) and (not (H.char_has_flag(H.u(ctx), "CHANGING"))))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "changing_failed"); table.insert(_wts, math.max(0, 2500))
            table.insert(_ids, "changing_successful"); table.insert(_wts, math.max(0, H.char_vitamin(H.u(ctx), "mutagen")))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    COND["changing_failed"] = function(ctx)
        return (services.random.native_probability(1, (4))) == true
    end
    EOC["changing_failed"] = function(ctx)
    if (services.random.native_probability(1, (4))) then
        services.messages.add(ctx:expand_text(services.translate("<CHANGING_FAILED>")), "bad")
        return true
    end
    return false
    end
    EOC["changing_successful"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("<CHANGING_SUCCESS>")), "mixed")
    do local _g = H.safe_id('mutation', "CHANGING"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
    return true
    end
    COND["changing_reqs_not_met"] = function(ctx)
        return (services.random.native_probability(1, (3))) == true
    end
    EOC["changing_reqs_not_met"] = function(ctx)
    if (services.random.native_probability(1, (3))) then
        services.messages.add(ctx:expand_text(services.translate("<CHANGING_ENDS>")), "bad")
        H.lose_trait(H.u(ctx), "CHANGING")
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["changing_mutate2"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "mutagen") >= 300)) == true
    end
    EOC["changing_mutate2"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "mutagen") >= 300)) then
        services.messages.add(ctx:expand_text(services.translate("You feel a deep, churning sensation fill your body.")), "mixed")
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 60; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = services.random.native_int(0, H.round_half_away(80)); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    else
        H.run_eoc("changing_reqs_not_met", ctx, nil, nil, nil)
        return false
    end
    end
    COND["changing_mutate"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "CHANGING"))) == true
    end
    EOC["changing_mutate"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "CHANGING"))) then
        H.run_eoc("changing_mutate2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_GENERIC_SPELL_MUTATION"] = function(ctx)
        return (((H.var_exists('context', nil, ctx, "prep_time") and H.var_exists('context', nil, ctx, "spell_to_cast") and H.var_exists('context', nil, ctx, "message_success") and H.var_exists('context', nil, ctx, "message_fail")) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0) > (ctx:get_number("energy_amount") or 0)))) == true
    end
    EOC["EOC_GENERIC_SPELL_MUTATION"] = function(ctx)
    if (((H.var_exists('context', nil, ctx, "prep_time") and H.var_exists('context', nil, ctx, "spell_to_cast") and H.var_exists('context', nil, ctx, "message_success") and H.var_exists('context', nil, ctx, "message_fail")) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0) > (ctx:get_number("energy_amount") or 0)))) then
        local _u10 = H.u(ctx)
        if _u10 then services.characters.adjust(_u10, { moves = -math.floor(((ctx:get_number("prep_time") or 0)) * 100) }) end
        H.set_char_val_extra(H.u(ctx), "stamina", (ctx:get_number("energy_amount") or 0), "-=")
        H.run_eoc("EOC_GENERIC_SPELL_MUTATION_ACT", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(H.var_str("context", nil, ctx, "message_fail", ""), "bad")
        return false
    end
    end
    EOC["EOC_GENERIC_SPELL_MUTATION_ACT"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), H.var_str("context", nil, ctx, "spell_to_cast", ""), false, { targeted = true, message = H.var_str("context", nil, ctx, "message_success", "") })
    return true
    end
    EOC["EOC_BIOLUM3_activated"] = function(ctx)
    H.run_eoc("EOC_GENERIC_SPELL_MUTATION", ctx, { ["prep_time"] = 3, ["spell_to_cast"] = "spell_spit_flare", ["message_success"] = services.translate("You launch a glob of bioluminescent material!"), ["message_fail"] = services.translate("Your body is too starved to activate your bioluminescent flare.") }, nil, nil)
    return true
    end
    COND["EOC_MUTE_BIRD_GAIN"] = function(ctx)
        return ((((("BEAK") == (H.var_str("context", nil, ctx, "trait", "")))) and (H.char_vitamin(H.u(ctx), "mutagen_bird") > H.char_vitamin(H.u(ctx), "mutagen_cephalopod")))) == true
    end
    EOC["EOC_MUTE_BIRD_GAIN"] = function(ctx)
    if ((((("BEAK") == (H.var_str("context", nil, ctx, "trait", "")))) and (H.char_vitamin(H.u(ctx), "mutagen_bird") > H.char_vitamin(H.u(ctx), "mutagen_cephalopod")))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_bird")
        do local _g = H.safe_id('mutation', "MUTE_BIRD"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_CEPHALOPOD_GAIN"] = function(ctx)
        return ((((("BEAK") == (H.var_str("context", nil, ctx, "trait", "")))) and (H.char_vitamin(H.u(ctx), "mutagen_bird") < H.char_vitamin(H.u(ctx), "mutagen_cephalopod")))) == true
    end
    EOC["EOC_MUTE_CEPHALOPOD_GAIN"] = function(ctx)
    if ((((("BEAK") == (H.var_str("context", nil, ctx, "trait", "")))) and (H.char_vitamin(H.u(ctx), "mutagen_bird") < H.char_vitamin(H.u(ctx), "mutagen_cephalopod")))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_ceph")
        do local _g = H.safe_id('mutation', "MUTE_CEPH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_GASTROPOD_GAIN"] = function(ctx)
        return ((((("GASTROPOD_EXTREMITY2") == (H.var_str("context", nil, ctx, "trait", "")))) and (not ((H.char_has_trait(H.u(ctx), "MUTE_GASTROPOD_OK") == 1))) and (not ((H.char_has_trait(H.u(ctx), "MUTE_GASTROPOD") == 1))))) == true
    end
    EOC["EOC_MUTE_GASTROPOD_GAIN"] = function(ctx)
    if ((((("GASTROPOD_EXTREMITY2") == (H.var_str("context", nil, ctx, "trait", "")))) and (not ((H.char_has_trait(H.u(ctx), "MUTE_GASTROPOD_OK") == 1))) and (not ((H.char_has_trait(H.u(ctx), "MUTE_GASTROPOD") == 1))))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_gastropod")
        do local _g = H.safe_id('mutation', "MUTE_GASTROPOD"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_INSECT_GAIN"] = function(ctx)
        return (((("PROBOSCIS") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_MUTE_INSECT_GAIN"] = function(ctx)
    if (((("PROBOSCIS") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_insect")
        do local _g = H.safe_id('mutation', "MUTE_INSECT"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_SLIME_GAIN"] = function(ctx)
        return (((("AMORPHOUS") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_MUTE_SLIME_GAIN"] = function(ctx)
    if (((("AMORPHOUS") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_slime")
        do local _g = H.safe_id('mutation', "MUTE_SLIME"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_BEAK_LOSE_1"] = function(ctx)
        return ((((("BEAK") == (H.var_str("context", nil, ctx, "trait", "")))))) == true
    end
    EOC["EOC_MUTE_BEAK_LOSE_1"] = function(ctx)
    if ((((("BEAK") == (H.var_str("context", nil, ctx, "trait", "")))))) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MUTE_BEAK_LOSE_2"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_BEAK_LOSE_2"] = function(ctx)
        return ((not (H.char_has_any_trait(H.u(ctx), { "BEAK_HUM", "BEAK_PECK" })))) == true
    end
    EOC["EOC_MUTE_BEAK_LOSE_2"] = function(ctx)
    if ((not (H.char_has_any_trait(H.u(ctx), { "BEAK_HUM", "BEAK_PECK" })))) then
        do local _g = H.safe_id('recipe', "prac_unmute_bird"); if H.u(ctx) and _g then services.recipes.forget(H.u(ctx), _g) end end
        do local _g = H.safe_id('recipe', "prac_unmute_ceph"); if H.u(ctx) and _g then services.recipes.forget(H.u(ctx), _g) end end
        H.lose_trait(H.u(ctx), "MUTE_BIRD")
        H.lose_trait(H.u(ctx), "MUTE_BIRD_OK")
        H.lose_trait(H.u(ctx), "MUTE_CEPH")
        H.lose_trait(H.u(ctx), "MUTE_CEPH_OK")
        H.set_var("actor", H.u(ctx), ctx, "progress_unmute_bird", 0)
        H.set_var("actor", H.u(ctx), ctx, "progress_unmute_ceph", 0)
        services.messages.add(ctx:expand_text(services.translate("You grasp at the base of your beak and feel the familiar contours of your old mouth.  You give it a try and your voice sounds almost like before.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_MUTE_GASTROPOD_LOSE_1"] = function(ctx)
        return ((((("GASTROPOD_EXTREMITY2") == (H.var_str("context", nil, ctx, "trait", "")))) or ((("GASTROPOD_EXTREMITY3") == (H.var_str("context", nil, ctx, "trait", "")))))) == true
    end
    EOC["EOC_MUTE_GASTROPOD_LOSE_1"] = function(ctx)
    if ((((("GASTROPOD_EXTREMITY2") == (H.var_str("context", nil, ctx, "trait", "")))) or ((("GASTROPOD_EXTREMITY3") == (H.var_str("context", nil, ctx, "trait", "")))))) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MUTE_GASTROPOD_LOSE_2"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_MUTE_GASTROPOD_LOSE_2"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "GASTROPOD_EXTREMITY3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "GASTROPOD_EXTREMITY_2") == 1))))) == true
    end
    EOC["EOC_MUTE_GASTROPOD_LOSE_2"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "GASTROPOD_EXTREMITY3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "GASTROPOD_EXTREMITY_2") == 1))))) then
        do local _g = H.safe_id('recipe', "prac_unmute_gastropod"); if H.u(ctx) and _g then services.recipes.forget(H.u(ctx), _g) end end
        H.lose_trait(H.u(ctx), "MUTE_GASTROPOD")
        H.lose_trait(H.u(ctx), "MUTE_GASTROPOD_OK")
        services.messages.add(ctx:expand_text(services.translate("You cough up a lot of off-color blood, but you swear in your own old voice again afterwards.")), "neutral")
        H.set_var("actor", H.u(ctx), ctx, "progress_unmute_gastropod", 0)
        return true
    end
    return false
    end
    COND["EOC_MUTE_DEXTEROUS_PAWS_GAIN"] = function(ctx)
        return ((((("PAWS_LITTLE") == (H.var_str("context", nil, ctx, "trait", "")))) or ((("PAWS_RAT") == (H.var_str("context", nil, ctx, "trait", "")))))) == true
    end
    EOC["EOC_MUTE_DEXTEROUS_PAWS_GAIN"] = function(ctx)
    if ((((("PAWS_LITTLE") == (H.var_str("context", nil, ctx, "trait", "")))) or ((("PAWS_RAT") == (H.var_str("context", nil, ctx, "trait", "")))))) then
        H.learn_recipe(H.u(ctx), "prac_dextrous_paws")
        return true
    end
    return false
    end
    COND["EOC_DEXTROUS_PAWS_LOSE"] = function(ctx)
        return ((((("PAWS_LITTLE") == (H.var_str("context", nil, ctx, "trait", "")))) or ((("PAWS_RAT") == (H.var_str("context", nil, ctx, "trait", "")))))) == true
    end
    EOC["EOC_DEXTROUS_PAWS_LOSE"] = function(ctx)
    if ((((("PAWS_LITTLE") == (H.var_str("context", nil, ctx, "trait", "")))) or ((("PAWS_RAT") == (H.var_str("context", nil, ctx, "trait", "")))))) then
        do local _g = H.safe_id('recipe', "prac_dextrous_paws"); if H.u(ctx) and _g then services.recipes.forget(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "progress_dextrous_paws_usage", 0)
        services.messages.add(ctx:expand_text(services.translate("You've got your old fingers back.  They feel almost hypermobile compared to before.")), "neutral")
        return true
    end
    return false
    end
    COND["mut_eyestalk"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "EYESTALKS1") == 1) and (not ((((function() local eg = H.safe_id('effect', "visuals"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))))) == true
    end
    EOC["mut_eyestalk"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "EYESTALKS1") == 1) and (not ((((function() local eg = H.safe_id('effect', "visuals"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))))) then
        services.messages.add(ctx:expand_text(services.translate("Your vision inverts!")), "bad")
        services.sound.play_if_audible("pixelated", "bionics", math.floor(50))
        H.eoc_add_effect(H.u(ctx), "visuals", 600, nil, nil, nil)
        return true
    end
    return false
    end
    COND["chitin2_molt_timer1"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1))))) == true
    end
    EOC["chitin2_molt_timer1"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "molting", -1, nil, 1, nil)
        return true
    end
    return false
    end
    COND["chitin2_molt_timer2"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1))))) == true
    end
    EOC["chitin2_molt_timer2"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "molting_imminent", -1, nil, 1, nil)
        do local _eg = H.safe_id('effect', "molting"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["chitin2_molt_timer_3"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1))))) == true
    end
    EOC["chitin2_molt_timer_3"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1))))) then
        H.eoc_add_effect(H.u(ctx), "narcosis", 300, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "sleep", 300, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Your exoskeleton grows steadily more rigid until you can no longer move.  You strain against it for a few minutes, and it peels and cracks away in chunks like a plaster mold, revealing a soft and tender new layer beneath.")), "bad")
        H.lose_trait(H.u(ctx), "CHITIN2")
        H.lose_trait(H.u(ctx), "CHITIN")
        do local _eg = H.safe_id('effect', "molting_imminent"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_spawn_item(H.u(ctx), "chitin_piece", 3, false, false, nil)
        do local _g = H.safe_id('mutation', "CHITIN_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN2_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["chitin2_molt_timer4"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2_MOLTED") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3_MOLTED") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE_MOLTED") == 1))))) == true
    end
    EOC["chitin2_molt_timer4"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2_MOLTED") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "CHITIN3_MOLTED") == 1))) and (not ((H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE_MOLTED") == 1))))) then
        services.messages.add(ctx:expand_text(services.translate("Your exoskeleton has finished hardening.")), "good")
        H.lose_trait(H.u(ctx), "CHITIN_MOLTED")
        H.lose_trait(H.u(ctx), "CHITIN2_MOLTED")
        do local _g = H.safe_id('mutation', "CHITIN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN2"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["chitin3_molt_timer1"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1) or (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1)) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["chitin3_molt_timer1"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1) or (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1)) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "molting", -1, nil, 1, nil)
        return true
    end
    return false
    end
    COND["chitin3_molt_timer2"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1) or (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1)) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["chitin3_molt_timer2"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and ((H.char_has_trait(H.u(ctx), "CHITIN3") == 1) or (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1)) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "molting_imminent", -1, nil, 1, nil)
        do local _eg = H.safe_id('effect', "molting"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["chitin3_molt_timer3"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and (H.char_has_trait(H.u(ctx), "CHITIN3") == 1) and ((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["chitin3_molt_timer3"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and (H.char_has_trait(H.u(ctx), "CHITIN3") == 1) and ((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "narcosis", 900, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "sleep", 900, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Your exoskeleton locks up around you like a straitjacket, completely immobilizing you.  As you try to move, you begin to feel it painlessly rip, opening a hole through which you can slowly emerge, raw, soft, and vulnerable.")), "bad")
        H.lose_trait(H.u(ctx), "CHITIN3")
        H.lose_trait(H.u(ctx), "CHITIN2")
        H.lose_trait(H.u(ctx), "CHITIN")
        do local _eg = H.safe_id('effect', "molting_imminent"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_spawn_item(H.u(ctx), "chitin_piece", 4, false, false, nil)
        do local _g = H.safe_id('mutation', "CHITIN_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN2_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN3_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["chitin3_molt_timer4"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2_MOLTED") == 1) and (H.char_has_trait(H.u(ctx), "CHITIN3_MOLTED") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["chitin3_molt_timer4"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2_MOLTED") == 1) and (H.char_has_trait(H.u(ctx), "CHITIN3_MOLTED") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("Your exoskeleton has finished hardening.")), "good")
        H.lose_trait(H.u(ctx), "CHITIN3_MOLTED")
        H.lose_trait(H.u(ctx), "CHITIN2_MOLTED")
        H.lose_trait(H.u(ctx), "CHITIN_MOLTED")
        do local _g = H.safe_id('mutation', "CHITIN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN2"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN3"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["chitin_carapace_molt_timer3"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1) and ((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["chitin_carapace_molt_timer3"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2") == 1) and (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE") == 1) and ((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "narcosis", 900, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "sleep", 900, nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Your exoskeleton locks up around you like a straitjacket, completely immobilizing you.  As you try to move, you begin to feel it painlessly rip, opening a hole through which you can slowly emerge, raw, soft, and vulnerable.")), "bad")
        H.lose_trait(H.u(ctx), "CRUSTACEAN_CARAPACE")
        H.lose_trait(H.u(ctx), "CHITIN2")
        H.lose_trait(H.u(ctx), "CHITIN")
        do local _eg = H.safe_id('effect', "molting_imminent"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_spawn_item(H.u(ctx), "chitin_piece", 5, false, false, nil)
        do local _g = H.safe_id('mutation', "CHITIN_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN2_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CRUSTACEAN_CARAPACE_MOLTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["chitin_carapace_molt_timer4"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHITIN2_MOLTED") == 1) and (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE_MOLTED") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["chitin_carapace_molt_timer4"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHITIN2_MOLTED") == 1) and (H.char_has_trait(H.u(ctx), "CRUSTACEAN_CARAPACE_MOLTED") == 1) and (not (((function() local eg = H.safe_id('effect', "molting"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "molting_imminent"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("Your exoskeleton has finished hardening.")), "good")
        H.lose_trait(H.u(ctx), "CRUSTACEAN_CARAPACE_MOLTED")
        H.lose_trait(H.u(ctx), "CHITIN2_MOLTED")
        H.lose_trait(H.u(ctx), "CHITIN_MOLTED")
        do local _g = H.safe_id('mutation', "CHITIN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CHITIN2"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _g = H.safe_id('mutation', "CRUSTACEAN_CARAPACE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["rashy_skin"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SKIN_RASHY") == 1) and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["rashy_skin"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SKIN_RASHY") == 1) and (not (((function() local eg = H.safe_id('effect', "formication"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "formication", 600, "RANDOM", nil, nil)
        return true
    end
    return false
    end
    COND["hay_fever_spring_fall"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SEASONAL_ALLERGIES") == 1) and ((services.time_snapshot().season_id == string.lower("spring")) or (services.time_snapshot().season_id == string.lower("autumn"))) and (not (((function() local eg = H.safe_id('effect', "took_flumed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["hay_fever_spring_fall"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SEASONAL_ALLERGIES") == 1) and ((services.time_snapshot().season_id == string.lower("spring")) or (services.time_snapshot().season_id == string.lower("autumn"))) and (not (((function() local eg = H.safe_id('effect', "took_flumed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("Your eyes water and your nose itches.")), "bad")
        H.eoc_add_effect(H.u(ctx), "hay_fever", (services.random.native_int(0, H.round_half_away(28800)) + 600), nil, nil, nil)
        return true
    end
    return false
    end
    COND["hay_fever_summer"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SEASONAL_ALLERGIES") == 1) and (services.time_snapshot().season_id == string.lower("SUMMER")) and (not (((function() local eg = H.safe_id('effect', "took_flumed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["hay_fever_summer"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SEASONAL_ALLERGIES") == 1) and (services.time_snapshot().season_id == string.lower("SUMMER")) and (not (((function() local eg = H.safe_id('effect', "took_flumed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("Your eyes water and your nose itches.")), "bad")
        H.eoc_add_effect(H.u(ctx), "hay_fever", (services.random.native_int(0, H.round_half_away(28800)) + 600), nil, nil, nil)
        return true
    end
    return false
    end
    COND["sneeze"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["sneeze"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "hay_fever"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (not (((function() local eg = H.safe_id('effect', "took_antihistamine"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("You sneeze!")), "bad")
        H.eoc_add_effect(H.u(ctx), "sneezing", 1, nil, nil, nil)
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(10), "speech", ctx:expand_text(services.translate("a sneeze!")), false) end end
        return true
    end
    return false
    end
    COND["shed_summer_timer_lupine"] = function(ctx)
        return (((services.time_snapshot().season_id == string.lower("summer")) and (H.char_has_trait(H.u(ctx), "LUPINE_FUR") == 1))) == true
    end
    EOC["shed_summer_timer_lupine"] = function(ctx)
    if (((services.time_snapshot().season_id == string.lower("summer")) and (H.char_has_trait(H.u(ctx), "LUPINE_FUR") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("You've been shedding for a while, and your coat feels noticeably lighter.")), "good")
        H.lose_trait(H.u(ctx), "LUPINE_FUR")
        do local _g = H.safe_id('mutation', "LUPINE_FUR_SUMMER"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["regrow_timer_lupine"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "LUPINE_FUR_SUMMER") == 1) and (not ((services.time_snapshot().season_id == string.lower("summer")))))) == true
    end
    EOC["regrow_timer_lupine"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "LUPINE_FUR_SUMMER") == 1) and (not ((services.time_snapshot().season_id == string.lower("summer")))))) then
        services.messages.add(ctx:expand_text(services.translate("It looks like your coat has grown back in for the colder seasons.")), "good")
        H.lose_trait(H.u(ctx), "LUPINE_FUR_SUMMER")
        do local _g = H.safe_id('mutation', "LUPINE_FUR"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["shed_summer_timer_ursine"] = function(ctx)
        return (((services.time_snapshot().season_id == string.lower("summer")) and (H.char_has_trait(H.u(ctx), "URSINE_FUR") == 1))) == true
    end
    EOC["shed_summer_timer_ursine"] = function(ctx)
    if (((services.time_snapshot().season_id == string.lower("summer")) and (H.char_has_trait(H.u(ctx), "URSINE_FUR") == 1))) then
        services.messages.add(ctx:expand_text(services.translate("You've been shedding for a while, and your coat feels noticeably lighter.")), "good")
        H.lose_trait(H.u(ctx), "URSINE_FUR")
        do local _g = H.safe_id('mutation', "URSINE_FUR_SUMMER"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["regrow_timer_ursine"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "URSINE_FUR_SUMMER") == 1) and (not ((services.time_snapshot().season_id == string.lower("summer")))))) == true
    end
    EOC["regrow_timer_ursine"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "URSINE_FUR_SUMMER") == 1) and (not ((services.time_snapshot().season_id == string.lower("summer")))))) then
        services.messages.add(ctx:expand_text(services.translate("It looks like your coat has grown back in for the colder seasons.")), "good")
        H.lose_trait(H.u(ctx), "URSINE_FUR_SUMMER")
        do local _g = H.safe_id('mutation', "URSINE_FUR"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["seasonal_affective_fall"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SEASONAL_AFFECTIVE") == 1) and (services.time_snapshot().season_id == string.lower("autumn")) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["seasonal_affective_fall"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SEASONAL_AFFECTIVE") == 1) and (services.time_snapshot().season_id == string.lower("autumn")) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("It's only fall, but you already miss the summer sun.")), "bad")
        do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-15), math.floor(-15), { duration = services.time.duration_from_turns(math.floor((services.random.native_int(0, H.round_half_away(216000)) + 86400))), decay_start = services.time.duration(30, 'minutes') }) end end
        return true
    end
    return false
    end
    COND["seasonal_affective_winter"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SEASONAL_AFFECTIVE") == 1) and (services.time_snapshot().season_id == string.lower("winter")) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["seasonal_affective_winter"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SEASONAL_AFFECTIVE") == 1) and (services.time_snapshot().season_id == string.lower("winter")) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        services.messages.add(ctx:expand_text(services.translate("The long, cold nights really get you feeling down.")), "bad")
        do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-15), math.floor(-15), { duration = services.time.duration_from_turns(math.floor((services.random.native_int(0, H.round_half_away(432000)) + 86400))), decay_start = services.time.duration(30, 'minutes') }) end end
        return true
    end
    return false
    end
    COND["EOC_RADIATION_MUTATION"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_RADIATION_MUTATION"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.set_var("context", nil, ctx, "radiation_mutation_category", ctx:expand_text("<radiation_category>"))
        do local _g = H.safe_id('mutation_category', H.var_str("context", nil, ctx, "radiation_mutation_category", "")); if H.u(ctx) and _g then services.mutations.mutate_category(H.u(ctx), _g, false, true) end end
        return true
    end
    return false
    end
    COND["EOC_ink_grand_spray"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "ink_gland_ink") > 1)) == true
    end
    EOC["EOC_ink_grand_spray"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "ink_gland_ink") > 1)) then
        H.eoc_cast_spell(H.u(ctx), "ink_gland_spray", false, nil)
        services.messages.add(ctx:expand_text(services.translate("Your ink glands spray some ink into your attacker's eyes!")), "good")
        H.eoc_add_effect(H.u(ctx), "ink_gland_ink", -1, nil, (H.creature_effect_intensity(H.u(ctx), "ink_gland_ink") - 1), nil)
        return true
    end
    return false
    end
    COND["EOC_ink_gland_recharge_timer"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "INK_GLANDS") == 1) and (not (((function() local eg = H.safe_id('effect', "ink_gland_ink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 4).value == true end)()))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).kcal_percent or 0) > 33) and (H.char_val_extra(H.u(ctx), "instant_thirst") < 240))) == true
    end
    EOC["EOC_ink_gland_recharge_timer"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "INK_GLANDS") == 1) and (not (((function() local eg = H.safe_id('effect', "ink_gland_ink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, 4).value == true end)()))) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).kcal_percent or 0) > 33) and (H.char_val_extra(H.u(ctx), "instant_thirst") < 240))) then
        do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(47 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 47; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        H.set_char_val_extra(H.u(ctx), "thirst", 4, "+=")
        H.eoc_add_effect(H.u(ctx), "ink_gland_ink", -1, nil, (H.creature_effect_intensity(H.u(ctx), "ink_gland_ink") + 1), nil)
        return true
    end
    return false
    end
    COND["EOC_ink_gland_ink_cleanup"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "ink_gland_ink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("INK_GLANDS") == (H.var_str("context", nil, ctx, "trait", "")))))) == true
    end
    EOC["EOC_ink_gland_ink_cleanup"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "ink_gland_ink"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((("INK_GLANDS") == (H.var_str("context", nil, ctx, "trait", "")))))) then
        do local _eg = H.safe_id('effect', "ink_gland_ink"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_social1_bonus"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "SOCIAL1") and (not (H.char_has_flag(H.u(ctx), "PSYCHOPATH"))) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "any") > 0) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_social1_bonus"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "SOCIAL1") and (not (H.char_has_flag(H.u(ctx), "PSYCHOPATH"))) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "any") > 0) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _eg = H.safe_id('effect', "social_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "social_satisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "social_satisfied", 7200, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_social2_bonus"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "SOCIAL2") and (not (H.char_has_flag(H.u(ctx), "PSYCHOPATH"))) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "allies") > 0) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_social2_bonus"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "SOCIAL2") and (not (H.char_has_flag(H.u(ctx), "PSYCHOPATH"))) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "allies") > 0) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _eg = H.safe_id('effect', "social_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "social_satisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "social_satisfied", 21600, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_social2_penalty"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "SOCIAL2") and (H.chars_nearby(H.u(ctx), 30, "allies") == 0) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_social2_penalty"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "SOCIAL2") and (H.chars_nearby(H.u(ctx), 30, "allies") == 0) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _eg = H.safe_id('effect', "social_satisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "social_dissatisfied", -1, nil, (H.creature_effect_intensity(H.u(ctx), "social_dissatisfied") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("You could use some friendly company.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_asocial1_bonus"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "ASOCIAL1") and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "any") == 0) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_asocial1_bonus"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "ASOCIAL1") and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "any") == 0) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        do local _eg = H.safe_id('effect', "asocial_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "asocial_satisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "asocial_satisfied", 7200, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_asocial2_bonus"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "ASOCIAL2") and (not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "any") == 0))) == true
    end
    EOC["EOC_asocial2_bonus"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "ASOCIAL2") and (not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.chars_nearby(H.u(ctx), 30, "any") == 0))) then
        do local _eg = H.safe_id('effect', "asocial_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "asocial_satisfied", 21600, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_asocial2_penalty_reset"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "ASOCIAL2") and (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.chars_nearby(H.u(ctx), 1, "any") == 0)) or ((not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) and (H.chars_nearby(H.u(ctx), 30, "any") == 0))))) == true
    end
    EOC["EOC_asocial2_penalty_reset"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "ASOCIAL2") and (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.chars_nearby(H.u(ctx), 1, "any") == 0)) or ((not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) and (H.chars_nearby(H.u(ctx), 30, "any") == 0))))) then
        do local _eg = H.safe_id('effect', "asocial_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_asocial2_penalty"] = function(ctx)
        return ((H.char_has_flag(H.u(ctx), "ASOCIAL2") and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.chars_nearby(H.u(ctx), 1, "any") > 0)) or ((not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) and (H.chars_nearby(H.u(ctx), 30, "any") > 0))))) == true
    end
    EOC["EOC_asocial2_penalty"] = function(ctx)
    if ((H.char_has_flag(H.u(ctx), "ASOCIAL2") and (not (((function() local eg = H.safe_id('effect', "took_prozac"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.chars_nearby(H.u(ctx), 1, "any") > 0)) or ((not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "drunk"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) and (H.chars_nearby(H.u(ctx), 30, "any") > 0))))) then
        do local _eg = H.safe_id('effect', "asocial_satisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "asocial_dissatisfied", -1, nil, (H.creature_effect_intensity(H.u(ctx), "asocial_dissatisfied") + 1), nil)
        services.messages.add(ctx:expand_text(services.translate("You'd really rather be by yourself.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_social_reset_sleep"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_social_reset_sleep"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "narcosis"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do local _eg = H.safe_id('effect', "asocial_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "social_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_social_reset_drugs"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_social_reset_drugs"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "valium"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "took_xanax"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "social_dissatisfied"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        do local _eg = H.safe_id('effect', "asocial_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "social_dissatisfied"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
end
