local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_cabin_tunnel_shadow",
    name = ccb.content.plural_text("languorous spectre", "languorous spectres"),
    description = ccb.content.text("The translucent shape of a cloaked human, crawling upon the ground.  It is featureless, slow, and mumbling words you think you might understand.  Might it speak with you?"),
    default_faction = "nether",
    volume = "120 L",
    mass = "1 kg",
    species = { "NETHER" },
    body_type = "human",
    materials = { "flesh" },
    chat_topics = { "TALK_CABIN_TUNNEL_SHADOW" },
    speed = 10,
    symbol = "s",
    morale = 20,
    aggression = -20,
    aggressive_to_characters = false,
    hp = 100,
    color = "light_gray",
    vision_day = 0,
    vision_night = 100,
    anger_triggers = { "HURT" },
    flags = {
        "SEES", "HEARS", "GOODHEARING", "HAS_MIND", "NOHEAD", "NO_BREATHE", "PATH_AVOID_DANGER",
        "QUIETDEATH", "CONVERSATION",
    },
    armor = { bash = 20, cut = 20, acid = 20, heat = 20, bullet = 20 },
}
