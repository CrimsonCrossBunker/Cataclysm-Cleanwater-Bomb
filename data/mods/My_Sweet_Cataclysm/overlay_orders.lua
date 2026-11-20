local ccb = require("ccb")
local content = ccb.content

-- Native global mutation-overlay ordering
do
local definition = content.OverlayOrder()
definition:mutation("SUGAR", 1500)
content.add(definition)
end
