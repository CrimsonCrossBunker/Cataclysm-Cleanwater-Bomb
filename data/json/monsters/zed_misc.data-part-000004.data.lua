local ccb = require("ccb")

-- Upgraded version of brainless.  Regenerating Skull with huge ears.
-- Weight and volume changed to reflect a (mostly) lack of head.
-- Removed Bite as this creature does not have a 'mouth'.
ccb.content.define_monster {
    id = "mon_zombie_ears",
    name = ccb.content.plural_text("listener zombie", "listener zombies"),
    description = ccb.content.text("This zombie's head was once obviously destroyed, the gaps in its scraps of face now filling with a peculiar gray goo.  Human ears hang from the sides, enormous and unsettling.  Thin slits at the front suggest it may have a (very limited) sense of sight."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    volume = "62275 ml",
    mass = "79800 g",
    hp = 90,
    melee_sides = 4,
    bleed_rate = 50,
    vision_day = 7,
    vision_night = 4,
    weakpoint_sets = { "wps_humanoid_body_headless" },
    harvest = "zombie_humanoid_headless",
    decay = "zombie_decay_bone",
    upgrade = { half_life = 112, monster = "mon_zombie_skull" },
    inheritance = {
        add = { flags = { "GOODHEARING", "NOHEAD", "CLUMSY_ATTACKS" } },
        remove = { attacks = { "bite_humanoid" } },
    },
}
