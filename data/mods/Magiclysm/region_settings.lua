local content = require("ccb").content

content.replace(content.RegionSettingsCity {
    id = "default",
    extends = "default",
    add_houses = {
        { "house_technomancer", 20 },
        { "house_elf_01", 50 },
        { "wizard_tower_1", 10 },
        { "wizard_tower_2", 20 },
    },
    add_shops = {
        { "magiclysm_augmentation_clinic", 100 },
        { "magic_shop", 100 },
        { "used_bookstore", 225 },
        { "magic_academy", 150 },
    },
})
