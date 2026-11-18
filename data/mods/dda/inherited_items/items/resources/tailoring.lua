local ccb = require("ccb")
local content = ccb.content

do
    -- 12 inch by 24 inch sheets, 16 layers thick. Values actually nearly identically matched panels available for purchase.
    local item = content.Item {
        id = "sheet_kevlar_layered",
        category = "spare_parts",
        name = ccb.content.plural_text("ballistic Kevlar panel", "ballistic Kevlar panels"),
        description = ccb.content.text("A small, 16-layer thick ballistic Kevlar panel.  This kind of Kevlar is precision-made by machine and features an extremely tight weave which cannot be replicated by hand.  Due to this, any damage incurred to your ballistic armor will necessitate complete replacement with a new panel.  It is not as effective as loose-woven Kevlar at stopping stab wounds, but it has no equal against the threat posed by firearms."),
        mass_milligrams = 428000,
        volume_ml = 818,
        price_cents = 15000,
        price_postapoc_cents = 150,
        symbol = ",",
        color = "green",
        stackable = true,
    }
    item:material("kevlar_layered", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- same as above but adding superglue. IRL this is how they are made, though using 2 part resin instead.
    local item = content.Item {
        id = "rigid_kevlar_plate",
        category = "spare_parts",
        name = ccb.content.plural_text("rigid Kevlar plate", "rigid Kevlar plates"),
        description = ccb.content.text("A compressed panel of Kevlar treated with epoxy or other adhesive.  It could be used to repair items made of rigid Kevlar, and makes a decent substitute for damaged carbon fiber and the like even if it isn't exactly the same."),
        mass_milligrams = 429000,
        volume_ml = 818,
        price_cents = 1000,
        price_postapoc_cents = 250,
        symbol = ",",
        color = "green",
        stackable = true,
    }
    item:material("kevlar_rigid", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gambeson_batting",
        category = "spare_parts",
        name = ccb.content.plural_text("gambeson batting", "clumps of gambeson batting"),
        description = ccb.content.text("A pile of shredded fabric, dry grass, hair or other cheap materials which could be used to stuff the fabric layers of a gambeson to create armor more cheaply and easily than properly layering and quilting the entire product."),
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 8,
        symbol = ",",
        color = "white",
        stackable = true,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
