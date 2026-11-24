local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_mon_when_magiclysm_1a7cb897b668", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_e96b61308c20", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_FERAL_RADIATION_MAGE_MAGIC_FISSILE_IRRADIATES_YOU", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_055f7663f8f9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_d703c72ddb40", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_140d572c6655", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING")))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_9fe5f25f3a2f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "effect_feral_technomancer_bless"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_a1b4a552975d", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "effect_feral_technomancer_bless"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (H.char_val_extra(H.u(ctx), "morale") <= (-20)) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_73a01ef3ac0e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "synaptic_stim"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (H.char_has_flag(H.u(ctx), "MUTE"))) and (not (H.char_has_flag(H.u(ctx), "NO_SPELLCASTING"))))) == true
end)
ccb.runtime.handler("w16b_mon_die_magiclysm_7750a01550f3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.monster or nil, payload and payload.killer or nil, {})
    E.H.run_eoc("EOC_ROCK_TROLL_TURN_TO_STONE", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_1569edf3b3ec", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return ((H.npc(ctx) ~= nil and ((H.safe_id('species', "IRON_GOLEM") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "IRON_GOLEM")).value == true)))) == true
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_0943fa32b485", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_RUST_MONSTER_RUSTING", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_44bc423eb3b5", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and ((function() local s = H.creature_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()) and ((function() local s = H.creature_snap(H.npc(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_eb41e6451236", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and (((function() local s = H.creature_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()) and ((function() local s = H.creature_snap(H.npc(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)())) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "road", math.floor(2)) end)()))) and (H.npc(ctx) ~= nil and ((H.safe_id('species', "ZOMBIE") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ZOMBIE")).value == true))))) == true
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_4820b435a624", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((((H.char_snap(H.npc(ctx)) or {}).creature or {}).outside == true) and (((function() local s = H.creature_snap(H.u(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)()) and ((function() local s = H.creature_snap(H.npc(ctx)); local fg = H.safe_id('json_flag', "DIGGABLE"); if not s or not s.position or not fg then return false end; return services.gameplay.environment.terrain_has_flag(s.position, fg) end)())) and ((H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_EMANATION") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_EMANATION")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "NETHER_BURROWING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "NETHER_BURROWING")).value == true)))))) == true
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_f48b3c5ac470", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_THAUMIC_ZOMBIE_MANA_DRAIN", ctx)
end)
ccb.runtime.handler("w16b_mon_hit_magiclysm_4d961aaef11f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, { damage = payload and payload.total_damage or 0 })
    E.H.run_eoc("EOC_THAUMIC_ZOMBIE_MANA_DRAIN_BITE", ctx)
end)
ccb.runtime.handler("w16b_mon_when_magiclysm_90a8f9dfaf08", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (H.char_has_flag(H.u(ctx), "GRAB_FILTER"))) and (not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
end)
