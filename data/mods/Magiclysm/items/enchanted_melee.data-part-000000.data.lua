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
