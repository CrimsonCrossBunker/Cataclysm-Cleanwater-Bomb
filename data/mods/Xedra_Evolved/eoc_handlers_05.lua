local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "DHAMPIR_WEAKNESS_BLOODTHIRST") == 1)) == true
    end
    EOC["EOC_DHAMPIR_WEAKNESS_BLOODLUST_CHECKS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "DHAMPIR_WEAKNESS_BLOODTHIRST") == 1)) then
        do local _g = H.safe_id('morale', "morale_craving_human_blood"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-30), math.floor(-90), { duration = services.time.duration_from_turns(math.floor(21600)), decay_start = services.time.duration_from_turns(math.floor(10800)) }) end end
        H.eoc_add_effect(H.u(ctx), "effect_dhampir_bloodlust_cravings", services.random.native_float(10800, 21600), nil, nil, nil)
        services.messages.add(ctx:expand_text(services.translate("Crimson clouds your vision as you are overcome with an urge to drink blood.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_DHAMPIR_BLEED_STOLEN_BLOOD"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "head") >= 1)) and (H.char_vitamin(H.u(ctx), "human_blood_vitamin") > (-1000)))) == true
    end
    EOC["EOC_DHAMPIR_BLEED_STOLEN_BLOOD"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "DHAMPIR_TRAIT") == 1) and ((H.creature_effect_intensity(H.u(ctx), "bleed", "arm_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "arm_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_l") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "leg_r") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "torso") >= 1) or (H.creature_effect_intensity(H.u(ctx), "bleed", "head") >= 1)) and (H.char_vitamin(H.u(ctx), "human_blood_vitamin") > (-1000)))) then
        do
            local _arr = { "arm_l", "arm_r", "leg_l", "leg_r", "torso", "head" }
            for _, _v in ipairs(_arr) do
                H.set_var("context", nil, ctx, "id", _v)
                if (H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")) >= 1) then
                    H.set_var("context", nil, ctx, "bleed_intensity", H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")))
                    services.messages.add(ctx:expand_text(services.translate("Bleed intensity for bodypart is <context_val:bleed_intensity>.")), "debug")
                    do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (H.creature_effect_intensity(H.u(ctx), "bleed", H.var_str("context", nil, ctx, "id", "")) / 2); local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
                end
            end
        end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(10), math.floor(10); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DHAMPIR_BLEED_STOLEN_BLOOD"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_GRACKEN_CONVERT_RADS_TO_CALORIES"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "RADIOTROPHIC") == 1)) == true
    end
    EOC["EOC_GRACKEN_CONVERT_RADS_TO_CALORIES"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "RADIOTROPHIC") == 1)) then
        if ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) >= 100) then
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(3 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 3; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            H.set_char_val_extra(H.u(ctx), "rad", 1, "-=")
        end
        if (((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) < 100) and ((((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0) > 0)) then
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            H.set_char_val_extra(H.u(ctx), "rad", 1, "-=")
        end
        return true
    end
    return false
    end
    COND["eoc_eggsac_mantain_or_remove_switch"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1)) == true
    end
    EOC["eoc_eggsac_mantain_or_remove_switch"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1)) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "eggsac_mantain"); table.insert(_wts, math.max(0, 10))
            table.insert(_ids, "eggsac_remove"); table.insert(_wts, math.max(0, (((H.char_snap(H.u(ctx)) or {}).stats or {}).strength or 0)))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    else
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "eggsac_mantain"); table.insert(_wts, math.max(0, 25))
            table.insert(_ids, "eggsac_remove"); table.insert(_wts, math.max(0, (((H.char_snap(H.u(ctx)) or {}).stats or {}).strength or 0)))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return false
    end
    end
    COND["eoc_eggsac_host"] = function(ctx)
        return (((H.moon_phase() == 3) and ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1) or (H.char_has_trait(H.u(ctx), "EGGSAC_FATAL") == 1)))) == true
    end
    EOC["eoc_eggsac_host"] = function(ctx)
    if (((H.moon_phase() == 3) and ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1) or (H.char_has_trait(H.u(ctx), "EGGSAC_FATAL") == 1)))) then
        H.run_eoc("eoc_eggsac_mantain_or_remove_switch", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["eoc_eggsac_survivable_or_fatal"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1)) == true
    end
    EOC["eoc_eggsac_survivable_or_fatal"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1)) then
        do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "spider_emergence_weak", (cs and cs.kind == 'monster'), nil) end end
        services.messages.add(ctx:expand_text(services.translate("Spiders erupt from your body!")), "bad")
        return true
    else
        do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "spider_emergence_strong", (cs and cs.kind == 'monster'), nil) end end
        services.messages.add(ctx:expand_text(services.translate("Spiders erupt from your body!")), "bad")
        return false
    end
    end
    EOC["eggsac_mantain"] = function(ctx)
    H.run_eoc("eoc_eggsac_survivable_or_fatal", ctx, nil, nil, nil)
    return true
    end
    COND["eoc_eggsac_remove_survivable_or_fatal"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1)) == true
    end
    EOC["eoc_eggsac_remove_survivable_or_fatal"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "EGGSAC_SURVIVABLE") == 1)) then
        do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "spider_emergence_weak", (cs and cs.kind == 'monster'), nil) end end
        H.lose_trait(H.u(ctx), "EGGSAC_SURVIVABLE")
        services.messages.add(ctx:expand_text(services.translate("Spiders erupt from your body!")), "bad")
        return true
    else
        do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "spider_emergence_strong", (cs and cs.kind == 'monster'), nil) end end
        H.lose_trait(H.u(ctx), "EGGSAC_FATAL")
        services.messages.add(ctx:expand_text(services.translate("Spiders erupt from your body!")), "bad")
        return false
    end
    end
    EOC["eggsac_remove"] = function(ctx)
    H.run_eoc("eoc_eggsac_remove_survivable_or_fatal", ctx, nil, nil, nil)
    return true
    end
    COND["manifest_destiny_goblin_complete"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "THRESH_TROGLOBITE") == 1)) == true
    end
    EOC["manifest_destiny_goblin_complete"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "THRESH_TROGLOBITE") == 1)) then
        H.lose_trait(H.u(ctx), "MANIFEST_DESTINY_GOBLIN")
        do local _g = H.safe_id('mutation', "MANIFESTED_DESTINY_GOBLIN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["manifest_destiny_goblin"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MANIFEST_DESTINY_GOBLIN") == 1)) == true
    end
    EOC["manifest_destiny_goblin"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MANIFEST_DESTINY_GOBLIN") == 1)) then
        do local _a, _v = H.u(ctx), "mutagen_troglobite"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.run_eoc("manifest_destiny_goblin_complete", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["destiny_goblin_removal"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "THRESH_TROGLOBITE") == 1)) == true
    end
    EOC["destiny_goblin_removal"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "THRESH_TROGLOBITE") == 1)) then
        H.lose_trait(H.u(ctx), "MANIFESTED_DESTINY_GOBLIN")
        return true
    end
    return false
    end
    COND["manifested_destiny_goblin"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_GOBLIN") == 1)) == true
    end
    EOC["manifested_destiny_goblin"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_GOBLIN") == 1)) then
        do local _a, _v = H.u(ctx), "mutagen_troglobite"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (1750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (1750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.run_eoc("destiny_goblin_removal", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["manifest_destiny_spider_complete"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "THRESH_SPIDER") == 1)) == true
    end
    EOC["manifest_destiny_spider_complete"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "THRESH_SPIDER") == 1)) then
        H.lose_trait(H.u(ctx), "MANIFEST_DESTINY_SPIDER")
        do local _g = H.safe_id('mutation', "MANIFESTED_DESTINY_SPIDER"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["manifest_destiny_spider"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MANIFEST_DESTINY_SPIDER") == 1)) == true
    end
    EOC["manifest_destiny_spider"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MANIFEST_DESTINY_SPIDER") == 1)) then
        do local _a, _v = H.u(ctx), "mutagen_spider"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.run_eoc("manifest_destiny_spider_complete", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["destiny_goblin_spider"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "THRESH_SPIDER") == 1)) == true
    end
    EOC["destiny_goblin_spider"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "THRESH_SPIDER") == 1)) then
        H.lose_trait(H.u(ctx), "MANIFESTED_DESTINY_SPIDER")
        return true
    end
    return false
    end
    COND["manifested_destiny_spider"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_SPIDER") == 1)) == true
    end
    EOC["manifested_destiny_spider"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MANIFESTED_DESTINY_SPIDER") == 1)) then
        do local _a, _v = H.u(ctx), "mutagen_spider"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (1750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (1750 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.run_eoc("destiny_goblin_spider", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["consume_human_blood"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1)) == true
    end
    EOC["consume_human_blood"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "VAMPIRE") == 1)) then
        do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (400 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_ARVORE_IS_IN_FOREST_ON_OMT_ENTER_2"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SE") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z0_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z0_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z1_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z1_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z2_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z2_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z3_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z3_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z4_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z4_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z5_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z5_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_n2", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z7_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z7_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_top_01", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_top_04", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_roots", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_roots_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_roots_nw", math.floor(2)) end)()))) == true
    end
    EOC["EOC_CONDITION_CHECK_ARVORE_IS_IN_FOREST_ON_OMT_ENTER_2"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SE") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z0_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z0_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z1_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z1_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z2_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z2_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z3_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z3_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z4_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z4_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z5_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z5_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_n2", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z6_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z7_nw", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_z7_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_06", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_11", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_top_01", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_crown_top_04", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_roots", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_roots_se", math.floor(2)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "great_tree_roots_nw", math.floor(2)) end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "arvore_is_in_forest", 1)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "arvore_is_in_forest", 0)
        return false
    end
    end
    COND["EOC_CONDITION_CHECK_ARVORE_IS_IN_FOREST_ON_OMT_ENTER"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "FALSE_ARVORE_HATRED", "FAE_ENMITY", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })) == true
    end
    EOC["EOC_CONDITION_CHECK_ARVORE_IS_IN_FOREST_ON_OMT_ENTER"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "ARVORE", "FALSE_ARVORE_HATRED", "FAE_ENMITY", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" })) then
        H.run_eoc("EOC_CONDITION_CHECK_ARVORE_IS_IN_FOREST_ON_OMT_ENTER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_ARVORE_ON_NATURAL_TERRAIN"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "YOUNG"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor_noroof" end)()))) == true
    end
    EOC["EOC_CONDITION_CHECK_ARVORE_ON_NATURAL_TERRAIN"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "YOUNG"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor_noroof" end)()))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_ARVORE_IN_THE_FOREST"] = function(ctx)
        return ((H.var_num(H.u(ctx), "arvore_is_in_forest") == 1)) == true
    end
    EOC["EOC_CONDITION_CHECK_ARVORE_IN_THE_FOREST"] = function(ctx)
    if ((H.var_num(H.u(ctx), "arvore_is_in_forest") == 1)) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_ARVORE_IN_THE_WILD"] = function(ctx)
        return ((H.var_num(H.u(ctx), "arvore_is_in_wilderness") == 1)) == true
    end
    EOC["EOC_CONDITION_CHECK_ARVORE_IN_THE_WILD"] = function(ctx)
    if ((H.var_num(H.u(ctx), "arvore_is_in_wilderness") == 1)) then
        return true
    end
    return false
    end
    COND["EOC_ARVORE_LOSE_PACT_OF_GREEN_IF_ATTACKING_TRIFFID_2"] = function(ctx)
        return (((H.char_has_trait(H.npc(ctx), "ARVORE_TRIFFID_NEUTRALITY") == 1) and (not ((H.char_has_trait(H.npc(ctx), "effect_arvore_attacked_a_triffid") == 1))))) == true
    end
    EOC["EOC_ARVORE_LOSE_PACT_OF_GREEN_IF_ATTACKING_TRIFFID_2"] = function(ctx)
    if (((H.char_has_trait(H.npc(ctx), "ARVORE_TRIFFID_NEUTRALITY") == 1) and (not ((H.char_has_trait(H.npc(ctx), "effect_arvore_attacked_a_triffid") == 1))))) then
        H.eoc_add_effect(H.npc(ctx), "effect_arvore_attacked_a_triffid", (10800 + services.random.native_int(0, H.round_half_away(43200))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ARVORE_LOSE_PACT_OF_GREEN_IF_ATTACKING_TRIFFID"] = function(ctx)
        return (((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))) and (H.npc(ctx) ~= nil))) == true
    end
    EOC["EOC_ARVORE_LOSE_PACT_OF_GREEN_IF_ATTACKING_TRIFFID"] = function(ctx)
    if (((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))) and (H.npc(ctx) ~= nil))) then
        H.run_eoc("EOC_ARVORE_LOSE_PACT_OF_GREEN_IF_ATTACKING_TRIFFID_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_ARVORE_BRIARS_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_ARVORE_BRIARS_SELECTOR_ARC"] == nil or E.cond["EOC_ARVORE_BRIARS_SELECTOR_ARC"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Thorny Arc")), description = ctx:expand_text(services.translate("Summon a spray of brambles to entrap an enemy.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_ARVORE_BRIARS_SELECTOR_ARC" end end
        do local _en = (E.cond["EOC_ARVORE_BRIARS_SELECTOR_LINE"] == nil or E.cond["EOC_ARVORE_BRIARS_SELECTOR_LINE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Wall of Brambles")), description = ctx:expand_text(services.translate("Summon a wall of thorns to fortify a location.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_ARVORE_BRIARS_SELECTOR_LINE" end end
        do local _en = (E.cond["EOC_NONE"] == nil or E.cond["EOC_NONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Do nothing")), description = ctx:expand_text(services.translate("Do nothing.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_NONE" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_ARVORE_BRIARS_SELECTOR_ARC"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_summon_briars_arc", false, { targeted = true })
    return true
    end
    EOC["EOC_ARVORE_BRIARS_SELECTOR_LINE"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_summon_briars_line", false, { targeted = true })
    return true
    end
    EOC["EOC_COMMUNE_WITH_NATURE"] = function(ctx)
    H.set_var("context", nil, ctx, "duration_lower_bound", ((((228.45 + (H.char_spell_count(H.u(ctx), "ARVORE") * 25.48)) + (H.char_skill(H.u(ctx), "gramarye") * 81.65)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))) * H._jm_paraclesian_post_threshold_doubler(ctx, 1)))
    H.set_var("context", nil, ctx, "duration_upper_bound", ((((492.85 + (H.char_spell_count(H.u(ctx), "ARVORE") * 59.42)) + (H.char_skill(H.u(ctx), "gramarye") * 149.53)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))) * H._jm_paraclesian_post_threshold_doubler(ctx, 1)))
    H.set_var("context", nil, ctx, "duration", services.random.native_float((ctx:get_number("duration_lower_bound") or 0), (ctx:get_number("duration_upper_bound") or 0)))
    H.eoc_add_effect(H.u(ctx), "natures_commune", (ctx:get_number("duration") or 0), nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_forest_unity"); if H.u(ctx) and _g then services.morale.remove(H.u(ctx), _g) end end
    do local _g = H.safe_id('morale', "morale_forest_unity"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor((((5 + (H.char_spell_count(H.u(ctx), "ARVORE") / 3)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))) * H._jm_paraclesian_post_threshold_doubler(ctx, 1))), math.floor(40), { duration = services.time.duration_from_turns(math.floor((ctx:get_number("duration") or 0))), decay_start = services.time.duration_from_turns(math.floor(((ctx:get_number("duration") or 0) / 2))) }) end end
    return true
    end
    EOC["EOC_APPLY_PARACLESIAN_DODGE_BONUS"] = function(ctx)
    H.set_var("context", nil, ctx, "duration_lower_bound", (((204.85 + (H.char_spell_count(H.u(ctx), "ARVORE") * 67.12)) + (H.char_skill(H.u(ctx), "gramarye") * 97.85)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))))
    H.set_var("context", nil, ctx, "duration_upper_bound", (((398.55 + (H.char_spell_count(H.u(ctx), "ARVORE") * 102.35)) + (H.char_skill(H.u(ctx), "gramarye") * 218.53)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).perception or 0))))
    H.set_var("context", nil, ctx, "duration", services.random.native_float((ctx:get_number("duration_lower_bound") or 0), (ctx:get_number("duration_upper_bound") or 0)))
    do
        local _sw28 = H.char_spell_count(H.u(ctx), "ARVORE")
        if _sw28 == 0 then
            H.eoc_add_effect(H.u(ctx), "effect_paraclesian_dodge_bonus_1", (ctx:get_number("duration") or 0), nil, nil, nil)
        elseif _sw28 == 15 then
            H.eoc_add_effect(H.u(ctx), "effect_paraclesian_dodge_bonus_2", (ctx:get_number("duration") or 0), nil, nil, nil)
        elseif _sw28 == 25 then
            H.eoc_add_effect(H.u(ctx), "effect_paraclesian_dodge_bonus_3", (ctx:get_number("duration") or 0), nil, nil, nil)
        end
    end
    return true
    end
    EOC["EOC_ARVORE_WALK_WILDS_TELEPORT_ACTION"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select tree to step to.")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "arvore_walk_wilds_location") and 1 or 0)) then
        if (((function() local p = H.get_tripoint_var("context", nil, ctx, "arvore_walk_wilds_location"); local fg = H.safe_id('json_flag', "TREE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "arvore_walk_wilds_location"); local fg = H.safe_id('json_flag', "YOUNG"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then
            do local _p = H.get_tripoint_var("context", nil, ctx, "arvore_walk_wilds_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            services.messages.add(ctx:expand_text(services.translate("You step into the tree and step out of another one nearby.")), "neutral")
        else
            services.messages.add(ctx:expand_text(services.translate("You must select a tree to step to.")), "neutral")
        end
    else
        services.messages.add(ctx:expand_text(services.translate("Canceled")), "neutral")
    end
    services.messages.add(ctx:expand_text(services.translate("You need to be standing next to a tree to traverse the wilds.")), "bad")
    return true
    end
    EOC["EOC_ARVORE_WALK_WILDS_TELEPORT_CHECK"] = function(ctx)
    do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "arvore_walk_wilds_origin", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "arvore_walk_wilds_origin"); local fg = H.safe_id('json_flag', "TREE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then for _, _eid in ipairs({ "EOC_ARVORE_WALK_WILDS_TELEPORT_ACTION" }) do H.run_eoc(_eid, ctx) end; if true then break end end end end end
    return true
    end
    EOC["EOC_ARVORE_SUMMON_FLORAL_BOAT_ACTION"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_summon_floral_boat_real", false, { targeted = true })
    services.messages.add(ctx:expand_text(services.translate("You need a nearby tree to transform it into the viridescent vessel.")), "bad")
    return true
    end
    EOC["EOC_ARVORE_SUMMON_FLORAL_BOAT_CHECK"] = function(ctx)
    do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "arvore_floral_boat_tree", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "arvore_floral_boat_tree"); local fg = H.safe_id('json_flag', "TREE"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then for _, _eid in ipairs({ "EOC_ARVORE_SUMMON_FLORAL_BOAT_ACTION" }) do H.run_eoc(_eid, ctx) end; if true then break end end end end end
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "arvore_floral_boat_tree"), H.safe_id('terrain_furniture_transform', "ter_arvore_tree_to_grass"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    return true
    end
    COND["EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS"] = function(ctx)
        return (((("effect_arvore_seedbearer_cooldown") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS"] = function(ctx)
    if (((("effect_arvore_seedbearer_cooldown") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        if (services.time_snapshot().season_id == string.lower("winter")) then
            do local _t = math.max(1, math.floor(86400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS_WINTER"), nil) end end
        else
            H.eoc_add_effect(H.u(ctx), "effect_arvore_seedbearer_available", -1, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS_WINTER"] = function(ctx)
        return ((services.time_snapshot().season_id == string.lower("winter"))) == true
    end
    EOC["EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS_WINTER"] = function(ctx)
    if ((services.time_snapshot().season_id == string.lower("winter"))) then
        do local _t = math.max(1, math.floor(86400)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ARVORE_SEED_BEARER_SWITCH_EFFECTS_WINTER"), nil) end end
        return true
    else
        H.eoc_add_effect(H.u(ctx), "effect_arvore_seedbearer_available", -1, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_GROWING_WOOD_WALLS_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_GROWING_WOOD_WALLS"] == nil or E.cond["EOC_GROWING_WOOD_WALLS"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Grow Wooden Wall")), description = ctx:expand_text(services.translate("Grow a wall of solid wood from the earth, grow or remove bark from a wall, or turn one of your wooden floors into a bark wall.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_GROWING_WOOD_WALLS" end end
        do local _en = (E.cond["EOC_GROWING_WOOD_FLOORS"] == nil or E.cond["EOC_GROWING_WOOD_FLOORS"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Grow Wooden Floor")), description = ctx:expand_text(services.translate("Grow a floor of bark from the earth, roof over a bark floor, or turn one of your wooden walls into a bark floor.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_GROWING_WOOD_FLOORS" end end
        do local _en = (E.cond["EOC_GROWING_WOOD_DOORS"] == nil or E.cond["EOC_GROWING_WOOD_DOORS"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Grow Wooden Door")), description = ctx:expand_text(services.translate("Grow a bramble door from a wooden wall or return the wall to solid wood.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_GROWING_WOOD_DOORS" end end
        do local _en = (E.cond["EOC_GROWING_WOOD_BRANCHES"] == nil or E.cond["EOC_GROWING_WOOD_BRANCHES"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Grow Leafy Branch")), description = ctx:expand_text(services.translate("Grow a leafy branch.  It won't provide shelter but it helps it feel like home.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_GROWING_WOOD_BRANCHES" end end
        do local _en = (E.cond["EOC_NONE"] == nil or E.cond["EOC_NONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Do nothing")), description = ctx:expand_text(services.translate("Do nothing.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_NONE" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_GROWING_WOOD_WALLS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_growing_wood_walls_wall", false, { targeted = true })
    return true
    end
    EOC["EOC_GROWING_WOOD_FLOORS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_growing_wood_walls_floor", false, { targeted = true })
    return true
    end
    EOC["EOC_GROWING_WOOD_BRANCHES"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_growing_wood_walls_branch", false, { targeted = true })
    return true
    end
    EOC["EOC_GROWING_WOOD_DOORS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "arvore_growing_wood_walls_door", false, { targeted = true })
    return true
    end
    COND["EOC_PERENNIAL_REBIRTH_INITIAL_CHECK_2"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SE"))) == true
    end
    EOC["EOC_PERENNIAL_REBIRTH_INITIAL_CHECK_2"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "forest_thick") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "arvore_genius_loci_SE"))) then
        H.run_eoc("EOC_PERENNIAL_REBIRTH_INITIAL", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You need to be in the heart of the forest or at an attuned elemental altar to successfully bind your soul.")), "bad")
        return false
    end
    end
    COND["EOC_PERENNIAL_REBIRTH_INITIAL_CHECK"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "arvore_perennial_rebirth_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_PERENNIAL_REBIRTH_INITIAL_CHECK"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "arvore_perennial_rebirth_cooldown"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.run_eoc("EOC_PERENNIAL_REBIRTH_INITIAL_CHECK_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your soul is still attaching itself to your new body.  You need to give it time before attempting to bind it to the forest again.")), "bad")
        return false
    end
    end
    EOC["EOC_PERENNIAL_REBIRTH_INITIAL"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "arvore_perennial_rebirth_teleport", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    do local _g = H.safe_id('mutation', "ARVORE_PERENNIAL_REBIRTH_CASTED"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    services.messages.add(ctx:expand_text(services.translate("You bind your soul to the abundance of nature around you.")), "good")
    return true
    end
    COND["EOC_PERENNIAL_REBIRTH"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARVORE_PERENNIAL_REBIRTH_CASTED") == 1)) == true
    end
    EOC["EOC_PERENNIAL_REBIRTH"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARVORE_PERENNIAL_REBIRTH_CASTED") == 1)) then
        ccb.presentation.notice(ctx:expand_text(services.translate("As your body dies, your fae spirit flies free and, drawn to the pull of the heart of the forest, rebirths itself from the bounty of nature.")))
        H.run_eoc("EOC_PERENNIAL_REBIRTH_START", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_PERENNIAL_REBIRTH_START"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "incorporeal", 1, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "downed", 1, nil, nil, nil)
    H.run_eoc("EOC_PERENNIAL_REBIRTH_HEAL", ctx, nil, nil, nil)
    H.eoc_spawn_item(H.u(ctx), "corpse_painful", 1, false, false, nil)
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_PERENNIAL_REBIRTH_FINALIZE"), nil) end end
    return true
    end
    EOC["EOC_PERENNIAL_REBIRTH_HEAL"] = function(ctx)
    H.set_char_hp(H.u(ctx), "ALL", 999, "=")
    H.set_char_hp(H.u(ctx), "ALL_MAJOR", 45, "=")
    do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(70000 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 70000; local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
    H.set_char_val_extra(H.u(ctx), "thirst", 0, "=")
    do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "bad_food"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    do local _a, _v = H.u(ctx), "instability"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
    local _a29 = H.u(ctx)
    if _a29 then services.characters.adjust(_a29, { pain = math.floor((0) - (H.char_pain(_a29))) }) end
    H.set_char_val_extra(H.u(ctx), "rad", 0, "=")
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
    return true
    end
    COND["EOC_PERENNIAL_REBIRTH_FINALIZE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARVORE_PERENNIAL_REBIRTH_CASTED") == 1)) == true
    end
    EOC["EOC_PERENNIAL_REBIRTH_FINALIZE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARVORE_PERENNIAL_REBIRTH_CASTED") == 1)) then
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "arvore_perennial_rebirth_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        H.lose_trait(H.u(ctx), "ARVORE_PERENNIAL_REBIRTH_CASTED")
        H.eoc_add_effect(H.u(ctx), "arvore_perennial_rebirth_cooldown", 2419200, nil, nil, nil)
        local _a30 = H.u(ctx)
        if _a30 then services.characters.adjust(_a30, { pain = math.floor((0) - (H.char_pain(_a30))) }) end
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(65000 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 65000; local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        H.set_char_val_extra(H.u(ctx), "thirst", 0, "=")
        do
            local _arr = {}; local _pg = services.registry.list("vitamin", { limit = 5000 }); if _pg and _pg.items then for _, e in ipairs(_pg.items) do table.insert(_arr, e.id and e.id.value or tostring(e)) end end
            for _, _v in ipairs(_arr) do
                H.set_var("context", nil, ctx, "id", _v)
                do local _a, _v = H.u(ctx), H.var_str("context", nil, ctx, "id", ""); local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_ARVORE_SUN_FOODS_ON_KCAL"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ARVORE_SUN_FOODS") == 1) and (not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["EOC_ARVORE_SUN_FOODS_ON_KCAL"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ARVORE_SUN_FOODS") == 1) and (not services.gameplay.environment.is_night()) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        if (((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) <= 179999) and ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) >= 75000)) then
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(7 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 7; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        else
            if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0) <= 74999) then
                do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_ARVORE_OVERGROWTH_2"] = function(ctx)
        return ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 0)) == true
    end
    EOC["EOC_ARVORE_OVERGROWTH_2"] = function(ctx)
    if ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 0)) then
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_arvore_overgrowth"); if _p and _g then services.world.transform_radius(_p, math.floor((((((H.char_spell_count(H.u(ctx), "ARVORE") / 2) + H.char_skill(H.u(ctx), "gramarye")) * services.random.native_float(0.8, 1.2)) + services.random.native_float(1.5, 4)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), _g, nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be on the surface and not on a building's upper stories to cast Overgrowth!")), "bad")
        return false
    end
    end
    COND["EOC_ARVORE_OVERGROWTH"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_ARVORE_OVERGROWTH"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.run_eoc("EOC_ARVORE_OVERGROWTH_2", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outside to cast Overgrowth!")), "bad")
        return false
    end
    end
    COND["EOC_ARVORE_DAMAGE_ZOMBIES_HEAL_LIVING"] = function(ctx)
        return (ctx:has_speaker()) == true
    end
    EOC["EOC_ARVORE_DAMAGE_ZOMBIES_HEAL_LIVING"] = function(ctx)
    if (ctx:has_speaker()) then
        services.messages.add(ctx:expand_text(services.translate("Nature's power roars forth in an explosion of vital energy!")), "good")
        H.run_eoc("EOC_ARVORE_DAMAGE_ZOMBIES_HEAL_LIVING_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ARVORE_DAMAGE_ZOMBIES_HEAL_LIVING_2"] = function(ctx)
        return ((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_ARVORE_DAMAGE_ZOMBIES_HEAL_LIVING_2"] = function(ctx)
    if ((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true)) then
        if ((H.char_snap(H.u(ctx)) or {}).npc == true) then
            H.set_char_hp(H.u(ctx), "arm_l", (services.random.native_float((H.char_spell_count(H.npc(ctx), "ARVORE") * 0.75), (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.5)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "+=")
            H.set_char_hp(H.u(ctx), "arm_r", (services.random.native_float((H.char_spell_count(H.npc(ctx), "ARVORE") * 0.75), (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.5)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "+=")
            H.set_char_hp(H.u(ctx), "leg_l", (services.random.native_float((H.char_spell_count(H.npc(ctx), "ARVORE") * 0.75), (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.5)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "+=")
            H.set_char_hp(H.u(ctx), "leg_r", (services.random.native_float((H.char_spell_count(H.npc(ctx), "ARVORE") * 0.75), (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.5)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "+=")
            H.set_char_hp(H.u(ctx), "torso", (services.random.native_float((H.char_spell_count(H.npc(ctx), "ARVORE") * 0.75), (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.5)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "+=")
            H.set_char_hp(H.u(ctx), "head", (services.random.native_float((H.char_spell_count(H.npc(ctx), "ARVORE") * 0.75), (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.5)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "+=")
        else
            if ((H.u(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "FERAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FERAL")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "SPIDER") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "SPIDER")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "CENTIPEDE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "CENTIPEDE")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "WORM") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "WORM")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "INSECT_FLYING")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "INSECT")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "MOLLUSK") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MOLLUSK")).value == true))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "MAMMAL") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "MAMMAL")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "BIRD") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "BIRD")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "FISH") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "FISH")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "AMPHIBIAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "AMPHIBIAN")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "REPTILE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "REPTILE")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true)))))) or ((H.u(ctx) ~= nil and ((H.safe_id('species', "HUMAN") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "HUMAN")).value == true))) and (not ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))))))) then
                H.set_char_hp(H.u(ctx), "ALL", (((H.char_spell_count(H.npc(ctx), "ARVORE") * services.random.native_float(12, 22)) + services.random.native_float(50, 120)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), "=")
            else
                do local _g, _a = H.safe_id('damage_type', "biological"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, (((H.char_spell_count(H.npc(ctx), "ARVORE") * services.random.native_float(12, 22)) + services.random.native_float(50, 120)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))), nil) end end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_ARVORE_TREE_SINGING"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select nearby tree")), "neutral")
    if H.truthy((H.var_exists("context", nil, ctx, "arvore_treesung_location") and 1 or 0)) then
        do local _g = H.safe_id('activity', "ACT_ARVORE_TREESINGING"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(2700)))) end end
    end
    return true
    end
    COND["EOC_ARVORE_TREE_SINGING_LEARN_RECIPES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ARVORE") == 1) and (H.char_spell_level(H.u(ctx), "arvore_tree_singing_spell") >= 1) and ((not (H.char_know_recipe(H.u(ctx), "create_chair_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_wardrobe_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_table_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_bedframe_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_helm"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_cuirass"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_gauntlets"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_leg_guards"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_boots"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_cloak"))) or (not (H.char_know_recipe(H.u(ctx), "create_shortbow_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_greatbow_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_arrow_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_spear_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_pike_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_mace_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_q_staff_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_naginata_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_baselard_treesung")))) and (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest", math.floor(2)) end)()) and (not (H.char_at_om_location(H.u(ctx), "field")))) or ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest_thick", math.floor(2)) end)()) and (not (H.char_at_om_location(H.u(ctx), "field")))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor" end)()) or H.test_eoc("EOC_CONDITION_CHECK_ARVORE_IN_THE_FOREST", ctx)))) == true
    end
    EOC["EOC_ARVORE_TREE_SINGING_LEARN_RECIPES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ARVORE") == 1) and (H.char_spell_level(H.u(ctx), "arvore_tree_singing_spell") >= 1) and ((not (H.char_know_recipe(H.u(ctx), "create_chair_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_wardrobe_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_table_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_bedframe_wood_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_helm"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_cuirass"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_gauntlets"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_leg_guards"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_boots"))) or (not (H.char_know_recipe(H.u(ctx), "create_verdant_cloak"))) or (not (H.char_know_recipe(H.u(ctx), "create_shortbow_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_greatbow_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_arrow_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_spear_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_pike_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_mace_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_q_staff_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_naginata_treesung"))) or (not (H.char_know_recipe(H.u(ctx), "create_baselard_treesung")))) and (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest", math.floor(2)) end)()) and (not (H.char_at_om_location(H.u(ctx), "field")))) or ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-1)))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "forest_thick", math.floor(2)) end)()) and (not (H.char_at_om_location(H.u(ctx), "field")))) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_barkfloor" end)()) or H.test_eoc("EOC_CONDITION_CHECK_ARVORE_IN_THE_FOREST", ctx)))) then
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "create_chair_wood_treesung", "create_wardrobe_wood_treesung", "create_table_wood_treesung", "create_bedframe_wood_treesung", "create_verdant_helm", "create_verdant_cuirass", "create_verdant_gauntlets", "create_verdant_leg_guards", "create_verdant_boots", "create_verdant_cloak", "create_shortbow_treesung", "create_greatbow_treesung", "create_arrow_treesung", "create_spear_treesung", "create_pike_treesung", "create_mace_treesung", "create_q_staff_treesung", "create_naginata_treesung", "create_baselard_treesung" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
        end
        services.messages.add(ctx:expand_text(services.translate("The trees whisper their knowledge of a recipe to you")), "good")
        return true
    end
    return false
    end
    EOC["EOC_ARVORE_TREE_FORM_IMMOBILE"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_arvore_tree_immobility", 86400, nil, 50000, nil)
    return true
    end
    COND["EOC_ARVORE_TREE_REDUCE_THIRST"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ARVORE_TREE_FORM_TRAITS") == 1)) == true
    end
    EOC["EOC_ARVORE_TREE_REDUCE_THIRST"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ARVORE_TREE_FORM_TRAITS") == 1)) then
        if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0) >= (-50)) then
            H.set_char_val_extra(H.u(ctx), "thirst", 1, "-=")
        end
        return true
    end
    return false
    end
    EOC["EOC_ARVORE_VERDANT_IMPRISONMENT_DELETE_NPC_ITEMS"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    COND["EOC_ARVORE_VERDANT_IMPRISONMENT"] = function(ctx)
        return ((not (((H.char_snap(H.u(ctx)) or {}).npc == true)))) == true
    end
    EOC["EOC_ARVORE_VERDANT_IMPRISONMENT"] = function(ctx)
    if ((not (((H.char_snap(H.u(ctx)) or {}).npc == true)))) then
        H.set_var("actor", H.u(ctx), ctx, "arvore_turn_into_tree_intelligence", (((((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0) + 10) / 20))
        H.set_var("actor", H.u(ctx), ctx, "arvore_turn_into_tree_spell_count", H.char_spell_count(H.npc(ctx), "ARVORE"))
        H.set_var("actor", H.u(ctx), ctx, "arvore_turn_into_tree_gramarye_level", H.char_skill(H.npc(ctx), "gramarye"))
        H.eoc_loc_var(H.u(ctx), ctx, "global", "arvore_tree_transform_target", nil, nil, nil, nil, { dx = math.floor(0), dy = math.floor(0), dz = math.floor(0) }, false, true, {  }, {  })
        H.eoc_cast_spell(H.u(ctx), "arvore_turn_into_tree_banish", false, { message = ctx:expand_text(services.translate("")) })
        H.run_eoc("EOC_NONE", ctx, nil, nil, nil)
        return true
    else
        H.set_var("context", nil, ctx, "damage_lower_bound", (((25 + (H.char_spell_count(H.npc(ctx), "ARVORE") * 2.6)) + (H.char_skill(H.npc(ctx), "gramarye") * 3.4)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))))
        H.set_var("context", nil, ctx, "damage_upper_bound", (((25 + (H.char_spell_count(H.npc(ctx), "ARVORE") * 5.6)) + (H.char_skill(H.npc(ctx), "gramarye") * 7.1)) * H._jm_scaling_factor(ctx, (((H.char_snap(H.npc(ctx)) or {}).stats or {}).intelligence or 0))))
        H.set_var("actor", H.u(ctx), ctx, "arvore_turn_into_tree_damage", services.random.native_float((ctx:get_number("damage_lower_bound") or 0), (ctx:get_number("damage_upper_bound") or 0)))
        H.set_var("actor", H.u(ctx), ctx, "health_comparison", ((((((H.char_hp(H.u(ctx), "arm_l", false) + H.char_hp(H.u(ctx), "arm_r", false)) + H.char_hp(H.u(ctx), "leg_l", false)) + H.char_hp(H.u(ctx), "leg_r", false)) + H.char_hp(H.u(ctx), "torso", false)) + H.char_hp(H.u(ctx), "head", false)) / 3))
        H.eoc_loc_var(H.u(ctx), ctx, "global", "arvore_tree_transform_target", nil, nil, nil, nil, { dx = math.floor(0), dy = math.floor(0), dz = math.floor(0) }, false, true, {  }, {  })
        if (H.var_num(H.u(ctx), "arvore_turn_into_tree_damage") > H.var_num(H.u(ctx), "health_comparison")) then
            if H.u(ctx) then services.characters.die(H.u(ctx)) end
            H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", nil, 0, 0, nil, nil, { "EOC_ARVORE_VERDANT_IMPRISONMENT_DELETE_NPC_ITEMS" })
            H.run_eoc("EOC_NONE", ctx, nil, nil, nil)
        end
        return false
    end
    end
    EOC["EOC_ARVORE_VERDANT_IMPRISONMENT_SUCCESS"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("global", nil, ctx, "arvore_tree_transform_target"), H.safe_id('terrain_furniture_transform', "ter_arvore_verdant_tree_transform"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    return true
    end
end
