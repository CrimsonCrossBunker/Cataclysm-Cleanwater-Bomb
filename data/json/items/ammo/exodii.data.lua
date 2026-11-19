local ccb = require("ccb")

ccb.content.define_item {
    id = "123ln",
    copy_from = "3006",
    name = ccb.content.plural_text("12.3ln", "12.3ln"),
    description = ccb.content.text("In some alternate universe, the 12.3ln cartridge was introduced in Romania in the wake of the second Carpathian conflict.  The PA md. 71 rifle, using this ammunition, rapidly gained popularity in the Eastern Union, and from there, the world.  Due to this, the 12.3ln rapidly became the standard combat round in the Eurasian sphere, making it easy for the Exodii to stockpile it in large quantities when they visited that version of Earth.  It looks vaguely like a rimless, .303 British cartridge loaded with a larger, non-spitzer bullet."),
    inheritance = { offset = { damage = { type = "bullet", amount = -3 } } },
    ammunition = { type = "123ln", casing = "123ln_casing" },
}

ccb.content.define_item {
    id = "reloaded_123ln",
    copy_from = "123ln",
    name = ccb.content.plural_text("12.3ln, reloaded", "12.3ln, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_123ln",
    copy_from = "123ln",
    name = ccb.content.plural_text("12.3ln, black powder", "12.3ln, black powder"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "123ln_ap",
    copy_from = "3006fmj",
    name = ccb.content.plural_text("12.3ln AP", "12.3ln AP"),
    description = ccb.content.text("In some alternate universe, the 12.3ln cartridge was introduced in Romania in the wake of the second Carpathian conflict.  This is the armor piercing variant, and it is the ammo that is preferred by exodii snipers or individuals using the PS md. 71z."),
    inheritance = { offset = { damage = { type = "bullet", amount = -4 } } },
    ammunition = { type = "123ln", casing = "123ln_casing" },
}

ccb.content.define_item {
    id = "reloaded_123ln_ap",
    copy_from = "123ln_ap",
    name = ccb.content.plural_text("12.3ln AP, reloaded", "12.3ln AP, reloaded"),
    inheritance = {
        add = { projectile_effects = { "RECYCLED" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = { price = 0.7, dispersion = 1.1, damage = { type = "bullet", amount = 0.9 } },
    },
    ammunition = {},
}

ccb.content.define_item {
    id = "bp_123ln_ap",
    copy_from = "123ln_ap",
    name = ccb.content.plural_text("12.3ln AP, black powder", "12.3ln AP, black powder"),
    mass = "27 g",
    inheritance = {
        add = { projectile_effects = { "RECYCLED", "BLACKPOWDER", "MUZZLE_SMOKE" } },
        remove = { flags = { "IRREPLACEABLE_CONSUMABLE" } },
        scale = {
            price = 0.3,
            recoil = 0.76,
            dispersion = 1.2,
            damage = { type = "bullet", amount = 0.76, penetration = 0.5 },
        },
    },
    ammunition = {},
}

-- NO_I18N
ccb.content.define_item {
    id = "273x110abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("base Exodii shotshell"),
    mass = "226 g",
    volume = "284 ml",
    length = "119 mm",
    price = "60 USD",
    survival_price = "27 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 4,
    ammunition = {
        count = 4,
        type = "273x110",
        casing = "273x110casing",
        range = 13,
        damage = { type = "bullet", amount = 95, penetration = 24 },
        recoil = 34279,
        effects = { "COOKOFF" },
    },
}

-- 1303 fps, 1750gr, rngmax:1829yds
ccb.content.define_item {
    id = "273x110sluglight",
    copy_from = "273x110abstract",
    name = ccb.content.text("27.3x110 Diyua light slug"),
    description = ccb.content.text("27.3x110 Diyua light slug loads were employed by colonists on some alternate Earth to take dangerous game, and later, fend off commonwealth forces from atop palisade walls."),
    ammunition = { dispersion = 25, effects = { "COOKOFF" } },
}

-- 1903 fps, 1750gr, rngmax:1943yds
ccb.content.define_item {
    id = "273x110slugmedium",
    copy_from = "273x110abstract",
    name = ccb.content.text("27.3x110 Diyua medium slug"),
    description = ccb.content.text("27.3x110 Diyua medium slug loads were employed by colonists on some alternate Earth to take extremely dangerous game, and later, fend off commonwealth forces from atop palisade walls.  Most users of the Brogyaga guns considered these shells too punishing to withstand."),
    inheritance = { scale = { price = 1.1 } },
    ammunition = {
        dispersion = 25,
        range = 14,
        recoil = 47319,
        damage = { type = "bullet", amount = 138, penetration = 26 },
        effects = { "COOKOFF" },
    },
}

-- 2624 fps, 2000gr, rngmax:2049yds
ccb.content.define_item {
    id = "273x110slugheavy",
    copy_from = "273x110abstract",
    name = ccb.content.text("27.3x110 Diyua heavy slug"),
    description = ccb.content.text("27.3x110 Diyua slug loads similar to these were employed by colonists on some alternate Earth to take extremely dangerous game.  This heavy slug load, however, was used almost entirely by recoil enthusiasts and braggarts, until the Exodii came upon them."),
    inheritance = { scale = { price = 1.3 } },
    ammunition = {
        range = 15,
        recoil = 61664,
        damage = { type = "bullet", amount = 204, penetration = 28 },
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "273x110flock",
    copy_from = "273x110abstract",
    name = ccb.content.plural_text("27.3x110 Diyua flockshot", "27.3x110 Diyua flockshot"),
    description = ccb.content.text("On some alien Earth, scores of flocks were decimated by loads such as this 27.3x110 Diyua shell, loaded with a ludicrous number of tiny pellets.  Though it would still be devastating against more humanoid targets, flockshot like this is more typically employed by the Exodii by the occasional hunting party."),
    inheritance = { scale = { price = 0.5, range = 0.83 } },
    ammunition = {
        projectile_count = 24155,
        shot_spread = 36000,
        shot_damage = { type = "bullet", amount = 1 },
        damage = { type = "bullet", amount = 93 },
        effects = { "SHOT", "NOGIB", "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "273x110canister",
    copy_from = "273x110abstract",
    name = ccb.content.text("27.3x110 Diyua canister"),
    description = ccb.content.text("On some alien Earth, these mini-canister loads mimicked much larger artillery shot, and were employed for anti-personnel usage against advancing waves from atop a palisade.  The Exodii would load these in their Brogyeki sidearms for backup usage."),
    inheritance = { scale = { range = 0.95 } },
    ammunition = {
        projectile_count = 27,
        shot_spread = 350,
        shot_damage = { type = "bullet", amount = 20 },
        effects = { "SHOT", "COOKOFF" },
    },
}

-- NO_I18N
ccb.content.define_item {
    id = "273x44abstract",
    abstract = true,
    name = ccb.content.text_without_extraction("base Exodii grenade"),
    mass = "195 g",
    volume = "176 ml",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 4,
    ammunition = {
        count = 4,
        type = "273x44",
        casing = "273x44casing",
        dispersion = 30,
        range = 30,
        damage = { type = "bullet", amount = 16 },
    },
}

ccb.content.define_item {
    id = "273x44flare",
    copy_from = "273x44abstract",
    name = ccb.content.plural_text("27.3x44 Diyua star", "27.3x44 Diyua star"),
    description = ccb.content.text("These flare cartridges are for use in 27.3x44 Diyua guns, or perhaps in 27.3x110 Diyua guns.  They are employed by the Exodii for emergency signaling when their usual communications systems are suffering interference, breakdown, or are being jammed."),
    price = "18 USD",
    survival_price = "15 USD",
    ammunition = {
        range = 30,
        dispersion = 200,
        recoil = 100,
        drop = "sigflare_lit",
        damage = { type = "bullet", amount = 16 },
        effects = { "NO_EMBED" },
    },
}

-- 690 fps, 1404gr, rngmax:2598yd.  Wurfgranate P326 at XM25 velocities.
ccb.content.define_item {
    id = "273x44trainer",
    copy_from = "273x44abstract",
    name = ccb.content.plural_text("27.3x44 Diyua practice", "27.3x44 Diyua practice"),
    description = ccb.content.text("A 27.3x44 Diyua cartridge loaded with a large hollow aluminum projectile, painted blue at the tip, for practicing shooting.  If interdimensional total replacement cyborgs have to practice, maybe you should too."),
    price = "24 USD",
    survival_price = "18 USD",
    ammunition = {
        range = 29,
        recoil = 2800,
        damage = { type = "bullet", amount = 45 },
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "273x44thermobaric",
    copy_from = "273x44trainer",
    name = ccb.content.plural_text("27.3x44 Diyua thermobaric", "27.3x44 Diyua thermobaric"),
    description = ccb.content.text("A 27.3x44 Diyua cartridge with a minute amount of liquid fuel encasing a fuel dispersing explosive charge, and a secondary ignition charge.  On impact the fuel is dispersed, creating a fuel air mixture which is ignited a few milliseconds later.  In a cartridge like 27.3x44 Diyua, the pressure wave produced is rather diminutive, yet it makes the most of what little payload is available."),
    price = "66 USD",
    survival_price = "40 USD",
    ammunition = {
        damage = { type = "bullet", amount = 15 },
        effects = { "COOKOFF", "EXPLOSIVE_EXODII_THERMOBARIC", "LARGE_BEANBAG" },
    },
}

ccb.content.define_item {
    id = "273x44HE",
    copy_from = "273x44trainer",
    name = ccb.content.plural_text("27.3x44 Diyua high explosive", "27.3x44 Diyua high explosive"),
    description = ccb.content.text("A 27.3x44 Diyua cartridge loaded with a high explosive charge and a point-detonating fuze.  Primarily useful for assaulting soft targets, and, in their universe of origin, dispersing crowds."),
    price = "60 USD",
    survival_price = "36 USD",
    ammunition = { damage = { type = "bullet", amount = 15 }, effects = { "COOKOFF", "FRAG_20x66" } },
}

ccb.content.define_item {
    id = "273x44RG",
    mass = "870 g",
    volume = "372 ml",
    length = "259 mm",
    price = "60 USD",
    survival_price = "36 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "lead", "powder" },
    symbol = "=",
    color = "yellow",
    stack_size = 1,
    name = ccb.content.plural_text("66/27.3x278 Diyua multipurpose", "66/27.3x278 Diyua multipurpose"),
    description = ccb.content.text("A long 27.3 Diyua cartridge loaded with a propelling charge, attached to a large high explosive shaped charge grenade several times larger in diameter.  It was designed to be muzzle loaded into 27.3x44 Diyua guns.  Though the grenade's penetration and fragmentation were ultimately deemed insufficient, this was of no matter to the Exodii who saw value in the explosive potential the grenade added to the Brogyeki '23."),
    ammunition = {
        count = 1,
        type = "273x44RG",
        casing = "273x44casing",
        range = 9,
        dispersion = 30,
        recoil = 22250,
        damage = { type = "bullet", amount = 220, penetration = 35 },
        effects = { "COOKOFF", "EXPLOSIVE_m433" },
    },
}

ccb.content.define_item {
    id = "caotel_cell",
    copy_from = "3006",
    name = ccb.content.text("Caotel cell"),
    description = ccb.content.text("This is a small metallic cube of inscrutable construction.  A single groove etched into one side of the object presumably allows it to be mounted into other things, and a small red arrow has been helpfully painted besides it."),
    survival_price = "12 USD",
    materials = { "qt_steel" },
    mass = "24 g",
    volume = "190 ml",
    ammunition = { count = 12, type = "caotel_cell", range = 0, casing = "caotel_cell_spent" },
}

ccb.content.define_item {
    id = "khuunaofaai_ammo_firework",
    name = ccb.content.text("Khuunäöfaai firework payload"),
    description = ccb.content.text("Pressurized chemical payload for the Khuunäöfaai.  Highly reactive to oxygen, removing it from the tank would be a bad idea."),
    survival_price = "1 USD",
    color = "green",
    symbol = "=",
    mass = "4 g",
    volume = "125 ml",
    flags = { "NO_DROP" },
    ammunition = {
        range = 100,
        type = "khuunaofaai_payload",
        effects = { "NON_FOULING", "TRAIL", "FLASHBANG", "SMOKE_BIG", "EXPLOSIVE_EXODII_FIREWORK" },
        damage = { type = "bullet", amount = 40, penetration = 4 },
        recoil = 10,
        dispersion = 20,
    },
}

ccb.content.define_item {
    id = "khuunaofaai_ammo_incendiary",
    name = ccb.content.text("Khuunäöfaai incendiary payload"),
    description = ccb.content.text("Pressurized chemical payload for the Khuunäöfaai.  Highly flammable and reactive to oxygen, removing it from the tank would be a bad idea."),
    survival_price = "10 USD 80 cent",
    color = "green",
    symbol = "=",
    mass = "12 g",
    volume = "125 ml",
    flags = { "NO_DROP" },
    ammunition = {
        range = 88,
        type = "khuunaofaai_payload_fire",
        effects = { "NON_FOULING", "TRAIL", "PYROPHORIC" },
        damage = { type = "bullet", amount = 44, penetration = 4 },
        recoil = 10,
        dispersion = 20,
    },
}

ccb.content.define_item {
    id = "khuunaofaai_ammo_corrosive",
    name = ccb.content.text("Khuunäöfaai corrosive payload"),
    description = ccb.content.text("Pressurized chemical payload for the Khuunäöfaai.  Essentially a juiced up version of pirahna solution, removing it from the tank would be a bad idea."),
    copy_from = "khuunaofaai_ammo_firework",
    mass = "6 g",
    survival_price = "8 USD 66 cent",
    ammunition = {
        range = 100,
        type = "khuunaofaai_payload_acid",
        effects = { "NON_FOULING", "CORROSIVE" },
        damage = { type = "acid", amount = 30, penetration = 4 },
    },
}

ccb.content.define_item {
    id = "khuunaofaai_ammo_foam",
    name = ccb.content.text("Khuunäöfaai foaming payload"),
    description = ccb.content.text("Pressurized chemical payload for the Khuunäöfaai.  An incredibly powerful binding agent and sealant, removing it from the tank would be a bad idea."),
    copy_from = "khuunaofaai_ammo_firework",
    mass = "8 g",
    survival_price = "5 USD 10 cent",
    ammunition = {
        range = 100,
        type = "khuunaofaai_payload_glue",
        effects = { "NON_FOULING", "GLUE_FOAM" },
        damage = { type = "bullet", amount = 10, penetration = 4 },
    },
}

-- secretly just 23x152mm; 236 x 33 mm of size
-- it has 90 kj of muzzle energy, but i just scaled .50 bmg stats.  TODO
ccb.content.define_item {
    id = "33naval_ball",
    name = ccb.content.plural_text("3.3 naval FMJ", "3.3 naval FMJ"),
    description = ccb.content.text("Initially made for marine combat, this hefty projectile is a go-to round for late-stage Exodii fights."),
    mass = "450 g",
    volume = "201 ml",
    length = "236 mm",
    price = "22 USD",
    survival_price = "25 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "steel", "brass", "lead", "powder" },
    symbol = "=",
    color = "dark_gray",
    stack_size = 1,
    ammunition = {
        count = 1,
        type = "33naval",
        casing = "33_naval_casing",
        range = 150,
        damage = { type = "bullet", amount = 589, penetration = 126 },
        dispersion = 150,
        recoil = 88917,
        effects = { "COOKOFF", "EXCESS_PEN" },
    },
}
