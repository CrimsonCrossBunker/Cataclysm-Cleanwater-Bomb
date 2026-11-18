local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a single nonfiction paperback.
    local group = content.ItemGroup { id = "SUS_book_nonf_soft", kind = "distribution" }
    group:group("SUS_book_nonf_soft_occult", 2)
    group:group("SUS_book_nonf_soft_psych", 6)
    group:group("SUS_book_nonf_pulp_newage", 3)
    group:group("SUS_book_nonf_soft_sports", 3)
    group:item("book_nonf_soft_wedding_coolring", 1)
    group:item("book_nonf_soft_parent_howtogen", 1)
    group:item("book_nonf_soft_safety_radiaea", 1)
    group:item("book_nonf_soft_mechnic_hotrod", 1)
    group:item("book_nonf_soft_speech_naillaw", 1)
    group:item("book_nonf_soft_phil_benoth", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single paperback book of occult studies
    local group = content.ItemGroup { id = "SUS_book_nonf_soft_occult", kind = "distribution" }
    group:item("occult_economicon", 1)
    group:item("occult_bobliographon", 1)
    group:item("occult_glimpses", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single psychology paperback
    local group = content.ItemGroup { id = "SUS_book_nonf_soft_psych", kind = "distribution" }
    group:item("book_nonf_soft_psych_paranoia", 1)
    group:item("book_nonf_soft_psych_psycolo", 1)
    group:item("book_nonf_soft_psych_psycstlk", 1)
    group:item("book_nonf_soft_psych_adrugds", 1)
    group:item("book_nonf_soft_psych_arteatds", 1)
    group:item("book_nonf_soft_psych_cggamers", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single new-age pulp book
    local group = content.ItemGroup { id = "SUS_book_nonf_pulp_newage", kind = "distribution" }
    group:item("book_newage_generic", 1)
    group:item("book_newage_inpsychic", 1)
    group:item("book_newage_healcrystals", 1)
    group:item("book_newage_oilsecrets", 1)
    group:item("book_newage_witchcraftbeg", 1)
    group:item("book_newage_witchcraftadv", 1)
    group:item("book_newage_beyondveil", 1)
    group:item("book_newage_weapcrys", 1)
    group:item("book_newage_aliens", 1)
    group:item("poetic_edda", 1)
    group:item("book_newage_horoscopes", 1)
    content.add(group)
end
