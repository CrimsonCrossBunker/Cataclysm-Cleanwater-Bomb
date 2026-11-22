local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_ROBOFAC_HATES_EXODII_CYBORGS"] = function(ctx)
    if (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 87) or (H.global_var_num("ancilla_bionic_garage_placed") == 1)) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_surface_entrance"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_intercom" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "hub01_intercom_locked", 1)
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
    else
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
        do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
    end
    return true
    end
    EOC["EOC_ROBOFAC_CHOP_SHOP_CLEAN_UP_MERCS"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x0y0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x1y0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x2y0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x3y0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x4y0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x0y1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x1y1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x2y1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x3y1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofac_strip_mall_x4y1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_mercs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    COND["EOC_MUTE_BIRD_START"] = function(ctx)
        return (((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "mutant_patient_bird").value == true))) == true
    end
    EOC["EOC_MUTE_BIRD_START"] = function(ctx)
    if (((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "mutant_patient_bird").value == true))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_bird")
        return true
    end
    return false
    end
    COND["EOC_MUTE_CEPHALOPOD_START"] = function(ctx)
        return (((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "mutant_patient_cephalopod").value == true))) == true
    end
    EOC["EOC_MUTE_CEPHALOPOD_START"] = function(ctx)
    if (((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "mutant_patient_cephalopod").value == true))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_ceph")
        return true
    end
    return false
    end
    COND["EOC_MUTE_INSECT_START"] = function(ctx)
        return (((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "mutant_patient_insect").value == true))) == true
    end
    EOC["EOC_MUTE_INSECT_START"] = function(ctx)
    if (((H.u(ctx) ~= nil and services.characters.has_profession(H.u(ctx), "mutant_patient_insect").value == true))) then
        H.learn_recipe(H.u(ctx), "prac_unmute_insect")
        return true
    end
    return false
    end
    COND["EOC_scenario_eldritch_ire"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "ELDRITCH_IRE") == 1)) == true
    end
    EOC["EOC_scenario_eldritch_ire"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "ELDRITCH_IRE") == 1)) then
        H.eoc_loc_var(H.u(ctx), ctx, "context", "zombie_horde_target_scen", nil, nil, nil, nil, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("context", nil, ctx, "zombie_horde_target_scen"); if _p then services.hordes.broadcast_signal(_p, math.floor((7000 + 1000))) end end
        services.messages.add(ctx:expand_text(services.translate("The air shudders with a foreboding presence.  They know where you are.")), "neutral")
        return true
    end
    return false
    end
    COND["scenario_trapped_in_labyrinth_recurring"] = function(ctx)
        return ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "scenario_trapped_in_labyrinth", "")))) and (not ((H.char_has_trait(H.u(ctx), "NL_MUTE") == 1))) and H.char_has_bionic(H.u(ctx), "bio_nl_collar") and (not ((services.gameplay.environment.dimension() == "netherum_labyrinth"))) and (not ((services.gameplay.environment.dimension() == "netherum_labyrinth2"))) and (not ((services.gameplay.environment.dimension() == "netherum_labyrinth_safehouse"))) and (not ((services.gameplay.environment.dimension() == "scarlet"))))) == true
    end
    EOC["scenario_trapped_in_labyrinth_recurring"] = function(ctx)
    if ((((("yes") == (H.var_str("actor", H.u(ctx), ctx, "scenario_trapped_in_labyrinth", "")))) and (not ((H.char_has_trait(H.u(ctx), "NL_MUTE") == 1))) and H.char_has_bionic(H.u(ctx), "bio_nl_collar") and (not ((services.gameplay.environment.dimension() == "netherum_labyrinth"))) and (not ((services.gameplay.environment.dimension() == "netherum_labyrinth2"))) and (not ((services.gameplay.environment.dimension() == "netherum_labyrinth_safehouse"))) and (not ((services.gameplay.environment.dimension() == "scarlet"))))) then
        H.lose_bionic(H.u(ctx), "bio_nl_collar")
        H.add_bionic(H.u(ctx), "bio_nl_collar_deactivated")
        ccb.presentation.notice(ctx:expand_text(services.translate("You feel very far away from AltarOS and the labyrinthine structures it inhabits.  Freedom feels within reach.")))
        return true
    end
    return false
    end
    EOC["scenario_paralyzepoison"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "paralyzepoison", 600, nil, 3, nil)
    return true
    end
    EOC["EOC_BANISH_MONSTERS_AROUND_PLAYER"] = function(ctx)
    H.run_eoc("EOC_BANISH_SELF", ctx, nil, nil, nil)
    return true
    end
    EOC["scenario_mansion_pursuit"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "mansion_centre", { terrain = "mansion_+4d" }, { z = math.floor(-1) }, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    do local tp = H.get_tripoint_var("actor", H.u(ctx), ctx, "mansion_centre"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(11) * 1, (tp.y or 0) + math.floor(11) * 1, (tp.z or 0) + math.floor(0)); H.set_var("actor", H.u(ctx), ctx, "mansion_centre", nt) end end
    H.run_eoc("EOC_BANISH_MANSION_MONSTERS", ctx, nil, nil, nil)
    H.run_eoc("EOC_SPAWN_MANSION_MONSTERS", ctx, nil, nil, nil)
    do local tp = H.get_tripoint_var("actor", H.u(ctx), ctx, "mansion_centre"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(0)); H.set_var("actor", H.u(ctx), ctx, "mansion_centre", nt) end end
    H.run_eoc("EOC_BANISH_MANSION_MONSTERS", ctx, nil, nil, nil)
    H.run_eoc("EOC_SPAWN_MANSION_MONSTERS", ctx, nil, nil, nil)
    do local tp = H.get_tripoint_var("actor", H.u(ctx), ctx, "mansion_centre"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(1)); H.set_var("actor", H.u(ctx), ctx, "mansion_centre", nt) end end
    H.run_eoc("EOC_BANISH_MANSION_MONSTERS", ctx, nil, nil, nil)
    H.run_eoc("EOC_SPAWN_MANSION_MONSTERS", ctx, nil, nil, nil)
    do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(12), nil); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "EOC_BANISH_MONSTERS_AROUND_PLAYER" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
    H.run_eoc("EOC_SPAWN_MANSION_MONSTERS_NEAR_PLAYER", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_BANISH_SELF"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "BEGONE_SHADOW", false, nil)
    return true
    end
    EOC["EOC_BANISH_MANSION_MONSTERS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "SPELL_BANISH_MONSTERS_AROUND_MANSION_CENTER", false, { target = H.get_tripoint_var("actor", H.u(ctx), ctx, "mansion_centre") })
    H.eoc_cast_spell(H.u(ctx), "SPELL_BANISH_MANSION_CIVILIANS", false, { target = H.get_tripoint_var("actor", H.u(ctx), ctx, "mansion_centre") })
    return true
    end
    COND["EOC_BANISH_MONSTERS_AROUND_MANSION_CENTER"] = function(ctx)
        return ((services.random.native_int(0, H.round_half_away(1)) == 0)) == true
    end
    EOC["EOC_BANISH_MONSTERS_AROUND_MANSION_CENTER"] = function(ctx)
    if ((services.random.native_int(0, H.round_half_away(1)) == 0)) then
        H.run_eoc("EOC_BANISH_SELF", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_SPAWN_MANSION_MONSTERS"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_MANSION_ARMORED"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(0), max_radius = math.floor(18), indoor_only = true }); 
    end end
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_MANSION_START"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(15), min_radius = math.floor(0), max_radius = math.floor(36), indoor_only = true }); 
    end end
    return true
    end
    EOC["EOC_SPAWN_MANSION_MONSTERS_NEAR_PLAYER"] = function(ctx)
    if (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mansion_boarded_t2d_start", math.floor(1)) end)()) and (services.random.native_int(0, H.round_half_away(2)) == 0)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_zombie_resort_dancer") or H.safe_id('monster_group', "mon_zombie_resort_dancer"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((1 + services.random.native_int(0, H.round_half_away(1)))), min_radius = math.floor(3), max_radius = math.floor(5) }); 
        end end
        ccb.presentation.notice(ctx:expand_text(services.translate("What was that sound?")))
    end
    if (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mansion_boarded_t2_start", math.floor(1)) end)()) and (services.random.native_int(0, H.round_half_away(1)) == 0)) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_SCENARIO_PANICROOM"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor((1 + services.random.native_int(0, H.round_half_away(1)))), max_radius = math.floor(2) }); 
        end end
        ccb.presentation.notice(ctx:expand_text(services.translate("Is there someone else in here?")))
    end
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_MANSION_PURSUERS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(5), min_radius = math.floor(10), max_radius = math.floor(16), indoor_only = true }); 
    end end
    return true
    end
    EOC["scenario_surrounded_zombie"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_ZOMBIE"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(5), min_radius = math.floor(12), max_radius = math.floor(30) }); 
    end end
    return true
    end
    EOC["scenario_surrounded_zombie_heavy"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_ZOMBIE"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(10), min_radius = math.floor(14), max_radius = math.floor(30) }); 
    end end
    return true
    end
    EOC["EOC_scenario_blood"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "SCENARIO_BLOOD" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_scenario_fire"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "SCENARIO_FIRE" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_scenario_smoke"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "SCENARIO_SMOKE" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_LAB_MUTANT_FRIENDS"] = function(ctx)
    H.eoc_cast_spell(H.u(ctx), "SPELL_ALLY_WITH_MUTANTS", false, nil)
    return true
    end
    EOC["EOC_DELETE_STARTER_MUTAGENS"] = function(ctx)
    do local t = H.npc(ctx); if t then local cs = H.creature_snap(t); if cs and cs.kind == 'monster' then services.monsters.die(t) else services.characters.die(t) end end end
    return true
    end
    EOC["EOC_LAB_MUTANT_NO_MUTAGENS"] = function(ctx)
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", nil, 0, 50, nil, { { id = "box_small_plastic" } }, { "EOC_DELETE_STARTER_MUTAGENS" })
    return true
    end
    COND["EOC_FLEE_WEAK"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_FLEE_WEAK"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.set_char_val_extra(H.u(ctx), "morale", (H.char_val_extra(H.u(ctx), "morale") + 5), "-=")
        H.set_char_val_extra(H.u(ctx), "anger", (H.char_val_extra(H.u(ctx), "anger") + 5), "-=")
        return true
    end
    return false
    end
    COND["EOC_FLEE"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_FLEE"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.set_char_val_extra(H.u(ctx), "morale", (H.char_val_extra(H.u(ctx), "morale") + 15), "-=")
        H.set_char_val_extra(H.u(ctx), "anger", (H.char_val_extra(H.u(ctx), "anger") + 15), "-=")
        return true
    end
    return false
    end
    COND["EOC_FLEE_STRONG"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_FLEE_STRONG"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        H.set_char_val_extra(H.u(ctx), "morale", (H.char_val_extra(H.u(ctx), "morale") + 25), "-=")
        H.set_char_val_extra(H.u(ctx), "anger", (H.char_val_extra(H.u(ctx), "anger") + 25), "-=")
        return true
    end
    return false
    end
    COND["thunder"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "lightning")) and services.random.native_probability(1, (50)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["thunder"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "lightning")) and services.random.native_probability(1, (50)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("You hear a distant rumble of thunder.")), "neutral")
        services.sound.play_from_outdoors("thunder_far", "environment", math.floor(80))
        return true
    end
    return false
    end
    COND["lightning"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "lightning") and services.random.native_probability(1, (600)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["lightning"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "lightning") and services.random.native_probability(1, (600)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("A flash of lightning illuminates your surroundings!")), "neutral")
        services.sound.play_if_audible("thunder_near", "environment", math.floor(80))
        services.weather.activate_lightning()
        services.weather.override_light(math.floor(100), services.time.duration_from_turns(math.floor(1)), "")
        return true
    end
    return false
    end
    COND["snow"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "snowing") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["snow"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "snowing") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        if H.u(ctx) then services.characters.add_wet(H.u(ctx), math.floor(10)) end
        return true
    end
    return false
    end
    COND["snowstorm"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "snowstorm") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["snowstorm"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "snowstorm") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        if H.u(ctx) then services.characters.add_wet(H.u(ctx), math.floor(40)) end
        return true
    end
    return false
    end
    COND["EOC_barricaded_church_nearby"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church_parking", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church", math.floor(1)) end)())) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knows_xedra_field_station_1", "")))))))) == true
    end
    EOC["EOC_barricaded_church_nearby"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church_parking", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church", math.floor(1)) end)())) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knows_xedra_field_station_1", "")))))))) then
        H.set_var("actor", H.u(ctx), ctx, "knows_xedra_field_station_1", "yes")
        return true
    end
    return false
    end
    COND["EOC_morgantown_nearby"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_forest_fence_s", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_forest_fence_corner", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_forest_fence_entry", math.floor(1)) end)())) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knows_xedra_field_station_2", "")))))))) == true
    end
    EOC["EOC_morgantown_nearby"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_forest_fence_s", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_forest_fence_corner", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_forest_fence_entry", math.floor(1)) end)())) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knows_xedra_field_station_2", "")))))))) then
        H.set_var("actor", H.u(ctx), ctx, "knows_xedra_field_station_2", "yes")
        return true
    end
    return false
    end
    COND["EOC_fishing_shack_nearby"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_fishing_shack_0", math.floor(1)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knows_xedra_field_station_3", "")))))))) == true
    end
    EOC["EOC_fishing_shack_nearby"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_fishing_shack_0", math.floor(1)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "knows_xedra_field_station_3", "")))))))) then
        H.set_var("actor", H.u(ctx), ctx, "knows_xedra_field_station_3", "yes")
        return true
    end
    return false
    end
    EOC["EOC_RandEnc_Roadstop_camper_add"] = function(ctx)
    ctx:set_conditional("random_enc_condition", (0 == 0))
    H.run_eoc("EOC_RandEnc", ctx, { ["omt"] = "roadstop_a", ["map_update"] = "nest_RandEnc_campervan_traveler_add", ["map_removal"] = "nest_RandEnc_campervan_traveler_remove", ["chance"] = 10, ["days_till_spawn"] = 7 }, nil, nil)
    return true
    end
    EOC["going_north"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_travel_direction", "north")
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_picked_direction", "yes")
    return true
    end
    EOC["going_south"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_travel_direction", "south")
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_picked_direction", "yes")
    return true
    end
    EOC["going_east"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_travel_direction", "east")
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_picked_direction", "yes")
    return true
    end
    EOC["going_west"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_travel_direction", "west")
    H.set_var("actor", H.u(ctx), ctx, "dialogue_travel_direction_picked_direction", "yes")
    return true
    end
    COND["EOC_traveler_random_destination_direction"] = function(ctx)
        return ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_travel_direction_picked_direction", ""))))))) == true
    end
    EOC["EOC_traveler_random_destination_direction"] = function(ctx)
    if ((not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "dialogue_travel_direction_picked_direction", ""))))))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "going_north"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "going_south"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "going_east"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "going_west"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    EOC["EOC_RandEnc_Roadstop_add"] = function(ctx)
    ctx:set_conditional("random_enc_condition", ((not ((services.time_snapshot().season_id == string.lower("winter")))) and (not services.gameplay.environment.is_night())))
    H.run_eoc("EOC_RandEnc", ctx, { ["omt"] = "roadstop_a", ["map_update"] = "nest_RandEnc_roadstop_a_add", ["map_removal"] = "nest_RandEnc_roadstop_a_remove", ["chance"] = 10, ["days_till_spawn"] = 7 }, nil, nil)
    return true
    end
    EOC["EOC_RandEnc_Roadstop_refugee_add"] = function(ctx)
    ctx:set_conditional("random_enc_condition", ((not ((services.time_snapshot().season_id == string.lower("winter")))) and (not services.gameplay.environment.is_night()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) < 45)))
    H.run_eoc("EOC_RandEnc", ctx, { ["omt"] = "roadstop_a", ["map_update"] = "nest_RandEnc_roadstop_a_refugee_add", ["map_removal"] = "nest_RandEnc_roadstop_a_refugee_remove", ["chance"] = 10, ["days_till_spawn"] = 7 }, nil, nil)
    return true
    end
    COND["EOC_RandEnc_RC_Shoppers_add"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(30)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))) and (not services.gameplay.environment.is_night()) and services.random.native_probability(1, (10)) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_flag_FMShopkeep_Mission1", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_RC_Shoppers_RandEnc"), 1) >= 86400))) == true
    end
    EOC["EOC_RandEnc_RC_Shoppers_add"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(30)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))) and (not services.gameplay.environment.is_night()) and services.random.native_probability(1, (10)) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_flag_FMShopkeep_Mission1", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_RC_Shoppers_RandEnc"), 1) >= 86400))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_13"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_RandEnc_RC_Shoppers_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "timer_RC_Shoppers_RandEnc", services.turn())
        H.eoc_loc_var(H.u(ctx), ctx, "global", "randenc_shoppers_loc", { terrain = "evac_center_13" }, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "RC_Shoppers_visiting", 1)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_RC_Shoppers_remove"] = function(ctx)
        return ((((H.time_since(H.var_num_opt(H.u(ctx), "timer_RC_Shoppers_RandEnc"), 1) > 21600) or services.gameplay.environment.is_night()) and (H.global_var_num("RC_Shoppers_visiting") == 1) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))))) == true
    end
    EOC["EOC_RandEnc_RC_Shoppers_remove"] = function(ctx)
    if ((((H.time_since(H.var_num_opt(H.u(ctx), "timer_RC_Shoppers_RandEnc"), 1) > 21600) or services.gameplay.environment.is_night()) and (H.global_var_num("RC_Shoppers_visiting") == 1) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))))) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "randenc_shoppers_loc"); if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_13"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_RandEnc_RC_Shoppers_remove" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "RC_Shoppers_visiting", 0)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_RC_JohnBailey_add"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(30)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))) and (not services.gameplay.environment.is_night()) and services.random.native_probability(1, (15)) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_flag_FMShopkeep_Mission1", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_JohnBailey_RandEnc"), 1) >= 259200))) == true
    end
    EOC["EOC_RandEnc_RC_JohnBailey_add"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(30)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))) and (not services.gameplay.environment.is_night()) and services.random.native_probability(1, (15)) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "mission_flag_FMShopkeep_Mission1", "")))) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_JohnBailey_RandEnc"), 1) >= 259200))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_13"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_RandEnc_RC_JohnBailey_add" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "timer_JohnBailey_RandEnc", services.turn())
        H.eoc_loc_var(H.u(ctx), ctx, "global", "randenc_johnbailey_loc", { terrain = "evac_center_13" }, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "RC_JohnBailey_visiting", 1)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_RC_JohnBailey_remove"] = function(ctx)
        return ((((H.time_since(H.var_num_opt(H.u(ctx), "timer_JohnBailey_RandEnc"), 1) > 21600) or services.gameplay.environment.is_night()) and (H.global_var_num("RC_JohnBailey_visiting") == 1) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))))) == true
    end
    EOC["EOC_RandEnc_RC_JohnBailey_remove"] = function(ctx)
    if ((((H.time_since(H.var_num_opt(H.u(ctx), "timer_JohnBailey_RandEnc"), 1) > 21600) or services.gameplay.environment.is_night()) and (H.global_var_num("RC_JohnBailey_visiting") == 1) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_13", math.floor(2)) end)()))))) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "randenc_johnbailey_loc"); if _p then local _omt = _p:project_to('omt'); local _om = "evac_center_13"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_RandEnc_RC_Shoppers_remove" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "RC_JohnBailey_visiting", 0)
        return true
    end
    return false
    end
    COND["EOC_HAUNTING"] = function(ctx)
        return (((H.global_var_num("XEDRA_OFFICER_STATUS") == 1) or (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["EOC_HAUNTING"] = function(ctx)
    if (((H.global_var_num("XEDRA_OFFICER_STATUS") == 1) or (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        H.set_var("global", nil, ctx, "XEDRA_OFFICER_STATUS", 0)
        services.messages.add(ctx:expand_text(services.translate("The sound of footsteps fade.  It's no longer tracking you.")), "good")
        return true
    else
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_XEDRA_soldier") or H.safe_id('monster_group', "mon_XEDRA_soldier"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(services.random.native_int(2, 3)), min_radius = math.floor(4), max_radius = math.floor(10), lifespan = { minimum = services.time.duration_from_turns(math.floor(60)), maximum = services.time.duration_from_turns(math.floor(120)) } }); 
        end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "MERC_LOC"); if _p then services.sound.emit(_p, math.floor(50), "speech", (services.snippets.native_random("<XEDRA_OFFICER>") or ''), false) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(30), math.floor(50); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HAUNTING"), nil) end end
        return false
    end
    end
    EOC["EOC_HAUNTING_SPAWN"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "MERC_LOC", nil, nil, nil, { min_radius = math.floor(25), max_radius = math.floor(45) }, nil, false, true, {  }, {  })
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_XEDRA_officer") or H.safe_id('monster_group', "mon_XEDRA_officer"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(1), max_radius = math.floor(2) }); 
        if not (_sr.ok and _sr.value and (_sr.value.spawned or 0) > 0) then H.run_eoc("EOC_HAUNTING_SPAWN", ctx) end
    end end
    do local _p, _g = H.get_tripoint_var("global", nil, ctx, "MERC_LOC"), H.safe_id('terrain_furniture_transform', "merc_darkness_transform"); if _p and _g then services.world.transform_radius(_p, math.floor(20), _g, nil) end end
    do local _p, _g = H.get_tripoint_var("global", nil, ctx, "MERC_LOC"), H.safe_id('terrain_furniture_transform', "merc_darkness_transform_walls"); if _p and _g then services.world.transform_radius(_p, math.floor(20), _g, nil) end end
    return true
    end
    EOC["EOC_HAUNTING_STOP"] = function(ctx)
    H.set_var("global", nil, ctx, "XEDRA_OFFICER_STATUS", 1)
    return true
    end
    EOC["EOC_HAUNTING_QUEUE_STOP"] = function(ctx)
    local _ach25 = H.safe_id("achievement", "achievement_officer_kill")
    if _ach25 then services.achievements.complete(_ach25) end
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_HAUNTING_STOP"), nil) end end
    return true
    end
    EOC["EOC_conjure_memories"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_memory") or H.safe_id('monster_group', "mon_memory"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(10), hallucinations = math.floor(10), outdoor_only = false, lifespan = { minimum = services.time.duration_from_turns(math.floor(5)), maximum = services.time.duration_from_turns(math.floor(30)) } }); 
        if _sr.ok and _sr.value and (_sr.value.spawned or 0) > 0 then services.messages.add(ctx:expand_text(services.translate("A flickering silhouette appears nearby.")), 'warning') end
    end end
    return true
    end
    EOC["EOC_ROBOFAC_HQ_UPDATE_RECURRENCE"] = function(ctx)
    H.run_eoc("EOC_ROBOFAC_HQ_UPDATE_EVENT", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_ROBOFAC_HQ_SURFACE_SANDBAGS"] = function(ctx)
        return (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 20)) == true
    end
    EOC["EOC_ROBOFAC_HQ_SURFACE_SANDBAGS"] = function(ctx)
    if (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 20)) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_meteorology1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "window_sandbags_meteorology1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_meteorology2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "window_sandbags_meteorology2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_surface_road2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "window_sandbags_surface_road2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["EOC_ROBOFAC_HQ_PLACE_ANCILLA_FORTRESS"] = function(ctx)
        return (((H.global_var_num("ancilla_fortress_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 45))) == true
    end
    EOC["EOC_ROBOFAC_HQ_PLACE_ANCILLA_FORTRESS"] = function(ctx)
    if (((H.global_var_num("ancilla_fortress_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 45))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_meteorology2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "robofachq_ancilla_fortress_basic" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "ancilla_fortress_placed", 1)
        return true
    end
    return false
    end
    COND["EOC_ROBOFAC_HQ_PLACE_ANCILLA_BAR"] = function(ctx)
        return (((H.global_var_num("ancilla_bar_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60))) == true
    end
    EOC["EOC_ROBOFAC_HQ_PLACE_ANCILLA_BAR"] = function(ctx)
    if (((H.global_var_num("ancilla_bar_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 60))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_subcc_a2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "robofachq_ancilla_bar_basic" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "ancilla_bar_loc", { terrain = "robofachq_subcc_a2" }, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "ancilla_bar_exists", 1)
        H.set_var("global", nil, ctx, "ancilla_bar_placed", 1)
        H.run_eoc("EOC_reroll_bar_mercs", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_ROBOFAC_HQ_PLACE_ANCILLA_AUTODOC"] = function(ctx)
        return (((H.global_var_num("ancilla_bar_exists") == 1) and (H.global_var_num("ancilla_autodoc_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 80))) == true
    end
    EOC["EOC_ROBOFAC_HQ_PLACE_ANCILLA_AUTODOC"] = function(ctx)
    if (((H.global_var_num("ancilla_bar_exists") == 1) and (H.global_var_num("ancilla_autodoc_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 80))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_subcc_a1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "robofachq_ancilla_bar_autodoc" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "ancilla_autodoc_loc", { terrain = "robofachq_subcc_a1" }, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "ancilla_autodoc_placed", 1)
        H.set_var("global", nil, ctx, "ancilla_autodoc_placed_when", services.turn())
        return true
    end
    return false
    end
    COND["EOC_ROBOFAC_HQ_PLACE_ANCILLA_BIONIC_GARAGE"] = function(ctx)
        return (((H.global_var_num("ancilla_autodoc_placed") == 1) and (H.global_var_num("ancilla_bionic_garage_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 87))) == true
    end
    EOC["EOC_ROBOFAC_HQ_PLACE_ANCILLA_BIONIC_GARAGE"] = function(ctx)
    if (((H.global_var_num("ancilla_autodoc_placed") == 1) and (H.global_var_num("ancilla_bionic_garage_placed") ~= 1) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 87))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_surface_car_entrance"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "robofachq_ancilla_bionic_garage" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "global", "ancilla_bionic_garage_loc", { terrain = "robofachq_surface_car_entrance" }, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "ancilla_bionic_garage_placed", 1)
        if ((not ((H.var_num(H.u(ctx), "hub01_completed_missions") >= 1))) and (H.char_has_trait(H.u(ctx), "EXODII_CYBERFRAME_GENERIC") == 1)) then
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_surface_entrance"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_robofac_intercom" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
            H.set_var("global", nil, ctx, "hub01_intercom_locked", 1)
            do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac_auxiliaries_chop_shop"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac_auxiliaries"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac_auxiliaries"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
            do local g = H.safe_id("faction", "robofac_auxiliaries"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
        end
        return true
    end
    return false
    end
    COND["EOC_ROBOFAC_HQ_UPDATE_EVENT"] = function(ctx)
        return ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_surface_road1", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_surface_road1", math.floor(4)) end)()))) and (H.global_var_num("robofac_destroyed") ~= 1))) == true
    end
    EOC["EOC_ROBOFAC_HQ_UPDATE_EVENT"] = function(ctx)
    if ((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_surface_road1", math.floor(180)) end)()) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_surface_road1", math.floor(4)) end)()))) and (H.global_var_num("robofac_destroyed") ~= 1))) then
        H.run_eoc("EOC_ROBOFAC_HQ_SURFACE_SANDBAGS", ctx, nil, nil, nil)
        H.run_eoc("EOC_ROBOFAC_HQ_PLACE_ANCILLA_FORTRESS", ctx, nil, nil, nil)
        H.run_eoc("EOC_ROBOFAC_HQ_PLACE_ANCILLA_BAR", ctx, nil, nil, nil)
        H.run_eoc("EOC_ROBOFAC_HQ_PLACE_ANCILLA_AUTODOC", ctx, nil, nil, nil)
        H.run_eoc("EOC_ROBOFAC_HQ_PLACE_ANCILLA_BIONIC_GARAGE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_reroll_bar_mercs"] = function(ctx)
        return (((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_subcc_a2", math.floor(1)) end)()))) and (H.global_var_num("ancilla_bar_exists") == 1))) == true
    end
    EOC["EOC_reroll_bar_mercs"] = function(ctx)
    if (((not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "robofachq_subcc_a2", math.floor(1)) end)()))) and (H.global_var_num("ancilla_bar_exists") == 1))) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "ancilla_bar_loc"); if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_subcc_a2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_ancilla_bar_remove_BEMs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "ancilla_bar_loc"); if _p then local _omt = _p:project_to('omt'); local _om = "robofachq_subcc_a2"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "nest_ancilla_bar_place_BEMs" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["is_disarmed"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "disarmed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) == true
    end
    EOC["is_disarmed"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "maimed_arm"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not (((function() local eg = H.safe_id('effect', "disarmed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))))) then
        return true
    end
    return false
    end
    COND["EOC_NL_PHASE_GOO_PHASED_FAULT"] = function(ctx)
        return (services.random.native_probability(1, (4))) == true
    end
    EOC["EOC_NL_PHASE_GOO_PHASED_FAULT"] = function(ctx)
    if (services.random.native_probability(1, (4))) then
        do local _g = H.safe_id('fault', "fault_nl_phase_goo"); if H.npc(ctx) and _g then services.items.set_fault(H.npc(ctx), _g, { force = true, message = true }) end end
        return true
    end
    return false
    end
end
