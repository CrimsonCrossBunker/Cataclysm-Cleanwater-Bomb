local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_landfall_kit_2",
        name = ccb.content.plural_text("Type II. landfall survival kit", "Type II. landfall survival kits"),
        description = ccb.content.text("This is a metal box containing survival supplies, often found within ships and their escape pods.  Its cyan highlights indicate that it's a simpler Type II kit, and that it would only be helpful in a planet whose atmosphere and gravity are within two deviations from Earth's."),
        mass_milligrams = 1022000,
        volume_ml = 22000,
        price_postapoc_cents = 3000,
        symbol = ",",
        color = "red",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 20000, max_weight_milligrams = 40000000, max_item_length_mm = 1330, rigid = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_augustmoon_kit_box",
        name = ccb.content.plural_text("survival kit", "survival kits"),
        description = ccb.content.text("A survival kit box clearly repurposed from a ship's escape pod.  It contains a variety of supplies to help you survive planetside."),
        mass_milligrams = 1022000,
        volume_ml = 32000,
        price_postapoc_cents = 500,
        symbol = ",",
        color = "red",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 30000, max_weight_milligrams = 40000000, max_item_length_mm = 1330, rigid = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cargo_crate",
        name = ccb.content.plural_text("cargo crate", "cargo crates"),
        description = ccb.content.text("A standard orbital cargo transfer container.  Its faceted corners are adorned with the livery of company you don't recognize."),
        mass_milligrams = 2710000,
        volume_ml = 30000,
        price_postapoc_cents = 3000,
        symbol = "0",
        color = "light_red",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 28000, max_weight_milligrams = 40000000, max_item_length_mm = 1700, rigid = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_sample_container",
        category = "container",
        name = ccb.content.plural_text("cryogenic flask", "cryogenic flasks"),
        looks_like = "thermos",
        description = ccb.content.text("A sealed flask used to transport hazardous and delicate materials.  Of advanced design, it utilizes a miniaturized Riemann barrier to achieve both perfect insulation and containment.  Although the scientific principles of Riemann barriers are not completely lost, its exceedingly difficult for contemporary industry to produce emitters of this size, making these containers extremely valuable."),
        ascii_picture = "thermos",
        mass_milligrams = 530000,
        volume_ml = 1250,
        longest_side_mm = 320,
        price_cents = 17500,
        price_postapoc_cents = 17500,
        symbol = "I",
        color = "green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_sample_container_on" },
        menu_text = ccb.content.text("Turn on"),
        message = ccb.content.text("You activate your %s.  A faint humming noise can be heard as the Riemann barrier powers up."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("BELT_CLIP")
    item:tool { ammo_types = { "battery" } }
    item:container_pocket {
        max_volume_ml = 750,
        max_weight_milligrams = 4000000,
        rigid = true,
        watertight = true,
        insulation = 3000,
    }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        holster = true,
        allowed_items = { "afs_compact_cartridge" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_sample_container_on",
        copy_from = "afs_sample_container",
        looks_like = "afs_sample_container",
        name = ccb.content.plural_text("cryogenic flask", "cryogenic flasks"),
        description = ccb.content.text("A sealed flask used to transport hazardous and delicate materials.  Of advanced design, it utilizes a miniaturized Riemann barrier to achieve both perfect insulation and containment.  Its currently active, and its contents are completely inaccessible."),
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "afs_sample_container" },
        menu_text = ccb.content.text("Turn off"),
        message = ccb.content.text("Your %s deactivates."),
        ammo_scale = 0,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("BELT_CLIP")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "afs_sample_container" }
    item:tool { power_milliwatts = 11111 }
    item:container_pocket {
        max_volume_ml = 1000,
        max_weight_milligrams = 4000000,
        rigid = true,
        watertight = true,
        insulation = 3000,
        spoil_multiplier = 0.0,
    }
    item:magazine_well {
        max_volume_ml = 200000000,
        max_weight_milligrams = 2000000000000,
        holster = true,
        allowed_items = { "afs_compact_cartridge" },
    }
    content.add(item)
end
