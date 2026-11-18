local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "pike_pipe",
        copy_from = "simple_pike_pipe",
        looks_like = "simple_pike_pipe",
        name = ccb.content.plural_text("pipe pike", "pipe pikes"),
        description = ccb.content.text("Five pipes welded together to form a very crude pike.  Heavy, slow, and all around cumbersome to carry and fight with."),
        price_postapoc_cents = 150,
    }
    item:clear_melee_damage()
    item:melee_damage("stab", 23)
    content.add(item)
end

do
    local item = content.Item {
        id = "naginata_machete_temp",
        copy_from = "naginata_machete",
        looks_like = "naginata_machete",
        name = ccb.content.plural_text("tempered machete naginata", "tempered machete naginata"),
        description = ccb.content.text("This crude facsimile of a naginata was made by attaching a machete to the end of a spear.  This one uses a tempered machete, making it a bit more sharp and durable."),
        price_cents = 5000,
        price_postapoc_cents = 2700,
    }
    item:material("wood", 25)
    item:material("qt_steel", 21)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 35)
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_aztec_spear",
        name = ccb.content.plural_text("medium steel bladed tepoztopili", "medium steel bladed tepoztopilis"),
        description = ccb.content.text("This is a redesigned version of the Mesoamerican tepoztopili.  It has an elliptical piece of carved wood lined with sharp medium steel blades, firmly attached to a stout spear shaft."),
        copy_from = "lc_aztec_spear",
        looks_like = "lc_aztec_spear",
        price_cents = 5000,
        price_postapoc_cents = 1750,
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 15)
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_aztec_spear",
        name = ccb.content.plural_text("high steel bladed tepoztopili", "high steel bladed tepoztopilis"),
        description = ccb.content.text("This is a redesigned version of the Mesoamerican tepoztopili.  It has an elliptical piece of carved wood lined with sharp high steel blades, firmly attached to a stout spear shaft."),
        copy_from = "lc_aztec_spear",
        looks_like = "lc_aztec_spear",
        price_cents = 7000,
        price_postapoc_cents = 2000,
    }
    item:material("wood", 1)
    item:material("hc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 18)
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_aztec_spear",
        name = ccb.content.plural_text("hardened steel bladed tepoztopili", "hardened steel bladed tepoztopilis"),
        description = ccb.content.text("This is a redesigned version of the Mesoamerican tepoztopili.  It has an elliptical piece of carved wood lined with sharp hardened steel blades, firmly attached to a stout spear shaft."),
        copy_from = "lc_aztec_spear",
        looks_like = "lc_aztec_spear",
        price_cents = 9000,
        price_postapoc_cents = 2500,
    }
    item:material("wood", 1)
    item:material("ch_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 22)
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_aztec_spear",
        name = ccb.content.plural_text("tempered steel bladed tepoztopili", "tempered steel bladed tepoztopilis"),
        description = ccb.content.text("This is a redesigned version of the Mesoamerican tepoztopili.  It has an elliptical piece of carved wood lined with sharp tempered steel blades, firmly attached to a stout spear shaft.  It's a weapon worthy of being wielded by Huitzilopochtli himself."),
        copy_from = "lc_aztec_spear",
        looks_like = "lc_aztec_spear",
        price_cents = 12000,
        price_postapoc_cents = 3000,
    }
    item:material("wood", 1)
    item:material("qt_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 26)
    content.add(item)
end
