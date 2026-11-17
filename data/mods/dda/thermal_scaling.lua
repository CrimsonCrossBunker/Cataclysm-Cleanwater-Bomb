local runtime = require("ccb").runtime

runtime.handler("cold_blood_speed_adjustment", function(temperature, threshold, warmth, rate)
    return math.min(((temperature - threshold) + warmth) * rate, 0)
end)

runtime.handler("thermal_speed_adjustment", function(temperature, threshold, warmth, rate)
    return ((temperature - threshold) + warmth) * rate
end)
