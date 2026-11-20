local ccb = require("ccb")
local content = ccb.content

-- Native profession groups
do
local definition = content.ProfessionGroup {
    id = "adult_basic_background",
}
definition:profession("driving_license")
definition:profession("simple_home_cooking")
definition:profession("computer_literate")
definition:profession("social_skills")
definition:profession("high_school_graduate")
definition:profession("mundane_survival")
content.add(definition)
end
