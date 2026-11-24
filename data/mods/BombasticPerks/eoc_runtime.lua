local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

require("eoc_handlers_01")(E, H)
require("eoc_handlers_02")(E, H)

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
ccb.runtime.handler("eoc_ev:avatar_moves", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_duck_and_weave", ctx)
    H.run_eoc("EOC_perk_duck_and_weave_reset", ctx)
    H.run_eoc("EOC_PERK_PERCUSSIVE_ENTRY_LOSE_BONUS_WHEN_MOVING", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_consumes_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_SOUP_FOR_SOUL_EFFECTS", ctx)
end)
ccb.runtime.on("game:character_consumes_item", "eoc_ev:character_consumes_item")
ccb.runtime.handler("eoc_ev:character_eats_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_blood_drinking_heal", ctx)
end)
ccb.runtime.on("game:character_eats_item", "eoc_ev:character_eats_item")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL", ctx)
    H.run_eoc("EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND", ctx)
    H.run_eoc("EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND_BUT_HAS_DREAM_ARMOR", ctx)
    H.run_eoc("EOC_PERK_QUICK_RECOVERY_INIT", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_kills_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_on_kill_check_exp", ctx)
    H.run_eoc("EOC_empath", ctx)
    H.run_eoc("EOC_praise", ctx)
end)
ccb.runtime.on("game:character_kills_monster", "eoc_ev:character_kills_monster")
ccb.runtime.handler("eoc_ev:character_melee_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_bellringer_application_character", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_character", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_character", "eoc_ev:character_melee_attacks_character")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_bellringer_application_monster", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_monster", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_character", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("event_perk_dice_addition_damage_ranged_attacks_character", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_character_ranged", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_character", "eoc_ev:character_ranged_attacks_character")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("event_perk_dice_addition_damage_ranged_attacks_monster", ctx)
    H.run_eoc("EOC_perk_rage_against_the_unnatural_checker_monster_ranged", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_monster", "eoc_ev:character_ranged_attacks_monster")
ccb.runtime.handler("eoc_ev:character_smashes_tile", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_PERCUSSIVE_ENTRY_SMASHING", ctx)
end)
ccb.runtime.on("game:character_smashes_tile", "eoc_ev:character_smashes_tile")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_boomstick_blast_character", ctx)
    H.run_eoc("EOC_PERK_SITUATIONAL_UNCANNY_DODGE_TAKE_DAMAGE", ctx)
    H.run_eoc("EOC_PERK_FIRSTEST_AID", ctx)
    H.run_eoc("EOC_PERK_TWICE_SHY_TAKE_DAMAGE", ctx)
    H.run_eoc("EOC_PERK_UNDYING_LOYALTY", ctx)
    H.run_eoc("EOC_PERK_VENGEFUL_TAKE_DAMAGE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wakes_up", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_NETHER_ATTENTION_NIGHTMARES", ctx)
end)
ccb.runtime.on("game:character_wakes_up", "eoc_ev:character_wakes_up")
ccb.runtime.handler("eoc_ev:gains_mutation", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_PERK_LEARN_EWWWW_DE_ZOMBIE_GAIN_RECIPE", ctx)
end)
ccb.runtime.on("game:gains_mutation", "eoc_ev:gains_mutation")
ccb.runtime.handler("eoc_ev:game_avatar_new", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_bombastic_perks_avatar_new", ctx)
end)
ccb.runtime.on("game:game_avatar_new", "eoc_ev:game_avatar_new")
ccb.runtime.handler("eoc_ev:game_begin", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_bombastic_perks_initialize", ctx)
end)
ccb.runtime.on("game:game_begin", "eoc_ev:game_begin")
ccb.runtime.handler("eoc_ev:game_load", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_EXISTING_CHARACTER_UPDATE_BOMBASTIC_PERKS", ctx)
end)
ccb.runtime.on("game:game_load", "eoc_ev:game_load")
ccb.runtime.handler("eoc_ev:monster_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_perk_boomstick_blast_monster", ctx)
    H.run_eoc("EOC_EWWWW_DE_ZOMBIE_ATTACK_ZOMBIE_SUPPRESSOR", ctx)
    H.run_eoc("EOC_HIVE_QUEEN_ATTACK_INSECT_SUPPRESSOR", ctx)
end)
ccb.runtime.on("game:monster_takes_damage", "eoc_ev:monster_takes_damage")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_PERK_SECOND_CHANCE_PREVENTION", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:EOC_PERK_MOONSTRUCK", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_MOONSTRUCK"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_moonstruck") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_MOONSTRUCK", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_MOONSTRUCK", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(3600), math.floor(3600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_MOONSTRUCK", "eoc_int:EOC_PERK_MOONSTRUCK")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_bird") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_BIRD_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_feline") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_FELINE_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_insect") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_INSECT_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_lupine") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_LUPINE_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_plant") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_PLANT_MUTATOR")
ccb.runtime.handler("eoc_rec:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "perk_portal_storm_mutator_spider") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor((function() local a, b = math.floor(300), math.floor(1800); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR", "eoc_int:EOC_PERK_PORTAL_STORM_SPIDER_MUTATOR")

return E
