local ccb = require("ccb")
local content = ccb.content

-- Native speed descriptions
do
local definition = content.SpeedDescription {
    id = "DEFAULT",
}
definition:value(1.4, { "<color_red>It is much faster than you.</color>" })
definition:value(1.15, { "<color_light_red>It is faster than you.</color>" })
definition:value(1.05, { "<color_yellow>It is a bit faster than you.</color>" })
definition:value(0.9, { "<color_white>It is about as fast as you.</color>" })
definition:value(0.8, { "<color_light_cyan>It is a bit slower than you.</color>" })
definition:value(0.6, { "<color_cyan>It is slower than you.</color>" })
definition:value(0.3, { "<color_light_green>It is much slower than you.</color>" })
definition:value(0.01, { "<color_green>It is practically immobile.</color>" })
definition:value(0.0, { "<color_green>It is immobile.</color>" })
content.add(definition)
end
