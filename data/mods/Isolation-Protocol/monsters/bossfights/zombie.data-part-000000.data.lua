local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_necro_boss",
    name = ccb.content.plural_text("zombie dreadlord", "zombie dreadlords"),
    description = ccb.content.text("A twisted mockery of the human form, emaciated, with jet-black skin and glowing red eyes.  It is somehow painful to look at, awakening fears deep within your psyche, and even the surrounding air seems more sinister, somehow darker and more dangerous."),
    attacks = {
        { reference = "RESURRECT", cooldown = 2 },
        {
            id = "mon_zombie_dreadlord_heal",
            spell = { id = "dreadlord_heal", min_level = 1, hit_self = true },
            casting_message = ccb.content.text("Glowing strands of distortion accumulate around %1$s."),
            cooldown = 10,
            kind = "spell",
        },
    },
    looks_like = "mon_zombie_necro",
    pathing = { max_distance = 10 },
    aggression = 100,
    morale = 100,
    copy_from = "mon_zombie_necro",
    vision_night = 50,
    inheritance = { add = { flags = { "ALWAYS_SEES_YOU" } } },
}
