local ccb = require("ccb")

ccb.content.define_item {
    id = "simple_pistol_cartridge_necklace",
    name = "handgun-cartridge necklace",
    description = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.",
    symbol = "[",
    color = "yellow",
    looks_like = "gold_necklace",
    mass = "24 g",
    volume = "38 ml",
    length = "28 mm",
    price = "5 USD",
    survival_price = "0 cent",
    snippet_category = {
        {
            id = "pistol_pendent1",
            text = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.  The shell's neck has been daintily drilled through with two tiny holes on opposite sides, through which the cord has been fed and tied off to form a poor man's excuse for a chain, and from where the cartridge hangs, dimpled primer-down.",
        },
        {
            id = "pistol_pendent2",
            text = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.  The dimpled section of the shell's primer has been punched out, and a second hole has been drilled through the casing's side just shy of the base, with the ballistic accoutrement hanging from a section of tied-off cord that has been threaded through both entry points.",
        },
        {
            id = "pistol_pendent3",
            text = "A simple, if rather crude, piece of post-Cataclysm jewelry: a solitary bullet casing from a handgun cartridge or other such form of ammunition strung upon a length of string, cord, or twine to form a makeshift pendant.  The shell's throat has been twisted closed by a set of pliers, creating a spiraled taper where the neck would be, while a hole has been drilled on opposite hemispheres of the pendant's sides, through which a length of string has been threaded.  The cord's loose ends have been wrapped several times around the casing before being tied off, forming a sort of little bullet cocoon.",
        },
    },
    flags = { "NO_WEAR_EFFECT", "BELTED" },
    materials = {
        { id = "brass", portions = 2 },
        { id = "cotton" },
    },
    conditional_names = {
        { kind = "COMPONENT_ID", key = "22_casing", name = "light rifle-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "38_casing", name = "revolver-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "57mm_casing", name = "automatic-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "45colt_casing", name = "revolver-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "357mag_casing", name = "magnum-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "44_casing", name = "magnum-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "454_casing", name = "revolver-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "500_casing", name = "magnum-cartridge necklace" },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_neck" },
                coverage = 20,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "simple_rifle_cartridge_necklace",
    copy_from = "simple_pistol_cartridge_necklace",
    name = "rifle-cartridge necklace",
    description = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.",
    mass = "25 g",
    volume = "40 ml",
    length = "50 mm",
    snippet_category = {
        {
            id = "rifle_pendent1",
            text = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.  The cartridge's neck has been carefully drilled through, leaving behind a tiny hole on either side of the shell's throat through which the cord has been fed and tied off, forming a pedestrian facsimile of a chain from where the round hangs, primer-down.",
        },
        {
            id = "rifle_pendent2",
            text = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.  The primer's indented portion has been drilled away, with a second hole situated in the casing's side just shy of the base and a length of tied-off cordage looping through both entry points to form a makeshift chain for the apparel.",
        },
        {
            id = "rifle_pendent3",
            text = "Rather crude and clearly put together on a budget, this is a piece of post-Cataclysmic—so-called—jewelry—little more than an unpolished, solitary rifle casing threaded on a length of cord, string, or twine to form a pendent necklace.  The jaws of a set of pliers have twisted closed the cartridge's throat with a spiral flourish, while a hole has been drilled through opposite sides of the pendant's shoulder, through which a loop of cord has been threaded.  The string's loose ends have been wrapped several times around the casing in a vague X-pattern before being tied off, creating a form of mini-bullet cocoon.",
        },
    },
    conditional_names = {
        { kind = "COMPONENT_ID", key = "4570_casing", name = "brush gun-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "30carbine_casing", name = "carbine-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "123ln_casing", name = "alien-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "450_casing", name = "Thumper-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "50beowulf_casing", name = "Thumper-cartridge necklace" },
    },
    armor = {},
}

ccb.content.define_item {
    id = "simple_ordnance_cartridge_necklace",
    copy_from = "simple_pistol_cartridge_necklace",
    name = "ordnance-cartridge necklace",
    description = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.",
    mass = "37 g",
    volume = "43 ml",
    length = "85 mm",
    snippet_category = {
        {
            id = "ordinance_pendent1",
            text = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.  The shell's neck has been carefully tapped, leaving a hole on either side of the casing's throat through which the makeshift neck chain has been fed and tied off.",
        },
        {
            id = "ordinance_pendent2",
            text = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.  The center of the shell's struck primer has been punched out, and a second hole has been drilled shy of the rim, with a section of tied-off cordage stringing through both entry points to form a makeshift neck chain.",
        },
        {
            id = "ordinance_pendent3",
            text = "An expedient means of flaunting one's gunnery prowess, or a crude attempt at overcompensating for matters best left undescribed, this article of craft-produced jewelry is, essentially, one part cordage and three parts mammoth bullet casing: the giant cartridge, either from a grenade round or some other form of heavy munitions, strung to hang upon the chest as a pendent.  The jaws of a set of pliers have been laid to work, with the shell's neck twisted closed in a tapered spiral, while a hole has been bored through opposite sides of the cartridge's base, through which a loop of cord has been tugged.  The string's loose ends have been wrapped around the casing in a serpentine pattern before being tied off, creating a manner of bullet cocoon.",
        },
    },
    materials = {
        { id = "brass", portions = 3 },
        { id = "cotton" },
    },
    conditional_names = {
        { kind = "COMPONENT_ID", key = "40x46mm_m212_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "40x46mm_m118_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "40x46mm_m199_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "40x46mm_m195_casing", name = "grenade-cartridge necklace" },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_22lr_casing",
            name = "grenade-cartridge necklace",
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_410_casing",
            name = "grenade-cartridge necklace",
        },
        { kind = "COMPONENT_ID", key = "40x53mm_m169_casing", name = "grenade-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "shot_hull", name = "shotgun-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "410shot_hull", name = "shotgun-cartridge necklace" },
        { kind = "COMPONENT_ID", key = "273x110casing", name = "alien-ordnance necklace" },
        { kind = "COMPONENT_ID", key = "273x44casing", name = "alien-ordnance necklace" },
    },
    armor = {},
}

ccb.content.define_item {
    id = "fancy_pistol_cartridge_necklace",
    name = "refined pistol-cartridge necklace",
    description = "The product of a gun nut and a fashionista proverbially shaking one another's hand, this plain, though elegant, necklace has been strung with a solitary, sparklingly polished casing from a handgun cartridge or other such form of ammunition.",
    symbol = "[",
    color = "yellow",
    looks_like = "gold_necklace",
    mass = "56 g",
    volume = "32 ml",
    length = "28 mm",
    price = "400 USD",
    survival_price = "50 cent",
    snippet_category = {
        {
            id = "fancy_pistol_pendent1",
            text = "The product of a gun nut and a fashionista proverbially shaking one another's hand, this plain, though elegant, necklace has been strung with a solitary, sparklingly polished casing from a handgun cartridge or other such form of ammunition.  The shell's primer and rim have been neatly sawed away, and in place of the projectile, a little gemstone has been wrapped with a length of fine-gauge wire and bedded into the casing's throat.  The rest of the wire's length trails back through the cartridge's body, feeding out the base and entwining with a link in the chain.",
        },
        {
            id = "fancy_pistol_pendent2",
            text = "The product of a gun nut and a fashionista proverbially shaking one another's hand, this plain, though elegant, necklace has been strung with a solitary, sparklingly polished casing from a handgun cartridge or other such form of ammunition.  The teeth of a saw have been put to work upon this shell, whose base and primer have been neatly cut away, and in the throat of which has been seated a small, shining gem.  A length of fine wire has been tightly wrapped around both the cartridge and gemstone in a top-down pattern, with the cord's loose ends eventually tugged through a small drill hole at the cartridge's base and finally wrapped among the neck chain's links.",
        },
    },
    flags = { "NO_WEAR_EFFECT", "BELTED" },
    materials = {
        { id = "brass", portions = 2 },
        { id = "gold", portions = 2 },
        { id = "gemstone" },
    },
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "22_casing",
            name = ccb.content.plural_text("Varmints' Bane", "Varmints' Bane"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "32_casing",
            name = ccb.content.plural_text("Short King", "Short King"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "38_casing",
            name = ccb.content.plural_text("Lawman's", "Lawman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "38super_casing",
            name = ccb.content.plural_text("Contestant's", "Contestant's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "40_casing",
            name = ccb.content.plural_text("Federal", "Federal"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "10mm_casing",
            name = ccb.content.plural_text("Crockett's Vice", "Crockett's Vice"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "44_casing",
            name = ccb.content.plural_text("Holliday's", "Holliday's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "357mag_casing",
            name = ccb.content.plural_text("Big Iron", "Big Iron"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "45colt_casing",
            name = ccb.content.plural_text("Peacemaker's", "Peacemaker's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "454_casing",
            name = ccb.content.plural_text("Judge's Wrath", "Judge's Wrath"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "460sw_casing",
            name = ccb.content.plural_text("Hyper Velocity", "Hyper Velocity"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "45_casing",
            name = ccb.content.plural_text("God's Caliber", "God's Caliber"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "57mm_casing",
            name = ccb.content.plural_text("Needle Rain", "Needle Rain"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "500_casing",
            name = ccb.content.plural_text("Recoil-Rider", "Recoil-Rider"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762_25_casing",
            name = ccb.content.plural_text("Revolutionary's", "Revolutionary's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "9mm_casing",
            name = ccb.content.plural_text("Sunrise Parabellum", "Sunrise Parabellum"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "357sig_casing",
            name = ccb.content.plural_text("Schweitzer", "Schweitzer"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "9x18mm_casing",
            name = ccb.content.plural_text("Semin", "Semin"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "380_casing",
            name = ccb.content.plural_text("Baby Browning", "Baby Browning"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "50ae_casing",
            name = ccb.content.plural_text("Fatman", "Fatman"),
        },
        { kind = "COMPONENT_ID", key = "diamond", name = "%s diamond necklace" },
        { kind = "COMPONENT_ID", key = "garnet", name = "%s garnet necklace" },
        { kind = "COMPONENT_ID", key = "amethyst", name = "%s amethyst necklace" },
        { kind = "COMPONENT_ID", key = "aquamarine", name = "%s aquamarine" },
        { kind = "COMPONENT_ID", key = "emerald", name = "%s emerald necklace" },
        { kind = "COMPONENT_ID", key = "alexandrite", name = "%s alexandrite necklace" },
        { kind = "COMPONENT_ID", key = "malachite", name = "%s malachite necklace" },
        { kind = "COMPONENT_ID", key = "pearl", name = "%s pearl necklace" },
        { kind = "COMPONENT_ID", key = "ruby", name = "%s ruby necklace" },
        { kind = "COMPONENT_ID", key = "peridot", name = "%s peridot necklace" },
        { kind = "COMPONENT_ID", key = "sapphire", name = "%s sapphire necklace" },
        { kind = "COMPONENT_ID", key = "opal", name = "%s opal necklace" },
        { kind = "COMPONENT_ID", key = "tourmaline", name = "%s tourmaline necklace" },
        { kind = "COMPONENT_ID", key = "citrine", name = "%s citrine necklace" },
        { kind = "COMPONENT_ID", key = "blue_topaz", name = "%s topaz necklace" },
        { kind = "COMPONENT_ID", key = "onyx", name = "%s onyx necklace" },
    },
    armor = {
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_neck" },
                coverage = 20,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "fancy_rifle_cartridge_necklace",
    copy_from = "fancy_pistol_cartridge_necklace",
    name = "refined rifle-cartridge necklace",
    description = "A gentlemanly article of craft-produced jewelry for the most spiffy ladies and gentlemen of the post-apocalypse, this plain chain of precious metal has been retrofitted with a fired rifle cartridge that hangs from it as a pendant.",
    mass = "57 g",
    volume = "35 ml",
    length = "50 mm",
    snippet_category = {
        {
            id = "fancy_rifle_pendent1",
            text = "A gentlemanly article of craft-produced jewelry for the most spiffy ladies and gentlemen of the post-apocalypse, this plain chain of precious metal has been retrofitted with a fired rifle cartridge that hangs from it as a pendant.  With its brass polished to a mirror-like sheen, the shell's primer and rim have been neatly extricated at the edge of a saw, with a little gemstone peeking out the casing's throat.  The gem's wrapped within the embrace of a length of fine-gauge wire, whose remaining length has been tugged back through the cartridge's body, fed out the base, and entwined with a link in the chain.",
        },
        {
            id = "fancy_rifle_pendent2",
            text = "A gentlemanly article of craft-produced jewelry for the most spiffy ladies and gentlemen of the post-apocalypse, this plain chain of precious metal has been retrofitted with a fired rifle cartridge that hangs from it as a pendant.  With its brass polished to a mirror-like sheen, the shell has grown shorter by virtue of its base having been sawed away, and a glittering jewel has been seated comfortably within the throat.  A length of wire is tightly wrapped around both cartridge and gemstone in a top-down pattern, forming an X-grid as it wines, with the cord's loose ends trailing through a small drill hole at the cartridge's base and tied to the chain's links.",
        },
    },
    conditional_names = {
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "77arisaka_casing",
            name = ccb.content.plural_text("Rising Sun", "Rising Sun"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "545_casing",
            name = ccb.content.plural_text("Devil's Poison", "Devil's Poison"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "4570_casing",
            name = ccb.content.plural_text("Frontiersman's", "Frontiersman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "270win_casing",
            name = ccb.content.plural_text("Sportsman's", "Sportsman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "303_casing",
            name = ccb.content.plural_text("Fusilier's", "Fusilier's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "223_casing",
            name = ccb.content.plural_text("US Diplomacy", "US Diplomacy"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "3006_casing",
            name = ccb.content.plural_text("Old Soldier", "Old Soldier"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762_51_casing",
            name = ccb.content.plural_text("Pig's Feed", "Pig's Feed"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "300blk_casing",
            name = ccb.content.plural_text("Cloak&Dagger", "Cloak&Dagger"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762R_casing",
            name = ccb.content.plural_text("White Death", "White Death"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "762_casing",
            name = ccb.content.plural_text("Iron Curtain", "Iron Curtain"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "300_casing",
            name = ccb.content.plural_text("Kyle's Laser", "Kyle's Laser"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "50beowulf_casing",
            name = ccb.content.plural_text("Wolf's Voice", "Wolf's Voice"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "450_casing",
            name = ccb.content.plural_text("Cooper's Touch", "Cooper's Touch"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "30carbine_casing",
            name = ccb.content.plural_text("Paratrooper's", "Paratrooper's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "308_casing",
            name = ccb.content.plural_text("Marksman's", "Marksman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "123ln_casing",
            name = ccb.content.plural_text("Illegal Alien", "Illegal Alien"),
        },
        { kind = "COMPONENT_ID", key = "diamond", name = "%s diamond necklace" },
        { kind = "COMPONENT_ID", key = "garnet", name = "%s garnet necklace" },
        { kind = "COMPONENT_ID", key = "amethyst", name = "%s amethyst necklace" },
        { kind = "COMPONENT_ID", key = "aquamarine", name = "%s aquamarine" },
        { kind = "COMPONENT_ID", key = "emerald", name = "%s emerald necklace" },
        { kind = "COMPONENT_ID", key = "alexandrite", name = "%s alexandrite necklace" },
        { kind = "COMPONENT_ID", key = "malachite", name = "%s malachite necklace" },
        { kind = "COMPONENT_ID", key = "pearl", name = "%s pearl necklace" },
        { kind = "COMPONENT_ID", key = "ruby", name = "%s ruby necklace" },
        { kind = "COMPONENT_ID", key = "peridot", name = "%s peridot necklace" },
        { kind = "COMPONENT_ID", key = "sapphire", name = "%s sapphire necklace" },
        { kind = "COMPONENT_ID", key = "opal", name = "%s opal necklace" },
        { kind = "COMPONENT_ID", key = "tourmaline", name = "%s tourmaline necklace" },
        { kind = "COMPONENT_ID", key = "citrine", name = "%s citrine necklace" },
        { kind = "COMPONENT_ID", key = "blue_topaz", name = "%s topaz necklace" },
        { kind = "COMPONENT_ID", key = "onyx", name = "%s onyx necklace" },
    },
    armor = {},
}

ccb.content.define_item {
    id = "fancy_ordinance_cartridge_necklace",
    copy_from = "fancy_pistol_cartridge_necklace",
    name = "refined ordnance-cartridge necklace",
    description = "An article of hand-produced apparel that George Washington himself could look down upon with an approving smile, the daintiness of this necklace's precious metal chain looks rather comical when compared against the gargantuan pendant that hangs from it: an expended casing from a grenade round, shotgun cartridge, or some other form of sizable munition.",
    mass = "69 g",
    volume = "38 ml",
    length = "85 mm",
    snippet_category = {
        {
            id = "fancy_ordinance_pendent1",
            text = "An article of hand-produced apparel that George Washington himself could look down upon with an approving smile, the daintiness of this necklace's precious metal chain looks rather comical when compared against the gargantuan pendant that hangs from it: an expended casing from a grenade round, shotgun cartridge, or some other form of sizable munition.  With its brass polished to a mirror-like sheen and its rim cleanly extricated by the saw, a well-sized gemstone peers at the world from out of this shell's throat.  The jewel's wrapped within a length of fine-gauge wire, whose remaining length has been tugged through the cartridge's body, fed out the base, and entwined with a link in the chain.",
        },
        {
            id = "fancy_ordinance_pendent2",
            text = "An article of hand-produced apparel that George Washington himself could look down upon with an approving smile, the daintiness of this necklace's precious metal chain looks rather comical when compared against the gargantuan pendant that hangs from it: an expended casing from a grenade round, shotgun cartridge, or some other form of sizable munition.  The shell has, essentially, been rendered into a tiny brass pipe: its base and primer are neatly sawed off, and its head is capped by a large, glittering gemstone that regards the Cataclysm from its seat within the throat.  A length of wire is tightly wrapped around both the cartridge and jewel, with the cord's loose ends trailing through a small drill hole at the shell's base and linked to the neck chain.",
        },
    },
    materials = {
        { id = "brass", portions = 3 },
        { id = "gold", portions = 2 },
        { id = "gemstone" },
    },
    conditional_names = {
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m118_casing",
            name = ccb.content.plural_text("Grenadier's", "Grenadier's"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m199_casing",
            name = ccb.content.plural_text("God's Boomstick", "God's Boomstick"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m195_casing",
            name = ccb.content.plural_text("Tearjerker", "Tearjerker"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_m212_casing",
            name = ccb.content.plural_text("Gentle Persuasion", "Gentle Persuasion"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_22lr_casing",
            name = ccb.content.plural_text("Beehive", "Beehive"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x46mm_hornets_nest_410_casing",
            name = ccb.content.plural_text("Metal Storm", "Metal Storm"),
        },
        {
            kind = "COMPONENT_ID",
            key = "40x53mm_m169_casing",
            name = ccb.content.plural_text("Meatgrinder", "Meatgrinder"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "50_casing",
            name = ccb.content.plural_text("Ma Deuce", "Ma Deuce"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "338lapua_casing",
            name = ccb.content.plural_text("Suomi Princess", "Suomi Princess"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "458wm_casing",
            name = ccb.content.plural_text("Huntsman's", "Huntsman's"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "shot_hull",
            name = ccb.content.plural_text("Street Howitzer", "Street Howitzer"),
        },
        {
            kind = "COMPONENT_ID_SUBSTRING",
            key = "410shot_hull",
            name = ccb.content.plural_text("Lancaster's Boar", "Lancaster's Boar"),
        },
        {
            kind = "COMPONENT_ID",
            key = "273x110casing",
            name = ccb.content.plural_text("Shock&Awe", "Shock&Awe"),
        },
        {
            kind = "COMPONENT_ID",
            key = "273x44casing",
            name = ccb.content.plural_text("Diyua Comet", "Diyua Comet"),
        },
        { kind = "COMPONENT_ID", key = "diamond", name = "%s diamond necklace" },
        { kind = "COMPONENT_ID", key = "garnet", name = "%s garnet necklace" },
        { kind = "COMPONENT_ID", key = "amethyst", name = "%s amethyst necklace" },
        { kind = "COMPONENT_ID", key = "aquamarine", name = "%s aquamarine" },
        { kind = "COMPONENT_ID", key = "emerald", name = "%s emerald necklace" },
        { kind = "COMPONENT_ID", key = "alexandrite", name = "%s alexandrite necklace" },
        { kind = "COMPONENT_ID", key = "malachite", name = "%s malachite necklace" },
        { kind = "COMPONENT_ID", key = "pearl", name = "%s pearl necklace" },
        { kind = "COMPONENT_ID", key = "ruby", name = "%s ruby necklace" },
        { kind = "COMPONENT_ID", key = "peridot", name = "%s peridot necklace" },
        { kind = "COMPONENT_ID", key = "sapphire", name = "%s sapphire necklace" },
        { kind = "COMPONENT_ID", key = "opal", name = "%s opal necklace" },
        { kind = "COMPONENT_ID", key = "tourmaline", name = "%s tourmaline necklace" },
        { kind = "COMPONENT_ID", key = "citrine", name = "%s citrine necklace" },
        { kind = "COMPONENT_ID", key = "blue_topaz", name = "%s topaz necklace" },
        { kind = "COMPONENT_ID", key = "onyx", name = "%s onyx necklace" },
    },
    armor = {},
}
