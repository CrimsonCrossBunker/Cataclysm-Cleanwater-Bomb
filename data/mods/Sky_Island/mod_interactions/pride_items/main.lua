local content = require("ccb").content

-- requirements.json

-- For when a recipe calls for a flag.
content.merge_requirement(
    content.Requirement { id = "any_flag_landing_upgradekey" },
    content.Requirement {}
        :component("pride_flag", 1)
)
