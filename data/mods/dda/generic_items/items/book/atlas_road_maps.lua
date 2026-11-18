local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "atlas_map_ca-ab",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Alberta", "road maps of Alberta"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-AB" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-bc",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of British Columbia", "road maps of British Columbia"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-BC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-mb",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Manitoba", "road maps of Manitoba"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-MB" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-nb",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of New Brunswick", "road maps of New Brunswick"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-NB" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-nl",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Newfoundland and Labrador", "road maps of Newfoundland and Labrador"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-NL" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-ns",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Nova Scotia", "road maps of Nova Scotia"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-NS" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-nt",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Northwest Territories", "road maps of Northwest Territories"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-NT" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-nu",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Nunavut", "road maps of Nunavut"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-NU" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-on",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Ontario", "road maps of Ontario"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-ON" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-pe",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Prince Edward Island", "road maps of Prince Edward Island"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-PE" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-qc",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Quebec", "road maps of Quebec"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-QC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-sk",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Saskatchewan", "road maps of Saskatchewan"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-SK" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_ca-yt",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Yukon", "road maps of Yukon"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "CA-YT" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-agu",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Aguascalientes", "road maps of Aguascalientes"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-AGU" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-bcn",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Baja California", "road maps of Baja California"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-BCN" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-bcs",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Baja California Sur", "road maps of Baja California Sur"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-BCS" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-cam",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Campeche", "road maps of Campeche"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-CAM" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-chh",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Chihuahua", "road maps of Chihuahua"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-CHH" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-chp",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Chiapas", "road maps of Chiapas"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-CHP" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-cmx",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Mexico City", "road maps of Mexico City"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-CMX" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-coa",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Coahuila", "road maps of Coahuila"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-COA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-col",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Colima", "road maps of Colima"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-COL" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-dur",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Durango", "road maps of Durango"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-DUR" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-gro",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Guerrero", "road maps of Guerrero"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-GRO" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-gua",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Guanajuato", "road maps of Guanajuato"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-GUA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-hid",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Hidalgo", "road maps of Hidalgo"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-HID" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-jal",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Jalisco", "road maps of Jalisco"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-JAL" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-mex",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of State of Mexico", "road maps of State of Mexico"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-MEX" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-mic",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Michoacán", "road maps of Michoacán"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-MIC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-mor",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Morelos", "road maps of Morelos"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-MOR" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-nay",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Nayarit", "road maps of Nayarit"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-NAY" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-nle",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Nuevo León", "road maps of Nuevo León"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-NLE" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-oax",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Oaxaca", "road maps of Oaxaca"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-OAX" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-pue",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Puebla", "road maps of Puebla"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-PUE" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-que",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Querétaro", "road maps of Querétaro"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-QUE" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-roo",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Quintana Roo", "road maps of Quintana Roo"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-ROO" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-sin",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Sinaloa", "road maps of Sinaloa"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-SIN" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-slp",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of San Luis Potosí", "road maps of San Luis Potosí"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-SLP" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-son",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Sonora", "road maps of Sonora"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-SON" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-tab",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Tabasco", "road maps of Tabasco"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-TAB" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-tam",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Tamaulipas", "road maps of Tamaulipas"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-TAM" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-tla",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Tlaxcala", "road maps of Tlaxcala"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-TLA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-ver",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Veracruz", "road maps of Veracruz"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-VER" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-yuc",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Yucatán", "road maps of Yucatán"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-YUC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_mx-zac",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Zacatecas", "road maps of Zacatecas"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "MX-ZAC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ak",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Alaska", "road maps of Alaska"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-AK" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-al",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Alabama", "road maps of Alabama"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-AL" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ar",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Arkansas", "road maps of Arkansas"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-AR" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-az",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Arizona", "road maps of Arizona"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-AZ" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ca",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of California", "road maps of California"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-CA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-co",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Colorado", "road maps of Colorado"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-CO" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ct",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Connecticut", "road maps of Connecticut"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-CT" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-dc",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Washington", "road maps of Washington"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-DC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-de",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Delaware", "road maps of Delaware"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-DE" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-fl",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Florida", "road maps of Florida"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-FL" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ga",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Georgia", "road maps of Georgia"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-GA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-hi",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Hawaii", "road maps of Hawaii"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-HI" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ia",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Iowa", "road maps of Iowa"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-IA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-id",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Idaho", "road maps of Idaho"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-ID" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-il",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Illinois", "road maps of Illinois"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-IL" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-in",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Indiana", "road maps of Indiana"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-IN" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ks",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Kansas", "road maps of Kansas"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-KS" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ky",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Kentucky", "road maps of Kentucky"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-KY" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-la",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Louisiana", "road maps of Louisiana"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-LA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ma",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Massachusetts", "road maps of Massachusetts"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-md",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Maryland", "road maps of Maryland"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MD" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-me",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Maine", "road maps of Maine"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-ME" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-mi",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Michigan", "road maps of Michigan"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MI" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-mn",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Minnesota", "road maps of Minnesota"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MN" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-mo",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Missouri", "road maps of Missouri"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MO" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ms",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Mississippi", "road maps of Mississippi"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MS" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-mt",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Montana", "road maps of Montana"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-MT" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-nc",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of North Carolina", "road maps of North Carolina"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-nd",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of North Dakota", "road maps of North Dakota"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-ND" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ne",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Nebraska", "road maps of Nebraska"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NE" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-nh",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of New Hampshire", "road maps of New Hampshire"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NH" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-nj",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of New Jersey", "road maps of New Jersey"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NJ" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-nm",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of New Mexico", "road maps of New Mexico"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NM" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-nv",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Nevada", "road maps of Nevada"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NV" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ny",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of New York", "road maps of New York"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-NY" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-oh",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Ohio", "road maps of Ohio"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-OH" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ok",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Oklahoma", "road maps of Oklahoma"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-OK" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-or",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Oregon", "road maps of Oregon"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-OR" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-pa",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Pennsylvania", "road maps of Pennsylvania"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-PA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ri",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Rhode Island", "road maps of Rhode Island"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-RI" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-sc",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of South Carolina", "road maps of South Carolina"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-SC" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-sd",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of South Dakota", "road maps of South Dakota"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-SD" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-tn",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Tennessee", "road maps of Tennessee"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-TN" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-tx",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Texas", "road maps of Texas"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-TX" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-ut",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Utah", "road maps of Utah"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-UT" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-va",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Virginia", "road maps of Virginia"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-VA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-vt",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Vermont", "road maps of Vermont"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-VT" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-wa",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Washington", "road maps of Washington"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-WA" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-wi",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Wisconsin", "road maps of Wisconsin"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-WI" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-wv",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of West Virginia", "road maps of West Virginia"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-WV" }
    content.add(item)
end

do
    local item = content.Item {
        id = "atlas_map_us-wy",
        copy_from = "roadmap",
        looks_like = "roadmap",
        name = ccb.content.plural_text("road map of Wyoming", "road maps of Wyoming"),
        description = ccb.content.text("A printed chart of highways, rivers, and major cities."),
    }
    item:clear_use_actions()
    item:reveal_map { radius = 0, atlas_jurisdiction = "US-WY" }
    content.add(item)
end
