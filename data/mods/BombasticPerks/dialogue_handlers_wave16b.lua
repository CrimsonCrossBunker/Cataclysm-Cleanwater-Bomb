local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_a_bombasticperks_8173186b74c6", function(ctx)
    H.run_eoc("EOC_give_perk_menu", ctx, nil, nil, nil)
end)
