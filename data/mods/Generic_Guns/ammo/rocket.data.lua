local ccb = require("ccb")

ccb.content.define_item {
    id = "rocket_he",
    copy_from = "84x246mm_he",
    name = ccb.content.plural_text("rocket, antipersonnel", "rockets, antipersonnel"),
    description = ccb.content.text("A large anti-personnel rocket for a military rocket launcher.  Designed to be highly effective against personnel."),
    ammunition = { type = "ammo_rocket" },
}

ccb.content.define_item {
    id = "rocket_hedp",
    copy_from = "84x246mm_hedp",
    name = ccb.content.plural_text("rocket, multipurpose", "rockets, multipurpose"),
    description = ccb.content.text("An anti-tank rocket with a high explosive dual purpose warhead for a military rocket launcher.  Designed to be highly effective against vehicles and structures, and retains some effectiveness against personnel."),
    ammunition = { type = "ammo_rocket" },
}

ccb.content.define_item {
    id = "rocket_smoke",
    copy_from = "84x246mm_smoke",
    name = ccb.content.plural_text("rocket, smoke", "rockets, smoke"),
    description = ccb.content.text("A rocket loaded with a smoke warhead for a military rocket launcher.  Commonly used for signaling, target designation, and for screening troop movements."),
    ammunition = { type = "ammo_rocket" },
}
