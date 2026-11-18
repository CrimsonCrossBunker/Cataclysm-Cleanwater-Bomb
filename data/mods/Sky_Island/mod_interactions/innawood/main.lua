local content = require("ccb").content

content.replace(content.Blacklist { kind = "scenario", whitelist = true }
    :entry("scenario_warper"))
