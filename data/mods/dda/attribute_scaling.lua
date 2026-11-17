local runtime = require("ccb").runtime

runtime.handler("attribute_scaling", function(attribute)
    return (attribute + 10) / 20
end)

runtime.handler("alpha_attribute_bonus", function(attribute)
    if attribute < 18 then
        return 13 - attribute / 2
    end
    return 4
end)
