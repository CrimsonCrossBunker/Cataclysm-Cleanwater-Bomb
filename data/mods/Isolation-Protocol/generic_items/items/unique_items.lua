local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "iso_science_security_black",
        symbol = ",",
        copy_from = "id_science",
        looks_like = "id_science",
        name = ccb.content.plural_text("Security: black zone badge", "Security: black zone badges"),
        description = ccb.content.text("Your black clearance security badge, it should unlock most doors in the facility."),
    }
    item:clear_flags()
    item:flag("SCIENCE_CARD_SECURITY_BLACK")
    item:flag("CREDIT_CARD_SHAPED")
    content.add(item)
end
