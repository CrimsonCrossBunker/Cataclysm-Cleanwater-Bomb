local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "chem_sulphur",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("sulfur", "sulfur"),
        symbol = "=",
        color = "yellow",
        description = ccb.content.text("A handful of pure sulfur.  Primarily used to make battery acid, sulfur is sometimes used as fuel for explosives.  Can be burned to produce acidic smoke that is deadly to bacteria and humans alike, or oxidized to make paper-bleaching agents.  It also serves as a basis for many kinds of fungicide."),
        volume_ml = 1,
        mass_milligrams = 2000,
        default_container = "bottle_plastic_small",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:clear_flags()
    item:flag("EDIBLE_FROZEN")
    item:flag("NO_INGEST")
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- density is around 2g/cm3
    local item = content.Item {
        id = "chunk_sulfur",
        category = "chems",
        price_cents = 50,
        price_postapoc_cents = 100,
        name = ccb.content.plural_text("chunk of sulfur", "chunks of sulfur"),
        symbol = "*",
        color = "yellow",
        description = ccb.content.text("A chunk of pure sulfur.  Break it up to use it."),
        volume_ml = 250,
        mass_milligrams = 500000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "graphite",
        category = "chems",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("graphite powder", "graphite powder"),
        symbol = "!",
        description = ccb.content.text("A handful of graphite in powder form.  Produces gray or black marks that are easily erased, but otherwise resistant to moisture, most chemicals, ultraviolet radiation, and natural aging.  Useful as a dry lubricant in metalworking, mixed with clay to form crucibles or creating casting molds, or mixed with oil to create a lubricant."),
        display_type = "BY_WEIGHT",
        volume_ml = 1,
        mass_milligrams = 2000,
        color = "dark_gray",
        looks_like = "charcoal",
        stackable = true,
    }
    item:material("dense_powder_nonflam", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    -- density is around 2.2g/cm3
    local item = content.Item {
        id = "chunk_graphite",
        category = "chems",
        price_cents = 50,
        price_postapoc_cents = 100,
        looks_like = "coal_lump",
        name = ccb.content.plural_text("chunk of graphite", "chunks of graphite"),
        symbol = "~",
        color = "dark_gray",
        description = ccb.content.text("A chunk of carbon graphite.  Break it up to use it."),
        volume_ml = 250,
        mass_milligrams = 550000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- density is around 2.7g/cm3
    local item = content.Item {
        id = "chunk_caco3",
        category = "chems",
        price_cents = 50,
        price_postapoc_cents = 100,
        looks_like = "rock",
        name = ccb.content.plural_text("calcite crystal", "calcite crystals"),
        symbol = "*",
        color = "white",
        description = ccb.content.text("A chunk of calcium carbonate as calcite.  Break it up to use it."),
        volume_ml = 250,
        mass_milligrams = 678000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- Density: 1.73g/cm3
    local item = content.Item {
        id = "chem_borax",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 0,
        looks_like = "detergent",
        name = ccb.content.plural_text("borax powder", "borax powder"),
        display_type = "BY_WEIGHT",
        symbol = "=",
        color = "white",
        description = ccb.content.text("Borax powder.  It's a common household cleaner, used in laundry to remove soap scum, and for making insecticide.  It's also useful in metalworking as a ubiquitous flux."),
        volume_ml = 2,
        mass_milligrams = 3460,
        stackable = true,
    }
    item:material("dense_powder_nonflam", 1)
    content.add(item)
end

do
    -- density is around 1.73g/cm3
    local item = content.Item {
        id = "chunk_borax",
        category = "chems",
        price_cents = 170,
        price_postapoc_cents = 170,
        looks_like = "rock",
        name = ccb.content.plural_text("crystal of borax", "crystals of borax"),
        symbol = "*",
        color = "white",
        description = ccb.content.text("A hard crystallized clump of borax.  Break it up to turn it into borax powder."),
        volume_ml = 250,
        mass_milligrams = 425000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "flux_ash",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("ash flux", "ash flux", "material"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A pinch of sand and wood ash.  This could be used as flux for iron forging, in a pinch."),
        volume_ml = 7,
        mass_milligrams = 6000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- density is around 2.56g/cm3
    local item = content.Item {
        id = "chunk_feldspar",
        category = "chems",
        price_cents = 0,
        price_postapoc_cents = 0,
        looks_like = "rock",
        name = ccb.content.plural_text("chunk of feldspar", "feldspar chunks"),
        symbol = "*",
        color = "pink",
        description = ccb.content.text("A feldspar stone.  A common rock native to the surface granite and pegmatite of New England, this contains pinkish flecks with high alumina content.  Useful for making refractory clay, important for high quality ceramics, and very common as a flux in glassmaking."),
        volume_ml = 250,
        mass_milligrams = 640000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "material_cement",
        category = "spare_parts",
        price_cents = 200,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("cement powder", "cement powder"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("Portland is most likely long gone, but its memory persists in cement.  This ubiquitous binder can be used for all kinds of advanced masonry.  Just add water."),
        volume_ml = 5,
        mass_milligrams = 7200,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("cement", 1)
    content.add(item)
end

do
    -- density: 1.6 g/cm3
    local item = content.Item {
        id = "material_gravel",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("gravel", "gravel", "material"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A handful of gravel, smaller than pebbles but larger than sand."),
        volume_ml = 5,
        mass_milligrams = 8000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "shredded_rubber",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("shredded rubber", "shredded rubber"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A handful of shredded rubber, usable as a mulch now."),
        volume_ml = 5,
        mass_milligrams = 6000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_limestone",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("limestone", "limestone"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A handful of small chunks of limestone.  Useful for experiments at science fairs, but pretty useless as ammo.  Maybe something could be crafted from this stuff…"),
        volume_ml = 5,
        mass_milligrams = 14000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_quicklime",
        category = "chems",
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("quicklime powder", "quicklime powder"),
        display_type = "BY_WEIGHT",
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("The product of burning limestone, this white powder is a crucial ingredient in making cement.  That said, it is also extremely caustic and will cause severe burns to any tissue it comes in contact with.  This property could probably be exploited."),
        volume_ml = 5,
        mass_milligrams = 16700,
        stackable = true,
    }
    item:material("quicklime", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_slaked_lime",
        category = "chems",
        price_cents = 2,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("slaked lime powder", "slaked lime powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of slaked lime, a white odorless powder with many uses.  Also known as calcium hydroxide."),
        volume_ml = 1,
        mass_milligrams = 2211,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("slaked_lime", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_sand",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("sand", "sand", "material"),
        display_type = "BY_WEIGHT",
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A handful of New England sand.  If you had a stoked furnace, you could turn it into glass.  Otherwise, it's only good for making cement."),
        volume_ml = 5,
        mass_milligrams = 8000,
        stackable = true,
    }
    item:material("sand", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_soil",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("soil", "soil"),
        display_type = "BY_VOLUME",
        symbol = "=",
        color = "brown",
        description = ccb.content.text("A pile of loosely-packed, slightly damp loamy soil.  This mixture of sand, silt and clay is ideal for growing plants."),
        volume_ml = 5000,
        mass_milligrams = 6500000,
        stackable = true,
    }
    item:material("soil", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_shrd_limestone",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("limestone shard", "limestone shards"),
        category = "chems",
        description = ccb.content.text("A small shard of limestone.  Pretty flimsy and not much of a weapon, but its alkaline properties may yet find some use."),
        price_cents = 500,
        price_postapoc_cents = 10,
        mass_milligrams = 2700000,
        volume_ml = 1000,
        display_type = "BY_VOLUME",
        stackable = true,
    }
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_rocksalt",
        category = "food",
        price_cents = 50,
        price_postapoc_cents = 100,
        name = ccb.content.plural_text("rock salt", "rock salt"),
        symbol = "*",
        color = "light_gray",
        description = ccb.content.text("A handful of rock salt crystals.  Could be refined into table salt."),
        volume_ml = 3500,
        mass_milligrams = 650000,
        display_type = "BY_VOLUME",
        stackable = true,
    }
    item:material("salt", 1)
    item:material("stone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- density: 3.57–3.76 g/cm3
    local item = content.Item {
        id = "material_rhodonite",
        category = "chems",
        price_cents = 250,
        price_postapoc_cents = 100,
        name = ccb.content.plural_text("rhodonite", "rhodonite"),
        symbol = "*",
        color = "red",
        description = ccb.content.text("A chunk of rhodonite.  It has manganese dioxide covering and going through it in veins, which can be obtained using a chisel."),
        volume_ml = 250,
        mass_milligrams = 915000,
        display_type = "BY_VOLUME",
        stackable = true,
    }
    item:material("rhodonite", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_zincite",
        category = "chems",
        price_cents = 250,
        price_postapoc_cents = 100,
        name = ccb.content.plural_text("zincite", "zincite"),
        symbol = "*",
        color = "red",
        description = ccb.content.text("A chunk of zincite.  Could be refined into zinc oxide, then into zinc by reduction with a source of carbon."),
        volume_ml = 250,
        mass_milligrams = 1412000,
        display_type = "BY_VOLUME",
        stackable = true,
    }
    item:material("zincite", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticide",
        category = "chems",
        name = ccb.content.plural_text("insecticide powder", "insecticide powder"),
        mass_milligrams = 50000,
        color = "pink",
        looks_like = "fungicide",
        default_container = "bag_plastic_small",
        symbol = "!",
        description = ccb.content.text("Agricultural-grade chemical insecticide powder designed to eradicate insect pests."),
        price_cents = 5,
        price_postapoc_cents = 5,
        volume_ml = 50,
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_aluminium_powder",
        stackable = true,
        category = "chems",
        price_cents = 5,
        price_postapoc_cents = 5,
        name = ccb.content.plural_text("aluminum powder", "aluminum powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of finely-ground aluminum powder.  This strong reducing agent was used in combination with various oxidants for chemical welding and explosives alike.  Just before the Cataclysm, however, it was the basis of virtually all commercial metallic-hued paints and anti-corrosive coatings."),
        volume_ml = 3,
        mass_milligrams = 1760,
        default_container = "bag_plastic_small",
        display_type = "BY_WEIGHT",
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_nickel_powder",
        category = "chems",
        price_cents = 12,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("nickel powder", "nickel powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of silvery-white metallic powder composed of nickel.  Common industrial uses include production of stainless steel as well as other alloys."),
        default_container = "bag_plastic_small",
        volume_ml = 1,
        mass_milligrams = 36,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    -- Density 7.14g/cm³
    local item = content.Item {
        id = "chem_zinc_powder",
        stackable = true,
        category = "chems",
        price_cents = 6,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("zinc powder", "zinc powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of zinc powder.  While commercially used mostly in cosmetics and for paints, hobbyists used to mix it with sulfur to make basic rocket fuel or a smokescreen.  When treated with a strong acid, it will produce hydrogen."),
        volume_ml = 1,
        mass_milligrams = 7140,
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- Density: 5.606 g/cm3
    local item = content.Item {
        id = "chem_zinc_oxide",
        stackable = true,
        category = "chems",
        price_cents = 2,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("zinc oxide", "zinc oxide"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of zinc oxide powder.  It can be reduced into zinc, or used for some other reactions of its own."),
        volume_ml = 1,
        mass_milligrams = 5606,
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- density: 5.026 g/cm3
    local item = content.Item {
        id = "chem_manganese_dioxide",
        stackable = true,
        category = "chems",
        price_cents = 6,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("manganese dioxide powder", "manganese dioxide powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of manganese dioxide powder.  Occurring naturally in the mineral pyrolusite, it is used commercially in the production of alkaline and zinc-carbon batteries."),
        volume_ml = 1,
        mass_milligrams = 5026,
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cathod_mix",
        category = "chems",
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("acidic electrolyte paste", "acidic electrolyte paste"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A moisturized mixture of zinc chloride and manganese dioxide, slightly acidic.  It can be used in the production of zinc-carbon batteries."),
        volume_ml = 1,
        mass_milligrams = 500,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_ferric_chloride",
        category = "chems",
        price_cents = 12,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("ferric chloride powder", "ferric chloride powder"),
        symbol = "=",
        color = "green",
        description = ccb.content.text("A handful of dark green crystalline powder, with a weak pungent smell similar to that of hydrochloric acid.  Commonly used as a Lewis acid for catalyzing various chemical reactions."),
        default_container = "bag_plastic_small",
        volume_ml = 1,
        mass_milligrams = 2900,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_antimony_trichloride",
        category = "chems",
        price_cents = 12,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("antimony trichloride powder", "antimony trichloride powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of soft, colorless powder with a sharp pungent odor, also known as butter of antimony.  It's a catalyst for polymerization, hydrocracking, and chlorination reactions, and has some other niche uses."),
        default_container = "bag_plastic_small",
        volume_ml = 1,
        mass_milligrams = 3140,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    -- density: 1.984 g/cm3
    local item = content.Item {
        id = "chem_potassium_chloride",
        stackable = true,
        category = "chems",
        price_cents = 6,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("potassium chloride powder", "potassium chloride powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of potassium chloride powder.  Although it occurs naturally in the mineral sylvite, it can be produced as a byproduct of the reaction of saltpeter and hydrochloric acid.  It can be used for making fertilizer, or potassium hydroxide by way of electrolysis."),
        volume_ml = 1,
        mass_milligrams = 1984,
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- density: 2.12 g/cm3 (25 °C)
    local item = content.Item {
        id = "chem_potassium_hydroxide",
        stackable = true,
        category = "chems",
        price_cents = 6,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("potassium hydroxide powder", "potassium hydroxide powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of potassium hydroxide powder.  Commonly called caustic potash, it was mainly used industrially for its caustic nature.  It can be used as an electrolyte in alkaline batteries, among other applications."),
        volume_ml = 1,
        mass_milligrams = 2120,
        default_container = "bottle_plastic_small",
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- density: 5.22 g/cm3
    local item = content.Item {
        id = "chem_chromium_oxide",
        stackable = true,
        category = "chems",
        price_cents = 500,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("chromium oxide powder", "chromium oxide powder"),
        symbol = "=",
        color = "green",
        description = ccb.content.text("A handful of chromium oxide.  This substance, typically known as the only stable green pigment for paints, is also a mild oxidizer, which can be mixed with aluminum powder to make thermite for welding.  If one had access to a CVD machine and a laboratory worth of reagents, they might be able to produce very durable ceramic layers."),
        volume_ml = 1,
        mass_milligrams = 5220,
        display_type = "BY_WEIGHT",
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    -- density: 2.22 g/cm3
    local item = content.Item {
        id = "chem_carbide",
        stackable = true,
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("calcium carbide powder", "calcium carbide powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of calcium carbide, giving off a faint, garlic-like smell.  Commercially, calcium carbide was used for on-the-spot manufacture of acetylene and historically to power acetylene lamps.  If mixed with water and sealed, it will explode with little strength, but with a relatively loud noise that might be useful as a distraction."),
        volume_ml = 1,
        mass_milligrams = 2220,
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- density: 2.71 g/cm3
    local item = content.Item {
        id = "chem_caco3",
        stackable = true,
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("calcium carbonate powder", "calcium carbonate powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of calcium carbonate powder, typically derived from lime or shells.  Useful for a number of roles, such as sugar production, fracking, construction, paint additives and antacid medicine."),
        volume_ml = 1,
        mass_milligrams = 2710,
        display_type = "BY_WEIGHT",
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- Plutonium is about 5000 USD/gram
    -- Nobody wants raw plutonium, unless they have a deathwish
    local item = content.Item {
        id = "plutonium",
        name = ccb.content.plural_text("chunk of plutonium", "chunks of plutonium"),
        category = "chems",
        price_cents = 495000000,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "light_gray",
        description = ccb.content.text("A chunk of unshielded plutonium.  You should probably get very far away from this, if you enjoy not being irradiated."),
        volume_ml = 50,
        mass_milligrams = 990000,
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("LEAK_ALWAYS")
    item:flag("RADIOACTIVE")
    content.add(item)
end

do
    -- Uranium is about 40 USD/kg
    -- Nobody wants raw uranium, unless they have a deathwish
    local item = content.Item {
        id = "uranium",
        name = ccb.content.plural_text("chunk of uranium", "chunks of uranium"),
        category = "chems",
        price_cents = 3812,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "light_gray",
        description = ccb.content.text("Some uranium.  You should probably get very far away from this, if you enjoy not being irradiated."),
        volume_ml = 50,
        mass_milligrams = 953000,
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("LEAK_ALWAYS")
    item:flag("RADIOACTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_ammonium_nitrate",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("ammonium nitrate powder", "ammonium nitrate powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of ammonium nitrate powder.  This white, crystalline powder is commonly used as a component of fertilizers and explosives.  Could also be dissolved in water to sharply lower its temperature, but is there any use for this quality in this new world?"),
        volume_ml = 1,
        mass_milligrams = 1000,
        default_container = "bag_canvas",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_ammonium_nitrate_pellets",
        looks_like = "fertilizer_commercial",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("ammonium nitrate pellets", "ammonium nitrate pellets"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of ammonium nitrate pellets.  These pellets are commonly used as a component of fertilizers and explosives.  Could also be dissolved in water to sharply lower its temperature, but is there any use for this quality in this new world?"),
        volume_ml = 1,
        mass_milligrams = 1000,
        default_container = "bag_canvas",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_saltpetre",
        stackable = true,
        category = "chems",
        price_cents = 4,
        price_postapoc_cents = 10,
        name = ccb.content.plural_text("saltpeter powder", "saltpeter powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of saltpeter powder.  Sometimes used as a fertilizer, this ubiquitous nitrate is the principal constituent of black gunpowder and simple rocket propellants, such as rocket candy."),
        display_type = "BY_WEIGHT",
        volume_ml = 50,
        mass_milligrams = 5275,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_niter",
        category = "spare_parts",
        price_cents = 75,
        price_postapoc_cents = 100,
        name = ccb.content.plural_text("niter crystal", "niter crystal"),
        symbol = "*",
        color = "white",
        description = ccb.content.text("A large crystal of niter, the mineral form of potassium nitrate.  It can be processed into saltpeter."),
        volume_ml = 1250,
        mass_milligrams = 790000,
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_aluminium_sulphate",
        category = "chems",
        price_cents = 6,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("aluminum sulfate crystal", "aluminum sulfate crystal"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("Several crystals of aluminum sulfate.  Historically, an agent for purifying water and as molluscicide, due to the fact that it degenerates their slime.  Just before the Cataclysm, its main uses were for adjusting the acidity of soil and as an additive to baking powder.  If mixed with a strong acid, it could be used to saturate soil with aluminum, causing all but the most resistant of plants to wither and die."),
        volume_ml = 5,
        mass_milligrams = 13350,
        default_container = "bag_canvas",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    -- Weight might not be accurate.
    local item = content.Item {
        id = "chem_thermite",
        category = "chems",
        price_cents = 50,
        price_postapoc_cents = 10,
        name = ccb.content.plural_text("thermite powder", "thermite powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of silvery-greenish powder, produced by mixing aluminum and chromium oxide.  This mixture, burning at a constant pace and at extremely high temperature, was once used for on-the-spot welding.  Can be used as an incendiary material in a pinch."),
        volume_ml = 5,
        mass_milligrams = 10000,
        default_container = "bag_canvas",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_anfo",
        category = "chems",
        price_cents = 10,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("ANFO pellets", "ANFO pellets"),
        symbol = "=",
        color = "red",
        description = ccb.content.text("A handful of brownish pellets, made by allowing ammonium nitrate to absorb an organic fuel.  This ammonium nitrate/fuel oil mixture, or ANFO, is a common industrial explosive due to its stability and low price.  Burns fast, but needs an explosive primer to detonate."),
        volume_ml = 1,
        mass_milligrams = 1000,
        default_container = "bag_canvas",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_black_powder",
        stackable = true,
        stack_size = 1000,
        category = "chems",
        price_cents = 2000,
        price_postapoc_cents = 1000,
        name = ccb.content.plural_text("black gunpowder", "black gunpowder"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A handful of black gunpowder, a mix of saltpeter, charcoal, and sulfur.  Pretty useless for making modern cartridges, as the soot produced when it burns will quickly clog any firearm, but it could be used to make some vicious bombs."),
        volume_ml = 89,
        mass_milligrams = 151,
        default_container = "bag_plastic_small",
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- Density of RDX/Hexogen is 1.858 g/cm3
    local item = content.Item {
        id = "chem_rdx",
        category = "chems",
        price_cents = 15,
        price_postapoc_cents = 5,
        name = ccb.content.plural_text("Hexogen/RDX powder", "Hexogen/RDX powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of Hexogen powder or RDX, commonly known as cyclonite: a military-grade, shelf-stable high explosive white, crystalline powder.  Can be cast into shaped charges, or mixed with scrap to pepper the blast area with high-velocity shrapnel."),
        volume_ml = 1,
        mass_milligrams = 1858,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- Density of composition B is 1.65 g/cm3
    local item = content.Item {
        id = "chem_compositionb",
        category = "chems",
        price_cents = 15,
        price_postapoc_cents = 4,
        name = ccb.content.plural_text("composition B", "composition B"),
        symbol = "=",
        color = "brown",
        description = ccb.content.text("Composition B is an explosive consisting of castable mixtures of Hexogen/RDX and TNT.  It is used as the main explosive filling in artillery projectiles, rockets, land mines, hand grenades, and various other munitions."),
        volume_ml = 1,
        mass_milligrams = 1650,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- Density of RDX is 1.57 g/cm3
    local item = content.Item {
        id = "chem_hmtd",
        category = "chems",
        price_cents = 25,
        price_postapoc_cents = 5,
        name = ccb.content.plural_text("HMTD powder", "HMTD powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("Hexamine peroxide: this fine, yellowish powder is a powerful primary explosive, used to initiate detonation of more stable explosives, such as RDX.  Relatively stable, but best not store it for too long.  Widely used pre-Cataclysm in amateur-made blasting caps."),
        volume_ml = 1,
        mass_milligrams = 1570,
        default_container = "bag_plastic_small",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("dense_powder", 1)
    content.add(item)
end

do
    -- Detonation velocity about 2500–3000 m/s near 0.5 g/cm3
    local item = content.Item {
        id = "chem_apex",
        category = "chems",
        price_cents = 25,
        price_postapoc_cents = 5,
        name = ccb.content.plural_text("Acetone Peroxide/APEX powder", "Acetone Peroxide/APEX powder"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("Acetone peroxide, also called APEX or Mother of Satan: this fine, white crystalline powder is a powerful primary explosive, used to initiate detonation of more stable explosives, such as RDX.  Relatively stable, with a fruit-like smell when pure."),
        volume_ml = 1,
        mass_milligrams = 500,
        default_container = "bag_plastic_small",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_rocket_fuel",
        category = "chems",
        price_cents = 500,
        price_postapoc_cents = 500,
        name = ccb.content.plural_text("chunk of improvised rocket fuel", "chunks of improvised rocket fuel"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A chunk of a zinc powder-and-sulfur mixture, mixed with superglue to form a solid, that can be used as an impromptu rocket fuel."),
        volume_ml = 250,
        mass_milligrams = 70000,
        default_container = "bag_plastic_small",
        stackable = true,
    }
    item:material("powder", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hickory_root",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("hickory root", "hickory roots"),
        description = ccb.content.text("A root from a hickory tree.  It has an earthy smell."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 500000,
        volume_ml = 500,
    }
    item:material("wood", 1)
    content.add(item)
end

do
    -- 180 days
    local item = content.Item {
        id = "hickory_nut",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("hickory nuts", "hickory nuts"),
        description = ccb.content.text("A handful of hard nuts from a hickory tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 212000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 180 days
    local item = content.Item {
        id = "pecan",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("pecans", "pecans"),
        description = ccb.content.text("A handful of hard nuts from a pecan tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 212000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 90 days
    local item = content.Item {
        id = "pistachio",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("pistachios", "pistachios"),
        description = ccb.content.text("A handful of hard nuts from a pistachio tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 180000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 300 days
    local item = content.Item {
        id = "almond",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("almonds", "almonds"),
        description = ccb.content.text("A handful of hard nuts from an almond tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 212000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 240 days
    local item = content.Item {
        id = "peanut",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("peanuts", "peanuts"),
        description = ccb.content.text("A handful of hard nuts from a peanut bush, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 200000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 150 days
    local item = content.Item {
        id = "hazelnut",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("hazelnuts", "hazelnuts"),
        description = ccb.content.text("A handful of hard nuts from a hazelnut tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 212000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 180 days
    local item = content.Item {
        id = "chestnut",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("chestnuts", "chestnuts"),
        description = ccb.content.text("A handful of hard nuts from a chestnut tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 240000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 180 days
    local item = content.Item {
        id = "walnut",
        category = "food",
        symbol = "%",
        color = "brown",
        name = ccb.content.plural_text("walnuts", "walnuts"),
        description = ccb.content.text("A handful of hard nuts from a walnut tree, still in their shells."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 240000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 180 days
    local item = content.Item {
        id = "butternut",
        category = "food",
        symbol = "%",
        color = "yellow",
        name = ccb.content.plural_text("butternuts", "butternuts"),
        description = ccb.content.text("A handful of nuts from a butternut tree, still in their shell."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 240000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    -- 180 days
    local item = content.Item {
        id = "butternut_husk",
        category = "food",
        symbol = "%",
        color = "yellow",
        name = ccb.content.plural_text("butternut husks", "butternut husks"),
        description = ccb.content.text("A handful of husks from a butternuts, emptied of their meat."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 210000,
        volume_ml = 250,
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "detergent",
        stackable = true,
        category = "chems",
        price_cents = 50,
        price_postapoc_cents = 10,
        name = ccb.content.plural_text("detergent powder", "detergent powder"),
        display_type = "BY_WEIGHT",
        symbol = "=",
        color = "white",
        description = ccb.content.text("A popular pre-Cataclysm washing powder."),
        volume_ml = 13,
        mass_milligrams = 7500,
    }
    item:material("powder", 1)
    item:clear_flags()
    item:flag("DETERGENT")
    content.add(item)
end

do
    local item = content.Item {
        id = "soap_flakes",
        category = "chems",
        price_cents = 10,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("soap flakes", "soap flakes"),
        looks_like = "detergent",
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of flakes shaved off a bar of soap, suitable for use in a washing machine."),
        volume_ml = 13,
        mass_milligrams = 4000,
        stackable = true,
    }
    item:clear_flags()
    item:flag("DETERGENT")
    content.add(item)
end

do
    local item = content.Item {
        id = "ash",
        category = "chems",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("wood ashes", "wood ashes"),
        symbol = "=",
        looks_like = "f_ash",
        color = "light_gray",
        description = ccb.content.text("A handful of almost-weightless residue left after the burning of some substance."),
        volume_ml = 2,
        mass_milligrams = 1000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_ash",
        category = "chems",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("corpse ashes", "corpse ashes"),
        symbol = "=",
        looks_like = "f_ash",
        color = "light_gray",
        description = ccb.content.text("The burnt remains of a person or animal."),
        volume_ml = 1,
        mass_milligrams = 1000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    -- Bulk density is around 0.5 g/mL
    local item = content.Item {
        id = "chem_peptone_broth",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("peptone water powder", "peptone water powder"),
        symbol = ";",
        color = "yellow",
        default_container = "bottle_plastic_small",
        description = ccb.content.text("A pre-mixed salty solution of protein and sugar meant for bacteria to eat."),
        volume_ml = 2,
        mass_milligrams = 1000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- Bulk density is around 0.55 g/mL
    local item = content.Item {
        id = "chem_agar",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("agar flake", "agar flake"),
        symbol = ";",
        color = "yellow",
        default_container = "bottle_plastic_small",
        description = ccb.content.text("Clear flakes of processed seaweed that can be dissolved in boiling water to create a very sturdy, temperature-resistant gel.  Not only is it good for making gels to separate molecules by size, but it's a great cheat ingredient to make sure your jellies set properly."),
        volume_ml = 1,
        mass_milligrams = 1000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- Bulk density is around 0.5 g/mL (because it's a powder, the actual density of 1.12 g/mL is not useful)
    local item = content.Item {
        id = "chem_acrylamide",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("acrylamide powder", "acrylamide powder"),
        symbol = ";",
        color = "white",
        default_container = "bottle_glass",
        description = ccb.content.text("A handful of highly carcinogenic white powder that can be readily polymerized into a whole bunch of useful water-soluble gels."),
        volume_ml = 2,
        mass_milligrams = 1000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "steel_grille",
        category = "other",
        name = ccb.content.plural_text("steel grille", "steel grilles"),
        description = ccb.content.text("A metal grille.  It can be used as a framework for making a chemical catalyst."),
        mass_milligrams = 600000,
        volume_ml = 250,
        price_cents = 500,
        price_postapoc_cents = 10,
        melee_to_hit = 0,
        symbol = ";",
        color = "light_gray",
        looks_like = "lc_link_sheet",
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "cobalt_60",
        category = "other",
        price_cents = 1000,
        price_postapoc_cents = 50,
        name = ccb.content.plural_text("cobalt-60 pellet", "cobalt-60 pellets"),
        symbol = "=",
        color = "green",
        description = ccb.content.text("A piece of unshielded radioactive material that used to be a part of some nuclear industry equipment.  You have yet to find some use for it, and you probably shouldn't stand near it."),
        volume_ml = 90,
        mass_milligrams = 80000,
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("LEAK_ALWAYS")
    item:flag("RADIOACTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "wooden_bead",
        category = "spare_parts",
        name = ccb.content.plural_text("wooden bead", "wooden beads"),
        description = ccb.content.text("A wooden bead.  It can be used to craft inscribable jewelry or create a beaded curtain door."),
        mass_milligrams = 1000,
        volume_ml = 2,
        price_cents = 1,
        price_postapoc_cents = 0,
        symbol = ".",
        color = "brown",
        looks_like = "bb",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rosin",
        category = "chems",
        name = ccb.content.plural_text("rosin", "rosin"),
        description = ccb.content.text("A chunk of yellowish rosin, usable as a flux for soldering."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 0,
        price_postapoc_cents = 1,
        symbol = "=",
        color = "yellow",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("wood", 1)
    content.add(item)
end

do
    -- Bulk density is around 0.5 g/mL (because it's a powder, the actual density of 1.12 g/mL is not useful)
    local item = content.Item {
        id = "chem_citric_acid",
        category = "chems",
        price_cents = 1,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("citric acid powder", "citric acid powder"),
        symbol = ";",
        color = "white",
        default_container = "bottle_glass",
        description = ccb.content.text("A manufactured form of citric acid that is commonly used as an additive in food, cleaning agents, and nutritional supplements."),
        volume_ml = 2,
        mass_milligrams = 1000,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- Density around 2.2g/cm3, but since it's a powder, it's a bit lower, around 1.8-2.0 g/cm3
    local item = content.Item {
        id = "red_phosphorous",
        stackable = true,
        category = "chems",
        name = ccb.content.plural_text("red phosphorous powder", "red phosphorous powder"),
        description = ccb.content.text("An allotrope of the element phosphorous.  It's what you use to light matches, but can also be used in the synthesis of methamphetamine.  You could use it to make bombs, and if you were truly desperate you might even be able to use it in small portions as a propellant for bullets."),
        mass_milligrams = 10000,
        volume_ml = 5,
        symbol = "=",
        color = "red",
        price_cents = 50,
        price_postapoc_cents = 2,
        display_type = "BY_WEIGHT",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "red_phosphorous_small",
        category = "chems",
        name = ccb.content.plural_text("scrapings of red phosphorous powder", "scrapings of red phosphorous powder"),
        description = ccb.content.text("A small collection of red phosphorous scrapings, scavenged from match heads.  An allotrope of the element phosphorous.  It's what you use to light matches, but can also be used in the synthesis of methamphetamine.  You could use it to make bombs, and if you were truly desperate you might even be able to use it as a propellant for bullets."),
        mass_milligrams = 100,
        volume_ml = 1,
        default_container = "bottle_plastic_small",
        symbol = "=",
        color = "red",
        price_cents = 50,
        price_postapoc_cents = 2,
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    content.add(item)
end

do
    -- Density around 1.8g/cm3, but since it's a powder, it's a bit lower, around 1.5 g/cm3
    local item = content.Item {
        id = "white_phosphorous",
        stackable = true,
        category = "chems",
        name = ccb.content.plural_text("white phosphorous powder", "white phosphorous powder"),
        description = ccb.content.text("An allotrope of the element phosphorous.  Extremely flammable, produces toxic smoke, you can use it to make smoke bombs."),
        mass_milligrams = 7500,
        volume_ml = 5,
        symbol = "=",
        color = "white",
        price_cents = 50,
        price_postapoc_cents = 2,
        display_type = "BY_WEIGHT",
    }
    content.add(item)
end

do
    -- Density around 5.1g/cm3, but since it's in crystal form, it's lower, around 3.5 g/cm3
    local item = content.Item {
        id = "iodine_crystal",
        stackable = true,
        category = "chems",
        name = ccb.content.plural_text("iodine crystals", "iodine crystals"),
        description = ccb.content.text("A handful of resublimed crystals of the element iodine, they can be used as an antiseptic, but are also used in the making of methamphetamine."),
        mass_milligrams = 3500,
        volume_ml = 1,
        default_container = "box_small",
        symbol = "=",
        color = "dark_gray",
        price_cents = 1,
        price_postapoc_cents = 1,
        display_type = "BY_WEIGHT",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ceramic_patch",
        category = "chems",
        price_cents = 5000,
        price_postapoc_cents = 5000,
        name = ccb.content.plural_text("exodii ceramic patch", "exodii ceramic patch"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A patch kit produced by the Exodii for repairing their nanotube-infused ceramics.  Requires a kiln."),
        volume_ml = 500,
        mass_milligrams = 65000,
        stackable = true,
    }
    item:material("exodii_ceramic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    -- 1.2m x 2 cm x 36 cm
    local item = content.Item {
        id = "material_styrofoam_sheet",
        category = "spare_parts",
        price_cents = 250,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("styrofoam sheet", "styrofoam sheets"),
        symbol = "#",
        color = "white",
        description = ccb.content.text("Bulky, but extremely light sheet of styrofoam, designed to be used in building insulation."),
        volume_ml = 8640,
        mass_milligrams = 260000,
        longest_side_mm = 1200,
        stackable = true,
    }
    item:material("styrofoam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "material_styrofoam_chunk",
        category = "spare_parts",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("chunk of styrofoam", "chunks of styrofoam"),
        display_type = "BY_VOLUME",
        symbol = "*",
        color = "white",
        description = ccb.content.text("A small chunk of styrofoam."),
        volume_ml = 150,
        mass_milligrams = 5000,
        stackable = true,
    }
    item:material("styrofoam", 1)
    content.add(item)
end
