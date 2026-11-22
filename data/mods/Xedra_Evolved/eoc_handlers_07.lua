local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_IERDE_ENTRAP_TARGET_IN_STONE"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)()))) == true
    end
    EOC["EOC_IERDE_ENTRAP_TARGET_IN_STONE"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.creature.position, fg) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)()))) then
        H.eoc_cast_spell(H.u(ctx), "ierde_trap_target_local_terrain_bash", false, nil)
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_ierde_entrap_target_in_stone"); if _p and _g then services.world.transform_radius(_p, math.floor(1), _g, nil) end end
        do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "ter_ierde_entrap_target_in_stone_ground_zero"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
        return true
    end
    return false
    end
    COND["EOC_IERDE_TUNNEL_TRANSLOCATE_CHECK"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-2)))) == true
    end
    EOC["EOC_IERDE_TUNNEL_TRANSLOCATE_CHECK"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-2)))) then
        H.eoc_cast_spell(H.u(ctx), "paraclesian_translocate", false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be standing deep underground and on the living earth to translocate.")), "mixed")
        return false
    end
    end
    COND["EOC_IERDE_TUNNEL_ATTUNEMENT_CHECK"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-2)))) == true
    end
    EOC["EOC_IERDE_TUNNEL_ATTUNEMENT_CHECK"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rock_floor" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_railroad_rubble" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_dirt_underground" end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-2)))) then
        H.eoc_cast_spell(H.u(ctx), "ierde_tunnel_translocation_attune_real", false, { targeted = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be deep underground on and on the living earth  to cast this spell.")), "mixed")
        return false
    end
    end
    COND["EOC_IERDE_BODY_OF_ADAMANT_LIMB_HEALER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "IERDE_NO_BROKEN_BONES") == 1)) == true
    end
    EOC["EOC_IERDE_BODY_OF_ADAMANT_LIMB_HEALER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "IERDE_NO_BROKEN_BONES") == 1)) then
        if (H.char_hp(H.u(ctx), "arm_r", false) == 0) then
            H.set_char_hp(H.u(ctx), "arm_r", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "arm_l", false) == 0) then
            H.set_char_hp(H.u(ctx), "arm_l", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "leg_r", false) == 0) then
            H.set_char_hp(H.u(ctx), "leg_r", 1, "+=")
        end
        if (H.char_hp(H.u(ctx), "leg_l", false) == 0) then
            H.set_char_hp(H.u(ctx), "leg_l", 1, "+=")
        end
        return true
    end
    return false
    end
    COND["EOC_FAE_GRAMARYE_SKILL_EXP"] = function(ctx)
        return ((H.char_has_any_trait(H.u(ctx), { "CHANGELING_MAGIC", "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "UNDINE", "SYLPH", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }) and (((("CHANGELING_MAGIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_SPRING") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_SUMMER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_AUTUMN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_WINTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARVORE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SALAMANDER") == (H.var_str("context", nil, ctx, "school", ""))))))) == true
    end
    EOC["EOC_FAE_GRAMARYE_SKILL_EXP"] = function(ctx)
    if ((H.char_has_any_trait(H.u(ctx), { "CHANGELING_MAGIC", "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "UNDINE", "SYLPH", "BLOODTHORNE_DRUID_SYMBIOTIC_PLANT" }) and (((("CHANGELING_MAGIC") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_SPRING") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_SUMMER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_AUTUMN") == (H.var_str("context", nil, ctx, "school", "")))) or ((("CHANGELING_SEASONAL_MAGIC_WINTER") == (H.var_str("context", nil, ctx, "school", "")))) or ((("ARVORE") == (H.var_str("context", nil, ctx, "school", "")))) or ((("SALAMANDER") == (H.var_str("context", nil, ctx, "school", ""))))))) then
        local _a33 = H.u(ctx)
        local _sg34 = H.safe_id("skill", "gramarye")
        if _a33 and _sg34 then services.skills.set(_a33, _sg34, { exercise_raw = math.floor((H.char_skill_exp(_a33, "gramarye", true)) + (((250 * (ctx:get_number("difficulty") or 0)) * (services.gameplay.options.get_number("SKILL_TRAINING_SPEED") or 0)))) }) end
        return true
    end
    return false
    end
    EOC["EOC_SUCCESSFUL_ROLL_REMAINDER_GOSSAMER_RECIPE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your dreams have revealed to you a recipe for gossamer raiment.")), "good")
    return true
    end
    COND["EOC_PARACLESIAN_GOSSAMER_RECIPES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PARACLESIAN_LEARN_GOSSAMER_RECIPES") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_paraclesian_learned_gossamer"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_PARACLESIAN_GOSSAMER_RECIPES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PARACLESIAN_LEARN_GOSSAMER_RECIPES") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_paraclesian_learned_gossamer"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_paraclesian_learned_gossamer", (services.random.native_int(0, H.round_half_away(864000)) + 345600), nil, nil, nil)
        do local _ok = false; local _ids = {}; for _, s in ipairs({ "tunic_gossamer", "sleeveless_tunic_gossamer", "doublet_gossamer", "dress_gossamer", "gown_gossamer", "cloak_gossamer", "jacket_light_gossamer", "robe_wizard_gossamer", "gloves_light_gossamer", "loincloth_gossamer", "pants_gossamer", "pants_no_pocket_gossamer", "skirt_gossamer", "skirt_long_gossamer", "socks_gossamer", "stockings_gossamer", "slippers_gossamer", "sheet_gossamer_patchwork", "gambeson_gossamer", "gambeson_hood_gossamer", "gambeson_pants_gossamer", "gambeson_batting_gossamer" }) do local g = H.safe_id("recipe", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "recipe", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
            if _ok then H.run_eoc("EOC_SUCCESSFUL_ROLL_REMAINDER_GOSSAMER_RECIPE", ctx) end
        end
        return true
    end
    return false
    end
    COND["EOC_WANTS_TO_TALK"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).npc == true) and ((("effect_wants_to_talk") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_WANTS_TO_TALK"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).npc == true) and ((("effect_wants_to_talk") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        do local _eg = H.safe_id('effect', "effect_wants_to_talk"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        if (not ((H.char_has_trait(H.u(ctx), "FINAL_DISCUSSION") == 1))) then
            do local _g = H.safe_id('mutation', "FINAL_DISCUSSION"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            if H.npc(ctx) then services.npcs.request_talk(H.npc(ctx)) end
        else
            do local _eg = H.safe_id('effect', "effect_wants_to_talk"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            services.messages.add(ctx:expand_text(services.translate("You cannot lead this person to talk to you anymore.")), "neutral")
        end
        return true
    end
    return false
    end
    COND["EOC_PARACLESIANS_CANNOT_USE_PURIFIER"] = function(ctx)
        return (H.char_has_any_trait(H.u(ctx), { "ARVORE", "HOMULLUS", "IERDE", "SALAMANDER", "SYLPH", "UNDINE" })) == true
    end
    EOC["EOC_PARACLESIANS_CANNOT_USE_PURIFIER"] = function(ctx)
    if (H.char_has_any_trait(H.u(ctx), { "ARVORE", "HOMULLUS", "IERDE", "SALAMANDER", "SYLPH", "UNDINE" })) then
        do local _a, _v = H.u(ctx), "mutagen_human"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 0; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    EOC["EOC_SALAMANDER_NEAR_FIRE_CHECK_3"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "salamander_near_fire", nil, nil, { kind = "field", id = H.safe_id("field", "fd_fire") }, { target_max_radius = math.floor(5) }, nil, false, true, {  }, {  })
    if ((function() local p = H.get_tripoint_var("context", nil, ctx, "salamander_near_fire"); local fg = H.safe_id('field', "fd_fire"); return p ~= nil and fg ~= nil and services.gameplay.environment.field_exists(p, fg, true) end)()) then
        H.set_var("actor", H.u(ctx), ctx, "salamander_near_fire", 1)
    else
        H.set_var("actor", H.u(ctx), ctx, "salamander_near_fire", 0)
    end
    return true
    end
    COND["EOC_SALAMANDER_NEAR_FIRE_CHECK_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air1"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air2"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air3"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air4"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()))) == true
    end
    EOC["EOC_SALAMANDER_NEAR_FIRE_CHECK_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air1"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air2"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air3"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_hot_air4"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) or ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()))) then
        H.set_var("actor", H.u(ctx), ctx, "salamander_near_fire", 1)
        return true
    else
        H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK_3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_SALAMANDER_NEAR_FIRE_CHECK"] = function(ctx)
        return ((not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.var_num(H.u(ctx), "salamander_near_fire") == 0))))) == true
    end
    EOC["EOC_SALAMANDER_NEAR_FIRE_CHECK"] = function(ctx)
    if ((not ((((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and (H.var_num(H.u(ctx), "salamander_near_fire") == 0))))) then
        H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1)) == true
    end
    EOC["EOC_SALAMANDER_NEAR_FIRE_CHECK_RECURRING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1)) then
        H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_SALAMANDER_NEAR_FIRE_CHECK_SPELLBOOK"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1)) == true
    end
    EOC["EOC_SALAMANDER_NEAR_FIRE_CHECK_SPELLBOOK"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SALAMANDER") == 1)) then
        H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_SALAMANDER_NEAR_FIRE_CHECK_CRAFTING"] = function(ctx)
        return (((((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))) and (H.char_has_trait(H.u(ctx), "SALAMANDER") == 1))) == true
    end
    EOC["EOC_SALAMANDER_NEAR_FIRE_CHECK_CRAFTING"] = function(ctx)
    if (((((("ACT_MULTIPLE_CRAFT") == (H.var_str("context", nil, ctx, "activity", "")))) or ((("ACT_CRAFT") == (H.var_str("context", nil, ctx, "activity", ""))))) and (H.char_has_trait(H.u(ctx), "SALAMANDER") == 1))) then
        H.run_eoc("EOC_SALAMANDER_NEAR_FIRE_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_SALAMANDER_FIRE_FLY"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_salamander_levitation", (12 + (((H.char_spell_count(H.u(ctx), "SALAMANDER") * 1.6) + (H.char_skill(H.u(ctx), "gramarye") * 2.4)) * services.random.native_float(2, 4))), nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "effect_salamander_featherfall", (15 + (((H.char_spell_count(H.u(ctx), "SALAMANDER") * 1.6) + (H.char_skill(H.u(ctx), "gramarye") * 2.4)) * 4)), nil, nil, nil)
    H.eoc_cast_spell(H.u(ctx), "salamander_fire_fly_real", false, { targeted = true })
    return true
    end
    COND["EOC_SALAMANDER_WATER_TO_BOOZE"] = function(ctx)
        return (((("SALAMANDER_WATER_TO_BOOZE") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_SALAMANDER_WATER_TO_BOOZE"] = function(ctx)
    if (((("SALAMANDER_WATER_TO_BOOZE") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "mixed_alcohol_strong_from_water")
        services.messages.add(ctx:expand_text(services.translate("From the fiery depths of your spirit, knowledge of how to turn various other water into strong alcohol fills your mind.")), "good")
        return true
    end
    return false
    end
    COND["EOC_SALAMANDER_WATER_TO_FUEL"] = function(ctx)
        return (((("SALAMANDER_WATER_TO_FUEL") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_SALAMANDER_WATER_TO_FUEL"] = function(ctx)
    if (((("SALAMANDER_WATER_TO_FUEL") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "lamp_oil_from_water")
        services.messages.add(ctx:expand_text(services.translate("From the fiery depths of your spirit, knowledge of how to turn various other water into lamp oil fills your mind.")), "good")
        return true
    end
    return false
    end
    COND["EOC_SALAMANDER_REBORN_IN_FLAMES_COOLDOWN"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SALAMANDER_PREVENT_DEATH") == 1) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) and ((function() local eg = H.safe_id('effect', "effect_salamander_prevented_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (7)))) == true
    end
    EOC["EOC_SALAMANDER_REBORN_IN_FLAMES_COOLDOWN"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SALAMANDER_PREVENT_DEATH") == 1) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) and ((function() local eg = H.safe_id('effect', "effect_salamander_prevented_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (7)))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("As your body takes its final wound, your fae spirit drinks in the heat of the flames and your flesh is renewed.")))
        H.run_eoc("EOC_PERENNIAL_REBIRTH_HEAL", ctx, nil, nil, nil)
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(40000 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 40000; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    end
    return false
    end
    COND["EOC_SALAMANDER_REBORN_IN_FLAMES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "SALAMANDER_PREVENT_DEATH") == 1) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) and (not (((function() local eg = H.safe_id('effect', "effect_salamander_prevented_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_SALAMANDER_REBORN_IN_FLAMES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "SALAMANDER_PREVENT_DEATH") == 1) and ((function() local s = H.char_snap(H.u(ctx)); local fg = H.safe_id('field', "fd_fire"); if not s or not s.creature or not fg then return false end; return services.gameplay.environment.field_exists(s.creature.position, fg, true) end)()) and (not (((function() local eg = H.safe_id('effect', "effect_salamander_prevented_death"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("As your body takes its final wound, your fae spirit drinks in the heat of the flames and your flesh is renewed.")))
        H.run_eoc("EOC_PERENNIAL_REBIRTH_HEAL", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_salamander_prevented_death", 1209600, nil, nil, nil)
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(40000 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 40000; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    else
        H.run_eoc("EOC_SALAMANDER_REBORN_IN_FLAMES_COOLDOWN", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_SYLPH_LIGHTNING_MELEE_ATTACKS_MELEE_MONSTER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE") == 1)) == true
    end
    EOC["EOC_SYLPH_LIGHTNING_MELEE_ATTACKS_MELEE_MONSTER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE") == 1)) then
        local _a35 = H.u(ctx)
        if _a35 then services.spells.set_mana_raw(_a35, math.floor((H.char_mana(_a35, "current")) - (3))) end
        return true
    end
    return false
    end
    COND["EOC_SYLPH_LIGHTNING_MELEE_ATTACKS_MELEE_CHARACTER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE") == 1)) == true
    end
    EOC["EOC_SYLPH_LIGHTNING_MELEE_ATTACKS_MELEE_CHARACTER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE") == 1)) then
        local _a36 = H.u(ctx)
        if _a36 then services.spells.set_mana_raw(_a36, math.floor((H.char_mana(_a36, "current")) - (3))) end
        return true
    end
    return false
    end
    COND["EOC_SYLPH_REVEAL_OVERMAP"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_SYLPH_REVEAL_OVERMAP"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.eoc_cast_spell(H.u(ctx), "sylph_reveal_overmap_spell_real", false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outdoors to cast Like a Bird on the Wing.")), "bad")
        return false
    end
    end
    COND["EOC_SYLPH_MASSIVE_LIGHTNING_BOLT"] = function(ctx)
        return ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) == true
    end
    EOC["EOC_SYLPH_MASSIVE_LIGHTNING_BOLT"] = function(ctx)
    if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
        H.eoc_cast_spell(H.u(ctx), "sylph_massive_lightning_bolt_spell_real", false, { targeted = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outdoors to cast Fist of Heaven's Fury.")), "bad")
        return false
    end
    end
    COND["EOC_SYLPH_WIND_TRANSLOCATE_CHECK"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 3) or (H.weather_val("windpower") >= 20)))) == true
    end
    EOC["EOC_SYLPH_WIND_TRANSLOCATE_CHECK"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and ((((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 3) or (H.weather_val("windpower") >= 20)))) then
        H.eoc_cast_spell(H.u(ctx), "paraclesian_translocate", false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outdoors and in a strong wind or high above the earth to translocate.")), "mixed")
        return false
    end
    end
    COND["EOC_SYLPH_WIND_ATTUNEMENT_CHECK"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 3))) == true
    end
    EOC["EOC_SYLPH_WIND_ATTUNEMENT_CHECK"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 3))) then
        H.eoc_cast_spell(H.u(ctx), "sylph_wind_translocation_attune_real", false, { targeted = true })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be outdoors and high above the earth to cast this spell.")), "mixed")
        return false
    end
    end
    COND["EOC_SYLPH_GOBLIN_FRUIT"] = function(ctx)
        return ((((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.weather_val("windpower") >= 15)) or ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1)))) == true
    end
    EOC["EOC_SYLPH_GOBLIN_FRUIT"] = function(ctx)
    if ((((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.weather_val("windpower") >= 15)) or ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 1)))) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_sylph", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must have a strong enough wind or be above ground level to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_CONDITION_CHECK_UNDINE_NEAR_WATER_ON_OMT_ENTER_2"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pond_field", math.floor(1)) end)()) or H.char_at_om_location(H.u(ctx), "fishing_pond_0_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_0_1") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_1") or H.char_at_om_location(H.u(ctx), "forest_water") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SE"))) == true
    end
    EOC["EOC_CONDITION_CHECK_UNDINE_NEAR_WATER_ON_OMT_ENTER_2"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river_bank", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "generic_river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_center", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_ne", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_nw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_se", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "river_c_not_sw", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lake_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_shore", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_bed", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_water_cube", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "ocean_surface", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pond_field", math.floor(1)) end)()) or H.char_at_om_location(H.u(ctx), "fishing_pond_0_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_0") or H.char_at_om_location(H.u(ctx), "fishing_pond_0_1") or H.char_at_om_location(H.u(ctx), "fishing_pond_1_1") or H.char_at_om_location(H.u(ctx), "forest_water") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_NE") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SW") or H.char_at_om_location(H.u(ctx), "undine_genius_loci_SE"))) then
        H.set_var("actor", H.u(ctx), ctx, "undine_is_connected_to_waters", 1)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "undine_is_connected_to_waters", 0)
        return false
    end
    end
    COND["EOC_CONDITION_CHECK_UNDINE_NEAR_WATER_ON_OMT_ENTER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "UNDINE") == 1)) == true
    end
    EOC["EOC_CONDITION_CHECK_UNDINE_NEAR_WATER_ON_OMT_ENTER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "UNDINE") == 1)) then
        H.run_eoc("EOC_CONDITION_CHECK_UNDINE_NEAR_WATER_ON_OMT_ENTER_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_CONDITION_CHECK_UNDINE_IN_WATER"] = function(ctx)
        return (((H.u(ctx) ~= nil and services.characters.is_underwater(H.u(ctx)).value == true) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_dp" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_sh" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_hot" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_murky" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_sh_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_sh_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_sh" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_moving_dp" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_moving_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_sh_murky_underground" end)()))) == true
    end
    EOC["EOC_CONDITION_CHECK_UNDINE_IN_WATER"] = function(ctx)
    if (((H.u(ctx) ~= nil and services.characters.is_underwater(H.u(ctx)).value == true) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_dp" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_sh" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_hot" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_murky" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_sh_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_sh_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_swater_sh" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_moving_dp" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_moving_dp_underground" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_water_sh_murky_underground" end)()))) then
        return true
    end
    return false
    end
    COND["EOC_CONDITION_UNDINE_CLOSE_TO_OR_IN_WATER"] = function(ctx)
        return (((H.var_num(H.u(ctx), "undine_is_connected_to_waters") == 1) or H.test_eoc("EOC_CONDITION_CHECK_UNDINE_IN_WATER", ctx))) == true
    end
    EOC["EOC_CONDITION_UNDINE_CLOSE_TO_OR_IN_WATER"] = function(ctx)
    if (((H.var_num(H.u(ctx), "undine_is_connected_to_waters") == 1) or H.test_eoc("EOC_CONDITION_CHECK_UNDINE_IN_WATER", ctx))) then
        return true
    end
    return false
    end
    EOC["EOC_COMPLETED_ROLL_REMAINDER_ELEMENTAL_RECIPE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("These are all the ways you can alter these elements now.")), "neutral")
    return true
    end
    EOC["EOC_SUCCESFUL_ROLL_REMAINDER_ELEMENTAL_RECIPE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You learn how to alter an element.")), "neutral")
    return true
    end
    COND["EOC_UNDINE_LEARN_SALTWATER_TO_FRESHWATER"] = function(ctx)
        return (((("SALTWATER_TO_FRESHWATER") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_UNDINE_LEARN_SALTWATER_TO_FRESHWATER"] = function(ctx)
    if (((("SALTWATER_TO_FRESHWATER") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "salt_water_from_water")
        H.learn_recipe(H.u(ctx), "water_from_salt_water")
        services.messages.add(ctx:expand_text(services.translate("Drawn from some atavistic well, knowledge of how to turn fresh water into salt water, and vice versa, fills your mind.")), "good")
        return true
    end
    return false
    end
    COND["EOC_UNDINE_LEARN_FOUL_WATER"] = function(ctx)
        return (((("FOUL_WATER") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_UNDINE_LEARN_FOUL_WATER"] = function(ctx)
    if (((("FOUL_WATER") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "water_from_water_clean")
        H.learn_recipe(H.u(ctx), "water_clean_from_water")
        services.messages.add(ctx:expand_text(services.translate("Drawn from some atavistic well, knowledge of how to turn foul water into clean, pure water, and vice versa, fills your mind.")), "good")
        return true
    end
    return false
    end
    COND["EOC_UNDINE_LEARN_LIQUID_TO_WATER"] = function(ctx)
        return (((("LIQUID_TO_WATER") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_UNDINE_LEARN_LIQUID_TO_WATER"] = function(ctx)
    if (((("LIQUID_TO_WATER") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        H.learn_recipe(H.u(ctx), "water_from_liquid")
        H.learn_recipe(H.u(ctx), "water_clean_from_water")
        services.messages.add(ctx:expand_text(services.translate("Drawn from some atavistic well, knowledge of how to turn various other liquids directly into water fills your mind.")), "good")
        return true
    end
    return false
    end
    EOC["EOC_UNDINE_DRAG_INWARD_SELECTOR"] = function(ctx)
    do
        local _sw37 = H.char_spell_level(H.u(ctx), "undine_drag_inward_spell")
        if _sw37 == 0 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_01", false, { targeted = true })
        elseif _sw37 == 4 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_02", false, { targeted = true })
        elseif _sw37 == 8 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_03", false, { targeted = true })
        elseif _sw37 == 12 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_04", false, { targeted = true })
        elseif _sw37 == 16 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_05", false, { targeted = true })
        elseif _sw37 == 20 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_06", false, { targeted = true })
        elseif _sw37 == 24 then
            H.eoc_cast_spell(H.u(ctx), "undine_drag_inward_spell_07", false, { targeted = true })
        end
    end
    return true
    end
    COND["EOC_UNDINE_GOBLIN_FRUIT"] = function(ctx)
        return (H.test_eoc("EOC_CONDITION_UNDINE_CLOSE_TO_OR_IN_WATER", ctx)) == true
    end
    EOC["EOC_UNDINE_GOBLIN_FRUIT"] = function(ctx)
    if (H.test_eoc("EOC_CONDITION_UNDINE_CLOSE_TO_OR_IN_WATER", ctx)) then
        H.eoc_spawn_item(H.u(ctx), "spell_spawned_goblin_fruit_undine", 1, true, false, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be standing in water or near a large body of water to call forth a goblin fruit.")), "bad")
        return false
    end
    end
    COND["EOC_UNDINE_WATER_PUSH_AWAY"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "UNDINE_WATER_PUSH_AWAY") == 1) and services.random.native_probability((((1 + H.char_has_trait(H.u(ctx), "THRESH_UNDINE")) + H.char_has_trait(H.u(ctx), "THRESH_UNDINE"))), (40)))) == true
    end
    EOC["EOC_UNDINE_WATER_PUSH_AWAY"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "UNDINE_WATER_PUSH_AWAY") == 1) and services.random.native_probability((((1 + H.char_has_trait(H.u(ctx), "THRESH_UNDINE")) + H.char_has_trait(H.u(ctx), "THRESH_UNDINE"))), (40)))) then
        H.eoc_cast_spell(H.u(ctx), "undine_water_push_away", false, nil)
        H.eoc_cast_spell(H.u(ctx), "undine_water_push_away", false, nil)
        return true
    end
    return false
    end
    COND["EOC_UNDINE_WATER_FORM_TRAITS_LOSE_WATER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "UNDINE_WATER_FORM_TRAITS") == 1)) == true
    end
    EOC["EOC_UNDINE_WATER_FORM_TRAITS_LOSE_WATER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "UNDINE_WATER_FORM_TRAITS") == 1)) then
        H.set_char_val_extra(H.u(ctx), "thirst", 4, "+=")
        return true
    end
    return false
    end
    EOC["EOC_CHANGELING_GLOBAL_SET_SEASON_FOR_JMATH"] = function(ctx)
    if (services.time_snapshot().season_id == string.lower("spring")) then
        H.set_var("global", nil, ctx, "global_what_is_the_season", 1)
    end
    if (services.time_snapshot().season_id == string.lower("summer")) then
        H.set_var("global", nil, ctx, "global_what_is_the_season", 2)
    end
    if (services.time_snapshot().season_id == string.lower("autumn")) then
        H.set_var("global", nil, ctx, "global_what_is_the_season", 3)
    end
    if (services.time_snapshot().season_id == string.lower("winter")) then
        H.set_var("global", nil, ctx, "global_what_is_the_season", 4)
    end
    return true
    end
    EOC["EOC_CHANGELING_NO_CASTING_OTHER_GLAMOURS_CHECKER"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_changeling_using_glamour_removes_checker", -1, nil, nil, nil)
    return true
    end
    COND["EOC_NOBLE_ATTACKS_SOMEONE_WHILE_RIGHT_OF_PASSAGE_RANGED_MONSTER"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS") == 1) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CHANGELING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HOMULLUS")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "UNDINE")).value == true)))))) == true
    end
    EOC["EOC_NOBLE_ATTACKS_SOMEONE_WHILE_RIGHT_OF_PASSAGE_RANGED_MONSTER"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS") == 1) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CHANGELING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HOMULLUS")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "UNDINE")).value == true)))))) then
        H.eoc_add_effect(H.u(ctx), "effect_changeling_noble_broken_right_of_passage", 3600, nil, nil, nil)
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_NOBLE_RIGHT_OF_PASSAGE_deactivate_future"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_NOBLE_ATTACKS_SOMEONE_WHILE_RIGHT_OF_PASSAGE_MELEE_MONSTER"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS") == 1) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CHANGELING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HOMULLUS")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "UNDINE")).value == true)))))) == true
    end
    EOC["EOC_NOBLE_ATTACKS_SOMEONE_WHILE_RIGHT_OF_PASSAGE_MELEE_MONSTER"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS") == 1) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "PLANT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "MIGO") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "MIGO")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CHANGELING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CHANGELING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ARVORE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ARVORE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "IERDE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "IERDE")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "HOMULLUS") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "HOMULLUS")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SALAMANDER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SALAMANDER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "SYLPH") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "SYLPH")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "UNDINE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "UNDINE")).value == true)))))) then
        H.eoc_add_effect(H.u(ctx), "effect_changeling_noble_broken_right_of_passage", 3600, nil, nil, nil)
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CHANGELING_NOBLE_RIGHT_OF_PASSAGE_deactivate_future"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_CHANGELING_NOBLE_MOVEMENT_BUFFS"] = function(ctx)
        return (((H.char_snap(H.u(ctx)) or {}).npc == true)) == true
    end
    EOC["EOC_CHANGELING_NOBLE_MOVEMENT_BUFFS"] = function(ctx)
    if (((H.char_snap(H.u(ctx)) or {}).npc == true)) then
        H.set_var("actor", H.u(ctx), ctx, "glamoured_changeling_noble_traits", H.char_sum_traits_cat(H.npc(ctx), "FAIR_FOLK_NOBLE", "ALL"))
        H.set_var("actor", H.u(ctx), ctx, "glamoured_deduction_movement_buff", H.char_skill(H.npc(ctx), "gramarye"))
        H.eoc_add_effect(H.u(ctx), "effect_changeling_noble_movement_buffs_ally", services.random.native_float((((H.var_num(H.u(ctx), "glamoured_changeling_noble_traits") * 5.5) + (H.var_num(H.u(ctx), "glamoured_deduction_movement_buff") * 39)) + 225), (((H.var_num(H.u(ctx), "glamoured_changeling_noble_traits") * 12.3) + (H.var_num(H.u(ctx), "glamoured_deduction_movement_buff") * 89)) + 691)), nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Your stretch your limbs and bounce on your heels.")), "neutral")
        H.eoc_add_effect(H.u(ctx), "effect_changeling_noble_movement_buffs", services.random.native_float((((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_NOBLE", "ALL") * 5.5) + (H.char_skill(H.u(ctx), "gramarye") * 39)) + 225), (((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_NOBLE", "ALL") * 12.3) + (H.char_skill(H.u(ctx), "gramarye") * 89)) + 691)), nil, nil, nil)
        return false
    end
    end
    EOC["EOC_CHANGELING_NOBLE_RIGHT_OF_PASSAGE_deactivate_future"] = function(ctx)
    do local _g = H.safe_id('mutation', "CHANGELING_NOBLE_RIGHT_OF_PASSAGE"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, false) end end
    return true
    end
    COND["EOC_BROWNIE_INDOOR_BLINK_SUCCESS"] = function(ctx)
        return ((not (((function() local p = H.get_tripoint_var("context", nil, ctx, "brownie_teleport"); return p ~= nil and services.gameplay.environment.is_outside(p) == true end)())))) == true
    end
    EOC["EOC_BROWNIE_INDOOR_BLINK_SUCCESS"] = function(ctx)
    if ((not (((function() local p = H.get_tripoint_var("context", nil, ctx, "brownie_teleport"); return p ~= nil and services.gameplay.environment.is_outside(p) == true end)())))) then
        do local _p = H.get_tripoint_var("context", nil, ctx, "brownie_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        services.messages.add(ctx:expand_text(services.translate("You carefully slip through the cracks.")), "good")
        return true
    else
        H.run_eoc("EOC_BROWNIE_INDOOR_BLINK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_BROWNIE_INDOOR_BLINK"] = function(ctx)
        return ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)))) == true
    end
    EOC["EOC_BROWNIE_INDOOR_BLINK"] = function(ctx)
    if ((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)))) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "brownie_teleport", nil, nil, nil, { min_radius = math.floor(5), max_radius = math.floor(10), passable_only = true }, nil, false, true, { "EOC_BROWNIE_INDOOR_BLINK_SUCCESS" }, {  })
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be indoors to slip through the cracks.")), "bad")
        return false
    end
    end
    EOC["EOC_BROWNIE_HOME_TELEPORT_SIGHT_CHECK_MONSTER"] = function(ctx)
    H.set_var("global", nil, ctx, "brownie_home_teleport", 1)
    return true
    end
    EOC["EOC_BROWNIE_HOME_TELEPORT_SIGHT_CHECK_NPC"] = function(ctx)
    H.set_var("global", nil, ctx, "brownie_home_teleport", 1)
    return true
    end
    COND["EOC_BROWNIE_HOME_TELEPORT_ACTUAL_TELEPORT"] = function(ctx)
        return (((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_white_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_lab_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_red_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_green_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_gray_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mdoor_lab_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mdoor_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_bar_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_green_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_gray_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_red_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_white_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_gray_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_green_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_red_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_white_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_secretdoor_concrete_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_secretdoor_metal_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_screen_door_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_bulkhead_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_frosted_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_frosted_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_laminated_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rdoor_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_ballistic_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_corrugated_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_reinforced_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_reinforced_door_glass_lab_o" end)())))) == true
    end
    EOC["EOC_BROWNIE_HOME_TELEPORT_ACTUAL_TELEPORT"] = function(ctx)
    if (((not ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_white_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_lab_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_red_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_green_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_gray_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mdoor_lab_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_mdoor_frame" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_bar_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_green_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_gray_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_red_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_white_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_gray_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_green_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_red_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_white_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_secretdoor_concrete_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_secretdoor_metal_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_screen_door_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_bulkhead_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_frosted_lab_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_glass_frosted_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_laminated_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_rdoor_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_ballistic_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_door_metal_corrugated_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_reinforced_door_glass_o" end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_reinforced_door_glass_lab_o" end)())))) then
        H.set_var("global", nil, ctx, "brownie_home_teleport", 0)
        do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(45), nil); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "EOC_BROWNIE_HOME_TELEPORT_SIGHT_CHECK_MONSTER" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
        do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_BROWNIE_HOME_TELEPORT_SIGHT_CHECK_NPC" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
        if (H.global_var_num("brownie_home_teleport") == 0) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "brownie_home_teleport_loc"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
            services.messages.add(ctx:expand_text(services.translate("You slip through the door and head straight home.")), "good")
        else
            services.messages.add(ctx:expand_text(services.translate("You must be unobserved to hurry home!")), "bad")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You must be in a doorway to hurry home.")), "bad")
        return false
    end
    end
    COND["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT"] = function(ctx)
        return (((("POOKA_SHAPESHIFT_FULL_SELECTOR") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT"] = function(ctx)
    if (((("POOKA_SHAPESHIFT_FULL_SELECTOR") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BAT"] == nil or E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BAT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Bat")), description = ctx:expand_text(services.translate("You will be able to assume the form of a bat.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BAT" end end
            do local _en = (E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_RAVEN"] == nil or E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_RAVEN"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Raven")), description = ctx:expand_text(services.translate("You will be able to assume the form of a raven.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_RAVEN" end end
            do local _en = (E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BEAR"] == nil or E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BEAR"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Bear")), description = ctx:expand_text(services.translate("You will be able to assume the form of a bear.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BEAR" end end
            do local _en = (E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_DEER"] == nil or E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_DEER"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Deer")), description = ctx:expand_text(services.translate("You will be able to assume the form of a deer.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_DEER" end end
            do local _en = (E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_WOLF"] == nil or E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_WOLF"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Wolf")), description = ctx:expand_text(services.translate("You will be able to assume the form of a wolf.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_WOLF" end end
            do local _en = (E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_COUGAR"] == nil or E.cond["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_COUGAR"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Cougar")), description = ctx:expand_text(services.translate("You will be able to assume the form of a cougar.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_COUGAR" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("What form will you be able to assume?")), allow_cancel = false })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BAT"] = function(ctx)
    do local _g = H.safe_id('mutation', "POOKA_SHAPESHIFT_FULL_BAT"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_RAVEN"] = function(ctx)
    do local _g = H.safe_id('mutation', "POOKA_SHAPESHIFT_FULL_RAVEN"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_BEAR"] = function(ctx)
    do local _g = H.safe_id('mutation', "POOKA_SHAPESHIFT_FULL_BEAR"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_DEER"] = function(ctx)
    do local _g = H.safe_id('mutation', "POOKA_SHAPESHIFT_FULL_DEER"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_WOLF"] = function(ctx)
    do local _g = H.safe_id('mutation', "POOKA_SHAPESHIFT_FULL_WOLF"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_POOKIE_GAIN_PINNACLE_OF_FORMS_TRAIT_COUGAR"] = function(ctx)
    do local _g = H.safe_id('mutation', "POOKA_SHAPESHIFT_FULL_COUGAR"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    COND["EOC_SELKIE_FOG_CLOAK"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_selkie_fog_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_SELKIE_FOG_CLOAK"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_selkie_fog_cloak"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "effect_selkie_fog_cloak", services.random.native_float((((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 5.6) + (H.char_skill(H.u(ctx), "gramarye") * 51.2)) + 135.4), (((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 13.8) + (H.char_skill(H.u(ctx), "gramarye") * 123.05)) + 498.5)), nil, nil, nil)
        return true
    else
        do local _eg = H.safe_id('effect', "effect_selkie_fog_cloak"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return false
    end
    end
    COND["EOC_SELKIE_CHANGE_WEATHER_DENSE_FOG"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") ~= 1)) == true
    end
    EOC["EOC_SELKIE_CHANGE_WEATHER_DENSE_FOG"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") ~= 1)) then
        services.messages.add(ctx:expand_text(services.translate("A thick fog begins to rise.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 1)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_fog", 21600, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(((((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 9.8) + (H.char_skill(H.u(ctx), "gramarye") * 34.53)) + 203.1) * H._jm_selkie_has_weather_mastery(ctx))), math.floor(((((H.char_sum_traits_cat(H.u(ctx), "FAIR_FOLK_COMMONER_SELKIE", "ALL") * 24.15) + (H.char_skill(H.u(ctx), "gramarye") * 102.75)) + 747.75) * H._jm_selkie_has_weather_mastery(ctx))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SELKIE_CHANGE_WEATHER_DENSE_FOG_REMOVE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You release your command over the fog and it begins to disperse.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        return false
    end
    end
end
