local ccb = require("ccb")
local content = ccb.content

-- Native charge-removal blacklists
do
local definition = content.Blacklist {
    kind = "charge_removal",
    whitelist = false,
}
definition:entry("mtailors_kit")
definition:entry("demon_forge")
content.add(definition)
end
