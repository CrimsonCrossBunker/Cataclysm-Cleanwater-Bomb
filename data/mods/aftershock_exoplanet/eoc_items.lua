local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
COND["afs_backpack_shieldgen_tick"] = function(ctx)
    return (ctx:has_speaker()) == true
end
ccb.runtime.handler("eoc_test:" .. "afs_backpack_shieldgen_tick", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    return COND["afs_backpack_shieldgen_tick"](H.ctx_new(u, npc, vars)) == true
end)
EOC["_afs_energy_shield"] = function(ctx)
    H.run_eoc("EOC_afs_do_shield", ctx, nil, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "_afs_energy_shield", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["_afs_energy_shield"](H.ctx_new(u, npc, vars))
end)
EOC["afs_backpack_shieldgen_activate"] = function(ctx)
    H.run_eoc("EOC_start_shield", ctx, { ["transform_target"] = "afs_backpack_shieldgen_on", ["shield_max_hp"] = 600, ["shield_regen"] = 2, ["shield_regen_rate"] = 1, ["turn_cost"] = 1, ["success_message"] = "a", ["failure_message"] = "b" }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "afs_backpack_shieldgen_activate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["afs_backpack_shieldgen_activate"](H.ctx_new(u, npc, vars))
end)
EOC["afs_backpack_shieldgen_deactivate"] = function(ctx)
    H.run_eoc("EOC_stop_shield", ctx, { ["transform_target"] = "afs_backpack_shieldgen" }, nil, nil)
    return true
end
ccb.runtime.handler("eoc:" .. "afs_backpack_shieldgen_deactivate", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["afs_backpack_shieldgen_deactivate"](H.ctx_new(u, npc, vars))
end)
EOC["afs_backpack_shieldgen_tick"] = function(ctx)
    if (ctx:has_speaker()) then
        H.set_var("actor", H.u(ctx), ctx, "shield_power_ratio", H.char_bionic_power(H.npc(ctx), "power_percentage"))
        return true
    else
        do local _g = H.safe_id('item', "afs_backpack_shieldgen"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, nil) end end
        return false
    end
end
ccb.runtime.handler("eoc:" .. "afs_backpack_shieldgen_tick", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["afs_backpack_shieldgen_tick"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_itick_aftershock_exoplanet_2573e18858a9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("_afs_energy_shield", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_aftershock_exoplanet_4575f7812cfa", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("afs_backpack_shieldgen_activate", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_aftershock_exoplanet_0971e4ad7d60", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("afs_backpack_shieldgen_deactivate", ctx)
    return 0
end)
ccb.runtime.handler("w16b_itick_aftershock_exoplanet_ce6bb248c679", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("afs_backpack_shieldgen_tick", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_aftershock_exoplanet_c72b04aee341", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_AFS_CALL_AUGUSTMOON_SHUTTLE", ctx)
    return 0
end)

do
    local item = ccb.content.Item { id = "afs_energy_shield", copy_from = "afs_energy_shield" }
    item:on_tick("w16b_itick_aftershock_exoplanet_2573e18858a9")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "afs_backpack_shieldgen", copy_from = "afs_backpack_shieldgen" }
    item:on_use("w16b_iuse_aftershock_exoplanet_4575f7812cfa", "Activate", nil, { ammo_scale = 1 })
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "afs_backpack_shieldgen_on", copy_from = "afs_backpack_shieldgen_on" }
    item:on_use("w16b_iuse_aftershock_exoplanet_0971e4ad7d60", "Deactivate", nil, { ammo_scale = 0 })
    item:on_tick("w16b_itick_aftershock_exoplanet_ce6bb248c679")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "afs_shuttle_radiobeacon", copy_from = "afs_shuttle_radiobeacon" }
    item:on_use("w16b_iuse_aftershock_exoplanet_c72b04aee341", "Activate", "Call a shuttle.")
    ccb.content.replace(item)
end
