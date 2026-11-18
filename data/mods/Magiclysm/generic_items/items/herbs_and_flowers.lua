local ccb = require("ccb")
local content = ccb.content

do
    -- magical poisons, 'death' and 'bio' related
    local item = content.Item {
        id = "kampuch",
        name = ccb.content.plural_text("kampuch", "kampuches"),
        color = "blue",
        symbol = "o",
        description = ccb.content.text("A small rod of curled white petals, delicately shielding toxic pollen that will lead to an agonizing, if mercifully quick death.  Infamously used by romantic assassins, when an artistic death is deemed more important than practicality."),
        price_postapoc_cents = 700,
        volume_ml = 5,
        mass_milligrams = 5000,
    }
    item:material("veggy", 1)
    content.add(item)
end

do
    -- armor' and 'summon' related
    local item = content.Item {
        id = "olieribos",
        name = ccb.content.plural_text("olieribos sheaf", "olieribos sheaves"),
        description = ccb.content.text("Dark colored leaves and bitter roots, firmly tied together in a small sheaf.  It's not toxic, but many people have died trying to taste it, due to the airway obstruction."),
        price_postapoc_cents = 400,
        symbol = "o",
        color = "light_blue",
        mass_milligrams = 2000,
        volume_ml = 3,
        looks_like = "wheat",
    }
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:material("veggy", 1)
    content.add(item)
end
