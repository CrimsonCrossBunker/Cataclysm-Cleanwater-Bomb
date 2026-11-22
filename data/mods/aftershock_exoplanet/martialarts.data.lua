local ccb = require("ccb")

ccb.content.define_martial_art {
    id = "style_eskrima",
    copy_from = "style_eskrima",
    name = "Eskrima",
    extend = {
        weapons = { "ceramic_knife", "afs_energy_saber_off" },
    },
}

ccb.content.define_martial_art {
    id = "style_fencing",
    copy_from = "style_fencing",
    name = "Fencing",
    extend = {
        weapons = { "afs_energy_saber_on", "afs_energy_saber_off" },
    },
}

ccb.content.define_martial_art {
    id = "style_krav_maga",
    copy_from = "style_krav_maga",
    name = "Krav Maga",
    extend = {
        weapons = { "ceramic_knife", "afs_energy_saber_off" },
    },
}

ccb.content.define_martial_art {
    id = "style_swordsmanship",
    copy_from = "style_swordsmanship",
    name = "Medieval Swordsmanship",
    extend = {
        weapons = { "afs_energy_saber_on" },
    },
}

ccb.content.define_martial_art {
    id = "style_ninjutsu",
    copy_from = "style_ninjutsu",
    name = "Ninjutsu",
    extend = {
        weapons = { "afs_energy_saber_on", "ceramic_knife" },
    },
}

ccb.content.define_martial_art {
    id = "style_niten",
    copy_from = "style_niten",
    name = "Niten Ichi-Ryu",
    extend = {
        weapons = { "afs_energy_saber_on" },
    },
}

ccb.content.define_martial_art {
    id = "style_silat",
    copy_from = "style_silat",
    name = "Silat",
    extend = {
        weapons = { "afs_energy_saber_on", "afs_energy_saber_off" },
    },
}
