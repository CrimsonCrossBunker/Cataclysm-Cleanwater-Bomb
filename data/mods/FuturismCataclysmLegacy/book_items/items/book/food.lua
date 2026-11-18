local content = require("ccb").content

do
    local book = content.Item {
        id = "fcl_bugbrew_book",
        category = "manuals",
        name = content.plural_text("mealworm farm logbook", "mealworm farm logbooks"),
        description = content.text("A binder containing detailed production logs from an industrial mealgrub farm.  Most pages are dry records of feed ratios, vat temperatures, sterilization cycles, and failed harvests.  A procurement appendix identifies the equipment vendor as Helixwirl Biotechnologies, a now-bankrupt food-industry firm funded by Trans-Coast Logistics.  You could use its recordings to start your own farming operations."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        looks_like = "file",
        symbol = "?",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 2,
        intelligence = 12,
        read_time_turns = 3000,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end
