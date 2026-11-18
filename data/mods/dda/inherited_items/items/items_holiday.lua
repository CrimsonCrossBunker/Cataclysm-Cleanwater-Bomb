local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "decorative_wreath",
        name = ccb.content.plural_text("yule wreath", "yule wreaths"),
        description = ccb.content.text("A decorative wreath that can be deployed as furniture to celebrate the winter holidays."),
        mass_milligrams = 1814000,
        volume_ml = 4000,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "0",
        color = "green",
        looks_like = "steel_plate",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_winter_wreath")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_jack_o_lantern",
        name = ccb.content.plural_text("plastic jack o'lantern", "plastic jack o'lanterns"),
        description = ccb.content.text("A plastic lantern that is painted to look like a pumpkin with a face.  It has a tiny LED light inside, which is currently off.  It's mostly for seasonal decoration and doesn't provide very much light."),
        mass_milligrams = 113000,
        volume_ml = 3964,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "0",
        color = "yellow",
        looks_like = "pumpkin",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "plastic_jack_o_lantern_lit" },
        message = ccb.content.text("You flip the switch in the jack-o'-lantern."),
        menu_text = ccb.content.text("Light", "verb"),
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_jack_o_lantern_lit",
        copy_from = "plastic_jack_o_lantern",
        looks_like = "plastic_jack_o_lantern",
        name = ccb.content.plural_text("spooky plastic jack o'lantern", "spooky plastic jack o'lanterns"),
        description = ccb.content.text("A plastic lantern that is painted to look like a pumpkin with a face.  It has a tiny LED light inside which is currently on, to delightfully spooky effect.  It doesn't provide very much light, but it can stay lit for a very long time."),
        price_cents = 0,
        light = 6,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "plastic_jack_o_lantern" },
        message = ccb.content.text("The LED winks out inside the lantern."),
        menu_text = ccb.content.text("Extinguish"),
        ammo_scale = 0,
    }
    item:flag("TRADER_AVOID")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "plastic_jack_o_lantern" }
    item:tool { turns_per_charge = 1350 }
    content.add(item)
end

do
    local item = content.Item {
        id = "jackolantern",
        name = ccb.content.plural_text("jack-o'-lantern", "jack-o'-lanterns"),
        description = ccb.content.text("A carved pumpkin with a candle inside it.  You could light it to really set the spooky mood."),
        mass_milligrams = 123000,
        color = "light_red",
        volume_ml = 3000,
        price_cents = 250,
        price_postapoc_cents = 50,
        symbol = "%",
        replace_pockets = true,
    }
    item:material("veggy", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "jackolantern_lit" },
        message = ccb.content.text("You light the jack-o'-lantern."),
        menu_text = ccb.content.text("Light", "verb"),
        need_fire = 1,
    }
    item:clear_flags()
    item:flag("BURNOUT")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { candle_wax = 100 }, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "jackolantern_lit",
        copy_from = "jackolantern",
        looks_like = "jackolantern",
        name = ccb.content.plural_text("lit jack-o'-lantern", "lit jack-o'-lanterns"),
        description = ccb.content.text("A carved pumpkin with a lit candle inside.  Spooky and festive!"),
        light = 8,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "jackolantern" },
        message = ccb.content.text("You blow out the jack-o'-lantern."),
        menu_text = ccb.content.text("Extinguish"),
        ammo_scale = 0,
    }
    item:flag("WATER_EXTINGUISH")
    item:flag("TRADER_AVOID")
    item:flag("WIND_EXTINGUISH")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "jackolantern" }
    item:tool { turns_per_charge = 1260 }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "inflatable_decoration",
        abstract = true,
        name = content.plural_text("inflatable", "inflatables"),
        description = content.text("A generic inflatable abstract to use for specific items."),
        mass_milligrams = 3000000,
        volume_ml = 5000,
        price_cents = 5000,
        symbol = "P",
        color = "light_red",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:tool { charges_per_use = 14 }
    content.add(item)
end

do
    local item = content.Item {
        id = "inflatable_dragon",
        copy_from = "inflatable_decoration",
        name = ccb.content.plural_text("inflatable dragon", "inflatable dragons"),
        description = ccb.content.text("A battery-powered inflatable dragon from the Halloween before the end.  It might be fun to display it somewhere."),
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "dragon_inflatable", no_fail = true, level = 1 }
    item:tool { ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "inflatable_ghost",
        copy_from = "inflatable_decoration",
        name = ccb.content.plural_text("inflatable ghost", "inflatable ghosts"),
        description = ccb.content.text("A battery-powered inflatable ghost from the Halloween before the end.  It might be fun to display it somewhere."),
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "ghost_inflatable", no_fail = true, level = 1 }
    item:tool { ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fog_machine",
        copy_from = "inflatable_decoration",
        name = ccb.content.plural_text("fog machine", "fog machines"),
        description = ccb.content.text("A battery-powered fog machine.  It would be great for setting ambience."),
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "fog_machine", no_fail = true, level = 1 }
    item:tool { ammo_types = { "battery" } }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        rigid = true,
        allowed_flags = { "BATTERY_MEDIUM" },
        default_magazine = "medium_battery_cell",
    }
    content.add(item)
end
