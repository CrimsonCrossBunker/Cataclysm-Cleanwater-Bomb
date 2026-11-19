local ccb = require("ccb")

-- Better night vision than default zombies, but not as good as living dwarves, and worse day vision.
ccb.content.define_monster {
    id = "mon_zombie_dwarf",
    name = ccb.content.plural_text("zombie dwarf", "zombie dwarves"),
    copy_from = "mon_zombie_tough",
    species = { "ZOMBIE", "DWARF" },
    description = ccb.content.text("Once a dwarf, this zombie now has rent flesh and a beard in tatters.  Its face is twisted in an expression of rage."),
    speed = 65,
    vision_day = 15,
    vision_night = 8,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_DWARF_UPGRADE" },
    inheritance = { scale = { volume = 0.7, mass = 0.9 } },
}

-- Better night vision than default zombies, but not as good as living dwarves, and worse day vision.
ccb.content.define_monster {
    id = "mon_zombie_dwarf_miner",
    name = ccb.content.plural_text("zombie dwarven miner", "zombie dwarven miners"),
    copy_from = "mon_zombie_miner",
    species = { "ZOMBIE", "DWARF" },
    description = ccb.content.text("Once a dwarven miner, this zombie now has rent flesh and a beard in tatters.  Its face is twisted in an expression of rage."),
    vision_day = 15,
    vision_night = 8,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_DWARF_UPGRADE" },
    inheritance = { scale = { hp = 1.2, volume = 0.7, mass = 0.9, speed = 0.9 } },
}

-- Better night vision than default zombies, but not as good as living elves.
ccb.content.define_monster {
    id = "mon_zombie_elf",
    name = ccb.content.plural_text("zombie elf", "zombie elves"),
    copy_from = "mon_zombie",
    species = { "ZOMBIE", "ELF" },
    description = ccb.content.text("Its face twisted in an expression of pure rage and with glassy eyes, this elf looks nothing like the ethereal elves from before the Cataclysm.  Though it also lacks the elves' characteristic grace, its movements are quieter than the other dead."),
    vision_night = 5,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_ELF_UPGRADE" },
    inheritance = { add = { flags = { "QUIETMOVES" } }, scale = { hp = 0.82, speed = 1.03, mass = 0.85 } },
}
