local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_fungaloid_shambler",
    name = ccb.content.plural_text("fungaloid shambler", "fungaloid shamblers"),
    description = ccb.content.text("A large white fungus, a bulging gray stalk supporting a bloom at the top.  Spores float from its gills and tendrils extend from the base.  Chunks of rock, metal, bone, and wood are held by tendrils as a kind of armor."),
    copy_from = "mon_fungaloid",
    volume = "120 L",
    mass = "160 kg",
    hp = 150,
    speed = 20,
    bleed_rate = 0,
    attacks = {
        { reference = "FUNGUS", cooldown = 20 },
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                skills = { { id = "throw", level = 4 } },
                strength = 7,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The fungaloid shambler throws a rock!"),
            },
        },
    },
    upgrade = false,
    armor = { bash = 4, cut = 10, stab = 20, acid = 3, bullet = 20, electric = 3 },
    death = {
        drops = {
            entries = {
                { group = "SUS_trash_metal", count = 5 },
                { group = "SUS_trash_forest_no_manmade", count = 5 },
            },
        },
    },
}
