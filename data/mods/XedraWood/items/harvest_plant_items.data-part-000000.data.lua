local ccb = require("ccb")

ccb.content.define_item {
    id = "morningflower_leaves",
    symbol = ",",
    color = "yellow",
    name = ccb.content.plural_text("morningflower leaf", "morningflower leaves"),
    description = ccb.content.text("A large leaf from the morningflower plant.  It has a faint golden glow in the dark."),
    survival_price = "5 cent",
    materials = { "veggy" },
    mass = "15 g",
    volume = "50 ml",
    melee_damage = { bash = 4 },
    light = 5,
    flags = { "INEDIBLE" },
    comestible = { shelf_life = "45 days", kind = "FOOD", smoking_result = "morningflower_leaves_smoked" },
}

ccb.content.define_item {
    id = "morningflower_leaves_smoked",
    symbol = ",",
    color = "yellow",
    name = ccb.content.plural_text("dehydrated morningflower leaf", "dehydrated morningflower leaves"),
    description = ccb.content.text("A large leaf from the morningflower plant.  It has been dehydrated in a smoker and its characteristic golden glow is much fainter now."),
    survival_price = "20 cent",
    materials = { "veggy" },
    mass = "15 g",
    volume = "50 ml",
    melee_damage = { bash = 4 },
    light = 1,
    flags = { "SMOKED", "INEDIBLE" },
    comestible = { shelf_life = "150 days", kind = "FOOD" },
}

ccb.content.define_item {
    id = "harfry_root",
    name = ccb.content.text("harfry root"),
    mass = "168 g",
    color = "green",
    symbol = "%",
    description = ccb.content.text("The large, brilliant-green root of the harfry plant.  It's edible, if barely, and smells faintly sweet."),
    price = "10 USD",
    survival_price = "2 USD 5 cent",
    materials = { "veggy" },
    volume = "250 ml",
    flags = { "RAW" },
    comestible = { shelf_life = "30 days", kind = "FOOD", calories = 20, fun = -6 },
}

ccb.content.define_item {
    id = "maidens_hair",
    symbol = "/",
    color = "light_green",
    name = ccb.content.plural_text("maiden's hair", "handfuls of maiden's hair"),
    description = ccb.content.text("A set of long, stringy leaves from the aquatic maiden's hair plant.  They seem to move slightly when you're not looking at them."),
    survival_price = "2 USD 5 cent",
    materials = { "veggy" },
    mass = "50 g",
    volume = "150 ml",
    melee_damage = { bash = 1 },
    flags = { "INEDIBLE" },
    comestible = { shelf_life = "8 days", kind = "FOOD" },
}
