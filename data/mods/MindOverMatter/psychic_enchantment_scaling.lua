local runtime = require("ccb").runtime
local scaling = {}
local weariness_factors = { 0.9, 0.75, 0.6, 0.45, 0.25, 0.25 }

function scaling.weariness(ctx)
    local effects = ctx.character_inputs.effect_intensities
    local factor = 1
    for level, penalty in ipairs(weariness_factors) do
        if effects["weary_" .. level] > -1 then
            factor = factor * penalty
        end
    end
    return factor
end

function scaling.power(ctx)
    local inputs = ctx.character_inputs
    return runtime.call_number("attribute_scaling", inputs.stats.intelligence)
        * inputs.character_variables.nether_attunement_power_scaling
        * scaling.weariness(ctx)
end

return scaling
