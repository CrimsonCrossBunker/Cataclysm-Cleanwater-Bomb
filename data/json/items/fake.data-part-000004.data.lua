local ccb = require("ccb")

-- This is used exclusively in the rescue mission for Barry to blow a hole in the scout tower.
-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "fake_dynamite_50lbs",
    category = "weapons",
    name = ccb.content.text_without_extraction("fake 50lbs dynamite car bomb"),
    description = ccb.content.text_without_extraction("Several sticks of explosives, bundled together with a fuse attached.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  Shortly after lighting the fuse, this item will explode, so get away!"),
    mass = "22680 g",
    volume = "15020 ml",
    price = "60 USD",
    survival_price = "10 USD",
    materials = { { id = "tnt", portions = 95 }, { id = "paper", portions = 5 } },
    symbol = "*",
    color = "red",
    explode_in_fire = true,
    flags = { "BOMB" },
    melee_damage = { bash = 4 },
    tool = {},
    countdown_action = { kind = "explosion", blast = { power = 18779, max_noise = 0 } },
    countdown_interval = "1 seconds",
    blast = { power = 18779 },
}
