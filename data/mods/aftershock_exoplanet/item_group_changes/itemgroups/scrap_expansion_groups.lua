local content = require("ccb").content

do
    local group = content.ItemGroup { id = "supplies_reagents_lab", kind = "distribution" }
    group:group("afs_common_biomaterial_scrapgroup", 50)
    group:group("afs_advanced_biomaterial_scrapgroup", 10)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "supplies_metal", kind = "distribution" }
    group:group("afs_basic_material_scrapgroup", 50)
    group:group("afs_common_material_scrapgroup", 35)
    group:group("afs_advanced_material_scrapgroup", 5)
    group:item("afs_titanium_frame", 5)
    group:entry { item = "afs_scrap_titanium", count = { 2, 8 }, probability = 5 }
    group:item("afs_titanium_small", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "supplies_mechanics", kind = "distribution" }
    group:group("afs_machinery_maintenance_scrapgroup", 40)
    group:item("afs_titanium_frame", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "tools_robotics", kind = "collection" }
    group:group("afs_robotics_scrapgroup", 60)
    group:group("afs_advanced_circuitry_scrapgroup", 2)
    group:group("afs_advanced_magnet_scrapgroup", 10)
    group:group("afs_advanced_energy_storage_scrapgroup", 2)
    group:group("afs_advanced_energy_storage_scrapgroup", 2)
    group:group("afs_advanced_heat_scrapgroup", 2)
    group:group("afs_advanced_material_scrapgroup", 2)
    group:group("afs_advanced_optics_scrapgroup", 30)
    content.extend_item_group(group)
end
