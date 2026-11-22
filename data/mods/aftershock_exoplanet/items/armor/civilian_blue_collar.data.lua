local ccb = require("ccb")

ccb.content.define_item {
    id = "xl_technician_pants_gray",
    copy_from = "technician_pants_gray",
    mass = "770 g",
    volume = "3 L",
    snippet_category = {
        { id = "xl_technician_pants_blue", text = "A pair of XL blue work pants." },
        { id = "xl_technician_pants_gray", text = "A pair of XL gray work pants." },
        { id = "xl_technician_pants_lightblue", text = "A pair of XL light-blue work pants." },
    },
    flags = { "VARSIZE", "POCKETS", "OVERSIZE", "PREFIX_XL" },
    pockets = {
        { kind = "CONTAINER", capacity = "1700 ml", mass_limit = "2 kg", rigid = true },
    },
    armor = { thickness = 2 },
}

ccb.content.define_item {
    id = "xl_technician_shirt_gray",
    copy_from = "technician_shirt_gray",
    mass = "84 g",
    volume = "350 ml",
    snippet_category = {
        {
            id = "xl_technician_shirt_blue",
            text = "An XL blue work t-shirt with a small front pocket.",
        },
        {
            id = "xl_technician_shirt_gray",
            text = "An XL gray work t-shirt with a small front pocket.",
        },
        {
            id = "xl_technician_shirt_lightblue",
            text = "An XL light-blue work t-shirt with a small front pocket.",
        },
    },
    flags = { "VARSIZE", "OVERSIZE", "PREFIX_XL" },
    armor = {},
}
