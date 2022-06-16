local ogg_load_table = {}
static_sound_table = {}

-- helper for helper function
local function local_batch_load_ogg(file_name, definition)

    -- create new distinct table for sound files
    static_sound_table[file_name] = {}

    -- automate the number of available assets
    static_sound_table[file_name].limit = definition.assets

    -- automate the random pitch
    static_sound_table[file_name].random_pitch = definition.random_pitch or false

    -- automate addition into table
    for i = 1,definition.assets do
        static_sound_table[file_name][file_name .. "_" .. i] = love.audio.newSource("sound/" .. file_name .. "_" .. i .. ".ogg", "static")
    end
end

function batch_load_ogg(definition)
    ogg_load_table[definition.name] = {
        assets = definition.assets,
        random_pitch = definition.random_pitch
    }
end

function complete_ogg_load()
    for file_name,definition in pairs(ogg_load_table) do
        local_batch_load_ogg(file_name, definition)
    end
end

-- automates the randomization/playing of sounds
function play_sound(file_name)

    local sound_pointer = static_sound_table[file_name]

    print(sound_pointer.random_pitch)

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