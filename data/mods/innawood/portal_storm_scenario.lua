local content = require("ccb").content

content.replace(content.Scenario {
    id = "portal_dependent",
    inherits = "portal_dependent",
    requirement = "achievement_witnessed_portal_storm",
})
