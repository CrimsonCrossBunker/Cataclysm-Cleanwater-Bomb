local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SPELLCASTING_DEFAULT_TRAIT",
    name = ccb.content.text_without_extraction("Default Spellcasting modifiers"),
    points = 0,
    description = ccb.content.text_without_extraction("Adds some default spellcasting modifiers to work around jmath limit.  Should not be player-visible"),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_SPELLCASTING_DEFAULT_TRAIT_0" },
}

ccb.content.define_mutation {
    id = "MAGUS",
    name = ccb.content.text("Magus"),
    points = 0,
    description = ccb.content.text("A tradition as old as magic, the Magus focuses on binding and shaping the energy of the universe to their will."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "ANIMIST" },
    spells_learned = { create_rune_magus = 0 },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "ANIMIST",
    name = ccb.content.text("Animist"),
    points = 0,
    description = ccb.content.text("The animist tradition is a relatively new school of magical thought, formed through combination of many older ways that focus on harmony and connection to the natural world.  This does not mean that animists are passive: the natural world is a savage place."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "MAGUS" },
    spells_learned = { create_rune_animist = 0 },
    monster_cameras = { mon_watcher_spirit = 30 },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "KELVINIST",
    name = ccb.content.text("Kelvinist"),
    points = 0,
    description = ccb.content.text("Disciples of the great Archwizard Lord Kelvin.  Kelvinists focus their magic on manipulation and control of the temperature of their environment, leading to spectacularly powerful explosions or bone-chilling cold.  Your powers grant you some immunity from fire that increases with your skills."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "STORMSHAPER" },
    spells_learned = { create_rune_kelvinist = 0 },
    enchantments = { "KELVINIST" },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "STORMSHAPER",
    name = ccb.content.text("Stormshaper"),
    points = 0,
    description = ccb.content.text("Stormshapers follow ancient arcane disciplines of meditation and harmony with the winds and tides that shape the planet.  Through their deep connection to these forces, they can request powerful changes.  Your powers grant you some immunity from electricity that increases with your skills."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "KELVINIST" },
    spells_learned = { create_rune_stormshaper = 0 },
    enchantments = { "STORMSHAPER" },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "TECHNOMANCER",
    name = ccb.content.text("Technomancer"),
    points = 0,
    description = ccb.content.text("Technomancers are the new breed of modern magician, blending their arcane might with their advanced knowledge of the fundamental nature of the universe.  They use technology to enhance their magic and vice versa."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "EARTHSHAPER" },
    spells_learned = { create_rune_technomancer = 0 },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "EARTHSHAPER",
    name = ccb.content.text("Earthshaper"),
    points = 0,
    description = ccb.content.text("Earthshapers have allowed their minds to sink deep within the stones and metals of the planet, and become one with its secrets.  To a master Earthshaper, spells can be as permanent as the stones they are created from, and time is measured in geological eras."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "TECHNOMANCER" },
    spells_learned = { create_rune_earthshaper = 0 },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "BIOMANCER",
    name = ccb.content.text("Biomancer"),
    points = 0,
    description = ccb.content.text("The Biomancer focuses on manipulating and even absorbing flesh; their own, and that of other living or dead things.  Most other wizards find their powers gross and disturbing, but no one can question the potency of their abilities, and certainly not their adaptability to any situation."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "DRUID" },
    spells_learned = { create_rune_biomancer = 0 },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "DRUID",
    name = ccb.content.text("Druid"),
    points = 0,
    description = ccb.content.text("Druids follow a wild tradition of allegiance and rebirth within the world of nature, especially the cycle of death and rebirth that is the plant world.  A powerful Druid is as much a part of that world as the human one."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "BIOMANCER" },
    spells_learned = { create_rune_druid = 0 },
    flags = { "ATTUNEMENT", "TREE_COMMUNION_PLUS" },
}
