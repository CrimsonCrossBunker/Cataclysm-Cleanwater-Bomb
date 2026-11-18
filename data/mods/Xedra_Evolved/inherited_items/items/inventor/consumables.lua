local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rip_ticket",
        name = ccb.content.plural_text("vancian bill", "vancian bills"),
        description = ccb.content.text("A small bill covered in odd symbols.  Tearing it will in turn cause a small dimensional tear located within a nearby entity.  Despite only lasting a few milliseconds, an internal tear in reality should be enough to kill anything.  Hopefully."),
        mass_milligrams = 1000,
        volume_ml = 1,
        symbol = "|",
        color = "brown",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("TRADER_AVOID")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:cast_spell { spell = "rip_ticket", no_fail = true, level = 0, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_warp_grenade",
        category = "weapons",
        looks_like = "grenade",
        name = ccb.content.plural_text("netherium warp grenade", "netherium warp grenades"),
        description = ccb.content.text("A homemade general purpose reality implosion device.  Use this item to pull the pin and start the fuse.  After 5 seconds, everything nearby will be violently sliced, warped, aged, and partially teleported straight into many different sections of the nether.  After a short moment of instant death, the dimensional gap will probably heal.  Probably."),
        mass_milligrams = 397000,
        volume_ml = 540,
        price_cents = 1000000,
        price_postapoc_cents = 20000,
        symbol = "*",
        color = "green",
    }
    item:material("mc_steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_warp_grenade_act", timer_turns = 5 },
        need_wielding = true,
        message = ccb.content.text("You pull the pin on the %s."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:flag("INVENTOR_CRAFTED")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_warp_grenade_act",
        category = "weapons",
        name = ccb.content.plural_text("active netherium warp grenade", "active netherium warp grenades"),
        description = ccb.content.text("This netherium warp grenade is active, and will explode any second now.  Continue holding it to die in the messiest and most violent of ways imaginable"),
        mass_milligrams = 397000,
        volume_ml = 270,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "*",
        color = "green",
        countdown_turns = 5,
    }
    item:material("mc_steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:message_on_use {
        message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("BOMB")
    item:flag("TRADER_AVOID")
    item:flag("DANGEROUS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    item:cast_spell_on_expiry { spell = "netherium_warp_grenade_detonation", no_fail = true, level = 0 }
    content.add(item)
end
