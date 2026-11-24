local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
EOC["EOC_ITEM_HEDGE_WITCHLIGHT_DISMISS"] = function(ctx)
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ITEM_HEDGE_WITCHLIGHT_DISMISS_ACTUAL"), nil) end end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_ITEM_HEDGE_WITCHLIGHT_DISMISS", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_ITEM_HEDGE_WITCHLIGHT_DISMISS"](H.ctx_new(u, npc, vars))
end)
EOC["EOC_CQC_ATTACK"] = function(ctx)
    do local _a, _t = H.u(ctx), H.npc(ctx); if _a and _t and H.creature_snap(_t) then services.characters.attack(_a, _t, "CQB_BRUTAL", nil) end end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_CQC_ATTACK", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_CQC_ATTACK"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_iuse_xedra_evolved_34a23c0610fc", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_WINCH_TELEPORT", ctx)
    return 1
end)
ccb.runtime.handler("w16b_iuse_xedra_evolved_c261cd818191", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_ITEM_HEDGE_WITCHLIGHT_DISMISS", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_xedra_evolved_0818e3f993b9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_CQC_ATTACK", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_xedra_evolved_4bea3c50f454", function(payload)
    if not payload or not payload.character or not payload.item then return nil end
    local worn_res = services.inventory.worn_items(payload.character)
    local snap = services.items.snapshot(payload.item, 0)
    local tid = snap and snap.ok and snap.value and snap.value.id and snap.value.id.value or nil
    local is_worn = false
    if worn_res and worn_res.ok and worn_res.value then
        for _, w in ipairs(worn_res.value) do
            local ws = services.items.snapshot(w, 0)
            if w == payload.item or (tid and ws and ws.ok and ws.value and ws.value.id and ws.value.id.value == tid) then
                is_worn = true
                break
            end
        end
    end
    if not is_worn then
        services.messages.add(services.translate("You must be wearing this to activate it."), "info")
        return nil
    end
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_XEDRA_DAMAGE_REVERSAL", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_xedra_evolved_054f25dc3cd3", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_CHECK_TO_SUMMON_REVENANT", ctx)
    return 1
end)

do
    local item = ccb.content.Item { id = "winch_stone", copy_from = "winch_stone" }
    item:on_use("w16b_iuse_xedra_evolved_34a23c0610fc", "Activate", "Jump.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "item_hedge_witchlight", copy_from = "item_hedge_witchlight" }
    item:on_use("w16b_iuse_xedra_evolved_c261cd818191", "Activate", "Dismiss the witchlight")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "inventor_fists_plus", copy_from = "inventor_fists_plus" }
    item:on_use("w16b_iuse_xedra_evolved_0818e3f993b9", "Activate", "Activate to read the file.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "xedra_inventor_damage_reversal_device", copy_from = "xedra_inventor_damage_reversal_device" }
    item:on_use("w16b_iuse_xedra_evolved_4bea3c50f454", "Activate", "Reverse your last injury.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "revenant_effigy", copy_from = "revenant_effigy" }
    item:on_use("w16b_iuse_xedra_evolved_054f25dc3cd3", "Activate", "Complete the ritual.")
    ccb.content.replace(item)
end
