local content = require("ccb").content
local text = content.text

content.add(content.EffectType {
    id = "effect_si_lilin_no_ruach_upgrades",
    name = text("Fragile Spirit"),
    description = text("Your ruach is too fragile to spend it frivolously."),
})

content.add(content.Mutation {
    id = "START_AS_VAMPIRE",
    name = text("Starting as a vampire"),
    description = text("This makes you start with the vampvirus effect.  This has no effect if gained after the game started."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
})

content.replace(content.Blacklist { kind = "scenario", whitelist = true }
    :entry("scenario_warper")
    :entry("scenario_warper_unique_paths"))
