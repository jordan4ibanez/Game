math.randomseed(os.time())

local player_position = { x = 2, y = 3}
local scaler = 10

local function collide_player(axis, modifier)
    -- apply the position in dry run
    local new_player_position = {x = player_position.x, y = player_position.y}
    new_player_position[axis] = new_player_position[axis] + modifier

    -- no going out of the cell
    if new_player_position.x < 0 or new_player_position.x > cell_size
        or new_player_position.y < 0 or new_player_position.y > cell_size then
            return false
    end

    -- there's something blocking it
    if test_cell[new_player_position.y][new_player_position.x] ~= 0 then
        return false
    end

    -- good to go
    return true
end

function move_player(axis, modifier)
    if collide_player(axis, modifier) then
        player_position[axis] = player_position[axis] + modifier
    end
end

static_sound_table = {}

local function batch_load_ogg(file_name, number_of_assets)

    -- create new distinct table for sound files
    static_sound_table[file_name] = {}

    -- automate the number of available assets
    static_sound_table[file_name].limit = number_of_assets

    -- automate addition into table
    for i = 1,number_of_assets do
        static_sound_table[file_name][file_name .. "_" .. i] = love.audio.newSource("sound/" .. file_name .. "_" .. i .. ".ogg", "static")
    end
end

-- automates the randomization/playing of sounds
function play_sound(file_name)

    local sound_pointer = static_sound_table[file_name]

    -- single sound, no need to do excess math
    if sound_pointer.limit == 1 then
        sound_pointer[file_name .. "_" .. 1]:stop()
        sound_pointer[file_name .. "_" .. 1]:play()
    -- batched sound, randomize selection
    else
        local selection = math.ceil( math.random() * 5 )
        sound_pointer[file_name .. "_" .. selection]:stop()
        sound_pointer[file_name .. "_" .. selection]:play()
    end
end


function love.load()

    batch_load_ogg("type", 5)

end


dofile("controls/controls.lua")
dofile("map/cell_main.lua")
dofile("user_interface/user_interface.lua")


function love.update(delta)
    update_user_interface(delta)
end

function love.draw()

    love.graphics.setColor(1,1,1,1)

    for y = 1,50 do
        for x = 1,50 do
            if test_cell[x][y] == 1 then
                love.graphics.print("x", y * scaler, x * scaler)
            end
        end
    end

    love.graphics.setColor(1,0,0,1)

    love.graphics.print("O", player_position.x * scaler, player_position.y * scaler)

    render_user_interface()

end