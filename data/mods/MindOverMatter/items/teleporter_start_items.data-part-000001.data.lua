local ccb = require("ccb")

ccb.content.define_item {
    id = "itzcuauhtli_cape",
    copy_from = "cloak",
    name = ccb.content.plural_text("Itzcuāuhtli Corps tilmàtli", "Itzcuāuhtli Corps tilmàtli"),
    description = ccb.content.text("A formal dress cape for the Itzcuāuhtli Corps in crimson and gold, with the eagle's head over a field of stars insignia on the left shoulder, worn by generations of those who sought out new worlds in service to the Huey Tlatoani and the Ēxcān Tlahtōlōyān.  You're pretty sure this is the furthest anyone wearing one has ever been from Anáhuac."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } }, remove = { flags = { "HOOD" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_hat",
    copy_from = "beret",
    name = ccb.content.text("Imperial navy cap"),
    description = ccb.content.text("A flat crimson hat worn by members of the Imperial navy at formal events.  This one has the black circle of the Yohualli Ehēcatl on it."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_holster",
    copy_from = "holster",
    name = ccb.content.text("Ch47 holster"),
    description = ccb.content.text("A holster for the Ch47.  You could put one of the primitive local ranged weapons in here too, if you had to."),
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "250 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_holster_m12",
    copy_from = "holster",
    name = ccb.content.text("M12 holster"),
    description = ccb.content.text("A holster for the M12.  You could put one of the primitive local ranged weapons in here too, if you had to."),
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "250 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_tunic",
    copy_from = "dress_shirt",
    name = ccb.content.text("Yohualli Ehēcatl division tunic"),
    description = ccb.content.text("A dress tunic, in gold and crimson, slashed with black bars.  This would immediately mark your exact rank and position to anyone else in the Imperial Navy, if you ever see another one again."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_tunic_jaguar",
    copy_from = "dress_shirt",
    name = ccb.content.text("Ocēlōpilli dress tunic"),
    description = ccb.content.text("A dress tunic, in gold and crimson, slashed with yellow bars.  This marks the wearer as one of the Jaguar Warrior special forces."),
    variant_kind = "generic",
    variants = {
        {
            id = "itzcuauhtli_tunic_jaguar_standard",
            name = ccb.content.text("Ocēlōpilli dress tunic"),
            description = ccb.content.text("A dress tunic, in gold and crimson, slashed with yellow bars.  This marks the wearer as one of the Jaguar Warrior special forces."),
            weight = 1,
        },
        {
            id = "itzcuauhtli_tunic_jaguar_non_fifth_sun",
            name = ccb.content.plural_text("uniform dress shirt", "uniform dress shirt"),
            description = ccb.content.text("Some sort of uniform dress shirt in a blood-red crimson color with gold accents and a series of yellow bars on the left side.  You can't recall any military that dresses quite like this."),
            weight = 1,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_pants",
    copy_from = "pants",
    name = ccb.content.plural_text("Itzcuāuhtli Corps pants", "Itzcuāuhtli Corps pants"),
    description = ccb.content.text("A set of gold and crimson uniform pants.  The days of wearing only a maxtlatl are gone following the expansion of the empire out from Anáhuac, and considering the local climate, you're grateful for it."),
    variant_kind = "generic",
    variants = {
        {
            id = "itzcuauhtli_pants_standard",
            name = ccb.content.plural_text("Itzcuāuhtli Corps pants", "Itzcuāuhtli Corps pants"),
            description = ccb.content.text("A set of gold and crimson uniform pants.  The days of wearing only a maxtlatl are gone following the expansion of the empire out from Anáhuac, and considering the local climate, you're grateful for it."),
            weight = 1,
        },
        {
            id = "itzcuauhtli_pants_non_fifth_sun",
            name = ccb.content.plural_text("uniform pants", "uniform pants"),
            description = ccb.content.text("Some sort of uniform pants in a blood-red crimson color with gold accents.  You can't recall any military that dresses quite like this."),
            weight = 1,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_boots",
    copy_from = "boots",
    name = ccb.content.plural_text("naval boots", "naval boots"),
    description = ccb.content.text("Simple black leather boots.  It's a good thing you weren't transporting a planetary tlatoani when the accident happened or you might have ended up on this gods-forsaken hellhole barefoot."),
    variant_kind = "generic",
    variants = {
        {
            id = "itzcuauhtli_boots_standard",
            name = ccb.content.plural_text("naval boots", "naval boots"),
            description = ccb.content.text("Simple black leather boots.  It's a good thing you weren't transporting a planetary tlatoani when the accident happened or you might have ended up on this gods-forsaken hellhole barefoot."),
            weight = 1,
        },
        {
            id = "itzcuauhtli_boots_standard_non_fifth_sun",
            name = ccb.content.plural_text("black leather boots", "black leather boots"),
            description = ccb.content.text("Simple black leather boots."),
            weight = 1,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}
