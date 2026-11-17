local runtime = require("ccb").runtime

runtime.handler("attribute_scaling", function(attribute)
    return (attribute + 10) / 20
end)
