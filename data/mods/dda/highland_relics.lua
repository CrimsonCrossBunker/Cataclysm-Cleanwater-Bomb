local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local state = require("portal_storm_state")

ccb.runtime.handler("study_highland_miniature", function(context)
    local character = context.character
    if not character then
        return 0
    end

    local travel = state.checked(services.relocation.travel_to_dimension("highlands",
        { npc_travel_radius = 0, npc_travel_filter = "none", item_travel_radius = -1 }))
    if travel.accepted then
        state.message(character, ccb.services.translate(
            "Your surroundings warp and fold before reforming into a strange landscape."))
    else
        state.message(character, ccb.services.translate(
            "You experience brief vertigo, but nothing dangerous seems to happen."))
    end

    local position = state.position(character)
    local target = services.overmap.find_target(position:project_to("omt"), "highlands", { z = 0 })
    local location = services.world.find_location(target:project_to("ms"))
    if location.found then
        state.checked(variables.set(character, "safe_highland", location.position, { include_before = false }))
    end
    local destination = state.checked(variables.get_tripoint(character, "safe_highland")).value
        or services.coords.tripoint_abs_ms(0, 0, 0)
    state.checked(services.relocation.teleport_character(character, destination))
    return 0
end)

do
    local relic = ccb.content.Item {
        id = "higlands_teleport",
        copy_from = "silver_necklace",
        name = ccb.content.text("landscape miniature"),
        description = ccb.content.text("A desolate scene depicts a sea of fog broken by great mountains and jagged ruins.  The painting seems to shift ever so slightly, as if the winds depicted within were real."),
    }
    relic:armor()
    relic:variants({})
    relic:on_use("study_highland_miniature", ccb.content.text("Activate"), ccb.content.text("Study the miniature."))
    ccb.content.add(relic)
end

do
    local relic = ccb.content.Item {
        id = "higlands_funeral_crown",
        copy_from = "crown_golden",
        name = ccb.content.text("funeral crown"),
        description = ccb.content.text("A golden circlet adorned with filigree leaves and pearls.  The remnants of a white silk veil remain attached to the crown."),
    }
    relic:armor()
    relic:variants({})
    ccb.content.add(relic)
end

do
    local relic = ccb.content.Item {
        id = "highland_funeral_mask",
        name = ccb.content.text("funeral mask"),
        description = ccb.content.text("A serene visage carved from a large piece of ivory.  Its internal surface is completely smooth, and adorned with a a series of concentric bronze rings and grooves.  You could wear it over your face, but it lacks any way to see or comfortably breathe through it."),
        mass_grams = 750,
        volume_ml = 750,
        price_cents = 4000,
        price_postapoc_cents = 10,
        melee_accuracy = { grip = "none", length = "hand", surface = "any", balance = "uneven" },
        symbol = "[",
        color = "green",
    }
    relic:armor { warmth = 5 }
    relic:material("stone", 1)
    relic:clear_flags()
    relic:flag("WATER_FRIENDLY")
    relic:armor_portion {
        covers = { "eyes", "mouth" },
        encumbrance = 40,
        coverage = 95,
        material_thickness = 0.2,
        environmental_protection = 1,
    }
    ccb.content.add(relic)
end

do
    local relic = ccb.content.Item {
        id = "highland_medallion",
        copy_from = "gold_medal",
        name = ccb.content.text("gold medallion"),
        description = ccb.content.text("A small gold medallion."),
        mass_grams = 50,
        volume_ml = 25,
        price_cents = 10000,
        price_postapoc_cents = 25,
        symbol = "[",
        color = "yellow",
    }
    relic:armor()
    relic:material("gold", 1)
    relic:clear_flags()
    relic:flag("NO_WEAR_EFFECT")
    relic:flag("IMPERIAL_ROAD_KEY")
    relic:variants {
        {
            id = "traveler",
            name = ccb.content.text("gold medallion"),
            description = ccb.content.text("Its engraved with an image showing a winged ship over a three peaked mountain."),
            append = true,
            weight = 300,
        },
        {
            id = "tindalos",
            name = ccb.content.text("starbeast icon"),
            description = ccb.content.text("This medallion is engraved with the image of a fanciful beast set before a starfield.  Its head is strangely piscine, with a wide, toothy maw and no eyes."),
            weight = 300,
        },
        {
            id = "realm_map",
            name = ccb.content.text("starchart medallion"),
            description = ccb.content.text("Three articulate discs are mounted within this medallion and can be rotated independently, creating a strange, shifting pattern of holes.  You believe it to be a starchart of some kind, but the allowed movements of the discs don't seem to correspond to how stars move in the sky."),
            weight = 300,
        },
        {
            id = "knight",
            name = ccb.content.text("knight's talisman"),
            description = ccb.content.text("A small sword shaped pendant wrapped in a still pristine indigo handkerchief.  Threads of silver and gold are woven into the fabric."),
            weight = 300,
        },
        {
            id = "faith",
            name = ccb.content.text("tree pendant"),
            description = ccb.content.text("A necklace with a pendant in the shape of a tree.  The treetop and roots are completely symmetrical, and a small sphere-cut gem is set in the center of the trunk."),
            weight = 300,
        },
    }
    ccb.content.add(relic)
end

do
    local relic = ccb.content.Item {
        category = "currency",
        id = "coin_highlands",
        copy_from = "coin_silver",
        name = ccb.content.text("silver obol"),
        description = ccb.content.text("A small silver coin, looted from the dead.  Its face shows the faded profile of a man, the reverse depicts a tree crowned by three starlike eyes."),
    }
    relic:clear_flags()
    relic:flag("MUNDANE")
    relic:passive_enchantment("ITEM_ENCH_dda_coin_highlands_0")
    ccb.content.add(relic)
end

do
    local relic = ccb.content.Item {
        id = "highland_shroud",
        copy_from = "cloak",
        name = ccb.content.text("burial shroud"),
        description = ccb.content.text("A cloak of thin, faded cloth that was used to wrap a corpse.  Its deep blue, and embroidered has been embroidered with a starmap in silver thread."),
    }
    relic:armor()
    relic:variants {
        {
            id = "default",
            description = ccb.content.text("A cloak of thin, faded cloth that was used to wrap a corpse.  Its deep blue, and embroidered has been embroidered with a starmap in silver thread."),
            weight = 500,
        },
        {
            id = "clue",
            description = ccb.content.text("Violet clouds part to reveal a road winding into the starry sky.  The constellations embroidered on this shroud seem to match the ones above you."),
            weight = 500,
        },
        {
            id = "plus",
            description = ccb.content.text("This shroud is dyed a deep, inky black.  The star map embroidered on it is more intricate than others you have seen, and includes a number of small, gem-like beads sewn into the fabric at various points."),
            weight = 500,
        },
        {
            id = "eden",
            description = ccb.content.text("Ramping beasts and blossoming plants are embroidered in gold thread across this shroud, which is dyed a vibrant emerald green."),
            weight = 500,
        },
        {
            id = "empire",
            description = ccb.content.text("White towers rise from a jagged coastline, in a heavily geometric pattern that repeats across the entire shroud."),
            weight = 500,
        },
        {
            id = "noble",
            description = ccb.content.text("A single tower pierces the heavens, its base obscured by swirling clouds.  Heraldic banners have been embroidered to serve as the scene's backdrop, and a large opal has been sewn into the fabric to represent the sun."),
            weight = 0,
        },
        {
            id = "guardian",
            description = ccb.content.text("A cream colored shroud, embroidered with a single, large eye.  The iris is deep blue, and its pupil is a small, black gem."),
            weight = 0,
        },
        {
            id = "tindalos",
            description = ccb.content.text("Fanged beasts devour each other in appalling detail across this shroud.  The embroidery is so intricate that it seems to shift and writhe as you look at it."),
            weight = 500,
        },
    }
    ccb.content.add(relic)
end
