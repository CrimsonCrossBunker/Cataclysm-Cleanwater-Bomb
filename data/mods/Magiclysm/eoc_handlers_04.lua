local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_NO_CASTING_RESTORATION_SPELLS_EFFECTS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_CASTING_RESTORATION_SPELLS") == 1)) == true
    end
    EOC["EOC_NO_CASTING_RESTORATION_SPELLS_EFFECTS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_CASTING_RESTORATION_SPELLS") == 1)) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "", 999, "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", 999, "=")
        return true
    end
    return false
    end
    COND["EOC_NO_CASTING_TRANSFORMATION_SPELLS_EFFECTS"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_CASTING_TRANSFORMATION_SPELLS") == 1)) == true
    end
    EOC["EOC_NO_CASTING_TRANSFORMATION_SPELLS_EFFECTS"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_CASTING_TRANSFORMATION_SPELLS") == 1)) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "", 999, "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", 999, "=")
        return true
    end
    return false
    end
    COND["EOC_NO_CASTING_FOR_EMPTY"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "MAGIC_EMPTY") == 1)) == true
    end
    EOC["EOC_NO_CASTING_FOR_EMPTY"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "MAGIC_EMPTY") == 1)) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", 999, "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "magiclysm", 999, "=")
        return true
    end
    return false
    end
    COND["EOC_MANA_OVERLOAD_MAKES_SPELLS_MORE_DIFFICULT"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_mana_overload"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MANA_OVERLOAD_MAKES_SPELLS_MORE_DIFFICULT"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_mana_overload"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_spell_adj(H.u(ctx), "difficulty", "", "", "magiclysm", H.creature_effect_intensity(H.u(ctx), "effect_mana_overload"), "=")
        H.set_spell_adj(H.u(ctx), "cost", "", "", "magiclysm", (H.creature_effect_intensity(H.u(ctx), "effect_mana_overload") / 2), "=")
        return true
    end
    return false
    end
    EOC["EOC_ARCHMAGE_BENEFITS_PROGRESSIVE_SCHOOL_DIFFICULTY_REDUCTIONS"] = function(ctx)
    H.set_spell_adj(H.u(ctx), "difficulty", "ANIMIST", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "ANIMIST") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "BIOMANCER", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "BIOMANCER") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "DRUID", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "DRUID") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "EARTHSHAPER", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "EARTHSHAPER") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "KELVINIST", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "KELVINIST") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "MAGUS", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "MAGUS") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "STORMSHAPER", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "STORMSHAPER") / 75))) * (-1)), (-6)), "=")
    H.set_spell_adj(H.u(ctx), "difficulty", "TECHNOMANCER", "", "", math.max((((function(_v) return _v >= 0 and math.floor(_v) or math.ceil(_v) end)((H.char_spell_level_sum(H.u(ctx), "TECHNOMANCER") / 75))) * (-1)), (-6)), "=")
    return true
    end
    COND["EOC_MC_CASTED_A_SPELL_LEARN_BOOST"] = function(ctx)
        return ((((("MANA_CRYST_MANA") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MANA_SEEKER_BOLTS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))))) == true
    end
    EOC["EOC_MC_CASTED_A_SPELL_LEARN_BOOST"] = function(ctx)
    if ((((("MANA_CRYST_MANA") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MANA_SEEKER_BOLTS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))))) then
        do local _a, _sp = H.u(ctx), H.var_str("context", nil, ctx, "spell", ""); local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = (((((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")) + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))))) or 0 end)())) / H._jm_mc_spell_cost_train_factor(ctx, (ctx:get_number("cost") or 0), 16, 65)) * H._jm_mc_spell_train_focus_factor(ctx, H.char_val_extra(H.u(ctx), "focus"), H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    end
    return false
    end
    COND["EOC_MC_CASTED_A_SPELL_LEARN_BOOST_ATTUNED"] = function(ctx)
        return ((((("MANA_CRYST_MANA") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MANA_SEEKER_BOLTS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARTIFICER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BLOOD_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BOREAL_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLEANSING_FLAME") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CRUSADER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTH_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FIRE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FORCE_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GAIAS_CHOSEN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GLACIER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GOLEMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GRAVITY_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ICE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ILLUSIONIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGNETISM_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("OVERCLOCKER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PERMAFROST_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("RADIATION_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAMAN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAPESHIFTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SOULFIRE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORM_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMCALLER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SUN_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TUNDRA_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VOID_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VULCANIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("WITHER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))))) == true
    end
    EOC["EOC_MC_CASTED_A_SPELL_LEARN_BOOST_ATTUNED"] = function(ctx)
    if ((((("MANA_CRYST_MANA") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MANA_SEEKER_BOLTS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ANIMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BIOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("DRUID") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTHSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("KELVINIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGUS") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMSHAPER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TECHNOMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ALCHEMIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARTIFICER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BLOOD_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("BOREAL_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CLEANSING_FLAME") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CRUSADER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("EARTH_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FIRE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("FORCE_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GAIAS_CHOSEN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GLACIER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GOLEMANCER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("GRAVITY_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ICE_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ILLUSIONIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("MAGNETISM_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("OVERCLOCKER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("PERMAFROST_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("RADIATION_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAMAN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SHAPESHIFTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SOULFIRE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORM_ELEMENTAL") == (H.var_str("context", nil, ctx, "school", "")))) or ((("STORMCALLER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SUN_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("TUNDRA_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VOID_MAGE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("VULCANIST") == (H.var_str("context", nil, ctx, "school", "")))) or ((("WITHER_MAGE") == (H.var_str("context", nil, ctx, "school", "")))))) then
        do local _a, _sp = H.u(ctx), H.var_str("context", nil, ctx, "spell", ""); local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = (((((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")) + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))))) or 0 end)())) / H._jm_mc_spell_cost_train_factor(ctx, (ctx:get_number("cost") or 0), 20, 75)) * H._jm_mc_spell_train_focus_factor(ctx, H.char_val_extra(H.u(ctx), "focus"), H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    end
    return false
    end
    COND["EOC_MC_CASTED_A_SPELL_LEARN_BOOST_BIOTEK"] = function(ctx)
        return (((("BIOTEK") == (H.var_str("context", nil, ctx, "school", ""))))) == true
    end
    EOC["EOC_MC_CASTED_A_SPELL_LEARN_BOOST_BIOTEK"] = function(ctx)
    if (((("BIOTEK") == (H.var_str("context", nil, ctx, "school", ""))))) then
        do local _a, _sp = H.u(ctx), H.var_str("context", nil, ctx, "spell", ""); local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = (((((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")) + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))))) or 0 end)())) * ((ctx:get_number("cost") or 0) / 5000)) * H._jm_mc_spell_train_focus_factor(ctx, H.char_val_extra(H.u(ctx), "focus"), H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    end
    return false
    end
    COND["EOC_MC_CASTED_A_SPELL_LEARN_BOOST_CLASSLESS"] = function(ctx)
        return ((((("crystallize_mana") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("dark_sight") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("megablast") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("create_atomic_light") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("blinding_flash") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("ethereal_grasp") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("obfuscated_body") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("obfuscated_body_plus") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("protection_aura") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("protection_aura_plus") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("translocate_self") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("acid_resistance") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("acid_resistance_greater") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("thought_shield") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("thought_shield_plus") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("sound_bomb") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_watch_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_clean_clothing_and_self") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_easy_sleep_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_dispel_magic") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_disjunction") == (H.var_str("context", nil, ctx, "spell", "")))))) == true
    end
    EOC["EOC_MC_CASTED_A_SPELL_LEARN_BOOST_CLASSLESS"] = function(ctx)
    if ((((("crystallize_mana") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("dark_sight") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("megablast") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("create_atomic_light") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("blinding_flash") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("ethereal_grasp") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("obfuscated_body") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("obfuscated_body_plus") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("protection_aura") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("protection_aura_plus") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("translocate_self") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("acid_resistance") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("acid_resistance_greater") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("thought_shield") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("thought_shield_plus") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("sound_bomb") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_watch_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_clean_clothing_and_self") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_easy_sleep_spell") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_dispel_magic") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("classless_disjunction") == (H.var_str("context", nil, ctx, "spell", "")))))) then
        do local _a, _sp = H.u(ctx), H.var_str("context", nil, ctx, "spell", ""); local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = (((((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")) + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))))) or 0 end)())) / H._jm_mc_spell_cost_train_factor(ctx, (ctx:get_number("cost") or 0), 16, 65)) * H._jm_mc_spell_train_focus_factor(ctx, H.char_val_extra(H.u(ctx), "focus"), H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.set_var("global", nil, ctx, "debug_mc_additional_spell_xp", (((((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")) + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', H.var_str("context", nil, ctx, "spell", "")); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", ""))))) or 0 end)())) / H._jm_mc_spell_cost_train_factor(ctx, (ctx:get_number("cost") or 0), 16, 65)) * H._jm_mc_spell_train_focus_factor(ctx, H.char_val_extra(H.u(ctx), "focus"), H.char_spell_level(H.u(ctx), H.var_str("context", nil, ctx, "spell", "")))))
        services.messages.add(ctx:expand_text(services.translate("debug_mc_additional_spell_xp: <global_val:debug_mc_additional_spell_xp>")), "debug")
        return true
    end
    return false
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_APPLY_FLAGS"] = function(ctx)
    if ((not (H.char_has_flag(H.npc(ctx), "SEMITANGIBLE"))) and (not (H.char_has_flag(H.npc(ctx), "UNRESTRICTED"))) and (not (H.char_has_flag(H.npc(ctx), "INTEGRATED")))) then
        do local _g = H.safe_id('json_flag', "SHAPESHIFTED_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "SEMITANGIBLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "UNRESTRICTED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "INTANGIBLE_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
        do local _g = H.safe_id('json_flag', "UNBREAKABLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    end
    return true
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_APPLY_FLAGS" }, {  })
    return true
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_REMOVE_FLAGS"] = function(ctx)
    do local _g = H.safe_id('json_flag', "SEMITANGIBLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "INTANGIBLE_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "UNRESTRICTED"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "SHAPESHIFTED_ARMOR"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    do local _g = H.safe_id('json_flag', "UNBREAKABLE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    EOC["EOC_SHAPESHIFTING_ARMOR_CHECK_RETURN_ARMOR_TO_NORMAL"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { flags = { "SHAPESHIFTED_ARMOR" } } }, { "EOC_SHAPESHIFTING_ARMOR_CHECK_SUBSUME_INTO_FORM_REMOVE_FLAGS" }, {  })
    return true
    end
    COND["EOC_DISPEL_MAGIC_REMOVE_ITEMS"] = function(ctx)
        return (((("effect_dispel_magic") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_DISPEL_MAGIC_REMOVE_ITEMS"] = function(ctx)
    if (((("effect_dispel_magic") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        do local g = H.safe_id('item', "decaying_boneclub"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "tentacle_whip"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "fleshpouch"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_caustic"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_biomancer_scalpel_fingers"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.lose_trait(H.u(ctx), "BIO_LASHING_TENTACLES")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_01")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_02")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_03")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_04")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_05")
        do local g = H.safe_id('item', "druid_recurve"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_naturearrows1"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_quiver"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_quiver_plus"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_feral"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_feral_plus"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_bandages"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "arrow_druid"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_bearmantle"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_bramble_spear_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_druid_breathing_water"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_druid_waterwalk"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "stonefist"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_stoneskin"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_hammer"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_pickaxe"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_ax"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_knife"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_shovel"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "finger_firelighter"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "ice_gliders"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "shield_ice"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "armor_frost"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "flamesword"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "jar_3l_force"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "impactsling"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "stormhammer"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "stormglove"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electric_lighter"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "flask_ethereal_rebreather"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_armor_magus_mage_conjured_armor"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_armor_magus_mage_conjured_armor"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "magic_lamp"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_summoned_radio"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_welder"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_far_sight_lens"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "thought_shield_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        return true
    end
    return false
    end
    COND["EOC_DISJUNCTION_REMOVE_ITEMS"] = function(ctx)
        return (((("effect_disjunction") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_DISJUNCTION_REMOVE_ITEMS"] = function(ctx)
    if (((("effect_disjunction") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        do local g = H.safe_id('item', "decaying_boneclub"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "tentacle_whip"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "fleshpouch"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_caustic"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_biomancer_scalpel_fingers"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.lose_trait(H.u(ctx), "BIO_LASHING_TENTACLES")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_01")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_02")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_03")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_04")
        H.lose_trait(H.u(ctx), "BIOMANCER_EAT_TONS_OF_FOOD_05")
        do local g = H.safe_id('item', "druid_recurve"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_naturearrows1"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_quiver"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_quiver_plus"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_feral"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_feral_plus"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_bandages"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "arrow_druid"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_bearmantle"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_bramble_spear_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_druid_breathing_water"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_druid_waterwalk"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "stonefist"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_stoneskin"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_hammer"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_pickaxe"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_ax"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_knife"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "eshaper_shovel"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "finger_firelighter"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "ice_gliders"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_kelvinist_frozen_heart"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "shield_ice"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "armor_frost"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "flamesword"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "jar_3l_force"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "impactsling"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "stormhammer"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "stormglove"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electric_lighter"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "flask_ethereal_rebreather"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "item_armor_magus_mage_conjured_armor"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "magic_lamp"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_summoned_radio"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_welder"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_far_sight_lens"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "druid_thorn_skin_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "bonespear"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "longsword_holy"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "technomancer_summoned_ups"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "alchemist_bomb"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "alchemist_mine"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "artificer_toolkit"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "demon_possession_aura"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_auroral_guard"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "holy_shield"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "longsword_judgement"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "flarewhip"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "force_magical_armor"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "subzero_talons"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "aura_cold_energy"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "pocket_sun"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "thought_shield_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "thought_shield_plus_item"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        return true
    end
    return false
    end
    COND["EOC_PUT_ON_WILDSHAPE_CLOAK_FISH"] = function(ctx)
        return ((((("wildshape_cloak_fish") == (H.var_str("context", nil, ctx, "itype", "")))) and (not (H.char_has_flag(H.u(ctx), "TEMPORARY_SHAPESHIFT"))))) == true
    end
    EOC["EOC_PUT_ON_WILDSHAPE_CLOAK_FISH"] = function(ctx)
    if ((((("wildshape_cloak_fish") == (H.var_str("context", nil, ctx, "itype", "")))) and (not (H.char_has_flag(H.u(ctx), "TEMPORARY_SHAPESHIFT"))))) then
        H.set_var("actor", H.u(ctx), ctx, "preshift_size", H.char_val_extra(H.u(ctx), "size"))
        do
            local _sw12 = H.var_num(H.u(ctx), "preshift_size")
            if _sw12 == 1 then
            elseif _sw12 == 2 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw12 == 3 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(4 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 4; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw12 == 4 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw12 == 5 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(10 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 10; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PUT_ON_WILDSHAPE_CLOAK_FISH_REMOVE"] = function(ctx)
        return (((("wildshape_cloak_fish") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_PUT_ON_WILDSHAPE_CLOAK_FISH_REMOVE"] = function(ctx)
    if (((("wildshape_cloak_fish") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        do
            local _sw13 = H.var_num(H.u(ctx), "preshift_size")
            if _sw13 == 1 then
            elseif _sw13 == 2 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw13 == 3 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(4 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 4; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw13 == 4 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw13 == 5 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(10 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 10; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR"] = function(ctx)
        return ((((("wildshape_cloak_bear") == (H.var_str("context", nil, ctx, "itype", "")))) and (not (H.char_has_flag(H.u(ctx), "TEMPORARY_SHAPESHIFT"))))) == true
    end
    EOC["EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR"] = function(ctx)
    if ((((("wildshape_cloak_bear") == (H.var_str("context", nil, ctx, "itype", "")))) and (not (H.char_has_flag(H.u(ctx), "TEMPORARY_SHAPESHIFT"))))) then
        H.set_var("actor", H.u(ctx), ctx, "preshift_size", H.char_val_extra(H.u(ctx), "size"))
        do
            local _sw14 = H.var_num(H.u(ctx), "preshift_size")
            if _sw14 == 1 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw14 == 2 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw14 == 3 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw14 == 4 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw14 == 5 then
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR_REMOVE"] = function(ctx)
        return (((("wildshape_cloak_bear") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_PUT_ON_WILDSHAPE_CLOAK_BEAR_REMOVE"] = function(ctx)
    if (((("wildshape_cloak_bear") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        do
            local _sw15 = H.var_num(H.u(ctx), "preshift_size")
            if _sw15 == 1 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(12 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 12; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw15 == 2 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(6 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 6; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw15 == 3 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw15 == 4 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw15 == 5 then
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PUT_ON_WILDSHAPE_CLOAK_DEER"] = function(ctx)
        return ((((("wildshape_cloak_deer") == (H.var_str("context", nil, ctx, "itype", "")))) and (not (H.char_has_flag(H.u(ctx), "TEMPORARY_SHAPESHIFT"))))) == true
    end
    EOC["EOC_PUT_ON_WILDSHAPE_CLOAK_DEER"] = function(ctx)
    if ((((("wildshape_cloak_deer") == (H.var_str("context", nil, ctx, "itype", "")))) and (not (H.char_has_flag(H.u(ctx), "TEMPORARY_SHAPESHIFT"))))) then
        H.set_var("actor", H.u(ctx), ctx, "preshift_size", H.char_val_extra(H.u(ctx), "size"))
        do
            local _sw16 = H.var_num(H.u(ctx), "preshift_size")
            if _sw16 == 1 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(4 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 4; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw16 == 2 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw16 == 3 then
            elseif _sw16 == 4 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw16 == 5 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(3 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 3; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_PUT_ON_WILDSHAPE_CLOAK_DEER_FOLLOWUP"] = function(ctx)
        return (((("wildshape_cloak_deer") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_PUT_ON_WILDSHAPE_CLOAK_DEER_FOLLOWUP"] = function(ctx)
    if (((("wildshape_cloak_deer") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        do
            local _sw17 = H.var_num(H.u(ctx), "preshift_size")
            if _sw17 == 1 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(4 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 4; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw17 == 2 then
                do local _a = H.u(ctx); if _a then if "*=" == '=' then services.needs.set_calories(_a, math.floor(2 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 2; local _d = ("*=" == '+=') and _nxt or (("*=" == '-=') and -_nxt or (("*=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw17 == 3 then
            elseif _sw17 == 4 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(1.5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 1.5; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            elseif _sw17 == 5 then
                do local _a = H.u(ctx); if _a then if "/=" == '=' then services.needs.set_calories(_a, math.floor(3 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 3; local _d = ("/=" == '+=') and _nxt or (("/=" == '-=') and -_nxt or (("/=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE"] = function(ctx)
        return (((("mring_sustenance") == (H.var_str("context", nil, ctx, "itype", ""))))) == true
    end
    EOC["EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE"] = function(ctx)
    if (((("mring_sustenance") == (H.var_str("context", nil, ctx, "itype", ""))))) then
        H.eoc_add_effect(H.u(ctx), "effect_mring_sustenance", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP_TRUE"] = function(ctx)
        return ((H.creature_effect_intensity(H.u(ctx), "effect_mring_sustenance") >= 25)) == true
    end
    EOC["EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP_TRUE"] = function(ctx)
    if ((H.creature_effect_intensity(H.u(ctx), "effect_mring_sustenance") >= 25)) then
        if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).kcal_percent or 0) <= 60) then
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(5 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 5; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        end
        if ((((H.char_snap(H.u(ctx)) or {}).needs or {}).kcal_percent or 0) <= 94.4) then
            do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(7 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 7; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        end
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP"), nil) end end
        return true
    else
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP"), nil) end end
        return false
    end
    end
    EOC["EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP_FALSE"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_mring_sustenance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { id = "mring_sustenance", worn_only = true } }, { "EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP_TRUE" }, { "EOC_MAGICLYSM_WEARING_RING_OF_SUSTENANCE_FOLLOW_UP_FALSE" })
    return true
    end
    COND["EOC_CLOAK_OF_ELVENKIND_TURN_ON"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((H.char_has_trait(H.u(ctx), "FOREST_STEALTH") == 1))) and ((function() local eg = H.safe_id('effect', "effect_elven_cloak_effect"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_tree_young" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_tall" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_long" end)()) or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick")))) == true
    end
    EOC["EOC_CLOAK_OF_ELVENKIND_TURN_ON"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((H.char_has_trait(H.u(ctx), "FOREST_STEALTH") == 1))) and ((function() local eg = H.safe_id('effect', "effect_elven_cloak_effect"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_tree_young" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_tall" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_long" end)()) or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick")))) then
        do local _g = H.safe_id('mutation', "FOREST_STEALTH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_CLOAK_OF_ELVENKIND_TURN_OFF"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "FOREST_STEALTH") == 1) and ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or (not (((function() local eg = H.safe_id('effect', "effect_elven_cloak_effect"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) or ((not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_tree_young" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_tall" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_long" end)()))) and (not (H.char_at_om_location(H.u(ctx), "forest"))) and (not (H.char_at_om_location(H.u(ctx), "forest_thick"))))))) == true
    end
    EOC["EOC_CLOAK_OF_ELVENKIND_TURN_OFF"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "FOREST_STEALTH") == 1) and ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) or (not (((function() local eg = H.safe_id('effect', "effect_elven_cloak_effect"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) or ((not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "SHRUB"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_tree_young" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_bamboo_tall" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_grass_long" end)()))) and (not (H.char_at_om_location(H.u(ctx), "forest"))) and (not (H.char_at_om_location(H.u(ctx), "forest_thick"))))))) then
        H.lose_trait(H.u(ctx), "FOREST_STEALTH")
        return true
    end
    return false
    end
    EOC["EOC_BIO_EAT_TONS_OF_FOOD_MUTATION_REMOVER"] = function(ctx)
    return true
    end
    COND["EOC_DRUID_WATER_WALKING"] = function(ctx)
        return (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "LIQUID"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) == true
    end
    EOC["EOC_DRUID_WATER_WALKING"] = function(ctx)
    if (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "LIQUID"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)())) then
        H.eoc_cast_spell(H.u(ctx), "druid_water_walking_real", false, { hit_self = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be standing on water to cast Water Strider's Walk")), "bad")
        return false
    end
    end
    COND["EOC_DRUID_WATERWALKING_REMOVERE"] = function(ctx)
        return ((H.char_has_item(H.u(ctx), "aura_druid_waterwalk") and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "LIQUID"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))))) == true
    end
    EOC["EOC_DRUID_WATERWALKING_REMOVERE"] = function(ctx)
    if ((H.char_has_item(H.u(ctx), "aura_druid_waterwalk") and (not (((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "LIQUID"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()))))) then
        do local g = H.safe_id('item', "aura_druid_waterwalk"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        services.messages.add(ctx:expand_text(services.translate("As you leave the water, your spell fades.")), "bad")
        return true
    end
    return false
    end
    COND["EOC_DRUID_SHIFTER_RAVEN_FORM_ASCEND"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_DRUID_SHIFTER_RAVEN_FORM_ASCEND"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "raven_form_fly_up_location", nil, nil, nil, { outdoor_only = true }, { dz = math.floor(1) }, false, true, {  }, {  })
        services.messages.add(ctx:expand_text(services.translate("Your wings carry you upward.")), "good")
        do local _p = H.get_tripoint_var("context", nil, ctx, "raven_form_fly_up_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You cannot fly up with a ceiling above you!")), "bad")
        return false
    end
    end
    EOC["EOC_LASHING_TENTACLES_MUTATION"] = function(ctx)
    return true
    end
    EOC["EOC_LASHING_TENTACLES_MUTATION_REMOVE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The tentacles recede back into your body.")), "bad")
    H.lose_trait(H.u(ctx), "BIO_LASHING_TENTACLES")
    return true
    end
    EOC["EOC_BIO_CAUSTIC_BLOOD_MUTATION"] = function(ctx)
    return true
    end
    EOC["EOC_BIO_CAUSTIC_BLOOD_MUTATION_REMOVE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The faint burning sensation fades.")), "bad")
    H.lose_trait(H.u(ctx), "ACIDBLOOD")
    H.lose_trait(H.u(ctx), "ACIDPROOF")
    return true
    end
    COND["EOC_MAGICLYSM_RAVENFOLK_HOARDER_UPDATE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "RAVENFOLK_BUILD") == 1) and (H.var_num(H.u(ctx), "has_ravenfolk_loves_gold_update") ~= 1))) == true
    end
    EOC["EOC_MAGICLYSM_RAVENFOLK_HOARDER_UPDATE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "RAVENFOLK_BUILD") == 1) and (H.var_num(H.u(ctx), "has_ravenfolk_loves_gold_update") ~= 1))) then
        do local _g = H.safe_id('mutation', "LOVES_SHINY_OBJECTS"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.lose_trait(H.u(ctx), "HOARDER")
        H.set_var("actor", H.u(ctx), ctx, "has_ravenfolk_loves_gold_update", 1)
        services.messages.add(ctx:expand_text(services.translate("Your ravenfolk traits have been updated.")), "mixed")
        return true
    end
    return false
    end
    COND["EOC_WARG_FOOD_ISNT_REAL"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "THRESH_SPECIES_GOBLIN") == 1))) and H.char_has_item(H.u(ctx), "warg_food"))) == true
    end
    EOC["EOC_WARG_FOOD_ISNT_REAL"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "THRESH_SPECIES_GOBLIN") == 1))) and H.char_has_item(H.u(ctx), "warg_food"))) then
        do local g = H.safe_id('item', "warg_food"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "warg_food"); if g and H.npc(ctx) then services.inventory.remove_type(H.npc(ctx), g) end end
        H.eoc_spawn_item(H.u(ctx), "meat", 1, false, false, nil)
        return true
    end
    return false
    end
    EOC["EOC_GIVE_COLD_AURA_OFF"] = function(ctx)
    return true
    end
    COND["EOC_perk_caster_level_up_animist"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_animist") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_animist"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_animist") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "ANIMIST", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_biomancer"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_biomancer") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_biomancer"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_biomancer") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "BIOMANCER", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_druid"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_druid") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_druid"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_druid") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "DRUID", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_earthshaper"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_earthshaper") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_earthshaper"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_earthshaper") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "EARTHSHAPER", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_kelvinist"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_kelvinist") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_kelvinist"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_kelvinist") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "KELVINIST", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_magus"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_magus") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_magus"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_magus") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "MAGUS", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_stormshaper"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_stormshaper") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_stormshaper"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_stormshaper") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "STORMSHAPER", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_perk_caster_level_up_technomancer"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_technomancer") == 1)) == true
    end
    EOC["EOC_perk_caster_level_up_technomancer"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_caster_level_up_technomancer") == 1)) then
        H.set_spell_adj(H.u(ctx), "level", "TECHNOMANCER", "", "", 1, "+=")
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_MANA_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_mana") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_MANA_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_mana") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_manatouched"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_manatouched"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    EOC["EOC_MAGICLYSM_SI_PRE_TELEPORT_LOCATION_CHECKING"] = function(ctx)
    if (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "magiclysm_si_on_sky_island_location", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "started_teleport_on_island", 1)
    else
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "magiclysm_si_on_ground_location", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "started_teleport_on_island", 0)
    end
    return true
    end
    COND["EOC_MAGICLYSM_SI_PRE_TELEPORT_POWER_CHECKING"] = function(ctx)
        return (((((("translocate_self") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("magus_word_of_recall") == (H.var_str("context", nil, ctx, "spell", ""))))))) == true
    end
    EOC["EOC_MAGICLYSM_SI_PRE_TELEPORT_POWER_CHECKING"] = function(ctx)
    if (((((("translocate_self") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("magus_word_of_recall") == (H.var_str("context", nil, ctx, "spell", ""))))))) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MAGICLYSM_SI_POST_TELEPORT_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_MAGICLYSM_SI_POST_TELEPORT_FOLLOWUP"] = function(ctx)
        return (((H.var_num(H.u(ctx), "started_teleport_on_island") == 0) and (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))))) == true
    end
    EOC["EOC_MAGICLYSM_SI_POST_TELEPORT_FOLLOWUP"] = function(ctx)
    if (((H.var_num(H.u(ctx), "started_teleport_on_island") == 0) and (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))))) then
        if (H.char_has_trait(H.u(ctx), "awayfromhome") == 1) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "magiclysm_si_on_ground_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            ccb.presentation.notice(ctx:expand_text(services.translate("You briefly see the familiar sights of the floating island before you feel a wrenching sensation and you're suddenly back on the surface.  Whatever powers have put you in this situation must not be happy with you trying to circumvent the rules.")))
            H.set_var("global", nil, ctx, "timeawayfromhome", (H.global_var_num("timeawayfromhome")) + (1))
        end
        return true
    else
        if ((H.var_num(H.u(ctx), "started_teleport_on_island") == 1) and (not ((((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9)))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("As you come out of the darkness and the cold and see the surface, you feel a sudden wrenching sensation.  Pain washes over your entire body as your vision goes red, and the air burns as you take in a ragged breath.  The powers behind your situation are not happy at your attempt to circumvent their rules.")))
            H.eoc_add_effect(H.u(ctx), "warpsickness", -1, nil, 3, nil)
            do local _t = math.max(1, math.floor((180 * (((H.global_var_num("bonuspulses") > 0)) and ((H.global_var_num("bonuspulses") * 60)) or (1))))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MAGICLYSM_SI_PRE_TELEPORT_POST_TELEPORT_FOLLOWUP"), nil) end end
        end
        return false
    end
    end
    EOC["EOC_MAGICLYSM_SI_PRE_TELEPORT_POST_TELEPORT_FOLLOWUP"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "OM_HQ_origin"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    ccb.presentation.notice(ctx:expand_text(services.translate("With an internal twist, you're suddenly back on the island.")))
    do local _eg = H.safe_id('effect', "warpsickness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_FERAL_RADIATION_MAGE_MAGIC_FISSILE_IRRADIATES_YOU"] = function(ctx)
    H.set_char_val_extra(H.npc(ctx), "rad", (services.random.native_int(0, H.round_half_away(10)) + 10), "+=")
    if H.npc(ctx) then services.characters.emit(H.npc(ctx), "emit_rad_leak", 1) end
    return true
    end
    EOC["EOC_RUST_MONSTER_RUSTING_TRUE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your <npc_name> rusts away to dust!")), "bad")
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    EOC["EOC_RUST_MONSTER_RUSTING_FALSE"] = function(ctx)
    H.set_char_val_extra(H.u(ctx), "anger", 0, "=")
    return true
    end
    EOC["EOC_RUST_MONSTER_RUSTING"] = function(ctx)
    H.eoc_run_inv_eocs(H.npc(ctx), ctx, "random", nil, { { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { worn_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true }, { wielded_only = true } }, { "EOC_RUST_MONSTER_RUSTING_TRUE" }, { "EOC_RUST_MONSTER_RUSTING_FALSE" })
    return true
    end
    COND["EOC_THAUMIC_ZOMBIE_MANA_DRAIN"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_THAUMIC_ZOMBIE_MANA_DRAIN"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        local _a18 = H.npc(ctx)
        if _a18 then services.spells.set_mana_raw(_a18, math.floor((H.char_mana(_a18, "current")) - (5))) end
        return true
    end
    return false
    end
    COND["EOC_THAUMIC_ZOMBIE_MANA_DRAIN_BITE"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_THAUMIC_ZOMBIE_MANA_DRAIN_BITE"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        local _a19 = H.npc(ctx)
        if _a19 then services.spells.set_mana_raw(_a19, math.floor((H.char_mana(_a19, "current")) - (15))) end
        return true
    end
    return false
    end
    COND["EOC_FORGE_LOCKDOWN"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "VAULT_DEFENDER") == 1)))) == true
    end
    EOC["EOC_FORGE_LOCKDOWN"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "VAULT_DEFENDER") == 1)))) then
        do local _g = H.safe_id('mutation', "MARK_FOR_DEATH_VALZAIN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
end
