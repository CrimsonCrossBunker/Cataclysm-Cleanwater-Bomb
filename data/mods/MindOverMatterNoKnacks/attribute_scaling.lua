local runtime = require("ccb").runtime

runtime.handler("attribute_scaling", function(attribute)
    return math.min((attribute + 10) / 20, 1.25)
end)
