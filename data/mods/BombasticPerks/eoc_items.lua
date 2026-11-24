local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_iuse_bombasticperks_ac35e518c504", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_PERK_ABSIT_INVIDIA_SALT", ctx)
    return 0
end)

do
    local item = ccb.content.Item { id = "salt", copy_from = "salt" }
    item:on_use("w16b_iuse_bombasticperks_ac35e518c504", "Activate", "Throw some salt over your shoulder.")
    ccb.content.replace(item)
end
