local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fake_smoke_plume",
        copy_from = "fake_item",
        name = ccb.content.plural_text("smoldering embers", "smoldering embers"),
        description = ccb.content.text("A handful of smoldering embers emitting smoke.  They are fading away before your eyes."),
        field_emissions = { "emit_small_smoke_plume" },
    }
    item:flag("TRADER_AVOID")
    item:flag("FAKE_SMOKE")
    content.add(item)
end

do
    local item = content.Item {
        id = "spinwheelitem",
        copy_from = "fake_item",
        name = ccb.content.plural_text("spinning wheel", "spinning wheels"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scutcheritem",
        copy_from = "fake_item",
        name = ccb.content.plural_text("stationary scutcher", "stationary scutchers"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_burrowing",
        copy_from = "fake_item",
        name = ccb.content.plural_text("teeth and claws", "teeth and claws"),
        replace_qualities = true,
    }
    item:clear_use_actions()
    item:native_use("DIG")
    item:quality("DIG", 2)
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_goggles",
        copy_from = "fake_item",
        name = ccb.content.plural_text("bionic goggles", "bionic goggles"),
        replace_qualities = true,
    }
    item:quality("GLARE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bio_scalpel",
        copy_from = "fake_item",
        name = ccb.content.plural_text("autonomous surgical scalpels", "autonomous surgical scalpels"),
        description = ccb.content.text("A system of surgical-grade scalpels.  They allow you to make precise cuts on corpses."),
        techniques = { "PRECISE" },
        replace_qualities = true,
        melee_to_hit = -2,
    }
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 5)
    item:quality("BUTCHER", 14)
    item:clear_melee_damage()
    item:melee_damage("stab", 8)
    item:flag("TRADER_AVOID")
    item:flag("BIONIC_WEAPON")
    item:flag("UNBREAKABLE_MELEE")
    item:flag("SPEAR")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_razor",
        copy_from = "fake_item",
        name = ccb.content.plural_text("bionic razor", "bionic razors"),
        replace_qualities = true,
    }
    item:quality("BUTCHER", 8)
    item:quality("CUT", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_sharp_metal_wreckage",
        copy_from = "fake_item",
        name = ccb.content.plural_text("sharp piece of wreckage", "sharp piece of wreckages"),
        replace_qualities = true,
    }
    item:quality("CUT", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "boulder_anvil",
        copy_from = "fake_item",
        name = ccb.content.plural_text("boulder anvil", "boulder anvils"),
        replace_qualities = true,
    }
    item:quality("ANVIL", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_anvil",
        copy_from = "fake_item",
        name = ccb.content.plural_text("anvil", "anvils"),
        replace_qualities = true,
    }
    item:quality("ANVIL", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_anvil_heavy",
        copy_from = "fake_item",
        name = ccb.content.plural_text("heavy anvil", "heavy anvils"),
        replace_qualities = true,
    }
    item:quality("ANVIL", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_firestarter",
        copy_from = "fake_item",
        name = ccb.content.plural_text("bionic firestarter", "bionic firestarters"),
    }
    item:flag("FIRESTARTER")
    item:flag("USES_BIONIC_POWER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_radio",
        copy_from = "fake_item",
        name = ccb.content.plural_text("bionic radio", "bionic radios"),
    }
    item:flag("TWO_WAY_RADIO")
    item:flag("USES_BIONIC_POWER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_tire_changer",
        copy_from = "fake_item",
        name = ccb.content.plural_text("tire changer", "tire changers"),
        replace_qualities = true,
    }
    item:quality("PRY", 1)
    item:quality("PRESSURIZATION", 1)
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("PSEUDO")
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "fake_power_tool",
        copy_from = "fake_item",
        name = content.plural_text("fake power tool", "fake power tools"),
    }
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("PSEUDO")
    item:flag("USE_UPS")
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_arc_furnace",
        copy_from = "fake_power_tool",
        looks_like = "fake_power_tool",
        name = ccb.content.plural_text("arc furnace", "arc furnaces"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_beverly_shear",
        copy_from = "fake_item",
        name = ccb.content.plural_text("Beverly shear", "Beverly shears"),
        replace_qualities = true,
    }
    item:quality("SAW_M", 2)
    item:flag("ALLOWS_REMOTE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "glassblowers_crucible_tool",
        name = ccb.content.plural_text("glassblower's crucible", "glassblower's crucibles"),
        copy_from = "fake_appliance_tool",
        symbol = "o",
        color = "brown",
    }
    item:flag("ALLOWS_REMOTE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tablesaw_tool",
        name = ccb.content.plural_text("table saw", "table saws"),
        copy_from = "fake_appliance_tool",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mitresaw_tool",
        name = ccb.content.plural_text("mitre saw", "mitre saws"),
        copy_from = "fake_appliance_tool",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bandsaw_tool",
        name = ccb.content.plural_text("band saw", "band saws"),
        copy_from = "fake_appliance_tool",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "router_tool",
        name = ccb.content.plural_text("router", "routers"),
        copy_from = "fake_appliance_tool",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "planer_tool",
        name = ccb.content.plural_text("planer", "planers"),
        copy_from = "fake_appliance_tool",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "jointer_tool",
        name = ccb.content.plural_text("jointer", "jointers"),
        copy_from = "fake_appliance_tool",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hydraulic_press_tool",
        copy_from = "fake_appliance_tool",
        name = ccb.content.plural_text("hydraulic press", "hydraulic presses"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_exercise_machine",
        name = ccb.content.plural_text("exercise machine", "exercise machines"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "T",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_punching_bag",
        name = ccb.content.plural_text("heavy punching bag", "heavy punching bags"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "0",
        color = "dark_gray",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_ergometer_mechanical",
        name = ccb.content.plural_text("mechanical ergometer", "mechanical ergometers"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "5",
        color = "dark_gray",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_treadmill_mechanical",
        name = ccb.content.plural_text("gravity treadmill", "gravity treadmills"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "L",
        color = "dark_gray",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_training_dummy_light",
        name = ccb.content.plural_text("training dummy", "training dummies"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "@",
        color = "brown",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_training_dummy_heavy",
        name = ccb.content.plural_text("armored training dummy", "armored training dummies"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "@",
        color = "brown",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_archery_target_box",
        name = ccb.content.plural_text("box archery target", "box archery targets"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "@",
        color = "brown",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_archery_target_bale",
        name = ccb.content.plural_text("bale archery target", "bale archery targets"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        symbol = "@",
        color = "yellow",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_lift_light",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("light hoist", "light hoists"),
        replace_qualities = true,
    }
    item:quality("LIFT", 2)
    item:quality("ROPE", 2)
    item:quality("SUSPENDING", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_lift_medium",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("sturdy hoist", "sturdy hoists"),
        replace_qualities = true,
    }
    item:quality("LIFT", 8)
    item:quality("ROPE", 2)
    item:quality("SUSPENDING", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_lift_heavy",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("heavy-duty hoist", "heavy-duty hoists"),
        replace_qualities = true,
    }
    item:quality("LIFT", 40)
    item:quality("ROPE", 2)
    item:quality("SUSPENDING", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pseudo_app_oxygen_concentrator",
        name = ccb.content.plural_text("oxygen concentrator", "oxygen concentrators"),
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        replace_pockets = true,
    }
    item:magazine_well { default_magazine = "pseudo_battery" }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "concrete_mix_tool",
        name = ccb.content.plural_text("concrete mixer", "concrete mixers"),
        copy_from = "fake_appliance_tool",
    }
    item:tool { charges_per_use = 20 }
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_lathe",
        copy_from = "fake_appliance_tool",
        name = ccb.content.plural_text("lathe", "lathes"),
    }
    item:tool { charges_per_use = 25 }
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_deep_fryer",
        copy_from = "fake_appliance_tool",
        name = ccb.content.plural_text("deep fryer", "deep fryers"),
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fake_oil_press_industrial",
        copy_from = "fake_appliance_tool",
        name = ccb.content.plural_text("industrial oil press", "industrial oil presses"),
    }
    item:tool()
    content.add(item)
end
