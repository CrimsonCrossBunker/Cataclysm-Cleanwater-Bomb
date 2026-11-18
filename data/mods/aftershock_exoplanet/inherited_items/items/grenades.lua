local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_electroshock_grenade_1_act",
        copy_from = "afs_electroshock_grenade_1",
        looks_like = "grenade_emp_act",
        name = ccb.content.plural_text("armed electroshock grenade", "armed electroshock grenades"),
        description = ccb.content.text("This electroshock grenade is currently creating a dangerous electric field."),
        field_emissions = { "emit_shock_cloud" },
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:transform_into { target = "afs_material_1" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_oxygen_bomb_act",
        copy_from = "pipebomb_act",
        looks_like = "pipebomb_act",
        name = ccb.content.plural_text("active oxygen bomb", "active oxygen bombs"),
        price_cents = 0,
        description = ccb.content.text("This bomb's fuse is lit, and it will explode any second now.  Throw it immediately!"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_kaburaya_bomb",
        copy_from = "grenade_canister",
        category = "weapons",
        looks_like = "c4",
        name = ccb.content.plural_text("Kabura-ya antipersonnel device", "Kabura-ya antipersonnel devices"),
        description = ccb.content.text("A tiny plastic explosive meant to be installed in a Kabura-ya drone.  Explodes 3 turns after activation."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_kaburaya_bomb_act", timer_turns = 3 },
        need_wielding = true,
        message = ccb.content.text("You pull the pin on the %s."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_electroshock_grenade_1",
        copy_from = "grenade_canister",
        category = "weapons",
        looks_like = "grenade_emp",
        name = ccb.content.plural_text("electroshock grenade", "electroshock grenades"),
        description = ccb.content.text("This is an electronic weapon that will emit a short-ranged electric field.  When activated, you'll have five turns before it starts doing so; throwing it before that would be a good idea."),
        price_cents = 35000,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_electroshock_grenade_1_act", timer_turns = 20 },
        menu_text = ccb.content.text("Pull pin"),
        need_wielding = true,
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "grenade_cryo",
        category = "weapons",
        name = ccb.content.plural_text("cryo grenade", "cryo grenades"),
        description = ccb.content.text("This is a military-grade cryo hand grenade.  Once it explodes it spreads exotic highly-radioactive shrapnel.  Use this item to pull the pin and light the fuse.  You will then have five seconds before it explodes; throwing it would be a good idea."),
        mass_milligrams = 397000,
        volume_ml = 250,
        price_cents = 45000,
        melee_to_hit = -1,
        symbol = "*",
        color = "green",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "grenade_cryo_act", timer_turns = 5 },
        need_wielding = true,
        message = ccb.content.text("You pull the pin on the %s."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_oxygen_bomb",
        copy_from = "pipebomb",
        looks_like = "pipebomb",
        name = ccb.content.plural_text("oxygen bomb", "oxygen bombs"),
        price_cents = 15000,
        description = ccb.content.text("A favorite tool of mutineers everywhere, this is a standard issue oxygen candle deliberately tampered to explode upon activation.  Its fuse is dangerously short, so you won't want to waste any time."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_oxygen_bomb_act", timer_turns = 3 },
        need_wielding = true,
        message = ccb.content.text("You pull the pin on the %s."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("NPC_ACTIVATE")
    item:tool()
    content.add(item)
end
