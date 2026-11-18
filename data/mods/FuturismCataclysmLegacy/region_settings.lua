local content = require("ccb").content

content.replace(content.RegionSettingsCity {
    id = "default",
    extends = "default",
    add_houses = { { "house_09b", 20 } },
    add_shops = { { "fcl_augmentation_clinic_1", 180 }, { "fcl_mealgrub_protein_farm", 90 } },
})
