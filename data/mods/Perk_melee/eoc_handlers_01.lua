local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_PERK_SHRUG_OFF"] = function(ctx)
    return true
    end
end
