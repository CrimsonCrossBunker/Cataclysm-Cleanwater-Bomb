local ccb = require("ccb")
local content = ccb.content

content.add(
    content.Item {
        id = "fakeitem_statue",
        name = ccb.content.text("nearby warp obelisk"),
        description = "This is a crafting_pseudo_item if you have it something is wrong.",
        symbol = "X",
        color = "red",
        mass_grams = 70000,
        volume_ml = 100000,
    }
        :material("stone", 1)
        :tool()
)

content.add(
    content.Item {
        id = "fakeitem_infinitree1",
        name = ccb.content.text("nearby infinity tree"),
        description = "This is a crafting_pseudo_item if you have it something is wrong.",
        symbol = "T",
        color = "red",
        mass_grams = 70000,
        volume_ml = 100000,
    }
        :material("wood", 1)
        :tool()
)

content.add(
    content.Item {
        id = "fakeitem_infinitystone",
        name = ccb.content.text("nearby infinity stone"),
        description = "This is a crafting_pseudo_item if you have it something is wrong.",
        symbol = "T",
        color = "red",
        mass_grams = 70000,
        volume_ml = 100000,
    }
        :material("wood", 1)
        :tool()
)

content.add(
    content.Item {
        id = "fakeitem_infinityore",
        name = ccb.content.text("nearby infinity ore"),
        description = "This is a crafting_pseudo_item if you have it something is wrong.",
        symbol = "T",
        color = "red",
        mass_grams = 70000,
        volume_ml = 100000,
    }
        :material("wood", 1)
        :tool()
)

content.add(
    content.Item {
        id = "warpbag_base",
        name = "warped bag",
        description = "This is a template you shouldn't actually see.",
        symbol = "[",
        color = "light_gray",
        looks_like = "backpack",
        mass_grams = 400,
        volume_ml = 2000,
        longest_side_mm = 11000,
    }
        :material("alien_resin", 1)
        :flag("NO_SALVAGE")
        :flag("ALLOWS_NATURAL_ATTACKS")
        :flag("TRADER_AVOID")
        :flag("OVERSIZE")
        :flag("PADDED")
        :flag("ONE_PER_LAYER")
        :flag("UNBREAKABLE")
        :flag("SEMITANGIBLE")
        :flag("AURA")
        :flag("TARDIS")
        :armor {
            warmth = 0,
            max_worn = 1,
        }
        :armor_portion {
            coverage = 0,
            covers = { "torso" },
            materials = { "alien_resin" },
            material_thickness = 1,
            environmental_protection = 0,
        }
)

content.add(
    content.Item {
        id = "warpdirtbag",
        name = ccb.content.text("warped excavator's bag"),
        description = ccb.content.text("THIS ITEM HAS BEEN OBSOLETED.  If you have one from an old save, you may continue to use it, but no more may be crafted.  You can deconstruct this for a full refund on warp shards."),
        copy_from = "warpbag_base",
    }
        :container_pocket {
            max_volume_ml = 4000000,
            max_weight_milligrams = 2000000000,
            max_item_length_mm = 10000,
            weight_multiplier = 0.001,
            allowed_items = {
                "material_soil",
                "material_cement",
                "material_gravel",
                "material_sand",
                "material_shrd_limestone",
                "rock_flaking",
                "flint",
                "rock_large",
                "rock",
                "pebble",
                "clay_lump",
                "brick",
                "mortar_build",
                "mortar_lime",
                "soft_adobe_brick",
                "adobe_brick",
                "mortar_adobe",
                "concrete",
            },
            moves = 1,
            rigid = true,
        }
)

content.add(
    content.Item {
        id = "warpmetalbag",
        name = ccb.content.text("warped scrapper's bag"),
        description = ccb.content.text("THIS ITEM HAS BEEN OBSOLETED.  If you have one from an old save, you may continue to use it, but no more may be crafted.  You can deconstruct this for a full refund on warp shards."),
        copy_from = "warpbag_base",
    }
        :container_pocket {
            max_volume_ml = 120000,
            max_weight_milligrams = 2000000000,
            max_item_length_mm = 10000,
            weight_multiplier = 0.001,
            allowed_items = {
                "wire",
                "nail",
                "hinge",
                "nuts_bolts",
                "pipe_fittings",
                "hd_pipe_fittings",
                "cable",
                "copper_wire",
                "sheet_metal",
                "steel_plate",
                "alloy_plate",
                "hard_plate",
                "mil_plate",
                "pipe",
                "scrap",
                "cu_pipe",
                "material_aluminium_ingot",
                "gold_small",
                "lead",
                "sheet_metal_small",
                "steel_chunk",
                "hc_steel_chunk",
                "mc_steel_chunk",
                "lc_steel_chunk",
                "steel_lump",
                "scrap_copper",
                "scrap_aluminum",
                "foldframe",
                "xlframe",
                "foldxlframe",
                "frame",
                "hdframe",
                "anvil",
                "anvil_bronze",
            },
            moves = 1,
            rigid = true,
        }
)

content.add(
    content.Item {
        id = "warphaulbag",
        name = ccb.content.plural_text("warped hauler's harness", "warped hauler's harnesses"),
        description = ccb.content.text("A looped pair of shimmering blue-black straps that can be worn over the shoulders like a harness.  They can snugly fit a single item of nearly any size in comfort, and any burdens carried here feel three quarters as heavy.  Ideal for squeezing one more bulky item home through the exit when your hands are already full, or even some container packed full of other items!  Just beware you don't break your back doing it."),
        copy_from = "warpbag_base",
    }
        :container_pocket {
            max_volume_ml = 8000000,
            max_weight_milligrams = 8000000000,
            max_item_length_mm = 10000,
            weight_multiplier = 0.75,
            moves = 2000,
            rigid = true,
            holster = true,
        }
)

content.add(
    content.Item {
        id = "warphaulbag_tier2",
        name = ccb.content.plural_text("warped hauler's harness mk II", "warped hauler's harnesses mk II"),
        description = ccb.content.text("A looped pair of shimmering blue-black straps that can be worn over the shoulders like a harness.  They can snugly fit a single item of nearly any size in comfort, and any burdens carried here feel half as heavy.  Ideal for squeezing one more bulky item home through the exit when your hands are already full, or even some container packed full of other items!  Just beware you don't break your back doing it."),
        copy_from = "warpbag_base",
    }
        :container_pocket {
            max_volume_ml = 8000000,
            max_weight_milligrams = 8000000000,
            max_item_length_mm = 10000,
            weight_multiplier = 0.5,
            moves = 2000,
            rigid = true,
            holster = true,
        }
)

content.add(
    content.Item {
        id = "warphaulbag_tier3",
        name = ccb.content.plural_text("warped hauler's harness mk III", "warped hauler's harnesses mk III"),
        description = ccb.content.text("A looped pair of shimmering blue-black straps that can be worn over the shoulders like a harness.  They can snugly fit a single item of nearly any size in comfort, and any burdens carried here feel a quarter as heavy.  Ideal for squeezing one more bulky item home through the exit when your hands are already full, or even some container packed full of other items!  Just beware you don't break your back doing it."),
        copy_from = "warpbag_base",
    }
        :container_pocket {
            max_volume_ml = 8000000,
            max_weight_milligrams = 8000000000,
            max_item_length_mm = 10000,
            weight_multiplier = 0.25,
            moves = 2000,
            rigid = true,
            holster = true,
        }
)

content.add(
    content.Item {
        id = "warp_carrier",
        name = ccb.content.text("warped animal carrier"),
        description = ccb.content.text("A hand-sized cage with a shimmering portal at its aperture.  Despite being shaped more like a cat carrier, the power of warp enables it to capture creatures far bigger than you.  This may be your best bet for bringing animals home to your island sanctuary.  Activate to capture an adjacent animal, or to release a carried animal."),
        symbol = "#",
        color = "light_gray",
        looks_like = "pet_carrier",
        mass_grams = 1000,
        volume_ml = 5000,
    }
        :material("alien_resin", 1)
        :flag("TRADER_AVOID")
        :flag("UNBREAKABLE")
        :tool()
        :capture_creature("HUGE")
)

content.add(
    content.Item {
        id = "warp_autodoc_inert",
        name = ccb.content.plural_text("Autodoc copyplate (inert)", "Autodoc copyplates (inert)"),
        description = ccb.content.text("This strange obsidian-colored plate is capable of mimicking the advanced tech found within a modern Autodoc, and can be used to create a working copy at your sanctuary.  However, it is inert in its current state and must first be imprinted on a working Autodoc.  To do so, find an Autodoc during an expedition and use the construction menu to imprint this plate."),
        symbol = ")",
        color = "light_cyan",
        mass_grams = 100,
        volume_ml = 200,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
)

content.add(
    content.Item {
        id = "warp_autodoc_active",
        name = ccb.content.plural_text("Autodoc copyplate (activated)", "Autodoc copyplates (activated)"),
        description = ccb.content.text("This strange obsidian-colored plate is capable of mimicking the advanced tech found within a modern Autodoc, and can be used to create a working copy at your sanctuary.  It has been successfully activated and can be used as the catalyst to create a new Autodoc at a location of your choosing using the construction menu.  Be aware this cannot be safely moved once placed, and will also require you to add an adjacent couch, then convert it to an Autodoc couch."),
        symbol = ")",
        color = "light_cyan",
        mass_grams = 100,
        volume_ml = 200,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
)

content.add(
    content.Item {
        id = "warped_autodoc_upgrader_1",
        name = ccb.content.text("warped autodoc enhancer"),
        description = ccb.content.text("A small device, so complex you can't entirely tell what it does.  You can see a miniature chair, a bed, some kind of machine, a computer console, a tangle of mechanical arms, all changing from moment to moment.  When used on an existing autodoc mark XI, you can upgrade it to a more advanced XXII model."),
        symbol = "A",
        color = "pink",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("alien_resin", 1)
        :tool()
)

content.add(
    content.Item {
        id = "warped_autodoc_upgrader_2",
        name = ccb.content.text("warped autodoc augmenter"),
        description = ccb.content.text("A small device, so complex you can't entirely tell what it does.  You can see a miniature chair, a bed, some kind of machine, a computer console, a tangle of mechanical arms, all changing from moment to moment.  When used on an advanced autodoc mark XXII, you can upgrade it to its most advanced XXXIII form."),
        symbol = "A",
        color = "pink",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("alien_resin", 1)
        :tool()
)

content.add(
    content.Item {
        id = "warp_grassbag",
        name = ccb.content.plural_text("warped grass seeds", "warped grass seeds"),
        description = ccb.content.text("While these are certainly imbued with warp, they don't seem to have any supernatural powers beyond just growing quickly.  A nice option if you want to re-plant grass on your island, for decoration's sake."),
        category = "other",
        symbol = ".",
        color = "light_gray",
        looks_like = "seed_wild_herbs",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("veggy", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 100,
            stack_size = 100,
        }
)

content.add(
    content.Item {
        id = "warp_wood_floor_tokens",
        name = ccb.content.plural_text("wood-floor tokens", "wood-floor tokens"),
        description = ccb.content.text("A group of small squares of wood, smooth and polished.  You can use them to transform a section of flooring into interlocking wooden planks."),
        category = "other",
        symbol = ".",
        color = "light_gray",
        looks_like = "seed_wild_herbs",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("veggy", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 50,
            stack_size = 50,
        }
)

content.add(
    content.Item {
        id = "warp_flagstone_floor_tokens",
        name = ccb.content.plural_text("flagstone tokens", "flagstone tokens"),
        description = ccb.content.text("A group of small stone stones, rough to the touch.  You can use them to transform a section of flooring into mortared flagstones."),
        category = "other",
        symbol = ".",
        color = "light_gray",
        looks_like = "seed_wild_herbs",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("veggy", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 50,
            stack_size = 50,
        }
)

content.add(
    content.Item {
        id = "warp_sand_floor_tokens",
        name = ccb.content.plural_text("sand tokens", "sand tokens"),
        description = ccb.content.text("A group of small yellow stones, gritty to the touch yet seemingly nothing ever rubs off.  You can use them to transform a section of flooring into fine sand."),
        category = "other",
        symbol = ".",
        color = "light_gray",
        looks_like = "seed_wild_herbs",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("veggy", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 50,
            stack_size = 50,
        }
)

content.add(
    content.Item {
        id = "warp_flesh_floor_tokens",
        name = ccb.content.plural_text("flesh tokens", "flesh tokens"),
        description = ccb.content.text("A group of small pieces of skin and meat, warm to the touch and fortunately never decaying.  You can use them to transform a section of flooring or wall into living flesh."),
        category = "other",
        symbol = ".",
        color = "pink",
        looks_like = "seed_wild_herbs",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("flesh", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 50,
            stack_size = 50,
        }
)

content.add(
    content.Item {
        id = "warp_vortex_token",
        name = ccb.content.text("vortex token"),
        description = ccb.content.text("This irregular purplish lump seems to slowly pull in air even while you hold it in your hand.  If you have one with you when you activate the return obelisk and the obelisk is correctly configured, it will drag the entire contents of the room with you back up to your island."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 100,
        }
)

content.add(
    content.Item {
        id = "item_merchant_attractor",
        name = ccb.content.plural_text("lucre lure", "lucre lure"),
        description = ccb.content.text("This irregular purplish lump shines like gold and is as heavy as gold too.  Activating it will attract a merchant to your trade stall when you next return from an expedition, whenever that should be."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 50,
        volume_ml = 5,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :flag("SINGLE_USE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 100,
        }
        :activate_effects {
            message = ccb.content.text("You squeeze the lure and it breaks apart in a burst of purple-gold light."),
            effects = {
                {
                    id = "effect_sky_island_merchant_attraction",
                    duration_turns = 99999999,
                    permanent = true,
                },
            },
        }
)

content.add(
    content.Item {
        id = "warp_healing_salve",
        name = ccb.content.plural_text("healing salve", "healing salve"),
        description = ccb.content.text("A lump of purplish goo, smooth but yielding, sculptable like clay.  If you rub it on a wound, it will immediately heal some of the damage you have taken, but the air of the lower world destabilizes its structure and it will only last a single trip to the surface."),
        category = "drugs",
        symbol = ",",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
        price_postapoc_cents = 600,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :flag("SINGLE_USE")
        :heal {
            move_cost = 2500,
            limb_power = 21,
            head_power = 21,
            torso_power = 21,
        }
)

content.add(
    content.Item {
        id = "warptoken",
        name = ccb.content.plural_text("warp shards", "warp shards"),
        description = ccb.content.text("A small quantity of airy-thin material that resembles flaked obsidian.  It glints with a purplish shimmer that seems to stretch off the bounds of itself and into the air itself.  Offered to the powers that be, one could exchange it for valuable artifacts."),
        category = "other",
        symbol = ",",
        color = "light_gray",
        looks_like = "spiral_stone",
        mass_grams = 1,
        volume_ml = 1,
    }
        :material("stone", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 100,
        }
)

content.add(content.Item {
    id = "warptoken_material",
    name = ccb.content.plural_text("material token", "material token"),
    description = ccb.content.text("A very tiny disc-shaped blue wafer.  It seems to shift in your grasp, feeling one moment like a grain of sand, then a sharp metal fragment, then a wooden splinter.  These miniature tokens are rewarded for surviving a raid, and can be crafted on your island for a large supply of common resources by using infinity nodes as a catalyst."),
    copy_from = "warptoken",
})

content.add(
    content.Item {
        id = "warp_labs_catalyst",
        name = ccb.content.text("Labs Catalyst"),
        description = ccb.content.text("A bit of warp power, a magnetic stripe keycard from a dangerous place, and a little hope, blended well.  This item is required to begin a Labs expedition, and is consumed when leaving."),
        category = "spare_parts",
        symbol = "V",
        color = "white",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("stone", 1)
)

content.add(
    content.Item {
        id = "warp_folded_heart",
        name = ccb.content.text("Heartseed"),
        description = ccb.content.text("A whorl of black stone that feels impossibly heavy for its size.  Activate this on your island to place the Heart of the Island, the catalyst of future upgrades."),
        symbol = "V",
        color = "white",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("stone", 1)
        :tool()
        :deploy_furniture("f_islandstatue")
)

content.add(
    content.Item {
        id = "warp_folded_infinitree",
        name = ccb.content.text("infinity tree sapling"),
        description = ccb.content.text("A fragile little wisp of a sapling.  Its leaves shake and quiver, shimmering with strange energies.  Activate this on your island to place an infinity tree, which can be used as a catalyst to turn material tokens into wooden resources."),
        symbol = "y",
        color = "green",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("stone", 1)
        :tool()
        :deploy_furniture("f_infinitree1")
)

content.add(
    content.Item {
        id = "warp_folded_infinitystone",
        name = ccb.content.text("infinity stone source"),
        description = ccb.content.text("A crackling little cluster of pebbles that spark as they knock together, tumbling about from forces unseen.  Activate this on your island to place an infinity stone, which can be used as a catalyst to turn material tokens into stony and earthen resources."),
        symbol = "y",
        color = "green",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("stone", 1)
        :tool()
        :deploy_furniture("f_infinitystone")
)

content.add(
    content.Item {
        id = "warp_folded_infinityore",
        name = ccb.content.text("infinity ore crucible"),
        description = ccb.content.text("A miniature tangle of metal that resembles a dust bunny made of barbed wire.  It twists in upon itself endlessly, folding and unfolding in ways that don't seem possible.  Activate this on your island to place an infinity ore, which can be used as a catalyst to turn material tokens into metal resources."),
        symbol = "y",
        color = "green",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("stone", 1)
        :tool()
        :deploy_furniture("f_infinityore")
)

content.add(
    content.Item {
        id = "sky_island_sunblock",
        name = ccb.content.text("Personal Sunblock"),
        description = ccb.content.text("The island is protecting you against the sun as long as you are on it."),
        symbol = "o",
        color = "blue",
        mass_grams = 1,
        volume_ml = 1,
    }
        :material("alien_resin", 1)
        :flag("AURA")
        :flag("SEMITANGIBLE")
        :flag("OVERSIZE")
        :flag("TRADER_AVOID")
        :flag("NO_TAKEOFF")
        :flag("NONCONDUCTIVE")
        :flag("UNBREAKABLE")
        :flag("RAIN_PROTECT")
        :flag("SUN_GLASSES")
        :flag("ALLOWS_NATURAL_ATTACKS")
        :armor {
            max_worn = 1,
        }
        :armor_portion {
            encumbrance = 0,
            coverage = 100,
            covers = {
                "leg_l",
                "leg_r",
                "torso",
                "arm_l",
                "arm_r",
                "hand_l",
                "hand_r",
                "head",
                "foot_l",
                "foot_r",
                "mouth",
                "eyes",
            },
        }
)

content.add(
    content.Item {
        id = "sky_island_windblock",
        name = ccb.content.text("Personal Windblock"),
        description = ccb.content.text("The island is protecting you against the winds as long as you are on it."),
        symbol = "o",
        color = "blue",
        mass_grams = 1,
        volume_ml = 1,
    }
        :material("alien_resin_windblock", 1)
        :flag("AURA")
        :flag("SEMITANGIBLE")
        :flag("OVERSIZE")
        :flag("TRADER_AVOID")
        :flag("NO_TAKEOFF")
        :flag("NONCONDUCTIVE")
        :flag("UNBREAKABLE")
        :flag("ALLOWS_NATURAL_ATTACKS")
        :armor {
            max_worn = 1,
        }
        :armor_portion {
            encumbrance = 0,
            coverage = 100,
            covers = {
                "leg_l",
                "leg_r",
                "torso",
                "arm_l",
                "arm_r",
                "hand_l",
                "hand_r",
                "head",
                "foot_l",
                "foot_r",
                "mouth",
                "eyes",
            },
        }
)

content.add(
    content.Item {
        id = "planter_token",
        name = ccb.content.plural_text("planter case token", "planter case token"),
        description = ccb.content.text("This flat purplish token has the image of a planter box case on one side and a swirl of grooves that almost seems to move as you look at them on the other.  You can transform it to a planter box, if you like."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
        price_postapoc_cents = 1000,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 1,
        }
)

content.add(
    content.Item {
        id = "birdbath_token",
        name = ccb.content.plural_text("birdbath token", "birdbath token"),
        description = ccb.content.text("This flat purplish token has the image of a birdbath on one side and a swirl of grooves that almost seems to move as you look at them on the other.  You can transform it to a birdbath, if you like."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
        price_postapoc_cents = 1500,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 1,
        }
)

content.add(
    content.Item {
        id = "display_case_token",
        name = ccb.content.plural_text("display case token", "display case token"),
        description = ccb.content.text("This flat purplish token has the image of a glass-fronted display case on one side and a swirl of grooves that almost seems to move as you look at them on the other.  You can transform it to a display case, if you like."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
        price_postapoc_cents = 2500,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 1,
        }
)

content.add(
    content.Item {
        id = "statue_token",
        name = ccb.content.plural_text("statue token", "statue token"),
        description = ccb.content.text("This flat purplish token has the image of a carved statue on one side and a swirl of grooves that almost seems to move as you look at them on the other.  You can transform it to a stone statue, if you like."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
        price_postapoc_cents = 5000,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 1,
        }
)

content.add(
    content.Item {
        id = "glass_door_token",
        name = ccb.content.plural_text("glass door token", "glass door token"),
        description = ccb.content.text("This flat purplish token has the image of a closed glass door on one side and a swirl of grooves that almost seems to move as you look at them on the other.  You can transform a closed door into a glass door, if you like."),
        category = "other",
        symbol = ".",
        color = "magenta",
        looks_like = "spiral_stone",
        mass_grams = 5,
        volume_ml = 5,
        price_postapoc_cents = 3500,
    }
        :material("alien_resin", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 1,
            stack_size = 1,
        }
)

content.add(
    content.Item {
        id = "secure_container_1",
        name = ccb.content.text("Alpha Secure Container"),
        description = ccb.content.text("The most secure storage possible, even if it is tiny.  This metaphysical container is unique in that it is the only storage that will keep its contents on death.  Everything else will still be lost."),
        symbol = "[",
        color = "yellow",
        looks_like = "ragpouch",
        mass_grams = 0,
        volume_ml = 0,
    }
        :material("stone", 1)
        :flag("INTEGRATED")
        :flag("UNBREAKABLE")
        :flag("AURA")
        :flag("NO_SALVAGE")
        :flag("TARDIS")
        :flag("ZERO_WEIGHT")
        :tool()
        :container_pocket {
            max_volume_ml = 500,
            max_weight_milligrams = 100000000,
            max_item_length_mm = 20000,
            watertight = true,
            moves = 10,
            volume_encumber_modifier = 0,
        }
)

content.add(
    content.Item {
        id = "secure_container_2",
        name = ccb.content.text("Beta Secure Container"),
        description = ccb.content.text("A small secure storage.  This metaphysical container is unique in that it is the only storage that will keep its contents on death.  Everything else will still be lost."),
        symbol = "[",
        color = "yellow",
        looks_like = "ragpouch",
        mass_grams = 0,
        volume_ml = 0,
    }
        :material("stone", 1)
        :flag("INTEGRATED")
        :flag("UNBREAKABLE")
        :flag("AURA")
        :flag("NO_SALVAGE")
        :flag("TARDIS")
        :flag("ZERO_WEIGHT")
        :tool()
        :container_pocket {
            max_volume_ml = 750,
            max_weight_milligrams = 100000000,
            max_item_length_mm = 20000,
            watertight = true,
            moves = 10,
            volume_encumber_modifier = 0,
        }
)

content.add(
    content.Item {
        id = "secure_container_3",
        name = ccb.content.text("Gamma Secure Container"),
        description = ccb.content.text("A medium-sized secure storage.  This metaphysical container is unique in that it is the only storage that will keep its contents on death.  Everything else will still be lost."),
        symbol = "[",
        color = "yellow",
        looks_like = "ragpouch",
        mass_grams = 0,
        volume_ml = 0,
    }
        :material("stone", 1)
        :flag("INTEGRATED")
        :flag("UNBREAKABLE")
        :flag("AURA")
        :flag("NO_SALVAGE")
        :flag("TARDIS")
        :flag("ZERO_WEIGHT")
        :tool()
        :container_pocket {
            max_volume_ml = 1000,
            max_weight_milligrams = 100000000,
            max_item_length_mm = 20000,
            watertight = true,
            moves = 10,
            volume_encumber_modifier = 0,
        }
)

content.add(
    content.Item {
        id = "secure_container_4",
        name = ccb.content.text("Epsilon Secure Container"),
        description = ccb.content.text("A large secure storage.  This metaphysical container is unique in that it is the only storage that will keep its contents on death.  Everything else will still be lost."),
        symbol = "[",
        color = "yellow",
        looks_like = "ragpouch",
        mass_grams = 0,
        volume_ml = 0,
    }
        :material("stone", 1)
        :flag("INTEGRATED")
        :flag("UNBREAKABLE")
        :flag("AURA")
        :flag("NO_SALVAGE")
        :flag("TARDIS")
        :flag("ZERO_WEIGHT")
        :tool()
        :container_pocket {
            max_volume_ml = 1500,
            max_weight_milligrams = 100000000,
            max_item_length_mm = 20000,
            watertight = true,
            moves = 10,
            volume_encumber_modifier = 0,
        }
)

content.add(
    content.Item {
        id = "secure_container_5",
        name = ccb.content.text("Kappa Secure Container"),
        description = ccb.content.text("The perfect secure storage.  This metaphysical container is unique in that it is the only storage that will keep its contents on death.  Everything else will still be lost."),
        symbol = "[",
        color = "yellow",
        looks_like = "ragpouch",
        mass_grams = 0,
        volume_ml = 0,
    }
        :material("stone", 1)
        :flag("INTEGRATED")
        :flag("UNBREAKABLE")
        :flag("AURA")
        :flag("NO_SALVAGE")
        :flag("TARDIS")
        :flag("ZERO_WEIGHT")
        :tool()
        :container_pocket {
            max_volume_ml = 2000,
            max_weight_milligrams = 100000000,
            max_item_length_mm = 20000,
            watertight = true,
            moves = 10,
            volume_encumber_modifier = 0,
        }
)
