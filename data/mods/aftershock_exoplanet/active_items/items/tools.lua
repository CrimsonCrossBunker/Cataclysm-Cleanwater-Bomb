local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_atomic_lamp",
        category = "tools",
        name = ccb.content.plural_text("atomic lamp", "atomic lamps"),
        looks_like = "ap_standing_lamp",
        description = ccb.content.text("A fairly hefty and frankly ugly lamp with a thick base and an odd spheroidal \"shade\".  While this is a commercial product, early versions were made from scavenged landing or spacecraft lights.  While the appeal of them there was to lower the maintence burden, as a lamp it's nothing more than a gimmick of infinite, albeit dim light."),
        mass_milligrams = 6000000,
        volume_ml = 2000,
        price_cents = 175000,
        price_postapoc_cents = 4000,
        symbol = ",",
        color = "light_green",
        light = 15,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_atomic_lamp_off" },
        message = ccb.content.text("You close the lamp's cover."),
        menu_text = ccb.content.text("Close cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atomic_lamp_off",
        copy_from = "afs_atomic_lamp",
        looks_like = "afs_atomic_lamp",
        category = "tools",
        name = ccb.content.plural_text("atomic lamp (covered)", "atomic lamps (covered)"),
        description = ccb.content.text("A fairly hefty and frankly ugly lamp with a thick base and an odd spheroidal \"shade\".  While this is a commercial product, early versions were made from scavenged landing or spacecraft lights.  While the appeal of them there was to lower the maintence burden, as a lamp it's nothing more than a gimmick of infinite, albeit dim light.  This one has been closed."),
        light = 0,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_atomic_lamp" },
        message = ccb.content.text("You open the lamp's cover."),
        menu_text = ccb.content.text("Open cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atomic_light",
        category = "tools",
        name = ccb.content.plural_text("atomic reading light", "atomic reading lights"),
        description = ccb.content.text("A commercially produced reading light, with the gimmick of never having to replace batteries thanks to its nuclear decay powered power source.  Instead of having an on/off switch, there is instead a cover you close over it."),
        mass_milligrams = 214000,
        volume_ml = 250,
        price_cents = 125000,
        price_postapoc_cents = 4000,
        symbol = ",",
        color = "light_green",
        light = 10,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_atomic_light_off" },
        message = ccb.content.text("You close the lamp's cover."),
        menu_text = ccb.content.text("Close cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_atomic_light_off",
        copy_from = "afs_atomic_light",
        looks_like = "afs_atomic_light",
        category = "tools",
        name = ccb.content.plural_text("atomic reading light (covered)", "atomic reading lights (covered)"),
        description = ccb.content.text("A commercially produced reading light, with the gimmick of never having to replace batteries thanks to its nuclear decay powered power source.  Instead of having an on/off switch, there is instead a cover you close over it."),
        light = 0,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_atomic_light" },
        message = ccb.content.text("You open the lamp's cover."),
        menu_text = ccb.content.text("Open cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    content.add(item)
end
