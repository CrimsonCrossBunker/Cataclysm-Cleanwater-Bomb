local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_see_fae_necklace",
    name = ccb.content.plural_text("Faesight Charm", "Faesight Charms"),
    description = ccb.content.text("A small sack with herbs in it to warn you if the Fair Folk are nearby.  You had better wear it under your clothes.  You wouldn't want them to know you're avoiding them.  It's awaiting you to speak the final words of the charm and activate it."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { glamour_charge = 360 } } },
    mass = "100 g",
    volume = "150 ml",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "leather", "veggy" },
    color = "green",
    symbol = ",",
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE", "HEDGE_ENCHANTED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { turns_per_charge = 25, ammo_types = "glamour_charge" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_0" } },
    use_actions = {
        {
            kind = "transform",
            need_charges = 1,
            target = "item_hedge_see_fae_necklace_on",
            message = ccb.content.text("You recite that last part of the charm."),
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "item_hedge_see_fae_necklace_on",
    name = ccb.content.plural_text("Faesight Charm (active)", "Faesight Charms (active)"),
    description = ccb.content.text("A small sack with herbs in it to warn you if the Fair Folk are nearby.  You had better wear it under your clothes.  You wouldn't want them to know you're avoiding them."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { glamour_charge = 360 } } },
    mass = "45 g",
    volume = "50 ml",
    materials = { "leather", "veggy" },
    color = "green",
    symbol = ",",
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "HEDGE_ENCHANTED", "SPAWN_ACTIVE" },
    revert_to = "item_hedge_see_fae_necklace_done",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {
        turns_per_charge = 25,
        revert_message = ccb.content.text("Your otherworldly senses fade."),
        ammo_types = "glamour_charge",
    },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_on_0" } },
}

ccb.content.define_item {
    id = "item_hedge_see_fae_necklace_done",
    name = ccb.content.plural_text("Faesight Charm", "Faesight Charms"),
    description = ccb.content.text("A small sack with herbs in it to warn you if the Fair Folk are nearby.  You had better wear it under your clothes.  You wouldn't want them to know you're avoiding them.  This charm seems lifeless somehow, its energy spent."),
    mass = "45 g",
    volume = "50 ml",
    materials = { "leather", "veggy" },
    color = "green",
    symbol = ",",
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_done_0" } },
}
