local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_elf_axe",
    copy_from = "mon_feral_human_axe",
    name = ccb.content.plural_text("feral axe-elf", "feral axe-elves"),
    description = ccb.content.text("Dragging a large axe along the ground, this elf's expression is one of twisted glee.  Their movements are more fluid than those of the feral humans, but no less unsettling."),
    symbol = "E",
    species = { "ELF", "FERAL" },
    dodge = 3,
    vision_night = 8,
    harvest = "demihuman",
    zombify_into = "mon_zombie_elf",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_demihuman" },
    inheritance = { add = { flags = { "QUIETMOVES" } }, scale = { hp = 0.82, speed = 1.03, mass = 0.85 } },
}

ccb.content.define_monster {
    id = "mon_feral_dwarf_axe",
    copy_from = "mon_feral_human_axe",
    looks_like = "mon_forgedwarves",
    name = ccb.content.plural_text("deranged axedwarf", "deranged axedwarves"),
    description = ccb.content.text("This dwarf holds the traditional dwarven weapon with none of the skill and craft of the axedwarves of old.  The axehead is pitted but still looks sharp, and the zombies around them ignore them as they hold it."),
    symbol = "D",
    species = { "DWARF", "FERAL" },
    armor = { bash = 2 },
    vision_day = 15,
    vision_night = 20,
    harvest = "demihuman",
    zombify_into = "mon_zombie_dwarf",
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_demihuman" },
    inheritance = { scale = { hp = 1.1, speed = 0.9, volume = 0.7, mass = 0.9 } },
}
