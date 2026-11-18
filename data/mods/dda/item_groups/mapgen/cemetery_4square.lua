local content = require("ccb").content

do
    local group = content.ItemGroup { id = "grave_memories", kind = "distribution" }
    group:item("barrette", 5)
    group:item("boots_combat", 10)
    group:item("cassock", 1)
    group:item("child_book", 5)
    group:item("flask_hip", 5)
    group:item("jedi_cloak", 1)
    group:item("jersey", 1)
    group:item("kittel", 1)
    group:item("kufi", 1)
    group:item("kippah", 1)
    group:item("tallit_gadol", 1)
    group:group("rings_and_things", 20)
    group:item("long_glove_white", 1)
    group:item("photo_album", 15)
    group:item("ref_lighter", 5)
    group:item("roadmap", 3)
    group:item("spray_can", 5)
    group:item("story_book", 5)
    group:item("syringe", 3)
    group:item("tall_tales", 5)
    group:entry {
        item = "teddy_bear",
        damage = { 0, 3 },
        flags = {
            "FILTHY",
        },
        probability = 15,
    }
    group:item("teleumbrella", 2)
    group:item("thawb", 1)
    group:item("umbrella", 10)
    group:group("newspaper", 20)
    group:item("survnote", 3)
    group:item("cig_butt", 5)
    group:item("cigar_butt", 10)
    content.add(group)
end
