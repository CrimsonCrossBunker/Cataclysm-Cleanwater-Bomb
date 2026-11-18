local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_welding_paste",
        name = ccb.content.plural_text("self-welding paste", "self-welding paste"),
        description = ccb.content.text("A pyrotechnic metal suspension that can be applied to metal surfaces and ignited to create 'temporary' welds.  Intended for use in emergency situations."),
        mass_milligrams = 2,
        volume_ml = 1,
        price_cents = 100,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "red",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("powder", 1)
    item:quality("WELD", 2)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("UNRECOVERABLE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atompot",
        name = ccb.content.plural_text("atompot", "atompots"),
        copy_from = "pressure_cooker",
        description = ccb.content.text("Rivtech's premiere self-heating kitchen appliance, complete with lid, hand-crafted with the power of the atom to reach any temperature in thirty seconds.  As bulky as it is, its plutonium power source means that it can be used to cook an absurd amount of meals without ever worrying about running low on power.  Unsurprisingly, sales weren't particularly good because of the prospect of irradiating your food, but internal shielding ensures that only trace amounts find their way into the center."),
        price_cents = 30000,
        price_postapoc_cents = 5000,
        looks_like = "pot",
        symbol = ")",
        color = "light_green",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("COOK", 3)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:quality("CHEM", 1)
    item:quality("HOTPLATE", 2)
    item:clear_use_actions()
    item:native_use("HOTPLATE_ATOMIC")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bionic_maintenance_toolkit",
        copy_from = "screwdriver_set",
        looks_like = "screwdriver_set",
        name = ccb.content.plural_text("bionic maintenance toolkit", "bionic maintenance toolkits"),
        description = ccb.content.text("A set of very small tools and encrypted digital keys normally used to repair bionic modules in clinical settings.  They will allow you to disassemble simple bionics, but anything more complex would require even more specialized tools."),
        replace_qualities = true,
    }
    item:quality("BIONIC_ASSEMBLY", 1)
    item:quality("SCREW_FINE", 1)
    item:quality("WRENCH_FINE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_complete_bionic_toolkit",
        copy_from = "screwdriver_set",
        looks_like = "screwdriver_set",
        name = ccb.content.plural_text("complete bionic toolkit", "complete bionic toolkits"),
        description = ccb.content.text("A set of very small robotic tools and encrypted digital keys originally designed to disassemble and test the quality of industrially produced bionics.  A highly skilled and patient engineer could use them to manually assemble new cybernetics."),
        replace_qualities = true,
    }
    item:quality("BIONIC_ASSEMBLY", 2)
    item:quality("SCREW_FINE", 1)
    item:quality("WRENCH_FINE", 1)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "nano_pseudo_forge",
        name = content.plural_text("pseudo nano forge", "pseudo nano forges"),
        description = content.text("This is a crafting_pseudo_item if you have it something is wrong."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 20000,
        replace_qualities = true,
        symbol = "H",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:quality("NANO_FORGE", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_bio_deck_jack",
        category = "tools",
        name = ccb.content.plural_text("Infolink jack", "Infolink jacks"),
        description = ccb.content.text("The interface jack of an implanted Infolink, coiled within your forearm and accessible through a small port in your wrist.  It can be used to interface and hack into electronic devices."),
        mass_milligrams = 20000,
        volume_ml = 2,
        price_cents = 100,
        symbol = ",",
        color = "green",
        replace_qualities = true,
    }
    item:clear_flags()
    item:flag("INTEGRATED")
    item:flag("UNBREAKABLE")
    item:flag("PERSONAL")
    item:flag("WATER_FRIENDLY")
    item:flag("SOFT")
    item:flag("NO_REPAIR")
    item:flag("ALLOWS_NATURAL_ATTACKS")
    item:flag("TRADER_AVOID")
    item:flag("USES_BIONIC_POWER")
    item:quality("HACK", 4)
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "pseudo_diamond_press",
        name = content.plural_text("pseudo diamond press", "pseudo diamond presses"),
        description = content.text("This is a crafting_pseudo_item if you have it something is wrong."),
        mass_milligrams = 6464000,
        volume_ml = 11356,
        price_cents = 20000,
        replace_qualities = true,
        symbol = "H",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:quality("DIAMONDPRESS", 1)
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "military_mess_kit",
        name = ccb.content.plural_text("military mess kit", "military mess kits"),
        description = ccb.content.text("A military mess kit designed for long-range reconnaissance patrols deployed behind enemy lines.  All of its parts are made from thin sheets of aluminum-superalloy composite and are insulated with ceramic coating.  Relies on a battery-operated hotplate, rather than the smoke-producing chemical-fueled hexamine stove.  Compact, durable and lightweight."),
        mass_milligrams = 900000,
        volume_ml = 1000,
        longest_side_mm = 100,
        price_cents = 6000,
        price_postapoc_cents = 500,
        melee_to_hit = -1,
        symbol = ";",
        color = "green",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("superalloy", 1)
    item:material("ceramic", 1)
    item:quality("COOK", 2)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_use_actions()
    item:native_use("HOTPLATE")
    item:native_use("HEAT_FOOD")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 25, ammo_types = { "battery" }, crafting_subtype = "hotplate_induction" }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_battery_charger",
        category = "other",
        name = ccb.content.plural_text("portable battery charger", "portable battery chargers"),
        looks_like = "box_battery_charger",
        description = ccb.content.text("This small device easily deploys anywhere you need it and will slowly charge all rechargeable batteries placed within it's storage space."),
        mass_milligrams = 3050000,
        color = "cyan",
        symbol = "]",
        volume_ml = 10000,
        price_cents = 10000,
        price_postapoc_cents = 10000,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:deploy_appliance("afs_battery_charger")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:ammo_pocket("battery", 100)
    content.add(item)
end
