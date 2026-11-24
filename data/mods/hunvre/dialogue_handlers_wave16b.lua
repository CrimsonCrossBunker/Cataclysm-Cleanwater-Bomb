local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_p_hunvre_371437fadc86", function(ctx)
    return (H.global_var_num("elevator_present") == 0)
end)
ccb.runtime.handler("w16b_a_hunvre_3d9f07542792", function(ctx)
    H.run_eoc("EOC_elevator_controls_call", ctx, nil, nil, nil)
end)
