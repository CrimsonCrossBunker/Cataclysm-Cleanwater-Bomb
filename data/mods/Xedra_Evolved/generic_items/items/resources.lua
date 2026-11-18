local ccb = require("ccb")
local content = ccb.content

do
    -- not really sure how to convert density to weight in our system look at it later.
    local item = content.Item {
        id = "moon_tear_ingot",
        category = "spare_parts",
        name = ccb.content.plural_text("moon tears ingot", "moon tears ingots"),
        description = ccb.content.text("An ingot of moon tears.  About 3cm by 7cm by 12cm in size, ready to be used for various blacksmithing tasks."),
        mass_milligrams = 683000,
        volume_ml = 250,
        price_cents = 6399,
        symbol = "=",
        color = "light_blue",
    }
    item:material("moon_tears", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "moon_tear_wire",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("moon tear wire", "moon tear wires"),
        description = ccb.content.text("A length of thin, relatively stiff moon tear wire."),
        category = "spare_parts",
        price_cents = 20000,
        price_postapoc_cents = 100,
        mass_milligrams = 151000,
        volume_ml = 100,
    }
    item:material("moon_tears", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "forged_dreamstuff_ingot",
        category = "spare_parts",
        name = ccb.content.plural_text("dreamdross ingot", "dreamdross ingots"),
        description = ccb.content.text("A forged ingot of dreamdross.  About 3cm by 7cm by 12cm in size, ready to be used for various reality forging tasks."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 6399,
        price_postapoc_cents = 5000,
        symbol = "=",
        color = "light_blue",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "changeling_dreamspark",
        category = "spare_parts",
        name = ccb.content.plural_text("dreamspark", "dreamsparks"),
        description = ccb.content.text("The extracted essence of human dreams, used to fuel fae magicks."),
        mass_milligrams = 0,
        volume_ml = 1,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "*",
        color = "cyan",
    }
    item:material("dreamstuff", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("ZERO_WEIGHT")
    item:flag("NO_DROP")
    content.add(item)
end

do
    local item = content.Item {
        id = "tanned_glimmer_pelt",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("tanned glimmer fur pelt", "tanned glimmer fur pelts"),
        description = ccb.content.text("A folded sheet of glimmer fur made from carefully tanned fae animal pelt.  Can be cut up or used as is."),
        price_cents = 5000,
        price_postapoc_cents = 500,
        mass_milligrams = 372000,
        volume_ml = 465,
        category = "spare_parts",
    }
    item:material("fae_fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cured_glimmer_pelt",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("cured glimmer pelt", "cured glimmer pelts"),
        description = ccb.content.text("A rolled-up fae animal hide which has been scraped of extraneous hair and flesh and treated to prevent decay.  It still requires tanning to become usable fur."),
        price_cents = 200,
        price_postapoc_cents = 150,
        mass_milligrams = 372000,
        volume_ml = 465,
        category = "spare_parts",
    }
    item:material("fae_fur", 1)
    item:material("fae_flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_gossamer",
        category = "spare_parts",
        name = ccb.content.plural_text("gossamer sheet", "gossamer sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of gossamer fabric, like a swatch plucked from a rainbow."),
        mass_milligrams = 25000,
        volume_ml = 47,
        price_cents = 2000,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "white",
    }
    item:material("fae_cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_gossamer_patchwork",
        copy_from = "sheet_gossamer",
        looks_like = "sheet_gossamer",
        name = ccb.content.plural_text("patchwork gossamer sheet", "patchwork gossamer sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of gossamer sewn together from patches of various clothing parts.  Suitable for making clothing if you lack proper material sheets."),
        price_cents = 200,
        price_postapoc_cents = 20,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_gossamer",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("gossamer scraps", "gossamer scraps"),
        description = ccb.content.text("Filmy bits of gossamer, barely there.  Not useful for much."),
        volume_ml = 1,
        symbol = "=",
        color = "white",
    }
    item:material("fae_cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_elemental_gossamer",
        category = "spare_parts",
        name = ccb.content.plural_text("elemental gossamer sheet", "elemental gossamer sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of elemental gossamer fabric, like a swatch plucked from a rainbow."),
        mass_milligrams = 50000,
        volume_ml = 47,
        price_cents = 2000,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "white",
    }
    item:material("elemental_fae_cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_elemental_gossamer_patchwork",
        copy_from = "sheet_gossamer",
        looks_like = "sheet_gossamer",
        name = ccb.content.plural_text("patchwork elemental gossamer sheet", "patchwork elemental gossamer sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of elemental gossamer sewn together from patches of various clothing parts.  Suitable for making clothing if you lack proper material sheets."),
        price_cents = 200,
        price_postapoc_cents = 20,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "elemental_scrap_gossamer",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("elemental gossamer scraps", "elemental gossamer scraps"),
        description = ccb.content.text("Filmy bits of elemental gossamer, barely there.  Not useful for much."),
        volume_ml = 1,
        symbol = "=",
        color = "white",
    }
    item:material("elemental_fae_cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "log_treesung",
        copy_from = "log",
        looks_like = "log",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("treesung log", "treesung logs"),
        description = ccb.content.text("A large log of living wood, sung from a tree by elemental magick."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "shadow_singularity_piece",
        copy_from = "rock",
        looks_like = "rock",
        name = ccb.content.plural_text("piece of the darkest shadow", "pieces of the darkest shadow"),
        color = "black",
        description = ccb.content.text("A chunk of darkness, torn from a powerful shadow.  It is so dark that no light reflect from it."),
    }
    item:material("monolith", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "skull_march_lord",
        name = ccb.content.plural_text("march lord skull", "march lord skulls"),
        description = ccb.content.text("The skull of a march lord.  You can feel its lingering power as you touch it."),
        copy_from = "skull_abstract",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "stormwrought_blood_itert",
        copy_from = "rock",
        name = ccb.content.plural_text("inert stormwrought blood", "doses of inert stormwrought blood"),
        mass_milligrams = 5000,
        color = "red",
        looks_like = "blood",
        description = ccb.content.text("A ball of almost-solid blood, needing to bath in the energies of a portal storm before being useful."),
    }
    item:material("hblood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "stormwrought_blood_charged",
        copy_from = "rock",
        name = ccb.content.plural_text("simmering stormwrought blood", "doses of simmering stormwrought blood"),
        color = "red",
        mass_milligrams = 5000,
        looks_like = "blood",
        description = ccb.content.text("A ball of almost-solid blood with ripples across its surface.  It has been exposed to the energies of the portal storms enough to be used in the ritual."),
    }
    item:material("hblood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "dream_drainer_heart",
        copy_from = "rock",
        name = ccb.content.plural_text("dream-drainer mosquito's heart", "dream-drainer mosquito's hearts"),
        mass_milligrams = 390000,
        volume_ml = 1500,
        color = "blue",
        looks_like = "jabberwock_heart",
        description = ccb.content.text("A heartlike object made from dreamdross.  It feels as if it were still beating despite its lack of movement."),
    }
    item:material("dreamstuff", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "moonstruck_pearl",
        copy_from = "rock",
        mass_milligrams = 39000,
        volume_ml = 15,
        name = ccb.content.plural_text("moonstruck pearl", "moonstruck pearls"),
        color = "white",
        looks_like = "pearl",
        description = ccb.content.text("A small pearl brightly shining with moonlight."),
    }
    item:material("monolith", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "abyssal_hunger_shard",
        copy_from = "rock",
        mass_milligrams = 900000,
        volume_ml = 50,
        name = ccb.content.plural_text("Abyssal Hunger's shard", "Abyssal Hunger's shards"),
        color = "brown",
        looks_like = "material_shrd_limestone",
        description = ccb.content.text("A strange object you brought back from the insides of the Abyssal Hunger."),
    }
    item:material("monolith", 1)
    content.add(item)
end
