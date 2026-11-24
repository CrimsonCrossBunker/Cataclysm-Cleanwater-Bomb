local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
EOC["EOC_unlock_afs_crate"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 9, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_crate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_crate"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_display_case"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 10, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_display_case", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_display_case"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_security_panel"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 10, ["t_radius"] = 6 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_security_panel", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_security_panel"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_security_panel_10"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 10, ["t_radius"] = 10 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_security_panel_10", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_security_panel_10"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_e_safe"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 3600)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 13, ["t_radius"] = 1 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_e_safe", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_e_safe"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_cryo_storage_unit"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.set_var("actor", H.u(ctx), ctx, "hack_success_eoc", "EOC_hack_cryo_storage_unit_success")
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 8, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_cryo_storage_unit", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_cryo_storage_unit"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_unlock_afs_metal_door"] = function(ctx)
    H.set_var("context", nil, ctx, "t_delay", 1200)
    H.run_eoc("EOC_start_lock_hack", ctx, { ["furn_pos"] = H.var_str("context", nil, ctx, "pos", ""), ["t_delay"] = H.var_str("context", nil, ctx, "t_delay", ""), ["difficulty"] = 9, ["t_radius"] = 0 }, services.characters.avatar(), nil)
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_unlock_afs_metal_door", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_unlock_afs_metal_door"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_aae3520fcb96", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_crate", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_8a3072a84d7f", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_display_case", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_c0eeb92bea86", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_security_panel", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_d6559b6d06f7", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_security_panel_10", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_6524a6a6b6d3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_e_safe", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_48d2ac0397b2", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_cryo_storage_unit", ctx)
end)
ccb.runtime.handler("w16b_tile_ex_aftershock_exoplanet_49d6e9dea68e", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, { pos = (payload and payload.position) and services.coords.tripoint_abs_ms(payload.position.x, payload.position.y, payload.position.z) or nil })
    E.H.run_eoc("EOC_unlock_afs_metal_door", ctx)
end)
