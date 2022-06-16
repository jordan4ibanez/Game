local ogg_load_table = {}
static_sound_table = {}

-- helper for helper function
local function local_batch_load_ogg(file_name, number_of_assets)

    -- create new distinct table for sound files
    static_sound_table[file_name] = {}

    -- automate the number of available assets
    static_sound_table[file_name].limit = number_of_assets

    -- automate addition into table
    for i = 1,number_of_assets do
        static_sound_table[file_name][file_name .. "_" .. i] = love.audio.newSource("sound/" .. file_name .. "_" .. i .. ".ogg", "static")
    end
end

function batch_load_ogg(file_name, number_of_assets)
    ogg_load_table[file_name] = number_of_assets
end

function complete_ogg_load()
    for file_name,number_of_assets in pairs(ogg_load_table) do
        local_batch_load_ogg(file_name, number_of_assets)
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