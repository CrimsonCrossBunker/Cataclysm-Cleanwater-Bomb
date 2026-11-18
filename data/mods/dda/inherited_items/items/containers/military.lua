local ccb = require("ccb")
local content = ccb.content

do
    -- 84mm heat 551 container, 265x700x124mm
    local item = content.Item {
        id = "ammunition_can_carlgustav",
        category = "container",
        name = ccb.content.plural_text("double 84mm HEDP container", "double 84mm HEDP containers"),
        description = ccb.content.text("Huge metal container, in a shape of two massive rockets."),
        mass_milligrams = 1400000,
        volume_ml = 23000,
        replace_pockets = true,
        symbol = "8",
        color = "dark_gray",
        variant_kind = "gun",
    }
    item:container_pocket {
        max_volume_ml = 2422,
        max_weight_milligrams = 5000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 437,
    }
    item:container_pocket {
        max_volume_ml = 2422,
        max_weight_milligrams = 5000000,
        rigid = true,
        watertight = true,
        max_item_length_mm = 437,
    }
    item:material("steel", 1)
    item:variants {
        { id = "ammunition_can_carlgustav_hedp", name = ccb.content.plural_text("double 84mm HEDP container", "double 84mm HEDP containers"), weight = 0, description = ccb.content.text("A heavy and bulky container in a shape of two recoilless rifle rounds.  Text on the front says:\n<color_yellow>1 RD\n84MM HEDP 502\n1315-01-343-1944</color>\n\n<color_red>EXPLOSIVE</color>") },
        { id = "ammunition_can_carlgustav_he", name = ccb.content.plural_text("double 84mm HE container", "double 84mm HE containers"), weight = 0, description = ccb.content.text("A heavy and bulky container in a shape of two recoilless rifle rounds.  Text on the front says:\n<color_yellow>1 RD\n84MM HE 441D</color>\n\n<color_red>EXPLOSIVE</color>") },
    }
    content.add(item)
end
