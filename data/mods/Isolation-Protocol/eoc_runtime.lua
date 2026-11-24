local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

H._jm_iso_balthazar_aid = function(ctx, _a0)
    return math.min(40, (H.global_var_num("iso_balthazar_aid_value") + _a0))
end

require("eoc_handlers_01")(E, H)

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
    H.run_eoc("EOC_ISO_GEAS", ctx)
end)
ccb.runtime.on("game:avatar_moves", "eoc_ev:avatar_moves")
ccb.runtime.handler("eoc_ev:character_gains_effect", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ISO_HYPO_O", ctx)
end)
ccb.runtime.on("game:character_gains_effect", "eoc_ev:character_gains_effect")
ccb.runtime.handler("eoc_ev:character_kills_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_on_kill_balthazar_aid", ctx)
    H.run_eoc("EOC_ISO_BIO_VAMPIRE_RESTORE", ctx)
end)
ccb.runtime.on("game:character_kills_monster", "eoc_ev:character_kills_monster")
ccb.runtime.handler("eoc_ev:character_melee_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ISO_BIO_VAMPIRE_RESTORE_IN_MELEE", ctx)
end)
ccb.runtime.on("game:character_melee_attacks_monster", "eoc_ev:character_melee_attacks_monster")
ccb.runtime.handler("eoc_ev:character_ranged_attacks_monster", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ISO_BIO_VAMPIRE_RESTORE_AT_RANGE", ctx)
end)
ccb.runtime.on("game:character_ranged_attacks_monster", "eoc_ev:character_ranged_attacks_monster")
ccb.runtime.handler("eoc_ev:character_takes_damage", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("ISO_PAIN_CEILING", ctx)
    H.run_eoc("EOC_ISO_HYPO_DAM", ctx)
    H.run_eoc("EOC_ISO_ELDRITCH_DAMAGE_SHIELD_COUNTER", ctx)
    H.run_eoc("EOC_ISO_ELDRITCH_MASS_AOE_ZOMBIE_DESTRUCTION_TAKE_DAMAGE", ctx)
end)
ccb.runtime.on("game:character_takes_damage", "eoc_ev:character_takes_damage")
ccb.runtime.handler("eoc_ev:character_wields_item", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ISO_LAST_SCION_SPELL_GAINING_WHEN_PICK_UP_GUN", ctx)
end)
ccb.runtime.on("game:character_wields_item", "eoc_ev:character_wields_item")
ccb.runtime.handler("eoc_ev:opens_spellbook", function(payload)
    local u, npc, vars = H.resolve_event_actors(payload)
    local ctx = H.ctx_new(u, npc, vars, { event = payload })
    H.run_eoc("EOC_ISO_GRABBED_ARMS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_ISO_GRABBED_HANDS_MAKES_SOMATIC_SPELLS_HARDER", ctx)
    H.run_eoc("EOC_ISO_NOT_WIELDING_STAFF_MAKES_SORCERY_HARDER", ctx)
end)
ccb.runtime.on("game:opens_spellbook", "eoc_ev:opens_spellbook")

-- PREVENT_DEATH hooks
ccb.runtime.handler("eoc_hook:avatar_fatal", function(payload)
    local prevented = false
    local u = payload and payload.character or services.characters.avatar()
    local ctx = H.ctx_new(u, nil, {}, { prevent_death_fn = function() prevented = true end })
    H.run_eoc("EOC_balthazar_prevent_death", ctx)
    if prevented then return false end
    return true
end)
ccb.runtime.hook("on_avatar_fatal", "eoc_hook:avatar_fatal")

-- Per-character RECURRING triggers
ccb.runtime.handler("eoc_rec:EOC_ISO_RECORD_MANA_FOR_LAST_SCION", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ISO_RECORD_MANA_FOR_LAST_SCION"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ISO_RECORD_MANA_FOR_LAST_SCION", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ISO_RECORD_MANA_FOR_LAST_SCION", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(1)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ISO_RECORD_MANA_FOR_LAST_SCION", "eoc_int:EOC_ISO_RECORD_MANA_FOR_LAST_SCION")
ccb.runtime.handler("eoc_rec:EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "iso_eldritch_sorcery") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING", ctx)
end)
ccb.runtime.handler("eoc_int:EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(60)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING", "eoc_int:EOC_ISO_LAST_SCION_STORE_SPELL_LEVELS_RECURRING")
ccb.runtime.handler("eoc_rec:iso_robolove", function(payload)
    local ch = payload and payload.character; if not ch then return end
    if not H.is_avatar(ch) then return end
    local dk = "eoc_deact:iso_robolove"
    local dr = services.variables.get(ch, dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(ch, nil, {})
    if ((not ((H.char_has_trait(H.u(ctx), "iso_robolove") == 1)))) then services.variables.set(ch, dk, 1); return end
    H.run_eoc("iso_robolove", ctx)
end)
ccb.runtime.handler("eoc_int:iso_robolove", function(payload)
    local ch = payload and payload.character
    local ctx = H.ctx_new(ch, nil, {})
    local t = math.floor(20)
    if t < 1 then t = 1 elseif t > 31536000 then t = 31536000 end
    return t
end)
ccb.runtime.character_recurring("eoc_rec:iso_robolove", "eoc_int:iso_robolove")

-- Global RECURRING triggers
ccb.runtime.handler("eoc_glob:ISO_REGEN_CLOCK", function(_)
    local dk = "eoc_deact:ISO_REGEN_CLOCK"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("ISO_REGEN_CLOCK", ctx)
    local t = math.max(1, math.floor(15))
    ccb.tasks.after(t, "eoc_glob:ISO_REGEN_CLOCK", {})
end)
ccb.runtime.handler("eoc_glob:ISO_DANGER_CLOCK", function(_)
    local dk = "eoc_deact:ISO_DANGER_CLOCK"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("ISO_DANGER_CLOCK", ctx)
    local t = math.max(1, math.floor(180))
    ccb.tasks.after(t, "eoc_glob:ISO_DANGER_CLOCK", {})
end)
ccb.runtime.handler("eoc_glob:ISO_DANGER_LEVEL_SPAWNER", function(_)
    local dk = "eoc_deact:ISO_DANGER_LEVEL_SPAWNER"
    local dr = services.variables.get_global(dk)
    if dr.ok and dr.value and dr.value.exists and dr.value.value == 1 then return end
    local ctx = H.ctx_new(services.characters.avatar(), nil, {})
    H.run_eoc("ISO_DANGER_LEVEL_SPAWNER", ctx)
    local t = math.max(1, math.floor(300))
    ccb.tasks.after(t, "eoc_glob:ISO_DANGER_LEVEL_SPAWNER", {})
end)
ccb.runtime.handler("eoc_glob:_init_all", function(_)
    if not ccb.state.world.get("eoc_glob_started:ISO_REGEN_CLOCK") then
        ccb.state.world.set("eoc_glob_started:ISO_REGEN_CLOCK", true)
        ccb.tasks.after(1, "eoc_glob:ISO_REGEN_CLOCK", {})
    end
    if not ccb.state.world.get("eoc_glob_started:ISO_DANGER_CLOCK") then
        ccb.state.world.set("eoc_glob_started:ISO_DANGER_CLOCK", true)
        ccb.tasks.after(1, "eoc_glob:ISO_DANGER_CLOCK", {})
    end
    if not ccb.state.world.get("eoc_glob_started:ISO_DANGER_LEVEL_SPAWNER") then
        ccb.state.world.set("eoc_glob_started:ISO_DANGER_LEVEL_SPAWNER", true)
        ccb.tasks.after(1, "eoc_glob:ISO_DANGER_LEVEL_SPAWNER", {})
    end
end)
ccb.runtime.on("world_ready", "eoc_glob:_init_all")

return E
