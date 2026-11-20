local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_monochrome",
    copy_from = "mon_zombie_base",
    name = ccb.content.plural_text("monochrome zombie", "monochrome zombies"),
    description = ccb.content.text("What stands in front of you is one of the healthiest zombies you've ever seen.  If not for the black muck oozing from its orifices and shambling gait, you might even think it human.  Every part of this zombie, even its clothes, is colored some shade of gray, and every couple of seconds it flickers."),
    symbol = "Z",
    color = "light_gray",
    attacks = {
        { id = "grab", cooldown = 1 },
        { id = "bite_humanoid", cooldown = 5 },
        {
            id = "zombie_monochrome_reset_hp_attack",
            spell = { id = "zombie_monochrome_reset_hp" },
            allow_no_target = true,
            cooldown = 10,
            casting_message = ccb.content.text("%1$s flickers and all of its injuries disappear!"),
            kind = "spell",
            when = "allow_zombie_monochrome_zombie_monochrome_reset_hp_attack",
        },
    },
    upgrade = { half_life = 100, monster_group = "GROUP_ZOMBIE_MONOCHROME_UPGRADE" },
}

ccb.content.define_monster {
    id = "mon_zombie_monochrome_2",
    copy_from = "mon_zombie_base",
    name = ccb.content.plural_text("distorted zombie", "distorted zombies"),
    description = ccb.content.text("This zombie is partially obscured by the gray, distorted air around it.  From what you can see it doesn't have a single wound on its body, and it moves much quicker than a zombie should.  Every few seconds the distortions surge."),
    symbol = "Z",
    color = "light_gray",
    attacks = {
        { id = "grab", cooldown = 1 },
        { id = "bite_humanoid", cooldown = 5 },
        {
            id = "zombie_monochrome_reset_hp_attack",
            spell = { id = "zombie_monochrome_reset_hp" },
            allow_no_target = true,
            cooldown = 5,
            casting_message = ccb.content.text("%1$s flickers and all of its injuries disappear!"),
            kind = "spell",
            when = "allow_zombie_monochrome_zombie_monochrome_reset_hp_attack",
        },
    },
    upgrade = { half_life = 100, monster = "mon_zombie_monochrome_3" },
    inheritance = {
        add = { flags = { "PULP_PRYING", "STABILIZED_TIMELINE" } },
        scale = { speed = 1.5, hp = 1.5 },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_monochrome_3",
    copy_from = "mon_zombie_base",
    name = ccb.content.plural_text("zombie timewound", "zombie timewounds"),
    description = ccb.content.text("Every bit of color around this zombie has been sapped a distorted gray.  In contrast with its healthy appearance, the surrounding environment seems to slowly erode, even after it swiftly moves away.  It sharply flickers every few seconds."),
    symbol = "Z",
    color = "dark_gray",
    attacks = {
        { id = "grab", cooldown = 1 },
        { id = "bite_humanoid", cooldown = 5 },
        {
            id = "zombie_monochrome_reset_hp_special",
            spell = { id = "zombie_monochrome_reset_hp" },
            allow_no_target = true,
            cooldown = 2,
            casting_message = ccb.content.text("%1$s flickers and all of its injuries disappear!"),
            kind = "spell",
            when = "allow_zombie_monochrome_zombie_monochrome_reset_hp_attack",
        },
        {
            id = "xedra_monster_erosion_buff_special",
            cooldown = 0,
            spell = { id = "xedra_monster_erosion_buff" },
            allow_no_target = true,
            casting_message = ccb.content.text("The ground around %1$s starts eroding into nothingness."),
            kind = "spell",
            when = "allow_zombie_monochrome_3_xedra_monster_erosion_buff_special",
        },
    },
    upgrade = false,
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "PULP_PRYING" } }, scale = { speed = 2, hp = 2 } },
}
