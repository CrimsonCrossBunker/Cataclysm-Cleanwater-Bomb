local ccb = require("ccb")
local services = ccb.services
local H = {}
local E = { run = {}, cond = {}, dyn_cond = {}, H = H }
require("ccb_runtime_helpers").attach(H, E)

local EOC = E.run
local COND = E.cond
EOC["EOC_DDOTD_CALCULATOR_WATCH"] = function(ctx)
    services.messages.add((services.snippets.native_random("<ddotd_calculator_watch_use>") or ''), "neutral")
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_DDOTD_CALCULATOR_WATCH", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_DDOTD_CALCULATOR_WATCH"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_iuse_classic_zombies_ae2d4ff74f24", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_DDOTD_CALCULATOR_WATCH", ctx)
    return 0
end)

do
    local item = ccb.content.Item { id = "calculator_watch", copy_from = "calculator_watch" }
    item:on_use("w16b_iuse_classic_zombies_ae2d4ff74f24", "Use the calculator")
    ccb.content.replace(item)
end
