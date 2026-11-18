local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "krar",
        looks_like = "krar_golden",
        name = ccb.content.plural_text("krar", "krars"),
        description = ccb.content.text("A wooden krar, similar to a harp."),
        copy_from = "krar_golden",
        mass_milligrams = 2500000,
    }
    item:material("wood", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "banjo",
        looks_like = "acoustic_guitar",
        category = "tools",
        name = ccb.content.plural_text("banjo", "banjos"),
        description = ccb.content.text("A standard factory-made banjo.  Looks to be in working condition."),
        mass_milligrams = 2800000,
        volume_ml = 3000,
        longest_side_mm = 720,
        price_cents = 7500,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = "|",
        color = "white",
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:material("wood", 7)
    item:material("steel", 1)
    item:material("nylon", 2)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 18,
        fun = -3,
        fun_bonus = 2,
        speed_penalty = 18,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your banjo."),
            ccb.content.text("You play a bluegrass tune on your banjo."),
            ccb.content.text("You play a quick, Southern ditty on your banjo."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bone_flute",
        looks_like = "flute",
        category = "tools",
        name = ccb.content.plural_text("bone flute", "bone flutes"),
        description = ccb.content.text("A polished bone flute with five finger holes."),
        mass_milligrams = 250000,
        volume_ml = 400,
        longest_side_mm = 320,
        price_cents = 5000,
        price_postapoc_cents = 100,
        symbol = "-",
        color = "white",
    }
    item:material("bone", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 12,
        fun = -5,
        fun_bonus = 2,
        speed_penalty = 10,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your flute."),
            ccb.content.text("You play a beautiful piece on your flute."),
            ccb.content.text("You play a piece on your bone flute that resembles the howling wind through Aurignacian caves."),
            ccb.content.text("Your bone flute wails for the fallen during the hunt."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "clarinet",
        looks_like = "flute",
        category = "tools",
        name = ccb.content.plural_text("clarinet", "clarinets"),
        description = ccb.content.text("An ornate clarinet made from wood."),
        mass_milligrams = 550000,
        volume_ml = 1500,
        longest_side_mm = 600,
        price_cents = 5500,
        price_postapoc_cents = 250,
        melee_to_hit = 0,
        symbol = "|",
        color = "light_gray",
    }
    item:material("wood", 9)
    item:material("silver", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 14,
        fun = -5,
        fun_bonus = 2,
        speed_penalty = 13,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your clarinet."),
            ccb.content.text("You play a moving, orchestral piece on your clarinet."),
            ccb.content.text("You play an uplifting marching tune on your clarinet."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "kantele",
        looks_like = "acoustic_guitar",
        category = "tools",
        name = ccb.content.plural_text("kantele", "kanteles"),
        description = ccb.content.text("A traditional Finnish string instrument.  According to myth the first one was fashioned from a great pike's bone.  This ordinary wooden one doesn't seem quite as special."),
        mass_milligrams = 550000,
        volume_ml = 3000,
        longest_side_mm = 460,
        price_cents = 5500,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = "(",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 10,
        fun = -5,
        fun_bonus = 2,
        speed_penalty = 13,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a riveting tune on your kantele."),
            ccb.content.text("You play an enchanting composition on your kantele."),
            ccb.content.text("You play a somber piece on your kantele."),
        },
    }
    content.add(item)
end

do
    -- Moved this to just being silver.  Flutes aren't made of iron, and a full size sterling silver flute weighs 440g, which is the existing weight.
    local item = content.Item {
        id = "flute",
        category = "tools",
        name = ccb.content.plural_text("flute", "flutes"),
        description = ccb.content.text("A simple silver-plated flute."),
        mass_milligrams = 440000,
        volume_ml = 500,
        longest_side_mm = 660,
        price_cents = 5000,
        price_postapoc_cents = 150,
        symbol = "-",
        color = "light_gray",
    }
    item:material("silver", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 12,
        fun = -5,
        fun_bonus = 2,
        speed_penalty = 10,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your flute."),
            ccb.content.text("You play a beautiful piece on your flute."),
            ccb.content.text("You play a piece on your flute that sounds harmonious with nature."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "trumpet",
        looks_like = "flute",
        category = "tools",
        name = ccb.content.plural_text("trumpet", "trumpets"),
        description = ccb.content.text("A brass trumpet with only a few dents here and there."),
        mass_milligrams = 1100000,
        volume_ml = 2500,
        longest_side_mm = 500,
        price_cents = 7500,
        price_postapoc_cents = 300,
        melee_to_hit = 0,
        symbol = "-",
        color = "yellow",
    }
    item:material("brass", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 21,
        fun = -3,
        fun_bonus = 4,
        speed_penalty = 17,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your trumpet."),
            ccb.content.text("You play a slow, mourning piece on your trumpet."),
            ccb.content.text("You play a little ballad on your trumpet."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ukulele",
        looks_like = "acoustic_guitar",
        category = "tools",
        name = ccb.content.plural_text("ukulele", "ukuleles"),
        description = ccb.content.text("A small factory-made ukulele.  Makes you wish you were on a tropical island, or somewhere over the rainbow."),
        mass_milligrams = 600000,
        volume_ml = 2500,
        longest_side_mm = 580,
        price_cents = 7500,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = "(",
        color = "brown",
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 16,
        fun = -3,
        fun_bonus = 2,
        speed_penalty = 20,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your ukulele."),
            ccb.content.text("You play a cute little ditty on your ukulele."),
            ccb.content.text("You play a small jam on your ukulele."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "violin",
        looks_like = "acoustic_guitar",
        category = "tools",
        name = ccb.content.plural_text("violin", "violins"),
        description = ccb.content.text("A cheap, factory-made violin with a built-in holder for a bow.  Still produces a nice sound."),
        mass_milligrams = 500000,
        volume_ml = 2500,
        longest_side_mm = 600,
        price_cents = 7500,
        price_postapoc_cents = 600,
        melee_to_hit = -2,
        symbol = "}",
        color = "brown",
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 18,
        fun = -2,
        fun_bonus = 3,
        speed_penalty = 25,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a little tune on your violin."),
            ccb.content.text("You play a beautiful orchestral piece on your violin."),
            ccb.content.text("You play a quick, southern ditty on your fiddle."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "violin_golden",
        looks_like = "acoustic_guitar",
        category = "tools",
        name = ccb.content.plural_text("golden fiddle", "golden fiddles"),
        description = ccb.content.text("A shiny golden fiddle, with a strange aura around it.  You feel like it once belonged to the best there's ever been."),
        mass_milligrams = 13000000,
        volume_ml = 2500,
        longest_side_mm = 600,
        price_cents = 1000000,
        price_postapoc_cents = 1000,
        melee_to_hit = -2,
        symbol = "}",
        color = "yellow",
    }
    item:material("gold", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 25,
        fun = 1,
        fun_bonus = 4,
        speed_penalty = 25,
        description_interval_turns = 10,
        player_descriptions = {
            ccb.content.text("You play a quick, folksy tune on your fiddle."),
            ccb.content.text("As you pull the bow across its strings, it makes an evil hiss."),
            ccb.content.text("You play a tune so fierce, it feels like hell's broke loose."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "krar_golden",
        looks_like = "acoustic_guitar",
        category = "tools",
        name = ccb.content.plural_text("golden krar", "golden krars"),
        description = ccb.content.text("A shiny golden krar, similar to a harp."),
        mass_milligrams = 13000000,
        volume_ml = 12000,
        longest_side_mm = 1000,
        price_cents = 1000000,
        price_postapoc_cents = 1000,
        melee_to_hit = -2,
        symbol = "}",
        color = "yellow",
    }
    item:material("gold", 1)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 25,
        fun = 1,
        fun_bonus = 4,
        speed_penalty = 25,
        description_interval_turns = 10,
        player_descriptions = { ccb.content.text("You play a relaxed, folksy tune on your krar.") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "drum_percussion",
        category = "tools",
        name = ccb.content.plural_text("drum, percussion", "drums, percussion"),
        description = ccb.content.text("A standard factory-made percussion drum.  Looks to be in working condition."),
        mass_milligrams = 2800000,
        volume_ml = 56629,
        longest_side_mm = 280,
        price_cents = 7500,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = "|",
        color = "white",
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:material("wood", 7)
    item:material("steel", 1)
    item:material("nylon", 2)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 28,
        fun = -3,
        fun_bonus = 2,
        speed_penalty = 18,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a beat on your drum.  Pa rum pa pum pum."),
            ccb.content.text("You play a fast beat on your drum.  Rat tat tat tat."),
            ccb.content.text("You play a march on your drums.  Brrrum brrum brrrrum."),
        },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "drum_percussion_primitive",
        category = "tools",
        name = ccb.content.plural_text("primitive drum, percussion", "primitive drums, percussion"),
        description = ccb.content.text("A handmade primitive percussion drum.  Looks to be in working condition."),
        mass_milligrams = 2800000,
        volume_ml = 56629,
        longest_side_mm = 280,
        price_cents = 7500,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = "|",
        color = "white",
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:material("wood", 7)
    item:material("steel", 1)
    item:material("leather", 2)
    item:clear_use_actions()
    item:play_instrument()
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    item:clear_tick_actions()
    item:music_on_tick {
        volume = 28,
        fun = -3,
        fun_bonus = 2,
        speed_penalty = 18,
        description_interval_turns = 20,
        player_descriptions = {
            ccb.content.text("You play a beat on your drum.  Pa rum pa pum pum."),
            ccb.content.text("You play a fast beat on your drum.  Rat tat tat tat."),
            ccb.content.text("You play a march on your drums.  Brrrum brrum brrrrum."),
        },
    }
    content.add(item)
end
