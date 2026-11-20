local ccb = require("ccb")

-- Intentionally unable to be culled when friendly.
ccb.content.define_monster {
    id = "mon_pigeon_passenger",
    copy_from = "mon_bird_flying_base",
    name = ccb.content.plural_text("pigeon passenger", "pigeon passengers"),
    description = ccb.content.text("A gentle, plump, small-billed bird with a third eye, between its bill and forehead.  On the ground, it struts about with a characteristic bobbing of the head.  It is a strong, swift flier thanks to its long wings and powerful flight muscles.  Is it following you?"),
    volume = "1 L",
    mass = "360 g",
    hp = 4,
    speed = 150,
    symbol = "v",
    color = "dark_gray",
    fear_triggers = { "SOUND", "FRIEND_ATTACKED", "FRIEND_DIED", "FIRE", "HURT" },
    biosignature = { item = "feces_bird", interval = 4 },
    attacks = {
        {
            id = "psi_pigeon_telepathic_blast",
            spell = { id = "telepathic_fear_blast_monster", min_level = 2 },
            casting_message = ccb.content.text("%s's third eye opens and it coos!"),
            kind = "spell",
            cooldown = { 9, 27 },
            when = "monster_attack_psionics_available",
        },
        {
            id = "pigeon_aura",
            spell = { id = "pigeon_aura", min_level = 4 },
            cooldown = 200,
            kind = "spell",
        },
    },
    reproduction = { offspring = { egg = "egg_pigeon_passenger" }, count = 3, interval = 32 },
    pet = {
        food = { "BIRDFOOD" },
        feed_message = ccb.content.text("The %s seems to like you!  It runs around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s runs around your leg."),
    },
    inheritance = {
        add = { flags = { "KEEP_DISTANCE", "HARDTOSHOOT" } },
        remove = { flags = { "CAN_BE_CULLED" } },
    },
}
