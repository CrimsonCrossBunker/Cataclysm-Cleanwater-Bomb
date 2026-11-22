local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_PERK_SITUATIONAL_UNCANNY_DODGE_TAKE_DAMAGE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_situational_uncanny_dodge") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_perk_situational_uncanny_dodge_remover"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_PERK_SITUATIONAL_UNCANNY_DODGE_TAKE_DAMAGE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_situational_uncanny_dodge") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_perk_situational_uncanny_dodge_remover"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_situational_uncanny_dodge_remover", ((180 + services.random.native_int(0, H.round_half_away(120))) + ((H.char_skill(H.u(ctx), "dodge") - 8) * (-30))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_EWWWW_DE_ZOMBIE_ATTACK_ZOMBIE_SUPPRESSOR"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_EWWWW_DE_ZOMBIE_ATTACK_ZOMBIE_SUPPRESSOR"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if ((H.u(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "ZOMBIE")).value == true))) and ((function() local eg = H.safe_id('effect', "effect_ewwww_de_zombie"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())) then
            H.eoc_add_effect(H.npc(ctx), "effect_ewwww_de_zombie_canceller", 120, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_PERK_LEARN_EWWWW_DE_ZOMBIE_GAIN_RECIPE"] = function(ctx)
        return (((("perk_ewwww_de_zombie") == (H.var_str("context", nil, ctx, "trait", ""))))) == true
    end
    EOC["EOC_PERK_LEARN_EWWWW_DE_ZOMBIE_GAIN_RECIPE"] = function(ctx)
    if (((("perk_ewwww_de_zombie") == (H.var_str("context", nil, ctx, "trait", ""))))) then
        services.messages.add(ctx:expand_text(services.translate("With a flash of insight you now understand how to mix zombie guts into a disguise!")), "neutral")
        H.learn_recipe(H.u(ctx), "item_ewwww_de_zombie")
        return true
    end
    return false
    end
    COND["EOC_PERK_FIRSTEST_AID"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_firstest_aid") == 1)) == true
    end
    EOC["EOC_PERK_FIRSTEST_AID"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_firstest_aid") == 1)) then
        do local _eg = H.safe_id('effect', "effect_perk_firstest_aid"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.eoc_add_effect(H.u(ctx), "effect_perk_firstest_aid", 120, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_HIVE_QUEEN_ATTACK_INSECT_SUPPRESSOR"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_HIVE_QUEEN_ATTACK_INSECT_SUPPRESSOR"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if (((H.u(ctx) ~= nil and ((H.safe_id('species', "INSECT") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "INSECT")).value == true))) or (H.u(ctx) ~= nil and ((H.safe_id('species', "INSECT_FLYING") ~= nil and services.creatures.has_species(H.u(ctx), H.safe_id('species', "INSECT_FLYING")).value == true)))) and (H.char_has_trait(H.npc(ctx), "perk_hive_queen") == 1)) then
            H.eoc_add_effect(H.npc(ctx), "effect_hive_queen_canceller", 120, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_PERK_MOONSTRUCK"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_moonstruck") == 1)) == true
    end
    EOC["EOC_PERK_MOONSTRUCK"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_moonstruck") == 1)) then
        do
            local _sw3 = H.moon_phase()
            if _sw3 == 0 then
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_full"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_waxing"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_new"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_perk_moonstruck_new", 7200, nil, nil, nil)
            elseif _sw3 == 3 then
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_full"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_waxing"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_new"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_perk_moonstruck_waxing", 7200, nil, nil, nil)
            elseif _sw3 == 4 then
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_full"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_waxing"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_new"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                H.eoc_add_effect(H.u(ctx), "effect_perk_moonstruck_full", 7200, nil, nil, nil)
            elseif _sw3 == 7 then
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_full"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_waxing"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                do local _eg = H.safe_id('effect', "effect_perk_moonstruck_new"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_perk_artifact_resonance_detection_active"] = function(ctx)
    H.set_var("context", nil, ctx, "artifact_resonance", (((H.char_snap(H.npc(ctx)) or {}).combat or {}).artifact_resonance or 0))
    H.set_var("context", nil, ctx, "your_total_resonance", (((H.char_snap(H.u(ctx)) or {}).combat or {}).artifact_resonance or 0))
    services.messages.add(services.text.expand_for("Exact resonance is <context_val:artifact_resonance>.", ctx), "debug")
    services.messages.add(services.text.expand_for("Your actual resonance is <context_val:your_total_resonance>.", ctx), "debug")
    do
        local _sw4 = (ctx:get_number("artifact_resonance") or 0)
        if _sw4 == 0 then
            services.messages.add(ctx:expand_text(services.translate("The artifact barely hums at all (resonance 0-250).")), "neutral")
        elseif _sw4 == 251 then
            services.messages.add(ctx:expand_text(services.translate("The artifact hums gently (resonance 251-750).")), "neutral")
        elseif _sw4 == 751 then
            services.messages.add(ctx:expand_text(services.translate("The artifact hums with a steady pulsing (resonance 751-1500).")), "neutral")
        elseif _sw4 == 1501 then
            services.messages.add(ctx:expand_text(services.translate("The artifact hums strongly and your skin tingles (resonance 1501-2500).")), "neutral")
        elseif _sw4 == 2501 then
            services.messages.add(ctx:expand_text(services.translate("The artifact hums loudly enough that it's almost vibrating (resonance 2501-5000)")), "neutral")
        elseif _sw4 == 5001 then
            services.messages.add(ctx:expand_text(services.translate("The artifact's hum drowns out all other sounds for a moment (resonance 5001+)")), "neutral")
        end
    end
    return true
    end
    EOC["EOC_perk_artifact_resonance_detection"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { wielded_only = true } }, { "EOC_perk_artifact_resonance_detection_active" }, {  })
    return true
    end
    COND["EOC_PERK_PERCUSSIVE_ENTRY_SMASHING"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_percussive_entry") == 1)) == true
    end
    EOC["EOC_PERK_PERCUSSIVE_ENTRY_SMASHING"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_percussive_entry") == 1)) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_percussive_entry", 2, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_PERCUSSIVE_ENTRY_LOSE_BONUS_WHEN_MOVING"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_perk_percussive_entry"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_PERK_PERCUSSIVE_ENTRY_LOSE_BONUS_WHEN_MOVING"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_perk_percussive_entry"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_perk_percussive_entry"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_praise"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_praise") == 1) and services.random.native_probability((1), (10)))) == true
    end
    EOC["EOC_praise"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_praise") == 1) and services.random.native_probability((1), (10)))) then
        services.messages.add((services.snippets.native_random("<good_job>") or ''), "good")
        return true
    end
    return false
    end
    COND["EOC_PERK_QUICK_RECOVERY_INIT"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_quick_recovery") == 1) and services.random.native_probability((3), (4)) and ((("downed") == (H.var_str("context", nil, ctx, "effect", "")))))) == true
    end
    EOC["EOC_PERK_QUICK_RECOVERY_INIT"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_quick_recovery") == 1) and services.random.native_probability((3), (4)) and ((("downed") == (H.var_str("context", nil, ctx, "effect", "")))))) then
        do local _eg = H.safe_id('effect', "downed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_perk_rage_against_the_unnatural_nether_list"] = function(ctx)
        return ((H.species_nearby(H.u(ctx), { "NETHER" }, 1, nil) > 0)) == true
    end
    EOC["EOC_perk_rage_against_the_unnatural_nether_list"] = function(ctx)
    if ((H.species_nearby(H.u(ctx), { "NETHER" }, 1, nil) > 0)) then
        return true
    end
    return false
    end
    COND["EOC_perk_rage_against_the_unnatural_checker_monster"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))))) == true
    end
    EOC["EOC_perk_rage_against_the_unnatural_checker_monster"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_rage_against_the_unnatural_penalty", (3 + services.random.native_int(0, H.round_half_away(9))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_rage_against_the_unnatural_checker_character"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx))) == true
    end
    EOC["EOC_perk_rage_against_the_unnatural_checker_character"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx))) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_rage_against_the_unnatural_penalty", (3 + services.random.native_int(0, H.round_half_away(9))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_rage_against_the_unnatural_checker_monster_ranged"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))))) == true
    end
    EOC["EOC_perk_rage_against_the_unnatural_checker_monster_ranged"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_rage_against_the_unnatural_penalty", (3 + services.random.native_int(0, H.round_half_away(9))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_rage_against_the_unnatural_checker_character_ranged"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx))) == true
    end
    EOC["EOC_perk_rage_against_the_unnatural_checker_character_ranged"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_rage_against_unnatural") == 1) and H.test_eoc("EOC_perk_rage_against_the_unnatural_nether_list", ctx))) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_rage_against_the_unnatural_penalty", (3 + services.random.native_int(0, H.round_half_away(9))), nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_SECOND_CHANCE_PREVENTION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_second_chance") == 1) and (not ((H.char_has_trait(H.u(ctx), "perk_second_chance_limiter") == 1))))) == true
    end
    EOC["EOC_PERK_SECOND_CHANCE_PREVENTION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_second_chance") == 1) and (not ((H.char_has_trait(H.u(ctx), "perk_second_chance_limiter") == 1))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("As the wounds overtake you, you feel a surge of inner strength.")))
        H.run_eoc("EOC_PERK_SECOND_CHANCE_PREVENTION_ACTIVATE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_SECOND_CHANCE_PREVENTION_ACTIVATE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_second_chance") == 1)) == true
    end
    EOC["EOC_PERK_SECOND_CHANCE_PREVENTION_ACTIVATE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_second_chance") == 1)) then
        local _a5 = H.u(ctx)
        if _a5 then services.characters.adjust(_a5, { pain = math.floor((0) - (H.char_pain(_a5))) }) end
        H.set_char_hp(H.u(ctx), "ALL_MINOR", 999, "=")
        H.set_char_hp(H.u(ctx), "torso", math.max(H.char_hp(H.u(ctx), "torso", false), 10), "=")
        H.set_char_hp(H.u(ctx), "head", math.max(H.char_hp(H.u(ctx), "head", false), 10), "=")
        H.set_char_hp(H.u(ctx), "arm_l", math.max(H.char_hp(H.u(ctx), "arm_l", false), 10), "=")
        H.set_char_hp(H.u(ctx), "arm_r", math.max(H.char_hp(H.u(ctx), "arm_r", false), 10), "=")
        H.set_char_hp(H.u(ctx), "leg_l", math.max(H.char_hp(H.u(ctx), "leg_l", false), 10), "=")
        H.set_char_hp(H.u(ctx), "leg_r", math.max(H.char_hp(H.u(ctx), "leg_r", false), 10), "=")
        do local _eg = H.safe_id('effect', "onfire"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "dazed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "downed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "deaf"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "stunned"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _g = H.safe_id('mutation', "perk_second_chance_limiter"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.eoc_add_effect(H.u(ctx), "effect_perk_second_chance", 5, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_SOUP_FOR_SOUL_EFFECTS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_soup_healing") == 1) and (((("mre_chickennoodle") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("soup_chicken") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("soup_instant_chicken_noodle_prepared") == (H.var_str("context", nil, ctx, "itype", ""))))))) == true
    end
    EOC["EOC_PERK_SOUP_FOR_SOUL_EFFECTS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_soup_healing") == 1) and (((("mre_chickennoodle") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("soup_chicken") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("soup_instant_chicken_noodle_prepared") == (H.var_str("context", nil, ctx, "itype", ""))))))) then
        local _a6 = H.u(ctx)
        if _a6 then services.characters.adjust(_a6, { pain = math.floor(-(5)) }) end
        H.set_char_hp(H.u(ctx), "torso", (3 + services.random.native_int(0, H.round_half_away(4))), "+=")
        H.set_char_hp(H.u(ctx), "head", (3 + services.random.native_int(0, H.round_half_away(4))), "+=")
        H.set_char_hp(H.u(ctx), "arm_l", (3 + services.random.native_int(0, H.round_half_away(4))), "+=")
        H.set_char_hp(H.u(ctx), "arm_r", (3 + services.random.native_int(0, H.round_half_away(4))), "+=")
        H.set_char_hp(H.u(ctx), "leg_l", (3 + services.random.native_int(0, H.round_half_away(4))), "+=")
        H.set_char_hp(H.u(ctx), "leg_r", (3 + services.random.native_int(0, H.round_half_away(4))), "+=")
        if (not (((function() local eg = H.safe_id('effect', "effect_perk_soul_for_soul_sickness_blocker"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
            H.eoc_add_effect(H.u(ctx), "effect_perk_soul_for_soul_sickness_blocker", 864000, nil, nil, nil)
        end
        do local _eg = H.safe_id('effect', "poison"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "badpoison"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_dmg"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_weaken"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_blind"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "venom_pain"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "paralyzepoison"); local _bp = ("ALL" ~= nil) and H.safe_id('body_part', "ALL") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_BIRD_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_bird") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_BIRD_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_bird") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_bird"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_bird"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_FELINE_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_feline") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_FELINE_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_feline") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_feline"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_feline"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_INSECT_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_insect") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_INSECT_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_insect") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_insect"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_insect"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_lupine") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_lupine") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_lupine"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_lupine"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_PLANT_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_plant") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_PLANT_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_plant") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_plant"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_plant"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_spider") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) == true
    end
    EOC["EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "close_portal_storm")) and (H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_spider") == 1) and H.test_eoc("EOC_PORTAL_STORM_CONDITION_FLAG_PORTAL_PROOF", ctx) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and services.random.native_probability((1), (3)))) then
        services.messages.add(ctx:expand_text(services.translate("Your whole body pulses in time with the raging storm.")), "info")
        do local _a, _v = H.u(ctx), "mutagen_spider"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.mutations.mutate(H.u(ctx), math.floor(0), true) end
        do local _a, _v = H.u(ctx), "mutagen_spider"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2500; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "mutagen"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    EOC["EOC_troubleseeking"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "zombie_horde_target", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("context", nil, ctx, "zombie_horde_target"); if _p then services.hordes.broadcast_signal(_p, math.floor((services.random.native_int(0, H.round_half_away(50)) + 30))) end end
    services.messages.add(ctx:expand_text(services.translate("You suddenly feel that you have found some trouble.")), "mixed")
    return true
    end
    EOC["EOC_troubleseek_on"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You start seeking trouble.")), "neutral")
    return true
    end
    EOC["EOC_troubleseek_off"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You stop seeking trouble for now.")), "neutral")
    return true
    end
    COND["EOC_PERK_TWICE_SHY_TAKE_DAMAGE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_twice_shy") == 1)) == true
    end
    EOC["EOC_PERK_TWICE_SHY_TAKE_DAMAGE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_twice_shy") == 1)) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_twice_shy", 5, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_UNDYING_LOYALTY"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_undying_loyalty") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_perk_undying_loyalty_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_any_trait(H.u(ctx), { "PRED1", "PRED2", "PRED3", "PRED4", "SAPIOVORE" }))) and (H.chars_nearby(H.u(ctx), 15, "allies") > 0) and (((H.char_hp(H.u(ctx), "head", false) / H.char_hp(H.u(ctx), "head", true)) <= 0.5) or ((H.char_hp(H.u(ctx), "torso", false) / H.char_hp(H.u(ctx), "torso", true)) <= 0.5)))) == true
    end
    EOC["EOC_PERK_UNDYING_LOYALTY"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_undying_loyalty") == 1) and (not (((function() local eg = H.safe_id('effect', "effect_perk_undying_loyalty_self"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_any_trait(H.u(ctx), { "PRED1", "PRED2", "PRED3", "PRED4", "SAPIOVORE" }))) and (H.chars_nearby(H.u(ctx), 15, "allies") > 0) and (((H.char_hp(H.u(ctx), "head", false) / H.char_hp(H.u(ctx), "head", true)) <= 0.5) or ((H.char_hp(H.u(ctx), "torso", false) / H.char_hp(H.u(ctx), "torso", true)) <= 0.5)))) then
        H.eoc_cast_spell(H.u(ctx), "perk_undying_loyalty_spell", false, nil)
        H.eoc_add_effect(H.u(ctx), "effect_perk_undying_loyalty_self", 300, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PERK_VENGEFUL_TAKE_DAMAGE"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_vengeful") == 1)) == true
    end
    EOC["EOC_PERK_VENGEFUL_TAKE_DAMAGE"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_vengeful") == 1)) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_vengeful", 2, nil, nil, nil)
        return true
    end
    return false
    end
end
