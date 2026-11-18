local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "beartrap",
        name = ccb.content.plural_text("bear trap", "bear traps"),
        category = "traps",
        description = ccb.content.text("A spring-loaded pair of steel jaws connected to a sensitive pressure plate.  Use it to set it on the ground, creating a trap that will ensnare and damage anything that steps on it.  If you are carrying a shovel, you will have the option of burying it."),
        mass_milligrams = 14000000,
        volume_ml = 1500,
        price_cents = 6000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_beartrap",
        moves = 200,
        practice = 4,
        message = ccb.content.text("You set the beartrap."),
        allow_underwater = true,
        bury_question = ccb.content.text("Bury the beartrap?"),
        buried = { trap = "tr_beartrap_buried", moves = 36000, practice = 7, message = ccb.content.text("You bury the beartrap.") },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "light_snare_kit",
        name = ccb.content.plural_text("light snare kit", "light snare kits"),
        category = "traps",
        description = ccb.content.text("A simple loop snare, comprising a carefully wound loop of string, two anchor points, and a tool to hammer them in.  It is suitable for immobilizing only small animals.  It has no means of harming its target, as live meat lasts longer."),
        mass_milligrams = 2500000,
        volume_ml = 3150,
        longest_side_mm = 800,
        price_cents = 1500,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_light_snare",
        moves = 2500,
        practice = 2,
        message = ccb.content.text("You set the snare trap."),
    }
    item:tool()
    content.add(item)
end

do
    -- 撤销 PR #86231 — 恢复刀片陷阱物品
    local item = content.Item {
        id = "blade_trap",
        name = ccb.content.plural_text("blade trap", "blade traps"),
        category = "traps",
        description = ccb.content.text("A machete attached laterally to a motor, with a tripwire controlling its throttle.  When the tripwire is pulled, the blade is swung around with great force.  The trap forms a 3x3 area of effect."),
        mass_milligrams = 10142000,
        volume_ml = 9500,
        price_cents = 5000,
        price_postapoc_cents = 1500,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_engine",
        moves = 400,
        practice = 12,
        message = ccb.content.text("You set the blade trap 2 squares away."),
        outer_layer_trap = "tr_blade",
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "board_trap",
        name = ccb.content.plural_text("nailboard trap", "nailboard traps"),
        category = "traps",
        description = ccb.content.text("Several pieces of wood nailed together, with some nails sticking straight up.  If an unsuspecting victim steps on it, they'll get nails through the foot."),
        mass_milligrams = 3917000,
        volume_ml = 3750,
        longest_side_mm = 650,
        price_cents = 0,
        price_postapoc_cents = 25,
        melee_to_hit = -3,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_nailboard",
        moves = 400,
        practice = 2,
        message = ccb.content.text("You set the board trap on the %s, nails facing up."),
        allow_underwater = true,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("stab", 6)
    item:tool()
    content.add(item)
end

do
    -- This has to be rigged in place, so it takes a while to set up.
    local item = content.Item {
        id = "boobytrap",
        name = ccb.content.plural_text("booby trap", "booby traps"),
        category = "traps",
        description = ccb.content.text("A crude explosive device triggered by a piece of string.  Use it to set it up and wait for some poor bastard to trigger it."),
        mass_milligrams = 586000,
        volume_ml = 750,
        price_cents = 5000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = ";",
        color = "red",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_boobytrap",
        moves = 6000,
        practice = 4,
        message = ccb.content.text("You set the booby trap up and activate the grenade."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bubblewrap",
        name = ccb.content.plural_text("bubble wrap", "bubble wraps"),
        category = "traps",
        description = ccb.content.text("A sheet of plastic covered with air-filled bubbles.  Use it to set it on the ground, creating a trap that will warn you with noise when something steps on it."),
        mass_milligrams = 6000,
        volume_ml = 250,
        price_cents = 50,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_cyan",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_bubblewrap",
        moves = 150,
        practice = 2,
        message = ccb.content.text("You set the bubble wrap on the ground, ready to be popped."),
        allow_underwater = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- Caltrops are meant to be scatterable in such a way that one point always sticks up, so this can just be done blindly and very quickly.
    local item = content.Item {
        id = "caltrops",
        name = ccb.content.plural_text("loose caltrops", "loose caltrops"),
        category = "traps",
        description = ccb.content.text("A handful of small metal objects covered with many sharp points.  If an unsuspecting victim steps on one, they'll get a spine through the foot."),
        mass_milligrams = 264000,
        volume_ml = 250,
        price_cents = 900,
        price_postapoc_cents = 100,
        melee_to_hit = -5,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("iron", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_caltrops",
        moves = 150,
        practice = 2,
        message = ccb.content.text("You scatter the caltrops on the %s."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("cut", 8)
    item:tool()
    content.add(item)
end

do
    -- Caltrops are meant to be scatterable in such a way that one point always sticks up, so this can just be done blindly and very quickly.
    local item = content.Item {
        id = "caltrops_glass",
        name = ccb.content.plural_text("loose glass caltrops", "loose glass caltrops"),
        category = "traps",
        description = ccb.content.text("A handful of glass shards glued together to expose all their sharp edges.  If an unsuspecting victim steps on one, they'll get cut."),
        mass_milligrams = 264000,
        volume_ml = 500,
        price_cents = 100,
        price_postapoc_cents = 50,
        melee_to_hit = -5,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_caltrops_glass",
        moves = 150,
        practice = 2,
        message = ccb.content.text("You scatter the glass caltrops on the %s."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "crossbow_trap",
        name = ccb.content.plural_text("crossbow trap", "crossbow traps"),
        category = "traps",
        description = ccb.content.text("A simple tripwire attached to the trigger of a loaded crossbow.  When the tripwire is pulled, the crossbow fires.  Only a single bolt can be used, after which the trap is disabled."),
        mass_milligrams = 1772000,
        volume_ml = 1750,
        price_cents = 6000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "green",
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_crossbow",
        moves = 6000,
        practice = 4,
        message = ccb.content.text("You set the crossbow trap."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "landmine",
        name = ccb.content.plural_text("land mine", "land mines"),
        category = "traps",
        description = ccb.content.text("A military anti-personnel fragmentation mine that is triggered when stepped on."),
        mass_milligrams = 2360000,
        volume_ml = 500,
        price_cents = 5000,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_landmine",
        moves = 200,
        practice = 4,
        message = ccb.content.text("You set the land mine."),
        bury_question = ccb.content.text("Bury the land mine?"),
        buried = { trap = "tr_landmine_buried", moves = 36000, practice = 7, message = ccb.content.text("You bury the land mine.") },
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "shotgun_trap",
        name = ccb.content.plural_text("shotgun trap", "shotgun traps"),
        category = "traps",
        description = ccb.content.text("A simple tripwire attached to the trigger of a loaded double slam-fire shotgun.  When the tripwire is pulled, the shotgun fires.  Two shells are loaded; the first time the trigger is pulled, one or both shells may be discharged."),
        mass_milligrams = 2922000,
        volume_ml = 1750,
        price_cents = 25000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_shotgun_2",
        moves = 6000,
        practice = 5,
        message = ccb.content.text("You set the shotgun trap."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tripwire",
        name = ccb.content.plural_text("tripwire trap", "tripwire traps"),
        category = "traps",
        description = ccb.content.text("A length of thin string with some affixing tools on either end.  It must be placed across a doorway or other thin passage to function.  Its purpose is to trip up trespassers, causing them to stumble and possibly hurt themselves slightly."),
        mass_milligrams = 40000,
        volume_ml = 250,
        price_cents = 300,
        price_postapoc_cents = 10,
        melee_to_hit = -5,
        symbol = ";",
        color = "light_gray",
    }
    item:material("cotton", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_tripwire",
        moves = 6000,
        practice = 3,
        message = ccb.content.text("You string up the tripwire."),
        needs_solid_neighbor = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    -- Caltrops are meant to be scatterable in such a way that one point always sticks up, so this can just be done blindly and very quickly.
    local item = content.Item {
        id = "caltrops_teeth",
        name = ccb.content.plural_text("loose teeth caltrops", "loose teeth caltrops"),
        category = "traps",
        description = ccb.content.text("A handful of small impossibly-sharp teeth glued together.  If an unsuspecting victim steps on one, they'll get a tooth through the foot."),
        mass_milligrams = 264000,
        volume_ml = 500,
        price_cents = 100,
        price_postapoc_cents = 50,
        melee_to_hit = -5,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("bone", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_caltrops_teeth",
        moves = 150,
        practice = 2,
        message = ccb.content.text("You scatter the teeth caltrops on the %s."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("cut", 12)
    item:tool()
    content.add(item)
end
