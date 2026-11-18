local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rmi2_corpse",
        symbol = "%",
        color = "white",
        name = ccb.content.plural_text("desiccated corpse", "desiccated corpses"),
        description = ccb.content.text("A badly mangled human body.  A giant puncture wound is visible on its upper chest, and something has drained most of the moisture from the carcass, leaving it desiccated and making it impossible to determine the body's age."),
        category = "corpses",
        price_cents = 0,
        volume_ml = 27000,
        mass_milligrams = 32000000,
    }
    item:material("hflesh", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_generic_human",
        copy_from = "corpse",
        looks_like = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A lifeless human body."),
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_generic_male",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body of a middle-aged man."),
        looks_like = "corpse_generic_human",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_generic_female",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body of a young woman."),
        looks_like = "corpse_generic_human",
        volume_ml = 40000,
        mass_milligrams = 52000000,
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    -- Implied that someone hacked off her body parts for jewelry.
    local item = content.Item {
        id = "corpse_oldwoman_jewelry",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body of an old woman.  Both of her earlobes are torn, several of her fingers have been chopped off, and several of her teeth have been knocked out."),
        looks_like = "corpse_generic_human",
        volume_ml = 40000,
        mass_milligrams = 52000000,
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_bloody",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body, coated in congealed blood."),
        looks_like = "corpse_generic_human",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_painful",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A dead body with a frightful grimace on its face.  He appears to have been horribly mangled prior to his death."),
        looks_like = "corpse_generic_human",
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_gunned",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("The dead body of a person.  Their forehead bears a large bullet entrance wound.  An even larger exit wound is present on the back of their head."),
        looks_like = "corpse_generic_human",
        volume_ml = 40000,
        mass_milligrams = 52000000,
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_halved_upper",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("The upper half of a dead body, as if it was torn apart with enormous force.  Some organs are hanging out."),
        looks_like = "corpse_generic_human",
        volume_ml = 30000,
        mass_milligrams = 40000000,
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_half_beheaded",
        copy_from = "corpse",
        name = ccb.content.plural_text("corpse", "corpses"),
        description = ccb.content.text("A half-decapitated dead body.  It is unclear what could have caused such a wound."),
        looks_like = "corpse_generic_human",
        volume_ml = 57000,
        mass_milligrams = 78000000,
    }
    item:material("hflesh", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "corpse_dermatik_victim",
        copy_from = "corpse_generic_human",
        volume_ml = 30000,
        mass_milligrams = 22000000,
        name = ccb.content.plural_text("strange corpse", "strange corpses"),
        description = ccb.content.text("This face of this corpse is locked in an agonized scream.  Through the large round holes in the skin, you can see that most of the flesh below is missing, leaving the skin and clothes draped over little more than bare bones."),
        looks_like = "corpse_generic_human",
    }
    item:clear_flags()
    item:flag("PULPED")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:flag("TARDIS")
    item:flag("TRADER_AVOID")
    content.add(item)
end
