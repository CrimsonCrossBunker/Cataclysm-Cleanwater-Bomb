local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "scrap_worthless",
        abstract = true,
        name = content.plural_text("worthless scraps", "worthless scraps"),
        description = content.text("A handful of oddly-shaped worthless bits of abstract code.  Seeing this is a bug."),
        category = "other",
        mass_milligrams = 500,
        volume_ml = 1,
        price_cents = 1,
        price_postapoc_cents = 0,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "scrap_valuable",
        abstract = true,
        name = content.plural_text("valuable scraps", "valuable scraps"),
        description = content.text("A handful of oddly-shaped valuable bits of abstract code.  Seeing this is a bug."),
        category = "other",
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 1,
        price_postapoc_cents = 5,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "grass_yarn",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("grass yarn", "grass yarns"),
        category = "spare_parts",
        description = ccb.content.text("Primitive yarn made from coarse plant fibers like straw or grass.  Too thick to sew with, but could be woven into a crude sheet of fabric."),
        price_cents = 10,
        mass_milligrams = 100000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("dry_plant", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_cotton",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("cotton scraps", "cotton scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of cotton, waste material from tailoring projects.  Not useful for much and usually disposed of, but they can be recycled into some thread if you really want."),
        volume_ml = 1,
        symbol = "=",
        color = "dark_gray",
    }
    item:material("cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_faux_fur",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("faux fur scraps", "faux fur scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of faux fur, waste material from tailoring projects.  Not useful for much and usually disposed of."),
        mass_milligrams = 3000,
        volume_ml = 7,
        price_cents = 0,
        price_postapoc_cents = 5,
    }
    item:material("faux_fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_felt",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("felt scraps", "felt scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of felt, waste material from tailoring projects.  Not useful for much and usually disposed of, but they can be recycled into some wool fiber if you really want."),
        volume_ml = 5,
    }
    item:material("wool", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_fur",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("fur scraps", "fur scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of fur, waste material from tailoring projects.  Not useful for much and usually disposed of."),
        price_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 15,
    }
    item:material("fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_kevlar",
        copy_from = "scrap_valuable",
        name = ccb.content.plural_text("Kevlar scraps", "Kevlar scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of Kevlar fabric, waste material from tailoring projects.  Normally it would be disposed of, but since Kevlar is very difficult to make in a post-apocalyptic world, it might be worth recycling it for Kevlar thread."),
        volume_ml = 2,
        mass_milligrams = 810,
        price_cents = 1,
        price_postapoc_cents = 10,
    }
    item:material("kevlar", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_leather",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("leather scraps", "leather scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of leather, waste material from tailoring projects.  Not useful for much and usually disposed of."),
        price_cents = 0,
        volume_ml = 6,
    }
    item:material("leather", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_lycra",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("Lycra scraps", "Lycra scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of Lycra, waste material from tailoring projects.  Not useful for much and usually disposed of."),
        price_cents = 0,
        volume_ml = 4,
    }
    item:material("lycra", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_neoprene",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("neoprene scraps", "neoprene scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of neoprene, waste material from tailoring projects.  Not useful for much and usually disposed of."),
        price_cents = 0,
        volume_ml = 6,
    }
    item:material("neoprene", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_nylon",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("synthetic fabric scraps", "synthetic fabric scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of synthetic fabric, waste material from tailoring projects.  Not useful for much and usually disposed of."),
        price_cents = 0,
        volume_ml = 3,
    }
    item:material("nylon", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_nomex",
        copy_from = "scrap_valuable",
        name = ccb.content.plural_text("Nomex scraps", "Nomex scraps"),
        description = ccb.content.text("A handful of oddly-shaped smallish bits of heat-resistant Nomex fabric, waste material from tailoring projects.  Normally it would be disposed of, but since Nomex is very difficult to make in a post-apocalyptic world, it might be worth recycling it for Nomex thread."),
        price_cents = 5,
        volume_ml = 2,
        price_postapoc_cents = 8,
    }
    item:material("nomex", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_carpet",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("scraps of carpet", "scraps of carpet"),
        description = ccb.content.text("A misshapen section of loose carpet.  Not useful for much on its own and can be discarded."),
        mass_milligrams = 500000,
        volume_ml = 500,
        symbol = "=",
        color = "dark_gray",
    }
    item:material("carpet_pilling", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wool_staple",
        category = "spare_parts",
        name = ccb.content.plural_text("wool staple", "wool staples"),
        description = ccb.content.text("A natural cluster of wool fibers.  Could be processed into felt patches or yarn."),
        mass_milligrams = 200000,
        volume_ml = 500,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "white",
        stackable = true,
    }
    item:material("wool", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "fur",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("fur patch", "fur patches"),
        description = ccb.content.text("A small bolt of fur from an animal, roughly six inches square.  Can be made into patchwork fur sheets or used to repair fur fabric."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 46000,
        volume_ml = 58,
        category = "spare_parts",
        stackable = true,
    }
    item:material("fur", 1)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "faux_fur",
        copy_from = "fur",
        looks_like = "fur",
        color = "pink",
        name = ccb.content.plural_text("faux fur patch", "faux fur patches"),
        price_postapoc_cents = 10,
        description = ccb.content.text("A small bolt of garishly-colored faux fur, roughly six inches square.  Can be made into patchwork faux fur sheets or used to repair faux fur fabric."),
        stackable = true,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:material("faux_fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "leather",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("leather patch", "leather patches"),
        description = ccb.content.text("A roughly six-inch square patch of leather, could be used to repair clothing and make smaller leather crafts."),
        price_cents = 2000,
        price_postapoc_cents = 25,
        mass_milligrams = 25000,
        volume_ml = 23,
        category = "spare_parts",
        stackable = true,
    }
    item:material("leather", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "felt_patch",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("felt patch", "felt patches"),
        description = ccb.content.text("A small, six-inch square patch of felt."),
        price_cents = 2000,
        price_postapoc_cents = 10,
        mass_milligrams = 3000,
        volume_ml = 18,
        category = "spare_parts",
        stackable = true,
    }
    item:material("wool", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "nomex",
        category = "spare_parts",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("Nomex patch", "Nomex patches"),
        description = ccb.content.text("A six-inch square patch of Nomex fire-resistant fabric."),
        price_cents = 4000,
        price_postapoc_cents = 20,
        mass_milligrams = 4000,
        volume_ml = 9,
        stackable = true,
    }
    item:material("nomex", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "cured_hide",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("cured hide", "cured hides"),
        description = ccb.content.text("A rolled-up animal hide which has been scraped of extraneous hair and flesh and treated to prevent decay.  It still requires tanning to become usable leather."),
        price_cents = 200,
        price_postapoc_cents = 150,
        mass_milligrams = 40000,
        volume_ml = 125,
        category = "spare_parts",
        stackable = true,
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tanned_hide",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("tanned hide", "tanned hides"),
        description = ccb.content.text("A folded 12-inch by 24-inch sheet of leather made from carefully tanned animal hide.  Can be cut up or used as is."),
        price_cents = 5000,
        price_postapoc_cents = 500,
        mass_milligrams = 296000,
        volume_ml = 186,
        category = "spare_parts",
        stackable = true,
    }
    item:material("leather", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_leather",
        name = ccb.content.plural_text("leather sheet", "leather sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of leather.  Can be cut up or used as is."),
        category = "spare_parts",
        mass_milligrams = 296000,
        volume_ml = 300,
        price_cents = 2500,
        price_postapoc_cents = 250,
        symbol = ",",
        color = "brown",
        stackable = true,
    }
    item:material("leather", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_leather_patchwork",
        name = ccb.content.plural_text("patchwork leather sheet", "patchwork leather sheets"),
        description = ccb.content.text("A folded 12-inch by 24-inch sheet of leather sewn together from patches.  Can be cut up or used as is."),
        copy_from = "sheet_leather",
        looks_like = "sheet_leather",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "cured_pelt",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("cured pelt", "cured pelts"),
        description = ccb.content.text("A rolled-up animal hide which has been scraped of extraneous hair and flesh and treated to prevent decay.  It still requires tanning to become usable fur."),
        price_cents = 200,
        price_postapoc_cents = 150,
        mass_milligrams = 372000,
        volume_ml = 465,
        category = "spare_parts",
        stackable = true,
    }
    item:material("fur", 1)
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tanned_pelt",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("tanned pelt", "tanned pelts"),
        description = ccb.content.text("A folded sheet of fur made from carefully tanned animal pelt.  Can be cut up or used as is."),
        price_cents = 5000,
        price_postapoc_cents = 500,
        mass_milligrams = 372000,
        volume_ml = 465,
        category = "spare_parts",
        stackable = true,
    }
    item:material("fur", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_fur_patchwork",
        symbol = ",",
        color = "brown",
        name = ccb.content.plural_text("patchwork fur sheet", "patchwork fur sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of fur sewn together from patches.  Can be cut up or used as is."),
        price_cents = 2500,
        price_postapoc_cents = 250,
        mass_milligrams = 372000,
        volume_ml = 465,
        category = "spare_parts",
        stackable = true,
    }
    item:material("fur", 1)
    content.add(item)
end

do
    -- .80 grams per mL, 203 GSM
    local item = content.Item {
        id = "sheet_cotton_patchwork",
        copy_from = "sheet_cotton",
        looks_like = "sheet_cotton",
        name = ccb.content.plural_text("patchwork cotton sheet", "patchwork cotton sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of cotton sewn together from patches of various clothing parts.  Suitable for making clothing if you lack proper material sheets."),
        price_cents = 200,
        price_postapoc_cents = 20,
    }
    content.add(item)
end

do
    -- Based on 2000gsm faux fur
    local item = content.Item {
        id = "sheet_faux_fur",
        category = "spare_parts",
        name = ccb.content.plural_text("faux fur sheet", "faux fur sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of colorful faux fur, suitable for making clothing."),
        mass_milligrams = 372000,
        volume_ml = 465,
        price_cents = 5000,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("faux_fur", 1)
    content.add(item)
end

do
    -- 12 inches by 24 inches with GSM of 2000
    local item = content.Item {
        id = "sheet_faux_fur_patchwork",
        copy_from = "sheet_faux_fur",
        looks_like = "sheet_faux_fur",
        name = ccb.content.plural_text("patchwork faux fur sheet", "patchwork faux fur sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of faux fur sewn together from mismatched patches.  Suitable for making clothing if you lack proper material sheets, but the bright, clashing colors might end up making you look like a diseased Muppet."),
        price_cents = 1000,
        price_postapoc_cents = 50,
        stackable = true,
    }
    content.add(item)
end

do
    -- based on 150GSM felt
    local item = content.Item {
        id = "sheet_felt",
        category = "spare_parts",
        name = ccb.content.plural_text("felt sheet", "felt sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of felt, suitable for making clothing."),
        mass_milligrams = 28000,
        volume_ml = 145,
        price_cents = 2500,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("wool", 1)
    content.add(item)
end

do
    -- 150GSM felt
    local item = content.Item {
        id = "sheet_felt_patchwork",
        copy_from = "sheet_felt",
        looks_like = "sheet_felt",
        name = ccb.content.plural_text("patchwork felt sheet", "patchwork felt sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of felt sewn together from patches.  Suitable for making clothing if you lack proper material sheets."),
        price_cents = 500,
        price_postapoc_cents = 50,
    }
    content.add(item)
end

do
    -- values taken from Duponts chemical reference. 144 GSM
    local item = content.Item {
        id = "sheet_kevlar",
        category = "spare_parts",
        name = ccb.content.plural_text("Kevlar sheet", "Kevlar sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of loose-woven Kevlar synthetic fabric, suitable for making durable cut and stab resistant clothing.  While protective, this kind of Kevlar is not suitable for making ballistic gear due to the difference in weave tightness."),
        mass_milligrams = 26000,
        volume_ml = 51,
        price_cents = 900,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("kevlar", 1)
    content.add(item)
end

do
    -- values taken from Duponts chemical reference. 144 GSM
    local item = content.Item {
        id = "sheet_kevlar_patchwork",
        category = "spare_parts",
        name = ccb.content.plural_text("patchwork Kevlar sheet", "patchwork Kevlar sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of fabric sewn together from Kevlar patches, suitable for making durable cut and stab resistant clothing.  This would be out of the question for ballistic Kevlar but the simpler, looser weave of this variety means it is fine to use if you lack proper material sheets."),
        mass_milligrams = 26000,
        volume_ml = 51,
        price_cents = 900,
        price_postapoc_cents = 50,
        looks_like = "sheet_kevlar",
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("kevlar", 1)
    content.add(item)
end

do
    -- values taken from Duponts chemical reference. 144 GSM
    local item = content.Item {
        id = "kevlar_patch",
        category = "spare_parts",
        name = ccb.content.plural_text("Kevlar patch", "Kevlar patches"),
        description = ccb.content.text("A 6-inch square patch of loose-woven Kevlar, suitable for repairing cut and stab resistant clothing or reassembling into a patchwork sheet for sewing."),
        mass_milligrams = 3250,
        volume_ml = 5,
        price_cents = 100,
        price_postapoc_cents = 5,
        symbol = ",",
        color = "dark_gray",
        stackable = true,
    }
    item:material("kevlar", 1)
    content.add(item)
end

do
    -- 180 GSM fabric
    local item = content.Item {
        id = "sheet_lycra",
        category = "spare_parts",
        name = ccb.content.plural_text("Lycra sheet", "Lycra sheets"),
        description = ccb.content.text("A sheet of synthetic fabric blended with stretchy Lycra fibers, suitable for making flexible, yet strong clothing."),
        mass_milligrams = 33000,
        volume_ml = 117,
        price_cents = 5000,
        price_postapoc_cents = 25,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("lycra", 1)
    content.add(item)
end

do
    -- 180GSM
    local item = content.Item {
        id = "sheet_lycra_patchwork",
        copy_from = "sheet_lycra",
        looks_like = "sheet_lycra",
        name = ccb.content.plural_text("patchwork Lycra sheet", "patchwork Lycra sheets"),
        description = ccb.content.text("A 12-inch by 24-inch sheet of fabric sewn together from Lycra patches.  Suitable for making flexible, yet strong clothing if you lack proper material sheets."),
        price_cents = 1000,
        price_postapoc_cents = 50,
    }
    content.add(item)
end

do
    -- 110GSM, 1mm thick neoprene
    local item = content.Item {
        id = "sheet_neoprene",
        category = "spare_parts",
        name = ccb.content.plural_text("neoprene sheet", "neoprene sheets"),
        description = ccb.content.text("A sheet of neoprene, a synthetic rubber, suitable for making underwater gear."),
        mass_milligrams = 26000,
        volume_ml = 186,
        price_cents = 5000,
        price_postapoc_cents = 35,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("neoprene", 1)
    content.add(item)
end

do
    -- Density of 1.23 grams per mL
    local item = content.Item {
        id = "sheet_neoprene_patchwork",
        copy_from = "sheet_neoprene",
        looks_like = "sheet_neoprene",
        name = ccb.content.plural_text("patchwork neoprene sheet", "patchwork neoprene sheets"),
        description = ccb.content.text("A sheet of neoprene sewn together from patches, with waterproofed seams.  Suitable for making underwater gear if you lack proper material sheets."),
        price_cents = 1000,
        price_postapoc_cents = 60,
    }
    content.add(item)
end

do
    -- Taken from duponts chemical reference sheets. 170GSM
    local item = content.Item {
        id = "sheet_nomex",
        category = "spare_parts",
        name = ccb.content.plural_text("Nomex sheet", "Nomex sheets"),
        description = ccb.content.text("A sheet of Nomex synthetic fabric, suitable for making heat-resistant clothing."),
        mass_milligrams = 32000,
        volume_ml = 75,
        price_cents = 15000,
        price_postapoc_cents = 40,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("nomex", 1)
    content.add(item)
end

do
    -- Taken from duponts chemical reference sheets. 170GSM
    local item = content.Item {
        id = "sheet_nomex_patchwork",
        copy_from = "sheet_nomex",
        looks_like = "sheet_nomex",
        name = ccb.content.plural_text("patchwork Nomex sheet", "patchwork Nomex sheets"),
        description = ccb.content.text("A sheet of Nomex synthetic fabric, sewn together from patches using Nomex thread.  Suitable for making heat-resistant clothing if you lack proper material sheets."),
        price_cents = 3000,
        price_postapoc_cents = 80,
    }
    content.add(item)
end

do
    -- .25mm thick, 288 GSM (nylon 6,6 ranges 250-300 gsm)
    -- 1x2' sheet is 1858 cm^2 and at 288 gsm gives listed weight; density of 1.14g/cm^3 suggests about .25 mm thickness per sheet
    local item = content.Item {
        id = "sheet_nylon",
        category = "spare_parts",
        name = ccb.content.plural_text("synthetic fabric sheet", "synthetic fabric sheets"),
        description = ccb.content.text("A sheet of synthetic fabric, suitable for making clothing."),
        mass_milligrams = 54000,
        volume_ml = 48,
        price_cents = 5000,
        price_postapoc_cents = 20,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("nylon", 1)
    content.add(item)
end

do
    -- .25mm thick, 288 GSM (nylon 6,6 ranges 250-300 gsm)
    -- 1x2' sheet is 1858 cm^2 and at 288 gsm gives listed weight; density of 1.14g/cm^3 suggests about .25 mm thickness per sheet
    local item = content.Item {
        id = "sheet_nylon_patchwork",
        copy_from = "sheet_nylon",
        looks_like = "sheet_nylon",
        name = ccb.content.plural_text("patchwork synthetic fabric sheet", "patchwork synthetic fabric sheet"),
        description = ccb.content.text("A sheet of fabric, sewn together from synthetic fabric patches in a patchwork fashion.  Suitable for making most clothing, though it's much less time-efficient than if using proper material sheets."),
        price_cents = 1000,
        price_postapoc_cents = 40,
    }
    content.add(item)
end

do
    -- Usually lightweight 10-12 oz denim.
    local item = content.Item {
        id = "sheet_denim",
        category = "spare_parts",
        name = ccb.content.plural_text("denim sheet", "denim sheets"),
        description = ccb.content.text("A 12 inch by 24 inch sheet of durable blue denim, suitable for making jeans, jorts, or jirts."),
        mass_milligrams = 80000,
        volume_ml = 95,
        price_cents = 1250,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("denim", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_denim",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("denim scraps", "denim scraps"),
        description = ccb.content.text("Oddly-shaped smallish denim patches, waste material from tailoring projects."),
        mass_milligrams = 2000,
        volume_ml = 2,
        price_cents = 1,
        price_postapoc_cents = 5,
        symbol = "=",
        color = "dark_gray",
    }
    item:material("denim", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "denim_patch",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("denim patch", "denim patches"),
        description = ccb.content.text("A small, 6 inch square patch of blue denim.  It could be used to repair items made of denim or stitched into patchwork sheets for tailoring projects."),
        price_cents = 400,
        price_postapoc_cents = 12,
        mass_milligrams = 11000,
        volume_ml = 13,
        category = "spare_parts",
        stackable = true,
    }
    item:material("denim", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "sheet_denim_patchwork",
        category = "spare_parts",
        name = ccb.content.plural_text("patchwork denim sheet", "patchwork denim sheets"),
        description = ccb.content.text("A selection of various sections of denim, sewn together in a patchwork fashion.  Suitable for tailoring, though it's much less time-efficient than if using proper material sheets."),
        mass_milligrams = 80000,
        volume_ml = 95,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("denim", 1)
    content.add(item)
end

do
    -- heavyweight cotton canvas with a GSM of 406
    -- 1x2' sheet is 1858 cm^2 and at 406 gsm gives listed weight; density of 1.6g/cm^3 suggests about .254 mm thickness per sheet - rounded down to .250
    local item = content.Item {
        id = "sheet_canvas",
        category = "spare_parts",
        name = ccb.content.plural_text("canvas sheet", "canvas sheets"),
        description = ccb.content.text("A 12 inch by 24 inch sheet of durable and waterproof waxed canvas fabric, suitable for making tough bags and clothing."),
        mass_milligrams = 76000,
        volume_ml = 48,
        price_cents = 1250,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("canvas", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "scrap_canvas",
        copy_from = "scrap_worthless",
        name = ccb.content.plural_text("canvas scraps", "canvas scraps"),
        description = ccb.content.text("Oddly-shaped smallish bits of canvas, waste material from tailoring projects.  Not useful for much and usually disposed of, but can be recycled into some tough thread."),
        mass_milligrams = 2375,
        volume_ml = 2,
        price_cents = 1,
        price_postapoc_cents = 5,
        symbol = "=",
        color = "dark_gray",
    }
    item:material("canvas", 1)
    content.add(item)
end

do
    -- Roughly 406 GSM cotton, with a size of 6 inches square
    local item = content.Item {
        id = "canvas_patch",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("canvas patch", "canvas patches"),
        description = ccb.content.text("A small, 6 inch square patch of tough canvas.  It could be used to repair items made of canvas or stitched into patchwork sheets for tailoring projects."),
        price_cents = 400,
        price_postapoc_cents = 12,
        mass_milligrams = 9500,
        volume_ml = 6,
        category = "spare_parts",
        stackable = true,
    }
    item:material("canvas", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    -- heavyweight cotton canvas with a GSM of 406
    -- 1x2' sheet is 1858 cm^2 and at 406 gsm gives listed weight; density of 1.6g/cm^3 suggests about .254 mm thickness per sheet - rounded down to .250
    local item = content.Item {
        id = "sheet_canvas_patchwork",
        category = "spare_parts",
        name = ccb.content.plural_text("patchwork canvas sheet", "patchwork canvas sheets"),
        description = ccb.content.text("A selection of various sections of canvas, sewn together in a patchwork fashion.  Suitable for tailoring, though it's much less time-efficient than if using proper material sheets."),
        mass_milligrams = 76000,
        volume_ml = 48,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("canvas", 1)
    content.add(item)
end

do
    -- Medium weight cotton fabric with a GSM of 203
    local item = content.Item {
        id = "strap_cotton",
        category = "spare_parts",
        name = ccb.content.plural_text("fabric strap", "fabric straps"),
        description = ccb.content.text("A strip of broad, flat cotton, 42 inches in length, with a metal adjustment buckle threaded in the center.  Normally used as a shoulder strap for bags, its ends are usually sown about a corresponding container's D-rings."),
        mass_milligrams = 59000,
        volume_ml = 52,
        price_cents = 0,
        price_postapoc_cents = 5,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("cotton", 6)
    item:material("steel", 1)
    content.add(item)
end
