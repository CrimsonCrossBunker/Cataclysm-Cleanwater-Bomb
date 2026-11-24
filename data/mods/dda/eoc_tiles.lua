local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
EOC["EOC_ACTIVATE_MAP"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if H.npc(ctx) and H.u(ctx) and _p then services.items.activate(H.npc(ctx), H.u(ctx), "reveal_map", { target = _p }) end end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_ACTIVATE_MAP", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_ACTIVATE_MAP"](H.ctx_new(u, npc, vars))
end)
EOC["eoc_pick_and_read_map"] = function(ctx)
    H.eoc_map_run_item_eocs(H.u(ctx), ctx, "all", H.get_tripoint_var("context", nil, ctx, "pos"), 0, 0, nil, { { category = "maps" } }, { "EOC_ACTIVATE_MAP" })
    return true
end
ccb.runtime.handler("eoc:" .. "eoc_pick_and_read_map", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["eoc_pick_and_read_map"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_60MM_SHOT"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "aimed_60mm", 180, nil, nil, nil)
    local _a1 = H.u(ctx)
    local _sg2 = H.safe_id("skill", "launcher")
    if _a1 and _sg2 then services.skills.set(_a1, _sg2, { exercise_percent = math.floor((H.char_skill_exp(_a1, "launcher", false)) + 1) }) end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 400) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 1340) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 2150) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    if (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "target"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 2890) then
        H.eoc_spawn_item(H.u(ctx), "60mm_propellant", 1, false, false, nil)
    end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_60MM_SHOT", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_60MM_SHOT"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_tile_ex_dda_f87909e875f4", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("eoc_pick_and_read_map", ctx)
end)
ccb.runtime.handler("w16b_mortar_c_dda_d4f8a86bd18c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return ((H.char_skill(H.u(ctx), "launcher") >= 1)) == true
end)
ccb.runtime.handler("w16b_mortar_dur_dda_0e910b3b75ac", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return ((((H.char_effect_dur(H.u(ctx), "aimed_60mm", "") > 1)) and (math.max(5, (16 / H.char_skill(H.u(ctx), "launcher")))) or (math.max(60, (190 / H.char_skill(H.u(ctx), "launcher"))))))
end)
ccb.runtime.handler("w16b_mortar_dev_dda_908d8984994c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    return (math.max(0.02, (0.1 / H.char_skill(H.u(ctx), "launcher"))))
end)
ccb.runtime.handler("w16b_mortar_f_m224_mortar_fired", function(payload)
    if not payload or not payload.furniture or payload.furniture.value ~= "f_m224_mortar" then return end
    local t = payload.target
    local tpos = t and services.coords.tripoint_abs_ms(t.x, t.y, t.z) or nil
    local ctx = E.H.ctx_new(payload.character, nil, { target = tpos })
    E.H.run_eoc("EOC_60MM_SHOT", ctx)
end)
ccb.runtime.hook("on_mortar_fired", "w16b_mortar_f_m224_mortar_fired")
