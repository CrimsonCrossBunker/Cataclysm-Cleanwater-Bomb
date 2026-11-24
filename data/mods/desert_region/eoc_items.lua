local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_iuse_desert_region_c6d2855619ce", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_CAUSE_EARLY_DUST_STORM", ctx)
    return 0
end)

do
    local item = ccb.content.Item { id = "test_duststorm", copy_from = "test_duststorm" }
    item:on_use("w16b_iuse_desert_region_c6d2855619ce", "Activate", "Touch the opening.")
    ccb.content.replace(item)
end
