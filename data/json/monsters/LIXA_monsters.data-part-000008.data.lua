local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_living_vector",
    name = ccb.content.plural_text("unfolded impossibility", "unfolded impossibilities"),
    description = ccb.content.text("This is the entirety of the infinite chamber you are in, which perfectly contains itself.  If you look very closely, you might see yourself looking back.  You are sure that at any other time, seeing this would crack your brain like an eggshell.  But you understand it just fine right now.  And you can see it breathing."),
    default_faction = "nether_player_hate",
    species = { "NETHER_EMANATION" },
    looks_like = "mon_impossible_shape",
    volume = "62500 ml",
    mass = "0 g",
    speed = 120,
    hp = 200,
    symbol = "X",
    color = "white",
    aggression = 100,
    morale = 100,
    dodge = 8,
    attacks = {
        {
            cooldown = 7,
            move_cost = 50,
            kind = "gun",
            gun = {
                weapon = "LIXA_vector_volley",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 8,
                perception = 8,
                lock_player = false,
                target_moving_vehicles = true,
                description = ccb.content.text("The %s rapidly rearranges the coordinates of the infinite chamber."),
                ranges = { { minimum = 2, maximum = 20, mode = "DEFAULT" } },
            },
        },
        {
            id = "LIXA_reshuffle_cone",
            spell = { id = "LIXA_reshuffle_cone", min_level = 1 },
            casting_message = ccb.content.text("The %s rearranges the parts of itself you occupy, dilating them around you."),
            cooldown = 20,
            kind = "spell",
        },
    },
    flags = { "FLIES", "NO_BREATHE", "SEES", "RANGED_ATTACKER", "HARDTOSHOOT", "HIT_AND_RUN" },
    armor = { bash = 6, cut = 12, bullet = 10 },
    death = {
        outcome = { corpse = "NO_CORPSE", spell = { id = "mon_LIXA_vector_death", hit_self = true } },
    },
}
