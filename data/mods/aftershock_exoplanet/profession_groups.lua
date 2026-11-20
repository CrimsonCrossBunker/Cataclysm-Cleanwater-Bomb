local ccb = require("ccb")
local content = ccb.content

-- Native profession groups
do
local definition = content.ProfessionGroup {
    id = "adult_basic_background",
}
definition:profession("mundane_survival")
definition:profession("bionic_interface")
content.replace(definition)
end
