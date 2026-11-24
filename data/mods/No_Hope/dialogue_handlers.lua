local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

ccb.runtime.handler("dlg_a_no_hope_8683ce392b9e", function(ctx)
    H.receive_item(H.u(ctx), "necropolis_freq", 1, nil)
end)
