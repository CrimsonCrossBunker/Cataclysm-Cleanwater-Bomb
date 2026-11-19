local ccb = require("ccb")
local content = ccb.content

-- Native bash-damage profiles
do
local definition = content.BashDamageProfile {
    id = "default",
}
definition:factor("bash", 1)
content.add(definition)
end
do
local definition = content.BashDamageProfile {
    id = "wooden_door",
}
definition:factor("bash", 0.94999999999999996)
definition:factor("cut", 1.2)
content.add(definition)
end
