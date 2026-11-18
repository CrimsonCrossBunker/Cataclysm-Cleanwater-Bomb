local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "living_brain_jar",
        category = "other",
        name = ccb.content.plural_text("living brain in a jar", "jars full of living brains"),
        description = ccb.content.text("This jar contains a human brain kept alive by mi-go technology.  It has metal veined tendrils that appear to allow it to connect to various devices."),
        mass_milligrams = 365000,
        volume_ml = 3000,
        price_cents = 100,
        melee_to_hit = -1,
        symbol = ")",
        color = "pink",
        looks_like = "fluid_preserved_brain",
    }
    item:material("alien_resin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "humming_heart",
        category = "other",
        name = ccb.content.plural_text("humming heart", "humming hearts"),
        description = ccb.content.text("This heartlike organ has multiple valves and upon its proper removal from the bioweapons corpse each valve sealed itself.  It hums gently in your hands, as if waiting for an appropriate receptacle."),
        mass_milligrams = 1400000,
        volume_ml = 1000,
        price_cents = 100,
        melee_to_hit = -1,
        symbol = ")",
        color = "pink",
        looks_like = "jabberwock_heart",
    }
    item:material("flesh", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "sensory_cluster",
        category = "other",
        name = ccb.content.plural_text("sensory cluster", "sensory clusters"),
        description = ccb.content.text("This lump of flesh has various lobes protruding from it that at intervals will emit toned sounds.  Perhaps it works via echolocation.  Like all mi-go bioparts the openings on this piece closed up after it was cut free and it seems to have gone into a form of hibernation with the pulses occurring slower and slower as it conserves energy."),
        mass_milligrams = 40000,
        volume_ml = 250,
        price_cents = 100,
        melee_to_hit = -1,
        symbol = ")",
        color = "pink",
        looks_like = "kidney",
    }
    item:material("alien_resin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "bioweapon_chassis",
        category = "other",
        name = ccb.content.plural_text("bioweapon chassis", "bioweapon chassis"),
        description = ccb.content.text("This cross between a sea anemone and what you imagine a dragon's mouth would look like is the core body of the bioweapon.  You cannot imagine what you could make out of this but maybe someone somewhere does."),
        mass_milligrams = 40000000,
        volume_ml = 25000,
        price_cents = 100,
        melee_to_hit = -3,
        symbol = ")",
        color = "pink",
        looks_like = "ruined_chunks",
    }
    item:material("alien_resin", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_afs_mon_migoturret",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken mi-go turret", "broken mi-go turrets"),
        category = "other",
        description = ccb.content.text("A broken mi-go turret.  It's leaking fluids and smells you can't identify.  Could be butchered for parts."),
        price_cents = 1000,
        mass_milligrams = 40750000,
        volume_ml = 30000,
        melee_to_hit = -3,
    }
    item:material("alien_resin", 1)
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 6)
    content.add(item)
end
