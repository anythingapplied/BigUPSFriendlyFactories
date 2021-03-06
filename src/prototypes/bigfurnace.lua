-- Big furnace prototype and item definition
require("adjustVisuals")
require("util")

commonAdjustments = require("commonAdjustments")

local function create_bigfurnace(name, energy, speed)
    local bigfurnace = util.table.deepcopy(data.raw.furnace["electric-furnace"])
    local icon = "__WhistleStopFactories__/graphics/icons/big-furnace.png"

    bigfurnace.name = name
    bigfurnace.icon = icon
    bigfurnace.localised_name = {"entity-name.wsf-big-furnace"}

    bigfurnace.collision_box = {{-8.1, -8.1}, {8.1, 8.1}}
    bigfurnace.selection_box = {{-8.8, -9}, {8.8, 9}}
    bigfurnace.drawing_box = {{-8.8, -8.8}, {8.8, 8.8}}

    bigfurnace.crafting_categories = {"big-smelting"}
    bigfurnace.crafting_speed = speed

    bigfurnace.energy_usage = energy
    bigfurnace.module_specification.module_slots = 6
    bigfurnace.map_color = {r=199, g=103, b=247}

    -- Set this to an assembling machine type
    bigfurnace.type = "assembling-machine"
    bigfurnace.result_inventory_size = nil
    bigfurnace.source_inventory_size = nil
    bigfurnace.ingredient_count = 2

    commonAdjustments(bigfurnace)

    local function fluidBox(type, position)
        retvalue = {
                production_type = type,
                pipe_picture = assembler3pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                pipe_connections = {{ type=type, position=position }},
                secondary_draw_orders = { north = -1 }
            }
        if type == "input" then
            retvalue.base_level = -1
        else
            retvalue.base_level = 1
        end
        return retvalue
    end

    bigfurnace.fluid_boxes = {
        fluidBox("input", {-9, 0})
    }

    adjustVisuals(bigfurnace, 5.4, 1/60)

    data.raw["assembling-machine"][name] = bigfurnace

    local bigfurnace_item = util.table.deepcopy(data.raw.item["electric-furnace"])

    bigfurnace_item.name = name
    bigfurnace_item.icon = icon
    bigfurnace_item.order = "d[" .. name .. "]"
    bigfurnace_item.place_result = name

    data.raw.item[name] = bigfurnace_item
end

return create_bigfurnace