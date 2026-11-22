local ccb = require("ccb")

ccb.content.define_item {
    id = "leatherbone_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("boiled leather horse barding with bones", "boiled leather horse bardings with bones"),
    description = ccb.content.text("Decorative bones affixed to leather horse barding to invoke fear in bandits and raiders and traders all!  You could put this on a friendly horse."),
    price = "450 USD",
    survival_price = "30 USD",
    materials = { "leather" },
    mass = "17 kg",
    volume = "150 L",
    pet_armor = { thickness = 6 },
}

ccb.content.define_item {
    id = "rubber_armor_horse",
    copy_from = "horse_armor",
    color = "green",
    name = ccb.content.plural_text("horse rain sheet", "horse rain sheets"),
    description = ccb.content.text("A thin plastic covering designed to keep a horse dry in the rain.  You could put this on a friendly horse."),
    price = "150 USD",
    survival_price = "15 USD",
    materials = { "neoprene", "plastic" },
    mass = "14 kg",
    volume = "150 L",
    pet_armor = { thickness = 3 },
}

ccb.content.define_item {
    id = "iron_armor_horse",
    copy_from = "horse_armor",
    color = "brown",
    name = ccb.content.plural_text("iron horse armor", "iron horse armors"),
    description = ccb.content.text("A heavy covering of strategically-placed iron plates and leather, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "iron", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "steel_armor_horse",
    copy_from = "horse_armor",
    color = "light_gray",
    name = ccb.content.plural_text("steel horse armor", "steel horse armors"),
    description = ccb.content.text("A heavy covering of steel plate and leather, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "600 USD",
    survival_price = "150 USD",
    materials = { "steel", "leather" },
    mass = "50 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "bronze_armor_horse",
    copy_from = "horse_armor",
    color = "yellow",
    name = ccb.content.plural_text("bronze horse armor", "bronze horse armors"),
    description = ccb.content.text("A heavy covering of strategically-placed bronze plates and leather, suitably made for horses as protection.  You could put this on a friendly horse."),
    price = "500 USD",
    survival_price = "100 USD",
    materials = { "bronze", "leather" },
    mass = "30 kg",
    volume = "150 L",
    pet_armor = { thickness = 4 },
}

ccb.content.define_item {
    id = "leather_armor_horse",
    copy_from = "horse_armor",
    name = ccb.content.plural_text("boiled leather horse barding with caparison", "boiled leather horse bardings with caparison"),
    description = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a battle between a monstrous dragon and regal griffin.  You could put this on a friendly horse.",
    color = "green",
    mass = "15 kg",
    volume = "150 L",
    price = "300 USD",
    survival_price = "30 USD",
    snippet_category = {
        {
            id = "battle",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a battle between a monstrous dragon and regal griffin.  You could put this on a friendly horse.",
        },
        {
            id = "ancientdragon",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a red dragon breathing fire on cities.  You could put this on a friendly horse.",
        },
        {
            id = "criticalbear",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a bear standing on its hind legs, forelegs outstretched in a menacing manner.  You could put this on a friendly horse.",
        },
        {
            id = "orange",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts an assortment of fruits and vegetables with a very large orange featured in the foreground.  You could put this on a friendly horse.",
        },
        {
            id = "vulture",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts a massive vulture perched on a mountain.  You could put this on a friendly horse.",
        },
        {
            id = "direboar",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison depicts the mythical Erymanthian boar in various artistic forms.  You could put this on a friendly horse.",
        },
        {
            id = "rycon",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison seems to be sponsored by Rycon Construction, with a tag line of \"From down under to your home, we play all the roles from start to finish!\".  You could put this on a friendly horse.",
        },
        {
            id = "coregentech",
            text = "A full barding for horses consisting of boiled leather and cloth undercovering.  This caparison seems to be sponsored by Core Generator Tech, with a tag line of \"Providing power solutions from culinary to graphic design, we have the magic touch for your problems!\".  You could put this on a friendly horse.",
        },
    },
    materials = { "cotton", "leather" },
    pet_armor = { thickness = 6 },
}
