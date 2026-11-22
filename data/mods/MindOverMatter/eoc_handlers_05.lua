local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_PERK_MIND_CRY_TAKE_DAMAGE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_mind_cry") == 1) and (((H.creature_snap(H.u(ctx)) or {}).perceived_pain or 0) >= 10) and services.random.native_probability((1), (100)))) == true
    end
    EOC["EOC_PERK_MIND_CRY_TAKE_DAMAGE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_mind_cry") == 1) and (((H.creature_snap(H.u(ctx)) or {}).perceived_pain or 0) >= 10) and services.random.native_probability((1), (100)))) then
        H.eoc_cast_spell(H.u(ctx), "telepathic_blast_radius_mind_cry", false, nil)
        services.messages.add(ctx:expand_text(services.translate("You involuntarily let out a psychic shriek.")), "mixed")
        return true
    end
    return false
    end
    COND["EOC_PERK_PHOENIX_RISING"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_phoenix_rising") == 1) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 155))) == true
    end
    EOC["EOC_PERK_PHOENIX_RISING"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_phoenix_rising") == 1) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 155))) then
        H.set_spell_adj(H.u(ctx), "cost", "", "", "", ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 154) * (-0.0069)), "=")
        return true
    end
    return false
    end
    EOC["EOC_FERAL_CRAZY_VITAKINETIC_INFLICT_LIGMA"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.npc(ctx) and _g then services.morale.add(H.npc(ctx), _g, math.floor(-10), math.floor(-60), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(1800)) }) end end
    return true
    end
    EOC["EOC_FERAL_CRAZY_VITAKINETIC_INFLICT_LIGMA_EXTREME"] = function(ctx)
    do local _g = H.safe_id('morale', "morale_feeling_bad"); if H.npc(ctx) and _g then services.morale.add(H.npc(ctx), _g, math.floor(-15), math.floor(-80), { duration = services.time.duration_from_turns(math.floor(10800)), decay_start = services.time.duration_from_turns(math.floor(5400)) }) end end
    return true
    end
    COND["DEFENSE_MODE_WAVE_CONTROL_PREMENITION"] = function(ctx)
        return ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1)) == true
    end
    EOC["DEFENSE_MODE_WAVE_CONTROL_PREMENITION"] = function(ctx)
    if ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1)) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel a multitude of foes coming for you, bleary-eyed and full of bloodlust.  Steel yourself, for the horde is coming.")))
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_danger_sense") * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("DEFENSE_MODE_WAVE_CONTROL_ACTUAL"), nil) end end
        return true
    else
        H.run_eoc("DEFENSE_MODE_WAVE_CONTROL_ACTUAL", ctx, nil, nil, nil)
        return false
    end
    end
    COND["DEFENSE_MODE_WAVE_CONTROL"] = function(ctx)
        return (services.gameplay.mods.is_loaded("defense_mode")) == true
    end
    EOC["DEFENSE_MODE_WAVE_CONTROL"] = function(ctx)
    if (services.gameplay.mods.is_loaded("defense_mode")) then
        H.run_eoc("DEFENSE_MODE_WAVE_CONTROL_PREMENITION", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["DEFENSE_MODE_WAVE_CONTROL_ACTUAL"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "your_spawnpoint"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    H.set_var("global", nil, ctx, "wave_number", (H.global_var_num("wave_number")) + (1))
    services.messages.add(ctx:expand_text(services.translate("Welcome to wave <global_val:wave_number>!")), "bad")
    H.run_eoc("DEFENSE_MODE_WAVE_SPECIAL_DECIDER", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_DEFENSE_MODE_RANDOM_NPC_ROBBER"] = function(ctx)
        return ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1)) == true
    end
    EOC["EOC_DEFENSE_MODE_RANDOM_NPC_ROBBER"] = function(ctx)
    if ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1)) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel greedy, insidious eyes watching you and rapidly getting closer.  Someone has it out for your stuff.")))
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_danger_sense") * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DEFENSE_MODE_RANDOM_NPC_ROBBER_ACTUAL"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_DEFENSE_MODE_RANDOM_NPC_ROBBER_ACTUAL"] = function(ctx)
    H.spawn_npc(H.u(ctx), "random_survivor_nefarious", { min_radius = math.floor(15), max_radius = math.floor(40), outdoor_only = true }, nil)
    return true
    end
    COND["EOC_DEFENSE_MODE_BANDIT_ATTACK"] = function(ctx)
        return ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1)) == true
    end
    EOC["EOC_DEFENSE_MODE_BANDIT_ATTACK"] = function(ctx)
    if ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 1)) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel a multitude of hostile eyes watching you and rapidly getting closer.  The masses have it in for you.")))
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "clair_danger_sense") * 4) + 5))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DEFENSE_MODE_BANDIT_ATTACK_ACTUAL"), nil) end end
        return true
    end
    return false
    end
    EOC["EOC_DEFENSE_MODE_BANDIT_ATTACK_ACTUAL"] = function(ctx)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    H.spawn_npc(H.u(ctx), "defense_mode_raider", { min_radius = math.floor(15), max_radius = math.floor(25), outdoor_only = true }, nil)
    return true
    end
    COND["EOC_STARE1_5"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or H.char_has_flag(H.u(ctx), "TEEPSHIELD"))) == true
    end
    EOC["EOC_STARE1_5"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or H.char_has_flag(H.u(ctx), "TEEPSHIELD"))) then
        services.messages.add(ctx:expand_text(services.translate("You sense <npc_name> trying to enter your mind, but you repel it!")), "warning")
        return true
    else
        H.run_eoc("EOC_STARE2", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_MOM_SI_PRE_TELEPORT_LOCATION_CHECKING"] = function(ctx)
    if (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "mom_si_on_sky_island_location", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "started_teleport_on_island", 1)
    else
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "mom_si_on_ground_location", nil, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "started_teleport_on_island", 0)
    end
    return true
    end
    COND["EOC_MOM_SI_PRE_TELEPORT_POWER_CHECKING"] = function(ctx)
        return (((((("teleport_farstep") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_loci_technique") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_gateway") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_dilated_gateway") == (H.var_str("context", nil, ctx, "spell", ""))))))) == true
    end
    EOC["EOC_MOM_SI_PRE_TELEPORT_POWER_CHECKING"] = function(ctx)
    if (((((("teleport_farstep") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_loci_technique") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_gateway") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_dilated_gateway") == (H.var_str("context", nil, ctx, "spell", ""))))))) then
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MOM_SI_POST_TELEPORT_FOLLOWUP"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_MOM_SI_POST_TELEPORT_FOLLOWUP"] = function(ctx)
        return (((H.var_num(H.u(ctx), "started_teleport_on_island") == 0) and (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))))) == true
    end
    EOC["EOC_MOM_SI_POST_TELEPORT_FOLLOWUP"] = function(ctx)
    if (((H.var_num(H.u(ctx), "started_teleport_on_island") == 0) and (((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9))))) then
        if (H.char_has_trait(H.u(ctx), "awayfromhome") == 1) then
            do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "mom_si_on_ground_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
            ccb.presentation.notice(ctx:expand_text(services.translate("You briefly see the familiar sights of the floating island before you feel a wrenching sensation and you're suddenly back on the surface.  Whatever powers have put you in this situation must not be happy with you trying to circumvent the rules.")))
            H.set_var("global", nil, ctx, "timeawayfromhome", (H.global_var_num("timeawayfromhome")) + (1))
        end
        return true
    else
        if ((H.var_num(H.u(ctx), "started_teleport_on_island") == 1) and (not ((((H.char_at_om_location(H.u(ctx), "open_air") or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_subcore", math.floor(1)) end)())) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 6)) or (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "sky_island_core", math.floor(1)) end)()) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 7)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 8)) or (H.char_at_om_location(H.u(ctx), "open_air") and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) == 9)))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("As you come out of the darkness and the cold and see the surface, you feel a sudden wrenching sensation.  Pain washes over your entire body as your vision goes red, and the air burns as you take in a ragged breath.  The powers behind your situation are not happy at your attempt to circumvent their rules.")))
            H.eoc_add_effect(H.u(ctx), "warpsickness", -1, nil, 3, nil)
            do local _t = math.max(1, math.floor((180 * (((H.global_var_num("bonuspulses") > 0)) and ((H.global_var_num("bonuspulses") * 60)) or (1))))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_MOM_SI_PRE_TELEPORT_POST_TELEPORT_FOLLOWUP"), nil) end end
        end
        return false
    end
    end
    EOC["EOC_MOM_SI_PRE_TELEPORT_POST_TELEPORT_FOLLOWUP"] = function(ctx)
    do local _p = H.get_tripoint_var("global", nil, ctx, "OM_HQ_origin"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    ccb.presentation.notice(ctx:expand_text(services.translate("With an internal twist, you're suddenly back on the island.")))
    do local _eg = H.safe_id('effect', "warpsickness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_CHECK"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_ench_bio_psi_range_increaser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_CHECK"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_ench_bio_psi_range_increaser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_spell_adj(H.u(ctx), "range", "", "", "", 1, "=")
        return true
    end
    return false
    end
    COND["EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER"] = function(ctx)
        return (H.char_has_bionic(H.u(ctx), "bio_psi_range_increaser")) == true
    end
    EOC["EOC_MOM_XE_NOETIC_RANGE_BOOSTER_POSSESSION_HEADACHES_AND_FEVER"] = function(ctx)
    if (H.char_has_bionic(H.u(ctx), "bio_psi_range_increaser")) then
        if (services.random.native_int(0, H.round_half_away(1)) == 1) then
            services.messages.add(ctx:expand_text(services.translate("Your head begins to pound.")), "bad")
            H.eoc_add_effect(H.u(ctx), "psionic_overload", services.random.native_float(900, 1800), nil, nil, nil)
        end
        if (services.random.native_int(0, H.round_half_away(10)) > 8) then
            H.eoc_add_effect(H.u(ctx), "effect_pyrokin_overload", services.random.native_float(1800, 10800), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You feel feverish.")), "bad")
        end
        return true
    end
    return false
    end
    COND["EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_ench_bio_psi_range_increaser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_MOM_XE_NOETIC_RANGE_BOOSTER_ACTIVE_HEADACHES_AND_FEVER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_ench_bio_psi_range_increaser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add(ctx:expand_text(services.translate("Your head begins to pound.")), "bad")
        H.eoc_add_effect(H.u(ctx), "psionic_overload", services.random.native_float(900, 1800), nil, nil, nil)
        if (services.random.native_int(0, H.round_half_away(10)) > 5) then
            H.eoc_add_effect(H.u(ctx), "effect_pyrokin_overload", services.random.native_float(1800, 10800), nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You feel feverish.")), "bad")
        end
        return true
    end
    return false
    end
    COND["EOC_MOM_XE_TORPOR_ENDS_POWERS"] = function(ctx)
        return (((("effect_vampire_torpor") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_MOM_XE_TORPOR_ENDS_POWERS"] = function(ctx)
    if (((("effect_vampire_torpor") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.run_eoc("EOC_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM"] = function(ctx)
        return (services.gameplay.mods.is_loaded("xedra_evolved")) == true
    end
    EOC["EOC_VITAKIN_BANISH_ILLNESS_XE_VAMPIRISM"] = function(ctx)
    if (services.gameplay.mods.is_loaded("xedra_evolved")) then
        return true
    end
    return false
    end
    EOC["EOC_VITAKIN3_DEATH_EFFECT"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "spawn_place", nil, nil, nil, { min_radius = math.floor(0) }, nil, false, true, {  }, {  })
    do local _cs = H.creature_snap(H.npc(ctx)); local _mg = H.safe_id('monster', "mon_feral_human_vita3_revived") or H.safe_id('monster_group', "mon_feral_human_vita3_revived"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(0), max_radius = math.floor(0) }); 
    end end
    H.run_eoc("EOC_VITAKIN3_DEATH_EFFECT_2", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_VITAKIN3_DEATH_EFFECT_2"] = function(ctx)
    H.set_char_hp(H.u(ctx), "ALL", 25, "=")
    H.eoc_add_effect(H.u(ctx), "effect_feral_regeneration", (function() local a, b = math.floor(15), math.floor(30); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
    return true
    end
    COND["EOC_FERAL_TELEPORTER_TELEPORTION_TOUCH"] = function(ctx)
        return (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "TELESTOP"))))) == true
    end
    EOC["EOC_FERAL_TELEPORTER_TELEPORTION_TOUCH"] = function(ctx)
    if (((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "DIMENSIONAL_ANCHOR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "DIMENSIONAL_ANCHOR")).value == true))) and (not (H.char_has_flag(H.u(ctx), "TELESTOP"))))) then
        do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "teleport_blink_monster", (cs and cs.kind == 'monster'), { min_level = math.floor(5) }) end end
        return true
    end
    return false
    end
    COND["EOC_FERAL_VITAKIN1_ENERVATING_TOUCH"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_FERAL_VITAKIN1_ENERVATING_TOUCH"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.eoc_add_effect(H.npc(ctx), "effect_vitakinetic_health_down", (function() local a, b = math.floor(6200), math.floor(16200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        do local _a = H.npc(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(75 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 75; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(75 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 75; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    else
        H.eoc_add_effect(H.npc(ctx), "effect_vitakinetic_health_down_monster", (function() local a, b = math.floor(6200), math.floor(16200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        return false
    end
    end
    COND["EOC_FERAL_VITAKIN2_ENERVATING_TOUCH"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_FERAL_VITAKIN2_ENERVATING_TOUCH"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.eoc_add_effect(H.npc(ctx), "effect_vitakinetic_healing_down", (function() local a, b = math.floor(6200), math.floor(16200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        do local _a = H.npc(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(200 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 200; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(200 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 200; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    else
        H.eoc_add_effect(H.npc(ctx), "effect_vitakinetic_health_down_monster", (function() local a, b = math.floor(6200), math.floor(16200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, 3, nil)
        return false
    end
    end
    COND["EOC_FERAL_VITAKIN3_ENERVATING_TOUCH"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_FERAL_VITAKIN3_ENERVATING_TOUCH"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.eoc_add_effect(H.npc(ctx), "effect_vitakinetic_healing_down_super", (function() local a, b = math.floor(6200), math.floor(16200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, nil, nil)
        do local _a = H.npc(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(350 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 350; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        do local _a = H.npc(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(350 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 350; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        return true
    else
        H.eoc_add_effect(H.npc(ctx), "effect_vitakinetic_health_down_monster", (function() local a, b = math.floor(6200), math.floor(16200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)(), nil, 3, nil)
        return false
    end
    end
    COND["EOC_VITAKIN_FERAL_VITA3_DEGENERATING_TOUCH"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_VITAKIN_FERAL_VITA3_DEGENERATING_TOUCH"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.eoc_cast_spell(H.u(ctx), "vita_feral_vitakin3_degenerating_touch", false, { hit_self = true })
        services.messages.add(ctx:expand_text(services.translate("Your flesh begins decaying before your eyes!")), "bad")
        return true
    else
        if ((not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))))) and (not ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true)))))) then
            do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "vita_feral_vitakin3_degenerating_touch_monster", (cs and cs.kind == 'monster'), { hit_self = true }) end end
            services.messages.add(ctx:expand_text(services.translate("Your flesh begins decaying before your eyes!")), "bad")
        end
        return false
    end
    end
    COND["pigeon_aura"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["pigeon_aura"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        do local _a, _v = H.u(ctx), "passenger_pigeon_aura"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (400 + services.random.native_int(0, H.round_half_away(100))); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_NULL_BREAK_CONCENTRATION_3"] = function(ctx)
        return (services.random.native_probability(((((5 - (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) - (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0)) - (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0))), (5))) == true
    end
    EOC["EOC_NULL_BREAK_CONCENTRATION_3"] = function(ctx)
    if (services.random.native_probability(((((5 - (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value) == true) and 1 or 0)) - (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_intermediate").value) == true) and 1 or 0)) - (((H.u(ctx) and services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_master").value) == true) and 1 or 0))), (5))) then
        services.messages.add(ctx:expand_text(services.translate("An icy dagger seems to stab into your brain.")), "bad")
        local _a22 = H.u(ctx)
        if _a22 then services.characters.adjust(_a22, { pain = math.floor((services.random.native_int(0, H.round_half_away(3)) + 1)) }) end
        H.run_eoc("EOC_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Icy fingers crawl across your brain for a moment.")), "bad")
        local _a23 = H.u(ctx)
        if _a23 then services.characters.adjust(_a23, { pain = math.floor(1) }) end
        return false
    end
    end
    COND["EOC_NULL_BREAK_CONCENTRATION_2"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1)) == true
    end
    EOC["EOC_NULL_BREAK_CONCENTRATION_2"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1)) then
        H.run_eoc("EOC_NULL_BREAK_CONCENTRATION_3", ctx, nil, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("Icy fingers crawl across your brain for a moment.")), "bad")
        local _a24 = H.u(ctx)
        if _a24 then services.characters.adjust(_a24, { pain = math.floor(1) }) end
        return false
    end
    end
    COND["EOC_NULL_BREAK_CONCENTRATION"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((H.char_spell_level(H.u(ctx), "telepathic_shield")), (12)))) == true
    end
    EOC["EOC_NULL_BREAK_CONCENTRATION"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((H.char_spell_level(H.u(ctx), "telepathic_shield")), (12)))) then
        services.messages.add(ctx:expand_text(services.translate("Icy fingers crawl across the surface of your mind, but your powers repel them.")), "bad")
        return true
    else
        H.run_eoc("EOC_NULL_BREAK_CONCENTRATION_2", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_TRIFFID_CLEAR_DISCERN_WEAKNESS"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "discern_weakness_clear_intelligence", 1.15)
    H.set_var("actor", H.u(ctx), ctx, "discern_weakness_clear_power_level", 4)
    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_discern_weakness_scaling", 1.05)
    H.eoc_add_effect(H.u(ctx), "effect_clair_weak_point", services.random.native_float(((((H.var_num(H.u(ctx), "discern_weakness_clear_power_level") * 1.5) + 13.5) * H.var_num(H.u(ctx), "discern_weakness_clear_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_discern_weakness_scaling")), ((((H.var_num(H.u(ctx), "discern_weakness_clear_power_level") * 2.5) + 30) * H.var_num(H.u(ctx), "discern_weakness_clear_intelligence")) * H.var_num(H.u(ctx), "nether_attunement_discern_weakness_scaling"))), nil, nil, nil)
    return true
    end
    EOC["EOC_TELEPORTER_TRIFFID_SUMMON_ALLIES"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_TRIFFID_HEARTGUARDS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(1, 2)), min_radius = math.floor(2), max_radius = math.floor(6) }); 
    end end
    return true
    end
    EOC["EOC_ELECTROKIN_MONSTER_PARALYSIS"] = function(ctx)
    H.set_var("context", nil, ctx, "duration", services.random.native_float(1.5, 4))
    if (not ((H.creature_has_effect(H.u(ctx), "effect_electrokinetic_speed_boost") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration") or H.creature_has_effect(H.u(ctx), "effect_monster_neuro_acceleration")))) then
        H.eoc_add_effect(H.u(ctx), "downed", (ctx:get_number("duration") or 0), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "psi_dazed", (ctx:get_number("duration") or 0), nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_electrokin_paralysis", (ctx:get_number("duration") or 0), nil, nil, nil)
    else
        services.messages.add(ctx:expand_text(services.translate("Your control over your own nerve impulses prevent the attack from taking hold.")), "good")
    end
    return true
    end
    EOC["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_INV_RESULT"] = function(ctx)
    H.set_bionic_power(H.npc(ctx), (services.random.native_int(0, H.round_half_away(200)) + 50), "-=")
    return true
    end
    COND["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_ELECTROKINETIC_CHECK"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_ELECTROKINETIC_CHECK"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { {  } }, { "EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_INV_RESULT" }, {  })
        return true
    else
        H.set_char_val_extra(H.u(ctx), "stamina", (services.random.native_int(0, H.round_half_away(350)) + 300), "-=")
        return false
    end
    end
    COND["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_CHARACTER_CHECK"] = function(ctx)
        return (services.random.native_probability((1), (3))) == true
    end
    EOC["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_CHARACTER_CHECK"] = function(ctx)
    if (services.random.native_probability((1), (3))) then
        H.run_eoc("EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_ELECTROKINETIC_CHECK", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_MONSTER_CHECK"] = function(ctx)
        return ((services.random.native_probability((1), (3)) and H.char_has_flag(H.u(ctx), "ELECTRIC"))) == true
    end
    EOC["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_MONSTER_CHECK"] = function(ctx)
    if ((services.random.native_probability((1), (3)) and H.char_has_flag(H.u(ctx), "ELECTRIC"))) then
        H.eoc_cast_spell(H.u(ctx), "electrokinetic_power_draining_electric_monster", false, nil)
        return true
    end
    return false
    end
    COND["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.run_eoc("EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_CHARACTER_CHECK", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_ELECTRONKINETIC_MONSTER_POWER_DRAINING_MONSTER_CHECK", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_MONSTER_APPLY_OBSCURITY"] = function(ctx)
        return (((not (H.char_has_flag(H.u(ctx), "TEEPSHIELD"))) and (not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not (((function() local eg = H.safe_id('effect', "eff_monster_immune_to_telepathy"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["EOC_MONSTER_APPLY_OBSCURITY"] = function(ctx)
    if (((not (H.char_has_flag(H.u(ctx), "TEEPSHIELD"))) and (not (H.char_has_flag(H.u(ctx), "TEEP_IMMUNE"))) and (not (((function() local eg = H.safe_id('effect', "eff_monster_immune_to_telepathy"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        H.set_var("actor", H.npc(ctx), ctx, "power_obscurity_duration", services.random.native_float(205, 835))
        H.eoc_add_effect(H.u(ctx), "telepathic_ignorance", H.var_num(H.npc(ctx), "power_obscurity_duration"), nil, nil, nil)
        H.eoc_add_effect(H.npc(ctx), "telepathic_ignorance_self", H.var_num(H.npc(ctx), "power_obscurity_duration"), nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TELEPORT_SUMMON_LAB_DEVOURER"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_NETHER_LAB_DEVOURER_BREACH"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(1, 3)), min_radius = math.floor(1), max_radius = math.floor(3) }); 
    end end
    return true
    end
    COND["EOC_AMALGAMATION_TELEKINETIC_SHIELDER_APPLICATION"] = function(ctx)
        return ((H.species_nearby(H.u(ctx), { "ZOMBIE", "FERAL" }, 25, nil) > 0)) == true
    end
    EOC["EOC_AMALGAMATION_TELEKINETIC_SHIELDER_APPLICATION"] = function(ctx)
    if ((H.species_nearby(H.u(ctx), { "ZOMBIE", "FERAL" }, 25, nil) > 0)) then
        H.eoc_cast_spell(H.u(ctx), "amalgamation_telekinetic_shielder_shield_other_spell_self_casting", false, { hit_self = true })
        H.eoc_add_effect(H.npc(ctx), "effect_amalgamation_telekinetic_shielder_counter", 60, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_SILENT_ONE_DRAINING_POWER"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_SILENT_ONE_DRAINING_POWER"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        do local _g = H.safe_id('morale', "morale_silent_one_drain"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-5), math.floor(-200), { duration = services.time.duration_from_turns(math.floor(86400)), decay_start = services.time.duration_from_turns(math.floor(43200)) }) end end
        H.set_char_health(H.u(ctx), (services.random.native_int(0, H.round_half_away(10)) + 5), "-=")
        if (H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) then
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor((services.random.native_int(0, H.round_half_away(125)) + 250) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = (services.random.native_int(0, H.round_half_away(125)) + 250); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        else
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(125 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 125; local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        end
        do local _a = H.u(ctx); if _a then if "+=" == '=' then services.needs.set_calories(_a, math.floor(125 + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = 125; local _d = ("+=" == '+=') and _nxt or (("+=" == '-=') and -_nxt or (("+=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        services.messages.add(ctx:expand_text(services.translate("You feel a sudden wave of fatigue!")), "bad")
        H.set_char_val_extra(H.npc(ctx), "anger", (services.random.native_int(0, H.round_half_away(5)) + 2), "-=")
        return true
    else
        H.set_char_val_extra(H.u(ctx), "anger", (services.random.native_int(0, H.round_half_away(5)) + 5), "-=")
        H.set_char_val_extra(H.u(ctx), "morale", (services.random.native_int(0, H.round_half_away(10)) + 10), "-=")
        H.eoc_add_effect(H.u(ctx), "effect_silent_one_monster_drain", 1800, nil, nil, nil)
        return false
    end
    end
    COND["EOC_SILENT_ONE_DETECT_PSIONIC_ACTIVITY"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_SILENT_ONE_DETECT_PSIONIC_ACTIVITY"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        if ((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) or (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") >= 1)) then
            H.set_char_val_extra(H.npc(ctx), "anger", (services.random.native_int(0, H.round_half_away(5)) + 1), "+=")
            services.messages.add(ctx:expand_text(services.translate("The hairs rise on the back of your neck as you feel a sudden sense of menace.")), "bad")
        end
        if (H.char_val_extra(H.npc(ctx), "anger") > 20) then
            H.eoc_loc_var(H.npc(ctx), ctx, "context", "loc", nil, nil, nil, nil, nil, false, true, {  }, {  })
            do local _a = H.npc(ctx); if _a then local cs = H.creature_snap(_a); H.eoc_cast_spell(_a, "silent_one_polymorph_to_hostile", (cs and cs.kind == 'monster'), { target = H.get_tripoint_var("context", nil, ctx, "loc") }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_SILENT_ONE_DETECT_PSIONIC_ACTIVITY_AGGRESSIVE"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_SILENT_ONE_DETECT_PSIONIC_ACTIVITY_AGGRESSIVE"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        if ((H.char_vitamin(H.u(ctx), "vitamin_maintained_powers") >= 1) or (H.var_num(H.u(ctx), "nether_conduit_repeated_channeling_value") >= 1)) then
            H.set_char_val_extra(H.npc(ctx), "anger", (services.random.native_int(0, H.round_half_away(10)) + 2), "+=")
            services.messages.add(ctx:expand_text(services.translate("A chill aura emanates from the silent one.")), "bad")
        else
            H.set_char_val_extra(H.npc(ctx), "anger", (services.random.native_int(0, H.round_half_away(25)) + 25), "-=")
        end
        return true
    end
    return false
    end
    COND["EOC_EATER_DRAIN"] = function(ctx)
        return ((H.u(ctx) ~= nil)) == true
    end
    EOC["EOC_EATER_DRAIN"] = function(ctx)
    if ((H.u(ctx) ~= nil)) then
        H.run_eoc("EOC_EATER_DRAIN_2", ctx, nil, nil, nil)
        return true
    else
        H.eoc_cast_spell(H.u(ctx), "eater_drain_health", false, nil)
        return false
    end
    end
    COND["EOC_EATER_DRAIN_2"] = function(ctx)
        return ((H.char_mana(H.u(ctx), "current") >= 150)) == true
    end
    EOC["EOC_EATER_DRAIN_2"] = function(ctx)
    if ((H.char_mana(H.u(ctx), "current") >= 150)) then
        H.eoc_cast_spell(H.u(ctx), "eater_drain_mana", false, nil)
        services.messages.add(ctx:expand_text(services.translate("You feel a sudden emptiness.")), "bad")
        return true
    else
        H.run_eoc("EOC_EATER_DRAIN_3", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_EATER_DRAIN_3"] = function(ctx)
        return (((((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0) >= 200)) == true
    end
    EOC["EOC_EATER_DRAIN_3"] = function(ctx)
    if (((((H.char_snap(H.u(ctx)) or {}).needs or {}).stamina or 0) >= 200)) then
        H.eoc_cast_spell(H.u(ctx), "eater_drain_stamina", false, nil)
        services.messages.add(ctx:expand_text(services.translate("For a moment, you feel exhausted.")), "bad")
        return true
    else
        H.eoc_cast_spell(H.u(ctx), "eater_drain_health", false, nil)
        services.messages.add(ctx:expand_text(services.translate("You feel your life draining away!")), "bad")
        return false
    end
    end
    COND["EOC_MOM_HOUND_SPEED_ADJUSTMENT"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_hound_extended_speed_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_MOM_HOUND_SPEED_ADJUSTMENT"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_hound_extended_speed_bonus"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.u(ctx), "effect_hound_extended_speed_bonus", 300, nil, nil, nil)
        H.eoc_add_effect(H.npc(ctx), "effect_mom_tindalos_hounds_corrupted_stride", 300, nil, nil, nil)
        return true
    else
        do local _eg = H.safe_id('effect', "effect_hound_extended_speed_bonus"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_mom_tindalos_hounds_corrupted_stride"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.npc(ctx) and _eg then services.effects.remove(H.npc(ctx), _eg, _bp) end end
        return false
    end
    end
    EOC["EOC_OBSIDIAN_RING_COMPUTER_CLAIRSENTIENT_DIALOGUE"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_OBSIDIAN_RING_COMPUTER_TELEPATH_DIALOGUE"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_OBSIDIAN_RING_COMPUTER_TELEPORTER_DIALOGUE"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_OBSIDIAN_RING_COMPUTER_VITAKINESIS_DIALOGUE"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_OBSIDIAN_RING_COMPUTER_BIOKINESIS_DIALOGUE"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_REMOVE_REFUGEE_CENTER_TRAITOR_BANISHED"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_19"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_refugee_center_traitor_because_banished" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_BIOKINETIC_CRYSTAL_SELECTED"] = function(ctx)
    do local _g = H.safe_id('json_flag', "MOM_SHADOW_URGE_CHOICE"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_BIOKINETIC_CRYSTAL"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "activated_shadow_urge_machine", "no")
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", ctx:expand_text(services.translate("Which crystal do you enter?")), { {  } }, { "EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECT_BIOKINETIC_CRYSTAL_SELECTED" }, {  })
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_BIOKINETIC_CRYSTAL_CONSUME_RUN"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    H.set_var("actor", H.u(ctx), ctx, "activated_shadow_urge_machine", "yes")
    return true
    end
    EOC["EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_BIOKINETIC_CRYSTAL_CONSUME"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { {  } }, { "EOC_MOM_BIOKINESIS_VITAKINESIS_LAB_SHADOW_URGE_SELECTED_BIOKINETIC_CRYSTAL_CONSUME_RUN" }, {  })
    return true
    end
end
