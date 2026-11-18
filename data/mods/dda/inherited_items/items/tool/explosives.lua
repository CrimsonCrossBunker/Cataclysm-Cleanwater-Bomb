local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "firecracker_pack",
        name = ccb.content.plural_text("pack of firecrackers", "packs of firecrackers"),
        description = ccb.content.text("A pack of 25 firecrackers with a starter fuse.  Use this item to light the fuse.  Of course, you will need a lighter or some matches to do so.  Shortly after you light the fuse they will begin to explode, so throw them quickly!"),
        mass_milligrams = 80000,
        volume_ml = 630,
        price_cents = 100,
        price_postapoc_cents = 100,
        symbol = "*",
        color = "red",
    }
    item:material("paper", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "firecracker_pack_act", timer_turns = 27 },
        message = ccb.content.text("You light the pack of firecrackers."),
        need_wielding = true,
        menu_text = ccb.content.text("Light up"),
        need_fire = 1,
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "firecracker_pack_act",
        copy_from = "firecracker_pack",
        looks_like = "firecracker_pack",
        description = ccb.content.text("A pack of 25 firecrackers that has been lit; the fuse is hissing.  Throw them quickly before they start to explode."),
    }
    item:clear_use_actions()
    item:message_on_use {
        message = ccb.content.text("You've already lit the fuse, try throwing it instead."),
        menu_text = ccb.content.text("Light up"),
    }
    item:clear_flags()
    item:flag("DANGEROUS")
    item:flag("SPAWN_ACTIVE")
    item:tool()
    item:clear_tick_actions()
    item:native_on_tick("FIRECRACKER_PACK_ACT")
    content.add(item)
end

do
    local item = content.Item {
        id = "grenade_inc_act",
        copy_from = "grenade_inc",
        looks_like = "grenade_inc",
        description = ccb.content.text("An active incendiary grenade, likely to burst into an inferno any second now.  Better throw it!"),
        countdown_turns = 5,
    }
    item:clear_flags()
    item:flag("ACT_IN_FIRE")
    item:flag("DANGEROUS")
    item:flag("SPAWN_ACTIVE")
    item:tool()
    item:native_on_expiry("GRENADE_INC_ACT")
    content.add(item)
end
