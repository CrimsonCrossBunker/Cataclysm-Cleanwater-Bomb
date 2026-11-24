local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_comp_ls_passcode", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("EOC_LS_Passcode_Randomize", ctx)
    E.H.run_eoc("EOC_LS_Passcode_Selector", ctx)
    return true
end)
