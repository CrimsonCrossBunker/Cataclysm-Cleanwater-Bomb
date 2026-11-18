local ccb = require("ccb")
local content = ccb.content

do
    -- intended fields: emits; countdown_interval; name
    local item = content.Item {
        id = "abstract_gas_bomb_active",
        abstract = true,
        copy_from = "abstract_gas_bomb_primed",
        description = ccb.content.text("This grenade has had its pin pulled and is now expelling highly toxic gas."),
        countdown_turns = 60,
    }
    item:transform_into { target = "canister_empty" }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("tear gas grenade", "tear gas grenades"),
        description = ccb.content.text("This tear gas grenade has had its pin removed and is expelling highly noxious gas."),
        field_emissions = { "emit_tear_gas_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "smokebomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("smoke grenade", "smoke grenades"),
        mass_milligrams = 680000,
        description = ccb.content.text("This smoke bomb has had its pin removed and is expelling thick smoke."),
        field_emissions = { "emit_smoke_stream" },
        countdown_turns = 100,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("insecticidal gas grenade", "insecticidal gas grenades"),
        field_emissions = { "emit_insecticidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_makeshift_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("makeshift insecticidal gas grenade", "makeshift insecticidal gas grenades"),
        field_emissions = { "emit_small_insecticidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("fungicidal gas grenade", "fungicidal gas grenades"),
        field_emissions = { "emit_fungicidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_makeshift_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("makeshift fungicidal gas grenade", "makeshift fungicidal gas grenades"),
        field_emissions = { "emit_small_fungicidal_stream" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_makeshift_act",
        copy_from = "abstract_gas_bomb_active",
        name = ccb.content.plural_text("makeshift toxic gas grenade", "makeshift toxic gas grenades"),
        countdown_turns = 30,
        field_emissions = { "emit_toxic_stream" },
    }
    content.add(item)
end

do
    -- intended fields: use_action (transform to primed grenade); name; description
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "abstract_gas_bomb_inactive",
        abstract = true,
        category = "weapons",
        looks_like = "smokebomb",
        name = content.plural_text("gas grenade", "gas grenades"),
        description = content.text("A canister grenade filled with a variety of chemicals."),
        mass_milligrams = 431000,
        volume_ml = 459,
        longest_side_mm = 158,
        price_cents = 500,
        price_postapoc_cents = 500,
        symbol = "*",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:flag("CYLINDER_GRENADE")
    content.add(item)
end

do
    -- intended fields: revert_to active grenade; name
    local item = content.Item {
        id = "abstract_gas_bomb_primed",
        abstract = true,
        copy_from = "abstract_gas_bomb_inactive",
        description = ccb.content.text("This grenade has had its pin removed and will shortly be expelling highly toxic gas."),
        looks_like = "smokebomb_act",
        price_cents = 0,
        price_postapoc_cents = 0,
        countdown_turns = 5,
    }
    item:clear_use_actions()
    item:message_on_use {
        message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("DANGEROUS")
    item:flag("SPAWN_ACTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tool_rocket_candy",
        category = "weapons",
        name = ccb.content.plural_text("rocket candy", "rocket candies"),
        description = ccb.content.text("A pear-shaped chunk of rocket candy obtained by heating saltpeter with sugar and casting the obtained liquid.  Can serve as a rocket fuel, but also as a smokescreen - if you light the narrow end, you should be able to throw it before the flame reaches the broad end."),
        mass_milligrams = 250000,
        volume_ml = 250,
        price_cents = 100,
        price_postapoc_cents = 100,
        symbol = "*",
        color = "green",
    }
    item:material("powder_nonflam", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tool_rocket_candy_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Light up"),
        message = ccb.content.text("You light the rocket candy on fire.  Throw it!"),
        need_fire = 1,
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("ACT_IN_FIRE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tool_rocket_candy_primed",
        copy_from = "tool_rocket_candy",
        looks_like = "tool_rocket_candy",
        description = ccb.content.text("A chunk of rocket candy that has been ignited and burns with a loud hiss."),
        countdown_turns = 5,
    }
    item:clear_use_actions()
    item:message_on_use {
        message = ccb.content.text("You've already lit the rocket candy, try throwing it instead."),
        menu_text = ccb.content.text("Light up"),
    }
    item:clear_flags()
    item:flag("DANGEROUS")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "tool_rocket_candy_act" }
    item:tool()
    item:clear_tick_actions()
    item:sound_on_tick { message = ccb.content.text("ssss…"), volume = 5, sound_id = "misc", sound_variant = "lit_fuse" }
    content.add(item)
end

do
    local item = content.Item {
        id = "tool_rocket_candy_act",
        copy_from = "tool_rocket_candy",
        looks_like = "tool_rocket_candy",
        description = ccb.content.text("A chunk of rocket candy that burns with a loud hiss, spewing forth large amounts of smoke."),
        countdown_turns = 30,
        field_emissions = { "emit_smoke_stream" },
    }
    item:clear_use_actions()
    item:message_on_use {
        message = ccb.content.text("You've already lit the rocket candy, try throwing it instead."),
        menu_text = ccb.content.text("Light up"),
    }
    item:clear_flags()
    item:flag("DANGEROUS")
    item:flag("SPAWN_ACTIVE")
    item:tool()
    item:clear_tick_actions()
    item:sound_on_tick { message = ccb.content.text("ssss…"), volume = 10, sound_id = "misc", sound_variant = "lit_fuse" }
    content.add(item)
end
