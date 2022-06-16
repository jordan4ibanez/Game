ui_table = {}

local function add_element(element_table)
    assert(element_table.id, "you forgot to add in an id to your ui element")
    ui_table[element_table.id] = {
        text = element_table.text,
        position = element_table.position,
        effect = element_table.effect,
        size = element_table.size,
        color = element_table.color
    }
end

function render_user_interface()
    for id,data in pairs(ui_table) do
        love.graphics.setColor(data.color[1], data.color[2], data.color[3], 1)
        love.graphics.print(data.text, data.position.x, data.position.y, 0, data.size, data.size)
    end
end

add_element({
    id = "debug",
    text = "this is my debug",
    position = {x = 100, y = 100},
    effect = "type",
    size = 1,
    color = {1.0, 1.0, 0.0}
})