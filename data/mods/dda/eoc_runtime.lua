local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

H.char_coverage = function(actor, bp)
    if not actor then return 0 end
    local gid = H.safe_id("body_part", bp)
    if not gid then return 0 end
    local r = services.characters.coverage(actor, gid)
    if not r.ok then return 0 end
    return r.value or 0
end
H.char_encumbrance = function(actor, bp)
    local s = H.char_snap(actor)
    if not s or not s.body_parts then return 0 end
    for _, e in ipairs(s.body_parts) do
        if e.id and e.id.value == bp then return e.encumbrance or 0 end
    end
    return 0
end
H.set_char_addiction = function(actor, add_id, field, val, op)
    if not actor then return end
    local gid = H.safe_id("addiction", add_id)
    if not gid then return end
    local cur = H.char_addiction(actor, add_id, field)
    local nxt = val
    if op == "+=" then nxt = cur + val
    elseif op == "-=" then nxt = cur - val
    elseif op == "*=" then nxt = cur * val
    elseif op == "/=" then nxt = cur / val
    end
    if field == "turns" then
        services.addictions.set(actor, gid, { turns = math.floor(nxt + 0.5) })
    else
        services.addictions.set(actor, gid, { intensity = math.floor(nxt + 0.5) })
    end
end
H._jm_addiction_rational = function(ctx, _a0, _a1, _a2)
    return ((_a0 / math.max(1, (_a0 - (_a1 * _a2)))) - 1)
end

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)
require("eoc_handlers_03")(E, H)
require("eoc_handlers_04")(E, H)
require("eoc_handlers_05")(E, H)
require("eoc_handlers_06")(E, H)
require("eoc_handlers_07")(E, H)
require("eoc_handlers_08")(E, H)
require("eoc_handlers_09")(E, H)
require("eoc_handlers_10")(E, H)
require("eoc_handlers_11")(E, H)
require("eoc_handlers_12")(E, H)

-- Generic EOC runtime handlers for cross-mod & scheduled calls
for eid, fn in pairs(E.run) do
    ccb.runtime.handler("eoc:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        fn(H.ctx_new(u, npc, vars))
    end)
end
for eid, cfn in pairs(E.cond) do
    ccb.runtime.handler("eoc_test:" .. eid, function(payload)
        local p = type(payload) == "table" and payload or nil
        local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
        local npc = p and p.npc or nil
        local vars = (p and p.vars) or {}
        return cfn(H.ctx_new(u, npc, vars)) == true
    end)
end

-- EVENT triggers
ccb.runtime.handler("eoc_ev:activates_mininuke", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_mininuke_record", ctx)
end)
ccb.runtime.on("game:activates_mininuke", "eoc_ev:activates_mininuke")
ccb.runtime.handler("eoc_ev:avatar_enters_omt", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("lab_security_check", ctx)
    H.run_eoc("lab_security_check_surface_3", ctx)
    H.run_eoc("lab_security_check_surface_2", ctx)
    H.run_eoc("lab_security_check_surface_1", ctx)
    H.run_eoc("lab_check_magenta_security_drop", ctx)
    H.run_eoc("lab_1x1x2_RES_8_check_SEC", ctx)
    H.run_eoc("lab_1x1x2_RES_8_check_MAINT", ctx)
    H.run_eoc("lab_concourse_bot_release", ctx)
    H.run_eoc("lab_concourse_bot_release_2", ctx)
    H.run_eoc("lab_magenta_security_check", ctx)
    H.run_eoc("lab_cyan_mutagen_check", ctx)
    H.run_eoc("lab_cyan_mutagen_check_2", ctx)
    H.run_eoc("lab_cyan_mutagen_check_3", ctx)
    H.run_eoc("lab_cyan_mutagen_check_4", ctx)
    H.run_eoc("lab_pink_mutagen_check", ctx)
    H.run_eoc("lab_pink_mutagen_check_2", ctx)
    H.run_eoc("lab_pink_mutagen_check_3", ctx)
    H.run_eoc("lab_pink_mutagen_check_4", ctx)
    H.run_eoc("EOC_STRING_DIMENSION_ENTERED_EXODII_DOME", ctx)
    H.run_eoc("EOC_quietfarm_nearby", ctx)
    H.run_eoc("EOC_vitrified_farm_entry_event", ctx)
    H.run_eoc("EOC_MISSION_OLD_GUARD_REP_3_CHECK", ctx)
    H.run_eoc("isherwood_mission_barry_return_home", ctx)
    H.run_eoc("EOC_HAVE_U_BEEN_TO_MIGOS", ctx)
    H.run_eoc("EOC_barricaded_church_nearby", ctx)
    H.run_eoc("EOC_morgantown_nearby", ctx)
    H.run_eoc("EOC_fishing_shack_nearby", ctx)
end)
ccb.runtime.on("game:avatar_enters_omt", "eoc_ev:avatar_enters_omt")
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DIVING_INTO_WATER_CHECK", ctx)
    H.run_eoc("isherwood_mission_player_leaves_map", ctx)
    H.run_eoc("isherwood_mission_player_leaves_map_setup", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:broken_bone", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FACTION_SUCCESSION_IMMEDIATE", ctx)
end)
ccb.runtime.on("game:broken_bone", "eoc_ev:broken_bone")
ccb.runtime.handler("eoc_ev:camp_taken_over", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_TOOK_OVER_CAMP_NOTICE", ctx)
end)
ccb.runtime.on("game:camp_taken_over", "eoc_ev:camp_taken_over")
ccb.runtime.handler("eoc_ev:character_attempt_to_fall_asleep", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PRE_THRESHOLD_SPIDER_SLEEP_MUTATION", ctx)
end)
ccb.runtime.on("game:character_attempt_to_fall_asleep", "eoc_ev:character_attempt_to_fall_asleep")
ccb.runtime.handler("eoc_ev:character_dies", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_event_character_dies_test", ctx)
end)
ccb.runtime.on("game:character_dies", "eoc_ev:character_dies")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_dermatik_visible_INIT", ctx)
    H.run_eoc("eoc_boomered_apply_conjunctivitis", ctx)
    H.run_eoc("EOC_boomer_bile_affliction", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_kills_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_SINGULARITY_RECLAIMER_CHECK_KILL_AMOUNT", ctx)
end)
ccb.runtime.on("game:character_kills_monster", "eoc_ev:character_kills_monster")
ccb.runtime.handler("eoc_ev:character_loses_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_DERMATIK_BIRTH", ctx)
end)
ccb.runtime.on("game:character_loses_effect", "eoc_ev:character_loses_effect")
ccb.runtime.handler("eoc_ev:character_radioactively_mutates", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_RADIATION_MUTATION", ctx)
end)
ccb.runtime.on("game:character_radioactively_mutates", "eoc_ev:character_radioactively_mutates")
ccb.runtime.handler("eoc_ev:character_wakes_up", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_GIVE_NIGHTMARES", ctx)
    H.run_eoc("EOC_GIVE_HEALTH_MESSAGE", ctx)
end)
ccb.runtime.on("game:character_wakes_up", "eoc_ev:character_wakes_up")
ccb.runtime.handler("eoc_ev:gains_mutation", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MUTE_BIRD_GAIN", ctx)
    H.run_eoc("EOC_MUTE_CEPHALOPOD_GAIN", ctx)
    H.run_eoc("EOC_MUTE_GASTROPOD_GAIN", ctx)
    H.run_eoc("EOC_MUTE_INSECT_GAIN", ctx)
    H.run_eoc("EOC_MUTE_SLIME_GAIN", ctx)
    H.run_eoc("EOC_MUTE_DEXTEROUS_PAWS_GAIN", ctx)
end)
ccb.runtime.on("game:gains_mutation", "eoc_ev:gains_mutation")
ccb.runtime.handler("eoc_ev:game_avatar_new", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_vitrified_succession", ctx)
    H.run_eoc("EOC_FACTION_SUCCESSION_CHANGE_REINIT", ctx)
end)
ccb.runtime.on("game:game_avatar_new", "eoc_ev:game_avatar_new")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_FACTION_SUCCESSION_COOLDOWN_GAMEBEGIN_CHECK", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_start", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_START_SCARLET_STORM", ctx)
    H.run_eoc("EOC_START_BALTHAZAR_COUNTERS", ctx)
    H.run_eoc("EOC_SINGULARITY_RECLAIMER_SETUP", ctx)
end)
ccb.runtime.on("game:game_start", "eoc_ev:game_start")
ccb.runtime.handler("eoc_ev:loses_mutation", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_MUTE_BEAK_LOSE_1", ctx)
    H.run_eoc("EOC_MUTE_GASTROPOD_LOSE_1", ctx)
    H.run_eoc("EOC_DEXTROUS_PAWS_LOSE", ctx)
    H.run_eoc("EOC_ink_gland_ink_cleanup", ctx)
end)
ccb.runtime.on("game:loses_mutation", "eoc_ev:loses_mutation")

-- AVATAR_DEATH subscribers
ccb.runtime.handler("eoc_ev:avatar_death", function(payload)
    local ctx = H.ctx_new(nil, nil, {}, { avatar_death = payload })
    H.run_eoc("EOC_DEATH_SWITCH", ctx)
    H.run_eoc("vitrified_death", ctx)
end)
ccb.runtime.on("avatar_death", "eoc_ev:avatar_death")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:bio_drain", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_drain"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_drain")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_drain", ctx)
end)
ccb.runtime.handler("eoc_int:bio_drain", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(5400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_drain", "eoc_int:bio_drain")
ccb.runtime.handler("eoc_rec:bio_trip", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_trip"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_trip")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_trip", ctx)
end)
ccb.runtime.handler("eoc_int:bio_trip", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1500), math.floor(4500); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_trip", "eoc_int:bio_trip")
ccb.runtime.handler("eoc_rec:bio_spasm", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_spasm"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_spasm")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_spasm", ctx)
end)
ccb.runtime.handler("eoc_int:bio_spasm", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(9000), math.floor(27000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_spasm", "eoc_int:bio_spasm")
ccb.runtime.handler("eoc_rec:bio_shakes", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_shakes"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_shakes")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_shakes", ctx)
end)
ccb.runtime.handler("eoc_int:bio_shakes", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_shakes", "eoc_int:bio_shakes")
ccb.runtime.handler("eoc_rec:bio_glowy", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_glowy"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_glowy")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_glowy", ctx)
end)
ccb.runtime.handler("eoc_int:bio_glowy", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1500), math.floor(4500); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_glowy", "eoc_int:bio_glowy")
ccb.runtime.handler("eoc_rec:bio_sleepy", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_sleepy"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_sleepy")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_sleepy", ctx)
end)
ccb.runtime.handler("eoc_int:bio_sleepy", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1500), math.floor(4500); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_sleepy", "eoc_int:bio_sleepy")
ccb.runtime.handler("eoc_rec:bio_itchy", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_itchy"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_itchy")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_itchy", ctx)
end)
ccb.runtime.handler("eoc_int:bio_itchy", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1500), math.floor(4500); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_itchy", "eoc_int:bio_itchy")
ccb.runtime.handler("eoc_rec:bio_noise", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_noise"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_noise")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_noise", ctx)
end)
ccb.runtime.handler("eoc_int:bio_noise", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(5400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_noise", "eoc_int:bio_noise")
ccb.runtime.handler("eoc_rec:bio_leaky", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bio_leaky"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_bionic(H.u(ctx), "bio_leaky")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("bio_leaky", ctx)
end)
ccb.runtime.handler("eoc_int:bio_leaky", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(180), math.floor(540); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bio_leaky", "eoc_int:bio_leaky")
ccb.runtime.handler("eoc_rec:bad_food_mood_debuff", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:bad_food_mood_debuff"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("bad_food_mood_debuff", ctx)
end)
ccb.runtime.handler("eoc_int:bad_food_mood_debuff", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:bad_food_mood_debuff", "eoc_int:bad_food_mood_debuff")
ccb.runtime.handler("eoc_rec:eoc_social_satisfied", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_social_satisfied"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("eoc_social_satisfied", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_social_satisfied", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_social_satisfied", "eoc_int:eoc_social_satisfied")
ccb.runtime.handler("eoc_rec:eoc_social_dissatisfied", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_social_dissatisfied"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("eoc_social_dissatisfied", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_social_dissatisfied", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_social_dissatisfied", "eoc_int:eoc_social_dissatisfied")
ccb.runtime.handler("eoc_rec:eoc_asocial_satisfied", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_asocial_satisfied"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("eoc_asocial_satisfied", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_asocial_satisfied", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_asocial_satisfied", "eoc_int:eoc_asocial_satisfied")
ccb.runtime.handler("eoc_rec:eoc_asocial_dissatisfied", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_asocial_dissatisfied"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("eoc_asocial_dissatisfied", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_asocial_dissatisfied", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(60), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_asocial_dissatisfied", "eoc_int:eoc_asocial_dissatisfied")
ccb.runtime.handler("eoc_rec:eoc_conjunctivitis_sting", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:eoc_conjunctivitis_sting"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("eoc_conjunctivitis_sting", ctx)
end)
ccb.runtime.handler("eoc_int:eoc_conjunctivitis_sting", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(2700), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:eoc_conjunctivitis_sting", "eoc_int:eoc_conjunctivitis_sting")
ccb.runtime.handler("eoc_rec:EOC_DERMATIK_BIRTH_INIT", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_DERMATIK_BIRTH_INIT"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_DERMATIK_BIRTH_INIT", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_DERMATIK_BIRTH_INIT", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(180), math.floor(600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_DERMATIK_BIRTH_INIT", "eoc_int:EOC_DERMATIK_BIRTH_INIT")
ccb.runtime.handler("eoc_rec:EOC_RANDOM_HALLUCINATIONS", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_RANDOM_HALLUCINATIONS"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_RANDOM_HALLUCINATIONS", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_RANDOM_HALLUCINATIONS", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_RANDOM_HALLUCINATIONS", "eoc_int:EOC_RANDOM_HALLUCINATIONS")
ccb.runtime.handler("eoc_rec:EOC_discover_zomborg", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_discover_zomborg"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (H.truthy((H.var_exists("global", nil, ctx, "dialogue_exodii_seen_zomborg") and 1 or 0))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_discover_zomborg", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_discover_zomborg", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(8)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_discover_zomborg", "eoc_int:EOC_discover_zomborg")
ccb.runtime.handler("eoc_rec:sewer_morale_debuff", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:sewer_morale_debuff"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("sewer_morale_debuff", ctx)
end)
ccb.runtime.handler("eoc_int:sewer_morale_debuff", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1200), math.floor(3600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:sewer_morale_debuff", "eoc_int:sewer_morale_debuff")
ccb.runtime.handler("eoc_rec:changing_initiate_check", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:changing_initiate_check"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (H.char_has_flag(H.u(ctx), "CHANGING")) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("changing_initiate_check", ctx)
end)
ccb.runtime.handler("eoc_int:changing_initiate_check", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(2700); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:changing_initiate_check", "eoc_int:changing_initiate_check")
ccb.runtime.handler("eoc_rec:changing_mutate", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:changing_mutate"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (H.char_has_flag(H.u(ctx), "CHANGING")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("changing_mutate", ctx)
end)
ccb.runtime.handler("eoc_int:changing_mutate", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(21600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:changing_mutate", "eoc_int:changing_mutate")
ccb.runtime.handler("eoc_rec:mut_eyestalk", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:mut_eyestalk"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "EYESTALKS1") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("mut_eyestalk", ctx)
end)
ccb.runtime.handler("eoc_int:mut_eyestalk", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(8100), math.floor(36900); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:mut_eyestalk", "eoc_int:mut_eyestalk")
ccb.runtime.handler("eoc_rec:chitin2_molt_timer1", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin2_molt_timer1"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin2_molt_timer1", ctx)
end)
ccb.runtime.handler("eoc_int:chitin2_molt_timer1", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(2073600), math.floor(3628800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin2_molt_timer1", "eoc_int:chitin2_molt_timer1")
ccb.runtime.handler("eoc_rec:chitin2_molt_timer2", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin2_molt_timer2"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin2_molt_timer2", ctx)
end)
ccb.runtime.handler("eoc_int:chitin2_molt_timer2", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin2_molt_timer2", "eoc_int:chitin2_molt_timer2")
ccb.runtime.handler("eoc_rec:chitin2_molt_timer_3", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin2_molt_timer_3"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin2_molt_timer_3", ctx)
end)
ccb.runtime.handler("eoc_int:chitin2_molt_timer_3", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin2_molt_timer_3", "eoc_int:chitin2_molt_timer_3")
ccb.runtime.handler("eoc_rec:chitin2_molt_timer4", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin2_molt_timer4"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin2_molt_timer4", ctx)
end)
ccb.runtime.handler("eoc_int:chitin2_molt_timer4", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin2_molt_timer4", "eoc_int:chitin2_molt_timer4")
ccb.runtime.handler("eoc_rec:chitin3_molt_timer1", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin3_molt_timer1"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin3_molt_timer1", ctx)
end)
ccb.runtime.handler("eoc_int:chitin3_molt_timer1", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(2073600), math.floor(3628800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin3_molt_timer1", "eoc_int:chitin3_molt_timer1")
ccb.runtime.handler("eoc_rec:chitin3_molt_timer2", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin3_molt_timer2"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin3_molt_timer2", ctx)
end)
ccb.runtime.handler("eoc_int:chitin3_molt_timer2", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(172800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin3_molt_timer2", "eoc_int:chitin3_molt_timer2")
ccb.runtime.handler("eoc_rec:chitin3_molt_timer3", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin3_molt_timer3"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin3_molt_timer3", ctx)
end)
ccb.runtime.handler("eoc_int:chitin3_molt_timer3", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin3_molt_timer3", "eoc_int:chitin3_molt_timer3")
ccb.runtime.handler("eoc_rec:chitin3_molt_timer4", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin3_molt_timer4"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin3_molt_timer4", ctx)
end)
ccb.runtime.handler("eoc_int:chitin3_molt_timer4", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin3_molt_timer4", "eoc_int:chitin3_molt_timer4")
ccb.runtime.handler("eoc_rec:chitin_carapace_molt_timer3", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin_carapace_molt_timer3"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin_carapace_molt_timer3", ctx)
end)
ccb.runtime.handler("eoc_int:chitin_carapace_molt_timer3", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(10800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin_carapace_molt_timer3", "eoc_int:chitin_carapace_molt_timer3")
ccb.runtime.handler("eoc_rec:chitin_carapace_molt_timer4", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:chitin_carapace_molt_timer4"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("chitin_carapace_molt_timer4", ctx)
end)
ccb.runtime.handler("eoc_int:chitin_carapace_molt_timer4", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:chitin_carapace_molt_timer4", "eoc_int:chitin_carapace_molt_timer4")
ccb.runtime.handler("eoc_rec:rashy_skin", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:rashy_skin"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("rashy_skin", ctx)
end)
ccb.runtime.handler("eoc_int:rashy_skin", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(7200), math.floor(86400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:rashy_skin", "eoc_int:rashy_skin")
ccb.runtime.handler("eoc_rec:hay_fever_spring_fall", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:hay_fever_spring_fall"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("hay_fever_spring_fall", ctx)
end)
ccb.runtime.handler("eoc_int:hay_fever_spring_fall", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(21600), math.floor(345600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:hay_fever_spring_fall", "eoc_int:hay_fever_spring_fall")
ccb.runtime.handler("eoc_rec:hay_fever_summer", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:hay_fever_summer"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("hay_fever_summer", ctx)
end)
ccb.runtime.handler("eoc_int:hay_fever_summer", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(28800), math.floor(691200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:hay_fever_summer", "eoc_int:hay_fever_summer")
ccb.runtime.handler("eoc_rec:sneeze", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:sneeze"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("sneeze", ctx)
end)
ccb.runtime.handler("eoc_int:sneeze", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(45), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:sneeze", "eoc_int:sneeze")
ccb.runtime.handler("eoc_rec:shed_summer_timer_lupine", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:shed_summer_timer_lupine"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("shed_summer_timer_lupine", ctx)
end)
ccb.runtime.handler("eoc_int:shed_summer_timer_lupine", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(604800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:shed_summer_timer_lupine", "eoc_int:shed_summer_timer_lupine")
ccb.runtime.handler("eoc_rec:regrow_timer_lupine", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:regrow_timer_lupine"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("regrow_timer_lupine", ctx)
end)
ccb.runtime.handler("eoc_int:regrow_timer_lupine", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(432000), math.floor(1296000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:regrow_timer_lupine", "eoc_int:regrow_timer_lupine")
ccb.runtime.handler("eoc_rec:shed_summer_timer_ursine", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:shed_summer_timer_ursine"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("shed_summer_timer_ursine", ctx)
end)
ccb.runtime.handler("eoc_int:shed_summer_timer_ursine", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(86400), math.floor(604800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:shed_summer_timer_ursine", "eoc_int:shed_summer_timer_ursine")
ccb.runtime.handler("eoc_rec:regrow_timer_ursine", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:regrow_timer_ursine"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("regrow_timer_ursine", ctx)
end)
ccb.runtime.handler("eoc_int:regrow_timer_ursine", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(432000), math.floor(1296000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:regrow_timer_ursine", "eoc_int:regrow_timer_ursine")
ccb.runtime.handler("eoc_rec:seasonal_affective_fall", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:seasonal_affective_fall"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("seasonal_affective_fall", ctx)
end)
ccb.runtime.handler("eoc_int:seasonal_affective_fall", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(432000), math.floor(1728000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:seasonal_affective_fall", "eoc_int:seasonal_affective_fall")
ccb.runtime.handler("eoc_rec:seasonal_affective_winter", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:seasonal_affective_winter"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("seasonal_affective_winter", ctx)
end)
ccb.runtime.handler("eoc_int:seasonal_affective_winter", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(259200), math.floor(1036800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:seasonal_affective_winter", "eoc_int:seasonal_affective_winter")
ccb.runtime.handler("eoc_rec:EOC_ink_gland_recharge_timer", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ink_gland_recharge_timer"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_ink_gland_recharge_timer", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ink_gland_recharge_timer", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1080), math.floor(1320); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ink_gland_recharge_timer", "eoc_int:EOC_ink_gland_recharge_timer")
ccb.runtime.handler("eoc_rec:EOC_social1_bonus", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_social1_bonus"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_social1_bonus", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_social1_bonus", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(600), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_social1_bonus", "eoc_int:EOC_social1_bonus")
ccb.runtime.handler("eoc_rec:EOC_social2_bonus", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_social2_bonus"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_social2_bonus", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_social2_bonus", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(600), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_social2_bonus", "eoc_int:EOC_social2_bonus")
ccb.runtime.handler("eoc_rec:EOC_social2_penalty", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_social2_penalty"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_social2_penalty", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_social2_penalty", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(5400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_social2_penalty", "eoc_int:EOC_social2_penalty")
ccb.runtime.handler("eoc_rec:EOC_asocial1_bonus", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_asocial1_bonus"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_asocial1_bonus", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_asocial1_bonus", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(600), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_asocial1_bonus", "eoc_int:EOC_asocial1_bonus")
ccb.runtime.handler("eoc_rec:EOC_asocial2_bonus", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_asocial2_bonus"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_asocial2_bonus", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_asocial2_bonus", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(600), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_asocial2_bonus", "eoc_int:EOC_asocial2_bonus")
ccb.runtime.handler("eoc_rec:EOC_asocial2_penalty_reset", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_asocial2_penalty_reset"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_asocial2_penalty_reset", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_asocial2_penalty_reset", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(600), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_asocial2_penalty_reset", "eoc_int:EOC_asocial2_penalty_reset")
ccb.runtime.handler("eoc_rec:EOC_asocial2_penalty", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_asocial2_penalty"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_asocial2_penalty", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_asocial2_penalty", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(5400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_asocial2_penalty", "eoc_int:EOC_asocial2_penalty")
ccb.runtime.handler("eoc_rec:EOC_social_reset_sleep", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_social_reset_sleep"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_social_reset_sleep", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_social_reset_sleep", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1800), math.floor(2700); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_social_reset_sleep", "eoc_int:EOC_social_reset_sleep")
ccb.runtime.handler("eoc_rec:EOC_social_reset_drugs", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_social_reset_drugs"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_social_reset_drugs", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_social_reset_drugs", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(1), math.floor(1); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_social_reset_drugs", "eoc_int:EOC_social_reset_drugs")
ccb.runtime.handler("eoc_rec:EOC_nether_glass_event", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_nether_glass_event"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_nether_glass_event", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_nether_glass_event", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(10)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_nether_glass_event", "eoc_int:EOC_nether_glass_event")
ccb.runtime.handler("eoc_rec:EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not (((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1) or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm") or ((function() local eg = H.safe_id('effect', "pd_strengthened_reality"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(900); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE", "eoc_int:EOC_PORTAL_DEPENDENT_EFFECTS_ACCEPTANCE")
ccb.runtime.handler("eoc_rec:EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (((not ((H.char_has_trait(H.u(ctx), "PORTAL_DEPENDENT") == 1))) or (((function() local eg = H.safe_id('effect', "pd_strengthened_reality"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "near_portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "distant_portal_storm")))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(900), math.floor(6000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION", "eoc_int:EOC_PORTAL_DEPENDENT_EFFECTS_REJECTION")
ccb.runtime.handler("eoc_rec:vitrified_bleed_check", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:vitrified_bleed_check"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("vitrified_bleed_check", ctx)
end)
ccb.runtime.handler("eoc_int:vitrified_bleed_check", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(10)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:vitrified_bleed_check", "eoc_int:vitrified_bleed_check")
ccb.runtime.handler("eoc_rec:EOC_hair_growth_tracking", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_hair_growth_tracking"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_hair_growth_tracking", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_hair_growth_tracking", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1728000)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_hair_growth_tracking", "eoc_int:EOC_hair_growth_tracking")
ccb.runtime.handler("eoc_rec:EOC_beard_growth_tracking", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_beard_growth_tracking"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_beard_growth_tracking", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_beard_growth_tracking", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1209600)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_beard_growth_tracking", "eoc_int:EOC_beard_growth_tracking")
ccb.runtime.handler("eoc_rec:EOC_godco_hate_u_mutant", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_godco_hate_u_mutant"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_godco_godco_notalk_to_u", ""))))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_godco_hate_u_mutant", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_godco_hate_u_mutant", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(20), math.floor(40); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_godco_hate_u_mutant", "eoc_int:EOC_godco_hate_u_mutant")
ccb.runtime.handler("eoc_rec:godco_place_trader", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:godco_place_trader"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.global_var_num("godco_met_merchants") == 1)) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("godco_place_trader", ctx)
end)
ccb.runtime.handler("eoc_int:godco_place_trader", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(100)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:godco_place_trader", "eoc_int:godco_place_trader")
ccb.runtime.handler("eoc_rec:godco_change_trader", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:godco_change_trader"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.global_var_num("freemerch_godco_trader_investigated") == 2)) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("godco_change_trader", ctx)
end)
ccb.runtime.handler("eoc_int:godco_change_trader", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(100)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:godco_change_trader", "eoc_int:godco_change_trader")
ccb.runtime.handler("eoc_rec:hallucinate_effect", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:hallucinate_effect"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("hallucinate_effect", ctx)
end)
ccb.runtime.handler("eoc_int:hallucinate_effect", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(7200), math.floor(21600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:hallucinate_effect", "eoc_int:hallucinate_effect")
ccb.runtime.handler("eoc_rec:EOC_BARRY_CHECK_IF_HOME", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_BARRY_CHECK_IF_HOME"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.global_var_num("barry_travelling_home") == 2)) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_BARRY_CHECK_IF_HOME", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_BARRY_CHECK_IF_HOME", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(100)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_BARRY_CHECK_IF_HOME", "eoc_int:EOC_BARRY_CHECK_IF_HOME")
ccb.runtime.handler("eoc_rec:isherwood_mission_large_damage_retreat", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:isherwood_mission_large_damage_retreat"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((H.global_var_num("isherwood_barry_rescued") == 1)) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("isherwood_mission_large_damage_retreat", ctx)
end)
ccb.runtime.handler("eoc_int:isherwood_mission_large_damage_retreat", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:isherwood_mission_large_damage_retreat", "eoc_int:isherwood_mission_large_damage_retreat")
ccb.runtime.handler("eoc_rec:EOC_scenario_eldritch_ire", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_scenario_eldritch_ire"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("EOC_scenario_eldritch_ire", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_scenario_eldritch_ire", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(21600), math.floor(43200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_scenario_eldritch_ire", "eoc_int:EOC_scenario_eldritch_ire")
ccb.runtime.handler("eoc_rec:scenario_trapped_in_labyrinth_recurring", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:scenario_trapped_in_labyrinth_recurring"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    H.run_eoc("scenario_trapped_in_labyrinth_recurring", ctx)
end)
ccb.runtime.handler("eoc_int:scenario_trapped_in_labyrinth_recurring", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(43200)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:scenario_trapped_in_labyrinth_recurring", "eoc_int:scenario_trapped_in_labyrinth_recurring")
ccb.runtime.handler("eoc_rec:PAINREC1_EOC", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:PAINREC1_EOC"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "PAINREC1") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("PAINREC1_EOC", ctx)
end)
ccb.runtime.handler("eoc_int:PAINREC1_EOC", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:PAINREC1_EOC", "eoc_int:PAINREC1_EOC")
ccb.runtime.handler("eoc_rec:PAINREC2_EOC", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:PAINREC2_EOC"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "PAINREC2") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("PAINREC2_EOC", ctx)
end)
ccb.runtime.handler("eoc_int:PAINREC2_EOC", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:PAINREC2_EOC", "eoc_int:PAINREC2_EOC")
ccb.runtime.handler("eoc_rec:PAINREC3_EOC", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:PAINREC3_EOC"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "PAINREC3") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("PAINREC3_EOC", ctx)
end)
ccb.runtime.handler("eoc_int:PAINREC3_EOC", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:PAINREC3_EOC", "eoc_int:PAINREC3_EOC")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:EOC_RandEnc_remove", function(_)
    local dk = "eoc_deact:EOC_RandEnc_remove"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_remove", ctx)
    local t = math.max(1, math.floor(200))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_remove", {})
end)
ccb.runtime.handler("eoc_glob:ambient_subway", function(_)
    local dk = "eoc_deact:ambient_subway"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("ambient_subway", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:ambient_subway", {})
end)
ccb.runtime.handler("eoc_glob:ambient_lab_subway", function(_)
    local dk = "eoc_deact:ambient_lab_subway"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("ambient_lab_subway", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:ambient_lab_subway", {})
end)
ccb.runtime.handler("eoc_glob:ambient_sewer", function(_)
    local dk = "eoc_deact:ambient_sewer"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("ambient_sewer", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(3600), math.floor(7200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:ambient_sewer", {})
end)
ccb.runtime.handler("eoc_glob:robofac_surveillance", function(_)
    local dk = "eoc_deact:robofac_surveillance"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("robofac_surveillance", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(86400), math.floor(604800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:robofac_surveillance", {})
end)
ccb.runtime.handler("eoc_glob:sunrise_morale_buff", function(_)
    local dk = "eoc_deact:sunrise_morale_buff"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("sunrise_morale_buff", ctx)
    local t = math.max(1, math.floor((H.time_until_named("sunrise", false) / 1)))
    ccb.tasks.after(t, "eoc_glob:sunrise_morale_buff", {})
end)
ccb.runtime.handler("eoc_glob:sunset_morale_buff", function(_)
    local dk = "eoc_deact:sunset_morale_buff"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("sunset_morale_buff", ctx)
    local t = math.max(1, math.floor((H.time_until_named("sunset", false) / 1)))
    ccb.tasks.after(t, "eoc_glob:sunset_morale_buff", {})
end)
ccb.runtime.handler("eoc_glob:MAKAYLA_MUTATOR_portal_storm", function(_)
    local dk = "eoc_deact:MAKAYLA_MUTATOR_portal_storm"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("MAKAYLA_MUTATOR_portal_storm", ctx)
    local t = math.max(1, math.floor(900))
    ccb.tasks.after(t, "eoc_glob:MAKAYLA_MUTATOR_portal_storm", {})
end)
ccb.runtime.handler("eoc_glob:EOC_SCARLET_STORM", function(_)
    local dk = "eoc_deact:EOC_SCARLET_STORM"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("scarlet_storm_died") == 1)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_SCARLET_STORM", ctx)
    local t = math.max(1, math.floor(28800))
    ccb.tasks.after(t, "eoc_glob:EOC_SCARLET_STORM", {})
end)
ccb.runtime.handler("eoc_glob:scarlet_gust_1", function(_)
    local dk = "eoc_deact:scarlet_gust_1"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("scarlet_gust_1", ctx)
    local t = math.max(1, math.floor(6))
    ccb.tasks.after(t, "eoc_glob:scarlet_gust_1", {})
end)
ccb.runtime.handler("eoc_glob:scarlet_gust_2", function(_)
    local dk = "eoc_deact:scarlet_gust_2"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("scarlet_gust_2", ctx)
    local t = math.max(1, math.floor(12))
    ccb.tasks.after(t, "eoc_glob:scarlet_gust_2", {})
end)
ccb.runtime.handler("eoc_glob:scarlet_gust_3", function(_)
    local dk = "eoc_deact:scarlet_gust_3"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("scarlet_gust_3", ctx)
    local t = math.max(1, math.floor(18))
    ccb.tasks.after(t, "eoc_glob:scarlet_gust_3", {})
end)
ccb.runtime.handler("eoc_glob:scarlet_thunder", function(_)
    local dk = "eoc_deact:scarlet_thunder"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("scarlet_thunder", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:scarlet_thunder", {})
end)
ccb.runtime.handler("eoc_glob:scarlet_lightning", function(_)
    local dk = "eoc_deact:scarlet_lightning"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("scarlet_lightning", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:scarlet_lightning", {})
end)
ccb.runtime.handler("eoc_glob:EOC_SCARLET_STORM_WARNING", function(_)
    local dk = "eoc_deact:EOC_SCARLET_STORM_WARNING"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if (((H.global_var_num("scarlet_storm_died") == 1) or (H.global_var_num("player_saw_scarlet_storm") == 1))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_SCARLET_STORM_WARNING", ctx)
    local t = math.max(1, math.floor(60))
    ccb.tasks.after(t, "eoc_glob:EOC_SCARLET_STORM_WARNING", {})
end)
ccb.runtime.handler("eoc_glob:EOC_DAILY_BALTHAZAR_POWER", function(_)
    local dk = "eoc_deact:EOC_DAILY_BALTHAZAR_POWER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_DAILY_BALTHAZAR_POWER", ctx)
    local t = math.max(1, math.floor(86400))
    ccb.tasks.after(t, "eoc_glob:EOC_DAILY_BALTHAZAR_POWER", {})
end)
ccb.runtime.handler("eoc_glob:EOC_BANDIT_ASSASSIN", function(_)
    local dk = "eoc_deact:EOC_BANDIT_ASSASSIN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_BANDIT_ASSASSIN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_BANDIT_ASSASSIN", {})
end)
ccb.runtime.handler("eoc_glob:EOC_BANDIT_ASSASSIN_2", function(_)
    local dk = "eoc_deact:EOC_BANDIT_ASSASSIN_2"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_BANDIT_ASSASSIN_2", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_BANDIT_ASSASSIN_2", {})
end)
ccb.runtime.handler("eoc_glob:EOC_BANDIT_ASSASSIN_3", function(_)
    local dk = "eoc_deact:EOC_BANDIT_ASSASSIN_3"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_BANDIT_ASSASSIN_3", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_BANDIT_ASSASSIN_3", {})
end)
ccb.runtime.handler("eoc_glob:EOC_OLD_GUARD_ASSASSIN", function(_)
    local dk = "eoc_deact:EOC_OLD_GUARD_ASSASSIN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_OLD_GUARD_ASSASSIN", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(5184000), math.floor(8640000); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_OLD_GUARD_ASSASSIN", {})
end)
ccb.runtime.handler("eoc_glob:EOC_REFUGEE_CENTER_NPC_MOVEMENT", function(_)
    local dk = "eoc_deact:EOC_REFUGEE_CENTER_NPC_MOVEMENT"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((services.gameplay.environment.dimension() == "default")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_REFUGEE_CENTER_NPC_MOVEMENT", ctx)
    local t = math.max(1, math.floor(3600))
    ccb.tasks.after(t, "eoc_glob:EOC_REFUGEE_CENTER_NPC_MOVEMENT", {})
end)
ccb.runtime.handler("eoc_glob:theresa_remove", function(_)
    local dk = "eoc_deact:theresa_remove"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_completed_theresa_gone", ""))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("theresa_remove", ctx)
    local t = math.max(1, math.floor(100))
    ccb.tasks.after(t, "eoc_glob:theresa_remove", {})
end)
ccb.runtime.handler("eoc_glob:EOC_EXODII_FM_UPDATES_RECURRANCE", function(_)
    local dk = "eoc_deact:EOC_EXODII_FM_UPDATES_RECURRANCE"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if (((H.global_var_num("exodii_FM_negotiation_failed") == 1) or ((H.global_var_num("FM_exodii_caravan_placed") == 1) and (H.global_var_num("FM_exodii_butte_building_placed") == 1) and (H.global_var_num("FM_exodii_autodoc_placed") == 1)))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_EXODII_FM_UPDATES_RECURRANCE", ctx)
    local t = math.max(1, math.floor(86400))
    ccb.tasks.after(t, "eoc_glob:EOC_EXODII_FM_UPDATES_RECURRANCE", {})
end)
ccb.runtime.handler("eoc_glob:thunder", function(_)
    local dk = "eoc_deact:thunder"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "lightning"))))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("thunder", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:thunder", {})
end)
ccb.runtime.handler("eoc_glob:lightning", function(_)
    local dk = "eoc_deact:lightning"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "lightning")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("lightning", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:lightning", {})
end)
ccb.runtime.handler("eoc_glob:snow", function(_)
    local dk = "eoc_deact:snow"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "snowing")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("snow", ctx)
    local t = math.max(1, math.floor(6))
    ccb.tasks.after(t, "eoc_glob:snow", {})
end)
ccb.runtime.handler("eoc_glob:snowstorm", function(_)
    local dk = "eoc_deact:snowstorm"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((not (((services.weather.current().weather and services.weather.current().weather.value) == "snowstorm")))) then services.variables.set_global(dk, 1); return end
    H.run_eoc("snowstorm", ctx)
    local t = math.max(1, math.floor(6))
    ccb.tasks.after(t, "eoc_glob:snowstorm", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_Roadstop_camper_add", function(_)
    local dk = "eoc_deact:EOC_RandEnc_Roadstop_camper_add"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_Roadstop_camper_add", ctx)
    local t = math.max(1, math.floor(1800))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_Roadstop_camper_add", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_Roadstop_add", function(_)
    local dk = "eoc_deact:EOC_RandEnc_Roadstop_add"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_Roadstop_add", ctx)
    local t = math.max(1, math.floor(1800))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_Roadstop_add", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_Roadstop_refugee_add", function(_)
    local dk = "eoc_deact:EOC_RandEnc_Roadstop_refugee_add"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_Roadstop_refugee_add", ctx)
    local t = math.max(1, math.floor(1800))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_Roadstop_refugee_add", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_RC_Shoppers_add", function(_)
    local dk = "eoc_deact:EOC_RandEnc_RC_Shoppers_add"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_RC_Shoppers_add", ctx)
    local t = math.max(1, math.floor(3000))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_RC_Shoppers_add", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_RC_Shoppers_remove", function(_)
    local dk = "eoc_deact:EOC_RandEnc_RC_Shoppers_remove"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_RC_Shoppers_remove", ctx)
    local t = math.max(1, math.floor(200))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_RC_Shoppers_remove", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_RC_JohnBailey_add", function(_)
    local dk = "eoc_deact:EOC_RandEnc_RC_JohnBailey_add"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_RC_JohnBailey_add", ctx)
    local t = math.max(1, math.floor(3200))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_RC_JohnBailey_add", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RandEnc_RC_JohnBailey_remove", function(_)
    local dk = "eoc_deact:EOC_RandEnc_RC_JohnBailey_remove"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RandEnc_RC_JohnBailey_remove", ctx)
    local t = math.max(1, math.floor(200))
    ccb.tasks.after(t, "eoc_glob:EOC_RandEnc_RC_JohnBailey_remove", {})
end)
ccb.runtime.handler("eoc_glob:EOC_ROBOFAC_HQ_UPDATE_RECURRENCE", function(_)
    local dk = "eoc_deact:EOC_ROBOFAC_HQ_UPDATE_RECURRENCE"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_ROBOFAC_HQ_UPDATE_RECURRENCE", ctx)
    local t = math.max(1, math.floor(43200))
    ccb.tasks.after(t, "eoc_glob:EOC_ROBOFAC_HQ_UPDATE_RECURRENCE", {})
end)
ccb.runtime.handler("eoc_glob:EOC_reroll_bar_mercs", function(_)
    local dk = "eoc_deact:EOC_reroll_bar_mercs"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_reroll_bar_mercs", ctx)
    local t = math.max(1, math.floor(43200))
    ccb.tasks.after(t, "eoc_glob:EOC_reroll_bar_mercs", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_ACTIVATE_SHADOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_ACTIVATE_SHADOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("Lieutenants_active") >= 1)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_LIEUTENANT_ACTIVATE_SHADOW", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_ACTIVATE_SHADOW", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_SPAWN_SHADOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_LIEUTENANT_SPAWN_SHADOW", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(900), math.floor(32400); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", {})
end)
ccb.runtime.handler("eoc_glob:EOC_LIEUTENANT_SHADOW_CHECK_POS", function(_)
    local dk = "eoc_deact:EOC_LIEUTENANT_SHADOW_CHECK_POS"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_LIEUTENANT_SHADOW_CHECK_POS", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_LIEUTENANT_SHADOW_CHECK_POS", {})
end)
ccb.runtime.handler("eoc_glob:EOC_RECLAIMER_WITHDRAWS_FOR_NOW", function(_)
    local dk = "eoc_deact:EOC_RECLAIMER_WITHDRAWS_FOR_NOW"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_RECLAIMER_WITHDRAWS_FOR_NOW", ctx)
    local t = math.max(1, math.floor(1))
    ccb.tasks.after(t, "eoc_glob:EOC_RECLAIMER_WITHDRAWS_FOR_NOW", {})
end)
ccb.runtime.handler("eoc_glob:EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT", function(_)
    local dk = "eoc_deact:EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("reclaimer_can_appear") == 0)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT", ctx)
    local t = math.max(1, math.floor((function() local a, b = math.floor(50), math.floor(70); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)()))
    ccb.tasks.after(t, "eoc_glob:EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT", {})
end)
ccb.runtime.handler("eoc_glob:EOC_SINGULARITY_RECLAIMER_RESET_SPAWN", function(_)
    local dk = "eoc_deact:EOC_SINGULARITY_RECLAIMER_RESET_SPAWN"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    if ((H.global_var_num("reclaimer_can_appear") == 0)) then services.variables.set_global(dk, 1); return end
    H.run_eoc("EOC_SINGULARITY_RECLAIMER_RESET_SPAWN", ctx)
    local t = math.max(1, math.floor(604800))
    ccb.tasks.after(t, "eoc_glob:EOC_SINGULARITY_RECLAIMER_RESET_SPAWN", {})
end)
ccb.runtime.handler("eoc_glob:EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE", function(_)
    local dk = "eoc_deact:EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE", ctx)
    local t = math.max(1, math.floor(172800))
    ccb.tasks.after(t, "eoc_glob:EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_remove") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_remove", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_remove", {})
    end
    if not ccb.state.world.get("eoc_glob_started:ambient_subway") then
        ccb.state.world.set("eoc_glob_started:ambient_subway", true)
        ccb.tasks.after(1, "eoc_glob:ambient_subway", {})
    end
    if not ccb.state.world.get("eoc_glob_started:ambient_lab_subway") then
        ccb.state.world.set("eoc_glob_started:ambient_lab_subway", true)
        ccb.tasks.after(1, "eoc_glob:ambient_lab_subway", {})
    end
    if not ccb.state.world.get("eoc_glob_started:ambient_sewer") then
        ccb.state.world.set("eoc_glob_started:ambient_sewer", true)
        ccb.tasks.after(1, "eoc_glob:ambient_sewer", {})
    end
    if not ccb.state.world.get("eoc_glob_started:robofac_surveillance") then
        ccb.state.world.set("eoc_glob_started:robofac_surveillance", true)
        ccb.tasks.after(1, "eoc_glob:robofac_surveillance", {})
    end
    if not ccb.state.world.get("eoc_glob_started:sunrise_morale_buff") then
        ccb.state.world.set("eoc_glob_started:sunrise_morale_buff", true)
        ccb.tasks.after(1, "eoc_glob:sunrise_morale_buff", {})
    end
    if not ccb.state.world.get("eoc_glob_started:sunset_morale_buff") then
        ccb.state.world.set("eoc_glob_started:sunset_morale_buff", true)
        ccb.tasks.after(1, "eoc_glob:sunset_morale_buff", {})
    end
    if not ccb.state.world.get("eoc_glob_started:MAKAYLA_MUTATOR_portal_storm") then
        ccb.state.world.set("eoc_glob_started:MAKAYLA_MUTATOR_portal_storm", true)
        ccb.tasks.after(1, "eoc_glob:MAKAYLA_MUTATOR_portal_storm", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_SCARLET_STORM") then
        ccb.state.world.set("eoc_glob_started:EOC_SCARLET_STORM", true)
        ccb.tasks.after(1, "eoc_glob:EOC_SCARLET_STORM", {})
    end
    if not ccb.state.world.get("eoc_glob_started:scarlet_gust_1") then
        ccb.state.world.set("eoc_glob_started:scarlet_gust_1", true)
        ccb.tasks.after(1, "eoc_glob:scarlet_gust_1", {})
    end
    if not ccb.state.world.get("eoc_glob_started:scarlet_gust_2") then
        ccb.state.world.set("eoc_glob_started:scarlet_gust_2", true)
        ccb.tasks.after(1, "eoc_glob:scarlet_gust_2", {})
    end
    if not ccb.state.world.get("eoc_glob_started:scarlet_gust_3") then
        ccb.state.world.set("eoc_glob_started:scarlet_gust_3", true)
        ccb.tasks.after(1, "eoc_glob:scarlet_gust_3", {})
    end
    if not ccb.state.world.get("eoc_glob_started:scarlet_thunder") then
        ccb.state.world.set("eoc_glob_started:scarlet_thunder", true)
        ccb.tasks.after(1, "eoc_glob:scarlet_thunder", {})
    end
    if not ccb.state.world.get("eoc_glob_started:scarlet_lightning") then
        ccb.state.world.set("eoc_glob_started:scarlet_lightning", true)
        ccb.tasks.after(1, "eoc_glob:scarlet_lightning", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_SCARLET_STORM_WARNING") then
        ccb.state.world.set("eoc_glob_started:EOC_SCARLET_STORM_WARNING", true)
        ccb.tasks.after(1, "eoc_glob:EOC_SCARLET_STORM_WARNING", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_DAILY_BALTHAZAR_POWER") then
        ccb.state.world.set("eoc_glob_started:EOC_DAILY_BALTHAZAR_POWER", true)
        ccb.tasks.after(1, "eoc_glob:EOC_DAILY_BALTHAZAR_POWER", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_BANDIT_ASSASSIN") then
        ccb.state.world.set("eoc_glob_started:EOC_BANDIT_ASSASSIN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_BANDIT_ASSASSIN", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_BANDIT_ASSASSIN_2") then
        ccb.state.world.set("eoc_glob_started:EOC_BANDIT_ASSASSIN_2", true)
        ccb.tasks.after(1, "eoc_glob:EOC_BANDIT_ASSASSIN_2", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_BANDIT_ASSASSIN_3") then
        ccb.state.world.set("eoc_glob_started:EOC_BANDIT_ASSASSIN_3", true)
        ccb.tasks.after(1, "eoc_glob:EOC_BANDIT_ASSASSIN_3", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_OLD_GUARD_ASSASSIN") then
        ccb.state.world.set("eoc_glob_started:EOC_OLD_GUARD_ASSASSIN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_OLD_GUARD_ASSASSIN", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_REFUGEE_CENTER_NPC_MOVEMENT") then
        ccb.state.world.set("eoc_glob_started:EOC_REFUGEE_CENTER_NPC_MOVEMENT", true)
        ccb.tasks.after(1, "eoc_glob:EOC_REFUGEE_CENTER_NPC_MOVEMENT", {})
    end
    if not ccb.state.world.get("eoc_glob_started:theresa_remove") then
        ccb.state.world.set("eoc_glob_started:theresa_remove", true)
        ccb.tasks.after(1, "eoc_glob:theresa_remove", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_EXODII_FM_UPDATES_RECURRANCE") then
        ccb.state.world.set("eoc_glob_started:EOC_EXODII_FM_UPDATES_RECURRANCE", true)
        ccb.tasks.after(1, "eoc_glob:EOC_EXODII_FM_UPDATES_RECURRANCE", {})
    end
    if not ccb.state.world.get("eoc_glob_started:thunder") then
        ccb.state.world.set("eoc_glob_started:thunder", true)
        ccb.tasks.after(1, "eoc_glob:thunder", {})
    end
    if not ccb.state.world.get("eoc_glob_started:lightning") then
        ccb.state.world.set("eoc_glob_started:lightning", true)
        ccb.tasks.after(1, "eoc_glob:lightning", {})
    end
    if not ccb.state.world.get("eoc_glob_started:snow") then
        ccb.state.world.set("eoc_glob_started:snow", true)
        ccb.tasks.after(1, "eoc_glob:snow", {})
    end
    if not ccb.state.world.get("eoc_glob_started:snowstorm") then
        ccb.state.world.set("eoc_glob_started:snowstorm", true)
        ccb.tasks.after(1, "eoc_glob:snowstorm", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_Roadstop_camper_add") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_Roadstop_camper_add", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_Roadstop_camper_add", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_Roadstop_add") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_Roadstop_add", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_Roadstop_add", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_Roadstop_refugee_add") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_Roadstop_refugee_add", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_Roadstop_refugee_add", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_RC_Shoppers_add") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_RC_Shoppers_add", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_RC_Shoppers_add", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_RC_Shoppers_remove") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_RC_Shoppers_remove", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_RC_Shoppers_remove", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_RC_JohnBailey_add") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_RC_JohnBailey_add", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_RC_JohnBailey_add", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RandEnc_RC_JohnBailey_remove") then
        ccb.state.world.set("eoc_glob_started:EOC_RandEnc_RC_JohnBailey_remove", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RandEnc_RC_JohnBailey_remove", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_ROBOFAC_HQ_UPDATE_RECURRENCE") then
        ccb.state.world.set("eoc_glob_started:EOC_ROBOFAC_HQ_UPDATE_RECURRENCE", true)
        ccb.tasks.after(1, "eoc_glob:EOC_ROBOFAC_HQ_UPDATE_RECURRENCE", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_reroll_bar_mercs") then
        ccb.state.world.set("eoc_glob_started:EOC_reroll_bar_mercs", true)
        ccb.tasks.after(1, "eoc_glob:EOC_reroll_bar_mercs", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_ACTIVATE_SHADOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_ACTIVATE_SHADOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_ACTIVATE_SHADOW", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_SPAWN_SHADOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_SPAWN_SHADOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_SPAWN_SHADOW", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_SHADOW_WITHDRAWS_FOR_NOW", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_LIEUTENANT_SHADOW_CHECK_POS") then
        ccb.state.world.set("eoc_glob_started:EOC_LIEUTENANT_SHADOW_CHECK_POS", true)
        ccb.tasks.after(1, "eoc_glob:EOC_LIEUTENANT_SHADOW_CHECK_POS", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_RECLAIMER_WITHDRAWS_FOR_NOW") then
        ccb.state.world.set("eoc_glob_started:EOC_RECLAIMER_WITHDRAWS_FOR_NOW", true)
        ccb.tasks.after(1, "eoc_glob:EOC_RECLAIMER_WITHDRAWS_FOR_NOW", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT") then
        ccb.state.world.set("eoc_glob_started:EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT", true)
        ccb.tasks.after(1, "eoc_glob:EOC_SINGULARITY_RECLAIMER_LOWER_KILL_AMOUNT", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_SINGULARITY_RECLAIMER_RESET_SPAWN") then
        ccb.state.world.set("eoc_glob_started:EOC_SINGULARITY_RECLAIMER_RESET_SPAWN", true)
        ccb.tasks.after(1, "eoc_glob:EOC_SINGULARITY_RECLAIMER_RESET_SPAWN", {})
    end
    if not ccb.state.world.get("eoc_glob_started:EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE") then
        ccb.state.world.set("eoc_glob_started:EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE", true)
        ccb.tasks.after(1, "eoc_glob:EOC_ROBOFAC_SCIENTIST_GARAGE_ADVANCE_EXODII_CBM_KNOWLEDGE", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
