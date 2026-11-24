local ccb = require("ccb")

-- Pretty much the same as the other, but now with a cool touchscreen that casts mirror image and does some minor things
-- Spellcasting aids like these should have some unique faults that could render them unusable as spellcasting aids.
ccb.content.define_item {
    id = "rune_technomancer_weapon_adept",
    looks_like = "halligan",
    name = ccb.content.plural_text("Technomancer mana-toolbar", "Technomancer mana-toolbars"),
    description = ccb.content.text("This staff incorporates a sturdy crescent wrench on top of a prybar and a hammer on the other in a convenient package.  There are electronic components in the staff connected to a touchscreen embedded in the staff, you only had time to cram one spell in the prototype software.  There is a Technomancer rune embedded in the hammerhead."),
    mass = "1000 g",
    volume = "550 ml",
    length = "65 cm",
    price = "50 USD",
    materials = { "steel" },
    symbol = "/",
    color = "light_gray",
    techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
    qualities = {
        { id = "PRY", level = 3 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
        { id = "WRENCH", level = 2 },
        { id = "WRENCH_FINE", level = 2 },
        { id = "PRYING_NAIL", level = 1 },
    },
    accuracy = { grip = "solid", length = "short", surface = "any", balance = "uneven" },
    flags = {
        "DURABLE_MELEE", "BELT_CLIP", "TRADER_AVOID", "MAGIC_FOCUS", "SPELLCASTING_AID", "WATCH",
        "ALARMCLOCK", "NO_RELOAD", "NO_UNLOAD",
    },
    faults = { { group = "steel_pipe_short" } },
    weapon_categories = { "HOOKING_WEAPONRY" },
    pockets = { { kind = "MAGAZINE", holster = true, rigid = true, ammunition = { crystallized_mana = 3 } } },
    melee_damage = { bash = 27, cut = 1 },
    subtype_order = { "tool", "artifact" },
    tool = { charges_per_use = 1 },
    artifact = { charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true } },
    use_actions = {
        { kind = "native", id = "CROWBAR", ammo_scale = 0 },
        {
            kind = "cast_spell",
            spell = "mirror_image",
            no_fail = true,
            level = 10,
            need_wielding = true,
        },
    },
}

-- It will be based on the Q +2 weapon but slightly worse, slightly better than the magus staff, but its greatest strength will be its regen mana capabilities, better than magi staff minor but worse than the lesser one.
-- The description needs to be changed so that it is clear where the two glass jars are on the staff.
ccb.content.define_item {
    id = "rune_magus_weapon_adept",
    copy_from = "q_staff",
    name = ccb.content.plural_text("Magus battle staff", "Magus battle staves"),
    description = ccb.content.text("A quarterstaff with runes carved into it and two mana pearls at the tip, enchanted with mana for durability.  It fills you with an invigorating sensation.  There are two Magi runes carved into the wood."),
    mass = "1600 g",
    volume = "1550 ml",
    length = "185 cm",
    price = "150 USD",
    accuracy = 4,
    materials = { "wood", "diamond" },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
    flags = { "DURABLE_MELEE", "SHEATH_SPEAR", "TRADER_AVOID", "MAGIC_FOCUS", "SPELLCASTING_AID" },
    melee_damage = { bash = 34 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_rune_magus_weapon_adept_0" } },
}

-- Similar to the Magus staff, but not as useful as a melee weapon and with conditional mana regen.
ccb.content.define_item {
    id = "rune_druid_nature_staff",
    copy_from = "q_staff",
    name = ccb.content.plural_text("Druidic staff", "Druidic staves"),
    description = ccb.content.text("A staff looking more like a tree branch than a weapon, with runes carved into its full length and a few leaves still sprouting from the top.  It fills you with an invigorating sensation when out in the wilderness.  There are two Druid runes carved into the wood."),
    length = "185 cm",
    price = "50 USD",
    materials = { "wood" },
    symbol = "/",
    color = "green",
    techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
    flags = { "SHEATH_SPEAR", "TRADER_AVOID", "MAGIC_FOCUS" },
    melee_damage = { bash = 25 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_rune_druid_nature_staff_0" } },
}

-- There isn't an equivalent, so the damage has been multiplied by 1.2 to cutting and bashing
ccb.content.define_item {
    id = "rune_stormshaper_weapon_adept",
    name = ccb.content.plural_text("Stormshaper hammer-axe", "Stormshaper hammer-axes"),
    description = ccb.content.text("A forged copper hammer-axe with silver trimmings and a wooden handle.  There is a Stormshaper rune embedded in the eye and a Nordic rune reminiscent of Thor, the thunder god, in the hammer side."),
    mass = "3755 g",
    volume = "3500 ml",
    length = "90 cm",
    price = "558 USD",
    survival_price = "210 USD",
    accuracy = 0,
    materials = { "wood", "copper", "silver" },
    symbol = "/",
    color = "brown",
    techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
    weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES", "GREAT_HAMMERS" },
    qualities = { { id = "AXE", level = 1 }, { id = "BUTCHER", level = -20 }, { id = "HAMMER", level = 1 } },
    flags = {
        "DURABLE_MELEE", "NO_UNLOAD", "NO_RELOAD", "SHEATH_AXE", "TRADER_AVOID", "MAGIC_FOCUS",
        "SPELLCASTING_AID", "HYGROMETER", "BAROMETER",
    },
    faults = { { group = "handle_long", weight_multiplier = 4 }, { group = "blade_general_no_tip" } },
    pockets = { { kind = "MAGAZINE", holster = true, rigid = true, ammunition = { crystallized_mana = 3 } } },
    melee_damage = { bash = 40, cut = 27 },
    subtype_order = { "tool", "artifact" },
    tool = { charges_per_use = 1 },
    artifact = { charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "lightning_bolt",
            no_fail = true,
            level = 7,
            need_wielding = true,
        },
        "WEATHER_TOOL",
    },
}

-- Tool qualities equivalent to combat knife with some saw capability, to represent sharpness, combat equiv.  to combat knife + 2 w/ RAPID and BLOCK1 with no to hit, size/weight off combat knife +1
ccb.content.define_item {
    id = "rune_animist_weapon_adept",
    name = ccb.content.plural_text("Animist life-athame", "Animist life-athames"),
    description = ccb.content.text("A steel ritual knife used by Animists to draw blood for summoning.  The knife has seen so much bloodshed that the rune at the crossguard seemingly is constantly drenched in blood and gives you preternatural resistance to pain."),
    mass = "504 g",
    volume = "500 ml",
    length = "25 cm",
    price = "150 USD",
    materials = { "wood", "steel" },
    symbol = ";",
    color = "light_gray",
    techniques = { "WBLOCK_1", "RAPID" },
    weapon_categories = { "KNIVES" },
    qualities = {
        { id = "CUT", level = 1 },
        { id = "SAW_W", level = 1 },
        { id = "SAW_M", level = 1 },
        { id = "CUT_FINE", level = 1 },
        { id = "BUTCHER", level = 19 },
    },
    accuracy = { grip = "weapon", length = "hand", surface = "line", balance = "good" },
    flags = { "SHEATH_KNIFE", "MAGIC_FOCUS", "SPELLCASTING_AID", "TRADER_AVOID" },
    faults = { { group = "handle_short" }, { group = "blade_general", weight_multiplier = 5 } },
    melee_damage = { bash = 7, stab = 30 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_rune_animist_weapon_adept_0" } },
}

-- Pretty similar to the war scythe, but with less weight, more cutting damage and capable of casting a strong offensive spell.
ccb.content.define_item {
    id = "grim_reaper_scythe",
    looks_like = "scythe_toy",
    repair_like = "rune_animist_weapon_adept",
    name = ccb.content.plural_text("grim reaper's scythe", "grim reaper's scythes"),
    description = ccb.content.text("This is a long and crooked tool used to reap souls, with a skull engraved in its blade.  Magically treated to reduce weight and enhance sharpness, this enchanted weapon is even capable of delivering a strong rupture attack.  Let the harvest begin."),
    mass = "2750 g",
    volume = "3550 ml",
    length = "150 cm",
    price = "100 USD",
    accuracy = { grip = "weapon", length = "long", surface = "point", balance = "neutral" },
    materials = { "steel", "wood" },
    symbol = "/",
    color = "dark_gray",
    techniques = { "WBLOCK_1", "WIDE", "BRUTAL" },
    qualities = { { id = "CUT", level = 2 }, { id = "BUTCHER", level = 3 }, { id = "GRASS_CUT", level = 2 } },
    flags = {
        "NONCONDUCTIVE", "DURABLE_MELEE", "TRADER_AVOID", "MAGIC_FOCUS", "SPELLCASTING_AID", "POLEARM",
        "SHEATH_SPEAR", "REACH_ATTACK", "ALWAYS_TWOHAND", "NO_RELOAD", "NO_UNLOAD",
    },
    faults = { { group = "handle_long", weight_multiplier = 4 }, { group = "blade_general" } },
    weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
    pockets = { { kind = "MAGAZINE", holster = true, rigid = true, ammunition = { crystallized_mana = 3 } } },
    melee_damage = { bash = 17, cut = 45 },
    subtype_order = { "tool", "artifact" },
    tool = { charges_per_use = 1 },
    artifact = { charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true } },
    use_actions = { { kind = "cast_spell", spell = "rupture", no_fail = true, level = 10, need_wielding = true } },
}

ccb.content.define_item {
    id = "rune_kelvinist_ice_adept_weapon",
    copy_from = "qt_scimitar",
    name = "Kelvinist Frostbind",
    description = "This curved sword, reminiscent of a scimitar, has a handle with an embedded crystal from which a cold wind emanates.  There are Kelvinist runes embedded in the blade.",
    symbol = "/",
    color = "light_gray",
    category = "weapons",
    looks_like = "scimitar",
    price = "5 kUSD 580 USD",
    survival_price = "210 USD",
    flags = {
        "DURABLE_MELEE",
        "SHEATH_SWORD",
        "TRADER_AVOID",
        "THERMOMETER",
        "MAGIC_FOCUS",
        "SPELLCASTING_AID",
        "NO_UNLOAD",
        "NO_RELOAD",
    },
    techniques = { "WBLOCK_2", "WIDE", "MOUNTED_CHARGE" },
    weapon_categories = { "MEDIUM_SWORDS" },
    pockets = {
        {
            kind = "MAGAZINE",
            holster = true,
            rigid = true,
            ammunition = { crystallized_mana = 3 },
        },
    },
    qualities = {
        { id = "CUT", level = 1 },
        { id = "BUTCHER", level = 8 },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "frost_spray",
            level = 10,
            no_fail = true,
            need_wielding = true,
        },
        "WEATHER_TOOL",
    },
    tool = { charges_per_use = 1 },
    artifact = {
        enchantments = {
            "ITEM_ENCH_Magiclysm_rune_kelvinist_ice_adept_weapon_0",
        },
        charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true },
    },
    subtype_order = { "tool", "artifact" },
    inheritance = {
        scale = {
            mass = 0.8,
            melee_damage = { all = 1.2 },
        },
        offset = { accuracy = 2 },
    },
}
