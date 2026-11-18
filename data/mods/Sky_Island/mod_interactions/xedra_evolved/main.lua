local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "effect_si_lilin_no_ruach_upgrades",
    name = ccb.content.text("Fragile Spirit"),
    description = ccb.content.text("Your ruach is too fragile to spend it frivolously."),
})

content.add(content.Mutation {
    id = "START_AS_VAMPIRE",
    name = ccb.content.text("Starting as a vampire"),
    description = ccb.content.text("This makes you start with the vampvirus effect.  This has no effect if gained after the game started."),
    points = 0,
    valid = false,
    purifiable = false,
    player_display = false,
})

content.replace(content.Blacklist { kind = "scenario", whitelist = true }
    :entry("scenario_warper")
    :entry("scenario_warper_unique_paths"))

for _, profession in ipairs {
    "paraclesian_sylph",
    "paraclesian_homullus",
    "paraclesian_salamander",
    "paraclesian_undine",
    "paraclesian_arvore",
    "paraclesian_ierde",
} do
    content.patch_profession(profession, { remove_flags = { "SCEN_ONLY" } })
end

require("mod_interactions.xedra_evolved.hobbies")
