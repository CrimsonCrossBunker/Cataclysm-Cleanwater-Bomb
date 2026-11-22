local ccb = require("ccb")
local services = ccb.services
local H = {}

H.safe_id = function(kind, name)
    local ok, gid = pcall(services.types.id, kind, name)
    if not ok then return nil end
    return gid
end

H.add_effect = function(actor, eff_id, turns)
    if not actor then return end
    local gid = H.safe_id("effect", eff_id)
    if not gid then return end
    local dur = turns < 0 and services.time.infinite_duration() or services.time.duration_from_turns(math.floor(turns))
    services.effects.add(actor, gid, dur)
end

H.assign_activity = function(actor, act_id, turns)
    if not actor then return end
    local gid = H.safe_id("activity", act_id)
    if not gid then return end
    services.activities.assign_timed(actor, gid, services.time.duration_from_turns(math.floor(turns)))
end

H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end

H.char_has_any_trait = function(actor, ids)
    if not actor then return false end
    for _, id in ipairs(ids) do
        if H.char_has_trait(actor, id) == 1 then return true end
    end
    return false
end

H.char_has_flag = function(actor, flag_id)
    if not actor then return false end
    local gid = H.safe_id("json_flag", flag_id)
    if not gid then return false end
    local r = services.characters.has_flag(actor, gid)
    return r.ok and r.value == true
end

H.char_has_item = function(actor, item_id)
    if not actor then return false end
    local gid = H.safe_id("item", item_id)
    if not gid then return false end
    local r = services.inventory.has_type(actor, gid)
    return r.ok and r.value == true
end

H.char_snap = function(actor)
    if not actor then return nil end
    local r = services.characters.snapshot(actor)
    if not r.ok then return nil end
    return r.value
end

H.char_need = function(actor, field)
    local s = H.char_snap(actor)
    if not s or not s.needs then return 0 end
    return s.needs[field] or 0
end

H.char_on_furniture = function(actor, furn_id)
    local s = H.char_snap(actor)
    if not s or not s.creature then return false end
    return services.gameplay.environment.furniture_id(s.creature.position) == furn_id
end

H.char_school_level = function(actor, school_id)
    if not actor then return -1 end
    local gid = H.safe_id("mutation", school_id)
    if not gid then return -1 end
    local r = services.spells.school_level(actor, gid)
    if not r.ok or r.value == nil then return -1 end
    return r.value
end

H.char_spell_level = function(actor, spell_id)
    if not actor then return -1 end
    local r = services.spells.effective_level(actor, spell_id)
    if not r.ok or r.value == nil then return -1 end
    return r.value
end

H.char_spell_level_sum = function(actor, school_id)
    if not actor then return 0 end
    local gid = nil
    if school_id and school_id ~= "" then
        gid = H.safe_id("mutation", school_id)
        if not gid then return 0 end
    end
    local r = services.spells.level_sum(actor, gid, 0)
    if not r.ok then return 0 end
    return r.value or 0
end

H.char_stat = function(actor, field)
    local s = H.char_snap(actor)
    if not s then return 0 end
    return s.stats[field] or 0
end

H.creature_has_effect = function(actor, effect_id, body_part, intensity)
    if not actor then return false end
    local gid = H.safe_id("effect", effect_id)
    if not gid then return false end
    local bp_gid = nil
    if body_part and body_part ~= "" then
        bp_gid = H.safe_id("body_part", body_part)
        if not bp_gid then return false end
    end
    local r = services.effects.has(actor, gid, bp_gid, intensity)
    return r.ok and r.value == true
end

H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

H.npc = function(ctx)
    return ctx:interlocutor()
end

H.round_half_away = function(v)
    if v >= 0 then return math.floor(v + 0.5) end
    return math.ceil(v - 0.5)
end

H.set_var = function(scope, actor, ctx, key, val)
    if scope == "context" then
        if val == nil then ctx:remove(key) else ctx:set(key, val) end
        return
    end
    if scope == "global" then
        if val == nil then services.variables.remove_global(key) else services.variables.set_global(key, val) end
        return
    end
    if not actor then return end
    if val == nil then services.variables.remove(actor, key) else services.variables.set(actor, key, val) end
end

H.u = function(ctx)
    return ctx:speaker()
end

H.jmath_jmath_telepathy_knacks_combined_level = function(ctx)
    return (((((((H.char_spell_level(H.u(ctx), "telepathic_shield_knack") + H.char_spell_level(H.u(ctx), "telepathic_mind_sense_knack")) + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")) + H.char_spell_level(H.u(ctx), "telepathic_blast_knack")) + H.char_spell_level(H.u(ctx), "telepathic_mesmerize_knack")) + H.char_spell_level(H.u(ctx), "telepathic_animal_mind_control_knack")) + H.char_spell_level(H.u(ctx), "telepathic_invisibility_knack")) + H.char_spell_level(H.u(ctx), "telepathic_blast_radius_knack"))
end

ccb.runtime.handler("dlg_p_mindovermatter_222d75bf80b0", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 2) or (H.char_spell_level(H.u(ctx), "clair_danger_sense_knack") >= 8))
end)

ccb.runtime.handler("dlg_p_mindovermatter_5b3ce0810487", function(ctx)
    return (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") >= 1)
end)

ccb.runtime.handler("dlg_p_mindovermatter_c24efe0eb6fd", function(ctx)
    return ((H.jmath_jmath_telepathy_knacks_combined_level(ctx) > 10) or (H.char_has_trait(H.u(ctx), "TELEPATH") == 1))
end)

ccb.runtime.handler("dlg_p_mindovermatter_ed589545a0d1", function(ctx)
    return ((H.char_school_level(H.u(ctx), "TELEPATH") >= 10) or (H.jmath_jmath_telepathy_knacks_combined_level(ctx) > 20))
end)

ccb.runtime.handler("dlg_p_mindovermatter_62abf232ddd6", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 30)
end)

ccb.runtime.handler("dlg_p_mindovermatter_60ee61334138", function(ctx)
    return ((H.char_need(H.npc(ctx), "thirst") > (80)) or (H.char_need(H.npc(ctx), "hunger") > (160)) or (H.char_need(H.npc(ctx), "sleepiness") > (191)) or (((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true) or (((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true) or H.creature_has_effect(H.npc(ctx), "asked_to_vitakinetic_heal", nil, nil))
end)

ccb.runtime.handler("dlg_p_mindovermatter_83ff787adb53", function(ctx)
    return (((H.char_snap(H.u(ctx)) or {}).movement or {}).driving == true)
end)

ccb.runtime.handler("dlg_p_mindovermatter_ad31ba7ddf09", function(ctx)
    return (((H.char_snap(H.npc(ctx)) or {}).movement or {}).driving == true)
end)

ccb.runtime.handler("dlg_p_mindovermatter_c12d8bd39fb6", function(ctx)
    return (H.char_need(H.npc(ctx), "thirst") > (80))
end)

ccb.runtime.handler("dlg_p_mindovermatter_170fbd5b08e8", function(ctx)
    return (H.char_need(H.npc(ctx), "hunger") > (160))
end)

ccb.runtime.handler("dlg_p_mindovermatter_f11538b5053e", function(ctx)
    return (H.char_need(H.npc(ctx), "sleepiness") > (191))
end)

ccb.runtime.handler("dlg_p_mindovermatter_8333d7767a16", function(ctx)
    return ((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) or (H.jmath_jmath_telepathy_knacks_combined_level(ctx) > 10))
end)

ccb.runtime.handler("dlg_p_mindovermatter_36a04c7d320b", function(ctx)
    return (((H.char_spell_level(H.u(ctx), "telepathic_morale") >= 1) or (H.char_spell_level(H.u(ctx), "telepathic_morale_knack") > 1)) and (not ((H.char_has_trait(H.npc(ctx), "NPC_TELEPATHY_IMMUNE") == 1))) and (not (H.char_has_flag(H.npc(ctx), "TEEPSHIELD"))))
end)

ccb.runtime.handler("dlg_p_mindovermatter_695b06c33141", function(ctx)
    return ((services.random.native_int(1, math.floor(10)) + ((H.char_spell_level(H.u(ctx), "telepathic_morale") + H.char_spell_level(H.u(ctx), "telepathic_morale_knack")))) > (H.char_stat(H.npc(ctx), "intelligence")))
end)

ccb.runtime.handler("dlg_p_mindovermatter_a42101192724", function(ctx)
    return (((services.random.native_int(1, math.floor(5)) + ((H.char_school_level(H.u(ctx), "TELEPATH") + (H.jmath_jmath_telepathy_knacks_combined_level(ctx) - 5)))) > (H.char_stat(H.npc(ctx), "intelligence"))) and (H.global_var_num("telepathically_stole_recently") <= 15))
end)

ccb.runtime.handler("dlg_p_mindovermatter_4d44b6e93be9", function(ctx)
    return (H.char_spell_level(H.u(ctx), "clair_clear_sight") >= 3)
end)

ccb.runtime.handler("dlg_p_mindovermatter_4e39a8ddadc9", function(ctx)
    return (H.char_spell_level(H.u(ctx), "teleport_gateway") >= 8)
end)

ccb.runtime.handler("dlg_p_mindovermatter_fb988aab4d33", function(ctx)
    return (((H.char_spell_level(H.u(ctx), "knack_clair_danger_sense") <= 11) and (H.char_spell_level(H.u(ctx), "knack_clair_danger_sense") ~= (-1))) or ((H.char_spell_level(H.u(ctx), "clair_danger_sense") <= 7) and (H.char_spell_level(H.u(ctx), "clair_danger_sense") ~= (-1))))
end)

ccb.runtime.handler("dlg_p_mindovermatter_e102dd3a1faa", function(ctx)
    return ((H.char_spell_level(H.u(ctx), "clair_danger_sense") > 7) or (H.char_spell_level(H.u(ctx), "clair_danger_sense") > 11))
end)

ccb.runtime.handler("dlg_p_mindovermatter_2aa005690cdb", function(ctx)
    return (H.char_spell_level(H.u(ctx), "clair_sense_hostile_creatures") >= 4)
end)

ccb.runtime.handler("dlg_p_mindovermatter_81c9b49d3f15", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60)
end)

ccb.runtime.handler("dlg_p_mindovermatter_88041846ca42", function(ctx)
    return ((H.char_school_level(H.u(ctx), "TELEPATH") >= 8) or (H.jmath_jmath_telepathy_knacks_combined_level(ctx) > 18))
end)

ccb.runtime.handler("dlg_p_mindovermatter_e91697b237dd", function(ctx)
    return H.char_on_furniture(H.u(ctx), "f_biokinetic_physiology_improver")
end)

ccb.runtime.handler("dlg_p_mindovermatter_021703ba852f", function(ctx)
    return (H.char_on_furniture(H.u(ctx), "f_biokinetic_physiology_improver") and H.char_has_item(H.u(ctx), "lab_file_shadow_urge_password"))
end)

ccb.runtime.handler("dlg_p_mindovermatter_f86c1b9c97f9", function(ctx)
    return (H.char_on_furniture(H.u(ctx), "f_biokinetic_physiology_improver") and (not (H.char_has_item(H.u(ctx), "lab_file_shadow_urge_password"))))
end)

ccb.runtime.handler("dlg_p_mindovermatter_32f7e13ae876", function(ctx)
    return (not (H.char_on_furniture(H.u(ctx), "f_biokinetic_physiology_improver")))
end)

ccb.runtime.handler("dlg_a_mindovermatter_98efafa391b5", function(ctx)
    ctx:set_conditional("perk_condition", ((services.proficiencies.has_id_text(H.u(ctx), "prof_concentration_basic").value == true) and (not ((H.char_has_trait(H.u(ctx), "CONCENTRATION_BAD") == 1)))))
end)

ccb.runtime.handler("dlg_a_mindovermatter_d4a20b456449", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "telekinetic_hammer") >= 1) or (H.char_spell_level(H.u(ctx), "telekinetic_explosion") >= 1)))
end)

ccb.runtime.handler("dlg_a_mindovermatter_749adcaaabfb", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "biokin_metabolism_enhance") >= 6) or (H.char_spell_level(H.u(ctx), "vita_sleeping_trance") >= 5)))
end)

ccb.runtime.handler("dlg_a_mindovermatter_41e132fb13c4", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "biokin_overcome_pain") >= 5) or (H.char_spell_level(H.u(ctx), "electrokinetic_reduce_pain") >= 6) or (H.char_spell_level(H.u(ctx), "telepathic_morale") >= 8)))
end)

ccb.runtime.handler("dlg_a_mindovermatter_a61b3676c020", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level_sum(H.u(ctx), "BIOKINETIC") >= 40) or (H.char_spell_level_sum(H.u(ctx), "CLAIRSENTIENT") >= 40) or (H.char_spell_level_sum(H.u(ctx), "ELECTROKINETIC") >= 40) or (H.char_spell_level_sum(H.u(ctx), "PHOTOKINETIC") >= 40) or (H.char_spell_level_sum(H.u(ctx), "PYROKINETIC") >= 40) or (H.char_spell_level_sum(H.u(ctx), "TELEPATH") >= 40) or (H.char_spell_level_sum(H.u(ctx), "TELEKINETIC") >= 40) or (H.char_spell_level_sum(H.u(ctx), "TELEPORTER") >= 40) or (H.char_spell_level_sum(H.u(ctx), "VITAKINETIC") >= 40)))
end)

ccb.runtime.handler("dlg_a_mindovermatter_cdd63c5284b6", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "telepathic_blast") >= 5) or (H.char_spell_level(H.u(ctx), "telepathic_blast_radius") >= 5) or (H.char_spell_level(H.u(ctx), "telepathic_blast_knack") >= 5) or (H.char_spell_level(H.u(ctx), "telepathic_blast_radius_knack") >= 5)))
end)

ccb.runtime.handler("dlg_a_mindovermatter_2cae873e6578", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level_sum(H.u(ctx), "BIOKINETIC") + H.char_spell_level_sum(H.u(ctx), "VITAKINETIC")) >= 100))
end)

ccb.runtime.handler("dlg_a_mindovermatter_cd77c4fba5af", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "TELEPATH") == 1) or (H.char_has_trait(H.u(ctx), "VITAKINETIC") == 1)))
end)

ccb.runtime.handler("dlg_a_mindovermatter_f528bfef766d", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_spell_level_sum(H.u(ctx), "PYROKINETIC") >= 30))
end)

ccb.runtime.handler("dlg_a_mindovermatter_d65b127805f4", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_spell_level(H.u(ctx), "clair_danger_sense") >= 5))
end)

ccb.runtime.handler("dlg_a_mindovermatter_9421131d4410", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING") == 1))
end)

ccb.runtime.handler("dlg_a_mindovermatter_bcccfc29c279", function(ctx)
    ctx:set_conditional("perk_condition", H.char_has_any_trait(H.u(ctx), { "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC" }))
end)

ccb.runtime.handler("dlg_a_mindovermatter_df936e254f08", function(ctx)
    local _ach1 = H.safe_id("achievement", "mom_read_rubiks_mind")
    if _ach1 then services.achievements.complete(_ach1) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_67f27142b7a4", function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Your telepathy attempt failed!")), "bad")
end)

ccb.runtime.handler("dlg_a_mindovermatter_2cfa11e32d4b", function(ctx)
    H.set_var("global", nil, ctx, "telepathically_stole_recently", (H.global_var_num("telepathically_stole_recently")) + (services.random.native_int(0, H.round_half_away(5))))
    local _ach2 = H.safe_id("achievement", "mom_use_telepathy_to_steal")
    if _ach2 then services.achievements.complete(_ach2) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_9387dea2b6c1", function(ctx)
    local _ach3 = H.safe_id("achievement", "teleported_offworld")
    if _ach3 then services.achievements.complete(_ach3) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_13dcaba35575", function(ctx)
    local _a4 = H.u(ctx)
    if _a4 then services.characters.adjust(_a4, { pain = math.floor(5) }) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_6abd6bb21f81", function(ctx)
    local _n5 = H.npc(ctx)
    local _fac6 = H.safe_id("faction", "hells_raiders")
    if _n5 and _fac6 then services.npcs.set_faction(_n5, _fac6) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_c86cc50b1935", function(ctx)
    local _n7 = H.npc(ctx)
    local _fac8 = H.safe_id("faction", "old_guard")
    if _n7 and _fac8 then services.npcs.set_faction(_n7, _fac8) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_22abd5d5205c", function(ctx)
    local _n9 = H.npc(ctx)
    local _fac10 = H.safe_id("faction", "old_guard")
    if _n9 and _fac10 then services.npcs.set_faction(_n9, _fac10) end
end)

ccb.runtime.handler("dlg_a_mindovermatter_a8520dd3dbfd", function(ctx)
    H.set_var("context", nil, ctx, "duration", (14400 + services.random.native_int(0, H.round_half_away(7200))))
    H.add_effect(H.u(ctx), "effect_mom_shadow_urge_process_operation", (ctx:get_number("duration") or 0))
    H.assign_activity(H.u(ctx), "ACT_MOM_SHADOW_URGE_GAIN_STRENGTH", (ctx:get_number("duration") or 0))
end)

ccb.runtime.handler("dlg_a_mindovermatter_a13a804dd05f", function(ctx)
    H.set_var("context", nil, ctx, "duration", (14400 + services.random.native_int(0, H.round_half_away(7200))))
    H.add_effect(H.u(ctx), "effect_mom_shadow_urge_process_operation", (ctx:get_number("duration") or 0))
    H.assign_activity(H.u(ctx), "ACT_MOM_SHADOW_URGE_GAIN_AGILITY", (ctx:get_number("duration") or 0))
end)

ccb.runtime.handler("dlg_a_mindovermatter_88fa3d64e264", function(ctx)
    H.set_var("context", nil, ctx, "duration", (14400 + services.random.native_int(0, H.round_half_away(7200))))
    H.add_effect(H.u(ctx), "effect_mom_shadow_urge_process_operation", (ctx:get_number("duration") or 0))
    H.assign_activity(H.u(ctx), "ACT_MOM_SHADOW_URGE_GAIN_RESILIENCE", (ctx:get_number("duration") or 0))
end)

ccb.runtime.handler("dlg_a_mindovermatter_01bb8aa35ac9", function(ctx)
    H.set_var("context", nil, ctx, "duration", (14400 + services.random.native_int(0, H.round_half_away(7200))))
    H.add_effect(H.u(ctx), "effect_mom_shadow_urge_process_operation", (ctx:get_number("duration") or 0))
    H.assign_activity(H.u(ctx), "ACT_MOM_SHADOW_URGE_GAIN_RECOVERY", (ctx:get_number("duration") or 0))
end)
