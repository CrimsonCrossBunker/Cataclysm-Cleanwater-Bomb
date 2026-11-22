local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_BALTHAZAR_CHECK_PROGRESS"] = function(ctx)
    return true
    end
end
