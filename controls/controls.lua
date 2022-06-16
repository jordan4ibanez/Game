-- simple helper function
local function bind(func, variable_1, variable_2)
    return function()
        return func(variable_1, variable_2)
    end
end

-- simple automated jump table for lua
local jump_table = {
    
    escape = bind(love.event.quit),


    down = bind(move_player, "y", 1)
}
-- basic controls
function love.keypressed( key )
    if jump_table[key] then jump_table[key]() end
end