local ccb = require("ccb")

ccb.content.define_item {
    id = "c4",
    category = "weapons",
    name = ccb.content.plural_text("C-4 explosive", "C-4 explosives"),
    description = ccb.content.text("A block of military-grade RDX composition explosive.  A label reads: \"Highly explosive, use with extreme caution!\" It comes with a small timer."),
    mass = "1570 g",
    volume = "1 L",
    price = "90 USD",
    survival_price = "20 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "rdx" },
    symbol = ";",
    color = "light_gray",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ALLOWS_REMOTE_USE" },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "c4armed",
            set_timer = true,
            menu_text = ccb.content.text("Activate"),
        },
    },
}

ccb.content.define_item {
    id = "c4armed",
    copy_from = "c4",
    description = ccb.content.text("A block of military-grade RDX composition explosive.  A label reads: \"Highly explosive, use with extreme caution!\" It comes with a small timer, which is currently ticking down."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 2000 } },
    countdown_interval = "6 seconds",
}

ccb.content.define_item {
    id = "dynamite_act",
    description = ccb.content.text("The fuse on this dynamite is lit and hissing.  It'll explode any moment now."),
    copy_from = "dynamite",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 938 } },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "dynamite",
    name = "dynamite",
    description = "Several sticks of explosives, bundled together with a fuse attached.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  Shortly after lighting the fuse, this item will explode, so get away!",
    symbol = "*",
    color = "red",
    category = "weapons",
    mass = "1133 g",
    volume = "750 ml",
    price = "60 USD",
    survival_price = "10 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = {
        { id = "tnt", portions = 95 },
        { id = "paper", portions = 5 },
    },
    melee_damage = { bash = 4 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    blast = { power = 938 },
    use_actions = {
        {
            kind = "transform",
            target = "dynamite_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the dynamite.",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "dynamite_bomb_act",
    description = ccb.content.text("The fuse on this dynamite bomb is lit and hissing.  It'll explode any moment now."),
    copy_from = "dynamite_bomb",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 938, shrapnel = { casing_mass = 1597, fragment_mass = 0.5 } },
    },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "dynamite_bomb",
    name = "dynamite bomb",
    description = "Several sticks of explosives stuffed inside a metal container and surrounded with shrapnel.  The fuse is sticking out through a small hole.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  Shortly after lighting the fuse, this item will explode, so get away!",
    symbol = "*",
    color = "red",
    category = "weapons",
    mass = "2531 g",
    volume = "2430 ml",
    price = "60 USD",
    survival_price = "15 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = {
        { id = "tnt", portions = 95 },
        { id = "steel", portions = 40 },
        { id = "paper", portions = 5 },
    },
    melee_damage = { bash = 4 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    blast = {
        power = 938,
        shrapnel = { casing_mass = 1597, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "dynamite_bomb_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the dynamite.",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "EMPbomb_act",
    copy_from = "EMPbomb",
    description = ccb.content.text("This EMP bomb is active and will shortly detonate, creating a large EMP field that damages robots and drains bionic energy, as well as a sizeable explosion.  You may not want to be holding it much longer."),
    flags = { "DANGEROUS", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate"),
        },
    },
    countdown_action = {
        kind = "explosion",
        draw_radius = 10,
        draw_color = "light_blue",
        emp_radius = 10,
        blast = {
            power = 600,
            light_effect = "emp_blast",
            shrapnel = { casing_mass = 3214, fragment_mass = 0.5 },
        },
    },
    countdown_interval = "50 seconds",
}

ccb.content.define_item {
    id = "EMPbomb",
    name = "EMP bomb",
    description = "This substantial device is a bomb that generates an electromagnetic pulse.  When activated, the plutonium fuel cell is drained into a flux compression generator, the detonation of which creates a strong magnetic field.  When this magnetic field is fed into the antenna, it creates a strong electro-magnetic pulse.",
    symbol = "*",
    color = "light_gray",
    category = "weapons",
    mass = "4543 g",
    volume = "15500 ml",
    price = "600 USD",
    survival_price = "30 USD",
    explode_in_fire = true,
    flags = {
        "RADIO_MODABLE",
        "RADIO_INVOKE_PROC",
        "BOMB",
        "GRENADE",
        "WATER_BREAK",
        "ALLOWS_REMOTE_USE",
    },
    materials = { "steel", "plastic" },
    melee_damage = { bash = 12 },
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    blast = {
        power = 600,
        light_effect = "emp_blast",
        shrapnel = { casing_mass = 3214, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "EMPbomb_act",
            message = "You activate the EMP bomb.",
            menu_text = "Activate",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "firecracker",
    name = ccb.content.plural_text("firecracker", "firecrackers"),
    description = ccb.content.text("A solitary firecracker with a short fuse.  Use this item to light the fuse.  Of course, you will need a lighter or some matches to do so.  Shortly after you light the fuse it will explode, so throw it quickly!"),
    mass = "3 g",
    volume = "25 ml",
    price = "4 cent",
    survival_price = "10 cent",
    materials = { "paper" },
    symbol = ";",
    color = "red",
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "firecracker_act",
            message = ccb.content.text("You light the firecracker."),
            need_fire = 1,
            need_wielding = true,
            menu_text = ccb.content.text("Light up"),
        },
    },
}

ccb.content.define_item {
    id = "firecracker_act",
    copy_from = "firecracker",
    description = ccb.content.text("A firecracker that has been lit; the fuse is hissing.  Throw it quickly before it explodes."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light up"),
        },
    },
    tick_actions = {
        {
            kind = "sound",
            message = ccb.content.text("ssss…"),
            volume = 0,
            sound_id = "misc",
            sound_variant = "lit_fuse",
        },
    },
    countdown_action = {
        kind = "sound",
        message = ccb.content.text_without_extraction("Bang!"),
        volume = 20,
        sound_id = "explosion",
        sound_variant = "small",
    },
    countdown_interval = "2 seconds",
}

-- Based on the M84 stun grenade
ccb.content.define_item {
    id = "flashbang",
    category = "weapons",
    name = ccb.content.plural_text("flashbang", "flashbangs"),
    description = ccb.content.text("A military police-style flashbang.  Use this item to pull the pin and start the fuse.  You will then have two seconds before it detonates with intense light and sound, blinding, deafening, and disorienting anyone nearby."),
    mass = "425 g",
    volume = "207 ml",
    length = "141 mm",
    price = "20 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "dark_gray",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "CYLINDER_GRENADE" },
    melee_damage = { bash = 1 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "flashbang_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

ccb.content.define_item {
    id = "flashbang_act",
    copy_from = "flashbang",
    description = ccb.content.text("This flashbang is active, and will soon detonate with intense light and sound, blinding, deafening, and disorienting anyone nearby.  It may be a good idea to throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = { kind = "explosion", flash = true },
    countdown_interval = "2 seconds",
}

-- Based off of the M67 grenade
ccb.content.define_item {
    id = "grenade",
    category = "weapons",
    name = ccb.content.plural_text("grenade", "grenades"),
    description = ccb.content.text("A military-grade fragmentation hand grenade.  Use this item to pull the pin and start the fuse.  You will then have five seconds before it explodes; throwing it would be a good idea."),
    mass = "397 g",
    volume = "540 ml",
    length = "110 mm",
    price = "15 USD",
    survival_price = "10 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "green",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

ccb.content.define_item {
    id = "grenade_act",
    copy_from = "grenade",
    description = ccb.content.text("This fragmentation grenade is active, and will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 240, shrapnel = { casing_mass = 217, fragment_mass = 0.02 } },
    },
    countdown_interval = "5 seconds",
}

-- Something this useful doesn't come cheap after the apocalypse
ccb.content.define_item {
    id = "grenade_emp",
    category = "weapons",
    name = ccb.content.plural_text("EMP grenade", "EMP grenades"),
    description = ccb.content.text("A grenade that generates an electromagnetic pulse with a low-inductance capacitor bank discharged into a single-loop antenna.  It also produces a mild electric shock cloud.  Use this item to pull the pin and light the fuse, turning it into an active EMP grenade.  You will then have three seconds before it detonates, creating an EMP field that damages robots and drains bionic energy."),
    mass = "400 g",
    volume = "270 ml",
    price = "60 USD",
    survival_price = "40 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    looks_like = "EMPbomb",
    color = "cyan",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "WATER_BREAK" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_emp_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

ccb.content.define_item {
    id = "grenade_emp_act",
    copy_from = "grenade_emp",
    description = ccb.content.text("This EMP grenade is active and will shortly detonate, creating a large EMP field that damages robots and drains bionic energy, as well as a mild electric shock cloud.  You may not want to be holding it much longer."),
    flags = { "DANGEROUS", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_electricity",
        field_radius = 1,
        field_minimum = 2,
        field_maximum = 10,
        emp_radius = 4,
    },
    countdown_interval = "3 seconds",
}

ccb.content.define_item {
    id = "grenade_inc",
    category = "weapons",
    name = ccb.content.plural_text("incendiary grenade", "incendiary grenades"),
    description = ccb.content.text("A military-grade incendiary hand grenade.  Use this item to pull the pin and start the fuse.  You will then have five seconds before it explodes into a raging inferno; throwing it would be a good idea."),
    mass = "180 g",
    volume = "270 ml",
    price = "20 USD",
    survival_price = "15 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel" },
    symbol = "*",
    color = "light_red",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ACT_IN_FIRE", "GRENADE", "CYLINDER_GRENADE" },
    melee_damage = { bash = 1 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "grenade_inc_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

-- This is based on the B54 Mod 1, all other man-portable nuclear weapons have far too high a yield.
ccb.content.define_item {
    id = "mininuke",
    category = "weapons",
    name = ccb.content.plural_text("SADM mininuke", "SADM mininukes"),
    description = ccb.content.text("The B54 Special Atomic Demolition Munition is an extremely powerful weapon, a portable nuclear bomb, using the smallest nuclear warhead in US inventory.  It is housed inside a extremely sturdy transit container.  Use it to activate the timer.  You guess that the explosion would be large enough to take out a small house."),
    mass = "26500 g",
    volume = "33389 ml",
    length = "46 cm",
    price = "1 kUSD 800 USD",
    survival_price = "100 USD",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    materials = { "aluminum", "nylon" },
    symbol = "*",
    color = "light_green",
    flags = { "STURDY", "LEAK_DAM", "BELTED", "RADIOACTIVE", "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    melee_damage = { bash = 8 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2.0 } },
                encumbrance = 90,
                coverage = 10,
                covers = { "hand_l", "hand_r" },
            },
        },
    },
    use_actions = { "MININUKE" },
}

ccb.content.define_item {
    id = "mininuke_act",
    copy_from = "mininuke",
    description = ccb.content.text("The nuclear bomb looks no different from the outside, yet you know that the device is armed and counting down.  You should probably get far, far away from it."),
    flags = { "STURDY", "LEAK_DAM", "BELTED", "RADIOACTIVE", "DANGEROUS", "SPAWN_ACTIVE" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_nuke_gas",
        field_radius = 18,
        field_minimum = 3,
        field_maximum = 3,
        blast = { power = 9000000 },
    },
    countdown_interval = "60 seconds",
}

-- The moves action cost should always be at least 100 (one full second) so that the molotov can properly know who's throwing it. See iuse::molotov_lit() for more details.
ccb.content.define_item {
    id = "molotov",
    category = "weapons",
    name = ccb.content.plural_text("Molotov cocktail", "Molotov cocktails"),
    description = ccb.content.text("A bottle of flammable liquid with a rag inserted.  Use this item to light the rag.  You will, of course, need a lighter or matches in your inventory to do this.  After lighting it, throw it to cause fires."),
    mass = "889 g",
    volume = "1085 ml",
    length = "29 cm",
    price = "0 USD",
    survival_price = "4 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "glass", "cotton" },
    symbol = "*",
    color = "light_gray",
    flags = { "NPC_ACTIVATE", "NO_REPAIR", "CYLINDER_GRENADE" },
    melee_damage = { bash = 5 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "molotov_lit",
            message = ccb.content.text("You light the Molotov cocktail!"),
            moves = 250,
            need_fire = 1,
            menu_text = ccb.content.text("Light rag"),
        },
    },
}

-- ["2% chance per turn of going out harmlessly.", "This is necessary to prevent a player from lighting a ton of molotovs and stuffing them in their backpack until pulling them out 6 weeks later."]
ccb.content.define_item {
    id = "molotov_lit",
    copy_from = "molotov",
    description = ccb.content.text("A bottle of flammable liquid with a flaming rag stoppered in its neck.  Throwing it will shatter the bottle on impact and ignite a fireball.  Dropping it will set you on fire, so don't do that unless you want to burn to death."),
    light = 15,
    flags = {
        "DANGEROUS", "NO_REPAIR", "WATER_EXTINGUISH", "DESTROY_ON_CHARGE_USE", "SPAWN_ACTIVE",
        "ACT_ON_RANGED_HIT", "NO_MANUAL_ACTIVATION",
    },
    tool = {},
    use_actions = { { kind = "explosion", ammo_effects = { "MOLOTOV" }, blast = { power = 0 } } },
    tick_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "molotov",
            chance = 2,
            message = ccb.content.text("Your lit Molotov goes out."),
        },
    },
}

ccb.content.define_item {
    id = "gelled_molotov",
    copy_from = "molotov",
    name = ccb.content.plural_text("gelled Molotov", "gelled Molotovs"),
    description = ccb.content.text("An older brother of the generic Molotov cocktail, this wicked beverage uses thickened gasoline or straight napalm.  It, surprisingly, does not make for a fire of much higher temperature, but what it does is make the burning mixture ever more sticky."),
    survival_price = "6 USD",
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "gelled_molotov_lit",
            message = ccb.content.text("You light the gelled Molotov!"),
            moves = 250,
            need_fire = 1,
            menu_text = ccb.content.text("Light rag"),
        },
    },
}

ccb.content.define_item {
    id = "gelled_molotov_lit",
    copy_from = "gelled_molotov",
    looks_like = "molotov_lit",
    light = 15,
    flags = {
        "DANGEROUS", "NO_REPAIR", "WATER_EXTINGUISH", "DESTROY_ON_CHARGE_USE", "SPAWN_ACTIVE",
        "ACT_ON_RANGED_HIT", "NO_MANUAL_ACTIVATION",
    },
    tool = {},
    use_actions = { { kind = "explosion", ammo_effects = { "GELLED_MOLOTOV" }, blast = { power = 0 } } },
    tick_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "gelled_molotov",
            chance = 2,
            message = ccb.content.text("Your lit gelled Molotov goes out."),
        },
    },
}

-- Something this useful doesn't come cheap after the apocalypse
ccb.content.define_item {
    id = "scrambler",
    category = "weapons",
    name = ccb.content.plural_text("scrambler grenade", "scrambler grenades"),
    description = ccb.content.text("A specialized grenade designed to scramble robots' IFF control chips.  This converts the robot to your side for a short time, before the backup systems kick in.  Use this item to pull the pin and start the fuse, turning it into an active scrambler grenade."),
    mass = "500 g",
    volume = "270 ml",
    price = "60 USD",
    survival_price = "50 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
    materials = { "steel", "plastic" },
    symbol = "*",
    color = "yellow",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "scrambler_act",
            message = ccb.content.text("You pull the pin on the %s."),
            menu_text = ccb.content.text("Pull pin"),
        },
    },
}

ccb.content.define_item {
    id = "scrambler_act",
    copy_from = "scrambler",
    description = ccb.content.text("This scrambler grenade is active and will soon detonate, releasing a control wave that temporarily converts robots to your side."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = { kind = "explosion", draw_radius = 4, draw_color = "cyan", scrambler_radius = 4 },
    countdown_interval = "3 seconds",
}

ccb.content.define_item {
    id = "military_explosive_small_grenade_act",
    copy_from = "military_explosive_small_grenade",
    looks_like = "homemade_grenade_act",
    description = ccb.content.text("The fuse on this improvised grenade is lit, and it will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 460, shrapnel = { casing_mass = 200, fragment_mass = 0.4 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "military_explosive_small_grenade",
    copy_from = "grenade",
    name = "military explosive small homemade grenade",
    description = "An improvised explosive device cobbled together from parts.  Use this item to light the fuse.  You will then have five seconds before it explodes; throwing it would be a good idea.",
    symbol = "*",
    color = "green",
    looks_like = "homemade_grenade",
    mass = "600 g",
    volume = "270 ml",
    price = "15 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    materials = { "aluminum", "iron" },
    blast = {
        power = 460,
        shrapnel = { casing_mass = 200, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_small_grenade_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the improvised grenade.  Throw it before it blows up in your face!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "military_explosive_grenade_act",
    copy_from = "military_explosive_grenade",
    looks_like = "homemade_grenade_act",
    description = ccb.content.text("The fuse on this improvised grenade is lit, and it will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 920, shrapnel = { casing_mass = 400, fragment_mass = 0.4 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "military_explosive_grenade",
    copy_from = "grenade",
    name = "military explosive homemade grenade",
    description = "An improvised explosive device cobbled together from parts.  Use this item to light the fuse.  You will then have five seconds before it explodes; throwing it would be a good idea.",
    symbol = "*",
    color = "green",
    looks_like = "homemade_grenade",
    mass = "1200 g",
    volume = "540 ml",
    price = "30 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "CYLINDER_GRENADE" },
    materials = { "aluminum", "iron" },
    blast = {
        power = 920,
        shrapnel = { casing_mass = 400, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_grenade_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the improvised grenade.  Throw it before it blows up in your face!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "military_explosive_pipebomb_act",
    copy_from = "military_explosive_pipebomb",
    looks_like = "pipebomb_act",
    description = ccb.content.text("This pipebomb's pin is pulled, and it will explode any second now.  Throw it immediately!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 920, shrapnel = { casing_mass = 410, fragment_mass = 0.5 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "military_explosive_pipebomb",
    copy_from = "grenade",
    name = "military explosive pipebomb",
    description = "A section of steel pipe filled with military explosives.  Use this item to pull the pin, giving you six seconds to get away from it before it detonates.",
    symbol = "*",
    color = "light_gray",
    looks_like = "pipebomb",
    mass = "1140 g",
    volume = "280 ml",
    length = "229 mm",
    price = "30 USD",
    survival_price = "30 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "CYLINDER_GRENADE" },
    materials = { "steel" },
    melee_damage = { bash = 4 },
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "uneven" },
    blast = {
        power = 920,
        shrapnel = { casing_mass = 410, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_pipebomb_act",
            need_wielding = true,
            message = "You pull the pin on the %s.",
            menu_text = "Pull pin",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "military_explosive_bomb_act",
    copy_from = "military_explosive_bomb",
    looks_like = "homemade_bomb_act",
    description = ccb.content.text("A homemade explosive device, consisting of a large plastic jug filled with military explosives and scrap metal.  Its fuse has been lit, its final countdown starting."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = {
            power = 6970,
            shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
        },
    },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "military_explosive_bomb",
    name = "military explosive bomb",
    description = "A homemade explosive device, consisting of a large plastic jug filled with military explosives and scrap metal, equipped with a delayed fuse.  Use this item to pull the pin.  Once you do, it should explode after about 20 seconds.",
    symbol = "*",
    color = "red",
    category = "weapons",
    looks_like = "homemade_bomb",
    mass = "8760 g",
    volume = "3900 ml",
    price = "200 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = { "steel", "plastic" },
    blast = {
        power = 6970,
        shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_bomb_act",
            need_wielding = true,
            message = "You pull the pin on the %s.",
            menu_text = "Pull pin",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "military_explosive_half_barrel_bomb_act",
    copy_from = "military_explosive_half_barrel_bomb",
    looks_like = "half_barrel_bomb_act",
    description = ccb.content.text("A metal keg filled with military explosives.  It has been activated and will soon explode, delivering its entire destructive power to everything in sight."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 100000, shrapnel = { casing_mass = 12600, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}

ccb.content.define_item {
    id = "military_explosive_half_barrel_bomb",
    copy_from = "half_barrel_bomb",
    name = "military explosive 50 L barrel bomb",
    description = "A metal keg filled with military explosives.  Once it has been activated, it will explode after 100 seconds, raining fire and steel on everything in sight.",
    mass = "135 kg",
    blast = {
        power = 100000,
        shrapnel = { casing_mass = 12600, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_half_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "military_explosive_full_barrel_bomb_act",
    copy_from = "military_explosive_full_barrel_bomb",
    looks_like = "full_barrel_bomb_act",
    description = ccb.content.text("A 100 L metal barrel filled with military explosives.  It has been activated and will soon explode, delivering its entire destructive power to everything in sight."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 200000, shrapnel = { casing_mass = 12600, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}

ccb.content.define_item {
    id = "military_explosive_full_barrel_bomb",
    copy_from = "full_barrel_bomb",
    name = "military explosive 100 L barrel bomb",
    description = "A 100 L metal barrel filled with military explosives.  Once it has been activated it will explode after 100 seconds, raining fire and steel on everything in sight.",
    mass = "252 kg",
    blast = {
        power = 200000,
        shrapnel = { casing_mass = 12000, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "military_explosive_full_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "small_homemade_grenade_act",
    copy_from = "small_homemade_grenade",
    looks_like = "homemade_grenade_act",
    description = ccb.content.text("The fuse on this improvised grenade is lit, and it will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 150, shrapnel = { casing_mass = 200, fragment_mass = 0.4 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "small_homemade_grenade",
    copy_from = "grenade",
    name = "small homemade grenade",
    description = "An improvised explosive device cobbled together from spare parts.  Use this item to light the fuse.  You will then have 5 seconds before it explodes; throwing it would be a good idea.",
    symbol = "*",
    color = "green",
    looks_like = "homemade_grenade",
    mass = "460 g",
    volume = "270 ml",
    price = "7 USD 50 cent",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE" },
    materials = { "aluminum", "iron" },
    blast = {
        power = 150,
        shrapnel = { casing_mass = 200, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "small_homemade_grenade_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the improvised grenade.  Throw it before it blows up in your face!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "homemade_grenade_act",
    copy_from = "homemade_grenade",
    looks_like = "grenade_act",
    description = ccb.content.text("The fuse on this improvised grenade is lit, and it will explode any second now.  Better throw it!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 300, shrapnel = { casing_mass = 400, fragment_mass = 0.4 } },
    },
    countdown_interval = "5 seconds",
}

ccb.content.define_item {
    id = "homemade_grenade",
    copy_from = "grenade",
    name = "homemade grenade",
    description = "An improvised explosive device cobbled together from spare parts.  Use this item to light the fuse.  You will then have 5 seconds before it explodes; throwing it would be a good idea.",
    symbol = "*",
    color = "green",
    mass = "900 g",
    price = "15 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "CYLINDER_GRENADE" },
    materials = { "aluminum", "iron" },
    blast = {
        power = 300,
        shrapnel = { casing_mass = 400, fragment_mass = 0.4 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "homemade_grenade_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the improvised grenade.  Throw it before it blows up in your face!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "pipebomb_act",
    copy_from = "pipebomb",
    description = ccb.content.text("This pipebomb's fuse is lit, and it will explode any second now.  Throw it immediately!"),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 300, shrapnel = { casing_mass = 410, fragment_mass = 0.5 } },
    },
    countdown_interval = "6 seconds",
}

ccb.content.define_item {
    id = "pipebomb",
    name = "pipebomb",
    description = "A section of steel pipe filled with explosives.  Use this item to light the fuse, giving you six seconds to get away from it before it detonates.  You'll need a lighter or some matches to use it.",
    symbol = "*",
    color = "light_gray",
    category = "weapons",
    mass = "840 g",
    volume = "280 ml",
    length = "229 mm",
    price = "15 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "CYLINDER_GRENADE" },
    materials = { "steel" },
    melee_damage = { bash = 3 },
    accuracy = { grip = "solid", length = "hand", surface = "any", balance = "uneven" },
    blast = {
        power = 300,
        shrapnel = { casing_mass = 410, fragment_mass = 0.5 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "pipebomb_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the pipe bomb.",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "homemade_bomb_act",
    copy_from = "homemade_bomb",
    description = ccb.content.text("A homemade explosive device, consisting of a large plastic jug filled with stable explosives and scrap metal.  Its fuse has been lit, its final countdown starting."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = {
            power = 2320,
            shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
        },
    },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "homemade_bomb",
    name = "homemade bomb",
    description = "A homemade explosive device, consisting of a large plastic jug filled with stable explosives and scrap metal, equipped with a long fuse.  Use this item to light the fuse.  Once you do, it should explode after about 20 seconds.",
    symbol = "*",
    color = "red",
    category = "weapons",
    mass = "6500 g",
    volume = "3900 ml",
    price = "100 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = { "steel", "plastic" },
    blast = {
        power = 2320,
        shrapnel = { casing_mass = 3000, fragment_mass = 0.5, drop = "scrap", recovery = 20 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "homemade_bomb_act",
            need_fire = 1,
            need_wielding = true,
            message = "You light the fuse on the bomb.  Get rid of it quickly!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "homemade_demolition_charge_act",
    copy_from = "homemade_demolition_charge",
    looks_like = "homemade_bomb_act",
    description = ccb.content.text("The fuse on this primitive demolition charge is lit and hissing.  It'll explode any moment now."),
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already lit the fuse.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Light fuse"),
        },
    },
    countdown_action = { kind = "explosion", blast = { power = 2590 } },
    countdown_interval = "20 seconds",
}

ccb.content.define_item {
    id = "homemade_demolition_charge",
    name = "homemade demolition charge",
    description = "An improvised demolition charge.  Use this item to light the fuse.  You will, of course, need a lighter or matches in your inventory to do this.  20 seconds after lighting the fuse, it will explode, so get away!",
    symbol = "*",
    color = "red",
    category = "weapons",
    looks_like = "homemade_bomb",
    mass = "3875 g",
    volume = "3900 ml",
    price = "0 cent",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB" },
    materials = { "plastic", "powder" },
    melee_damage = { bash = 4 },
    accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
    blast = { power = 2590 },
    use_actions = {
        {
            kind = "transform",
            target = "homemade_demolition_charge_act",
            need_fire = 1,
            message = "You light the fuse on the bomb.  Get rid of it quickly!",
            menu_text = "Light fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "half_barrel_bomb_act",
    copy_from = "half_barrel_bomb",
    description = ccb.content.text("A metal keg filled with stable explosives.  The fuse has been lit and once it ignites the primary explosive, the bomb will detonate and rain fire and steel on everything in sight."),
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 34400, shrapnel = { casing_mass = 12600, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}

ccb.content.define_item {
    id = "half_barrel_bomb",
    name = "50 L barrel bomb",
    description = "A metal keg filled with stable explosives.  Contains a volatile explosive core, so 100 seconds after the fuse has been lit the charge will detonate completely, delivering its entire destructive power to everything in sight.",
    symbol = "(",
    color = "red",
    category = "weapons",
    mass = "61620 g",
    volume = "52500 ml",
    price = "1 kUSD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ALLOWS_REMOTE_USE" },
    materials = { "steel" },
    melee_damage = { bash = 20 },
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    blast = {
        power = 34400,
        shrapnel = { casing_mass = 12600, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "half_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "full_barrel_bomb",
    name = "100 L barrel bomb",
    description = "A 100 L metal barrel filled with military explosives.  Once it has been activated it will explode after 100 seconds, raining fire and steel on everything in sight.",
    symbol = "(",
    color = "red",
    category = "weapons",
    looks_like = "half_barrel_bomb",
    mass = "110610 g",
    volume = "105 L",
    price = "900 USD",
    explode_in_fire = true,
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "ALLOWS_REMOTE_USE" },
    materials = { "steel" },
    melee_damage = { bash = 20 },
    accuracy = { grip = "bad", length = "long", surface = "any", balance = "clumsy" },
    blast = {
        power = 69200,
        shrapnel = { casing_mass = 12000, fragment_mass = 600 },
    },
    use_actions = {
        {
            kind = "transform",
            target = "full_barrel_bomb_act",
            message = "You activate the fuse on the barrel bomb.  Clear the area!",
            menu_text = "Activate fuse",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "full_barrel_bomb_act",
    copy_from = "full_barrel_bomb",
    description = ccb.content.text("A 100 L metal barrel filled with military explosives.  It has been activated and will soon explode, delivering its entire destructive power to everything in sight."),
    looks_like = "half_barrel_bomb_act",
    color = "light_red",
    flags = { "DANGEROUS", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate fuse"),
        },
    },
    countdown_action = {
        kind = "explosion",
        blast = { power = 69200, shrapnel = { casing_mass = 12000, fragment_mass = 600 } },
    },
    countdown_interval = "100 seconds",
}
