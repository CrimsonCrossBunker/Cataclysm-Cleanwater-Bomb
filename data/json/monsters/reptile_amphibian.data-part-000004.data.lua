local ccb = require("ccb")

-- Give climbing (Z axis) ability when available.
ccb.content.define_monster {
    id = "mon_shift_bigfrog",
    name = ccb.content.plural_text("mimic treefrog", "mimic treefrogs"),
    description = ccb.content.text("You've seen enough to gather that this is a frog with some very specialized camouflage.  Its skin appears able to reactively change texture and color to match its surroundings.  Like a morphing ghillie suit it can extend filaments to mimic individual leaves and blades of grass.  It is keen enough to match the swaying of brush in the wind."),
    copy_from = "mon_jumbo_bigfrog",
    speed = 130,
    color = "light_gray",
    dodge = 6,
    armor = { bash = 5, acid = 2, heat = 5, electric = 4 },
    vision_night = 35,
    zombify_into = "mon_frog_shadow",
    reproduction = { offspring = { egg = "egg_shift_bigfrog" }, count = 12, interval = 20 },
    inheritance = { add = { flags = { "CAMOUFLAGE" } } },
}
