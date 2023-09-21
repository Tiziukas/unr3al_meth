Config = {}

Config.Debug = true

--WIP Doesnt work atm
Config.Inventory = 'ox_iventory' --valid options are 'ox_inventory' or 'esx' this used to get the max player weight
--WIP Doesnt work atm
Config.LogType = 'discord' --Valid options are 'ox_lib' or 'discord'

Config.StartKey = 'G'

Config.PauseTime = 4000                 -- Time between every % update

Config.Progress = {         -- % every update gets added
    Min = 1,
    Max = 5
}

Config.ChangeMiniGame = 3           -- 1 out of 3 Progress updates gets a random minigame



Config.Police                     = 'police'            -- Your Police society name
Config.PoliceCount                = 0







Config.SmokeColor = 'white' --orange, white or black


Config.Item = {
    Meth = 'meth',
    MethWeight = 0.5, --Number is in Kg

    Acetone = 'acetone',
    Lithium = 'lithium',

    Chance = { -- At the End a random amount of Meth gets added to the quantity received by questions
        Min = -5,
        Max = 5
    }
}








Config.SkillCheck = {
    StartingProd = {
        Enabled = true,
        Difficulty = {'easy', 'easy'},
        Key = 'e' --You can add multiple with {'w', 'a', 's', 'd'}
    },

    Questions = {
        DisableAll = false, --if true, no Skillcheck will be done on questions

        --Diffuclty 0 is no Skillcheck
        Difficulty_1 = {
            Difficulty = {'easy', 'easy'},
            Key = 'e' --You can add multiple with {'w', 'a', 's', 'd'}
        },
        Difficulty_2 = {
            Difficulty = {'medium', 'medium'},
            Key = 'e' --You can add multiple with {'w', 'a', 's', 'd'}
        },


        Question_01 = {
            Enabled = true,
            DifficultyAnswer_1 = 1,
            DifficultyAnswer_3 = 2
        },

        Question_02 = {
            Enabled = true,
            DifficultyAnswer_1 = 1,
            DifficultyAnswer_3 = 1
        },

        Question_03 = {
            Enabled = true,
            DifficultyAnswer_2 = 1,
            DifficultyAnswer_3 = 1
        },

        Question_04 = {
            Enabled = true,
            DifficultyAnswer_2 = 1,
            DifficultyAnswer_3 = 2
        },

        Question_05 = {
            Enabled = true,
            DifficultyAnswer_1 = 1,
        },

        Question_06 = {
            Enabled = true,
            DifficultyAnswer_1 = 1,
            DifficultyAnswer_2 = 0,
        },

        Question_07 = {
            Enabled = true,
        },

        Question_08 = {
            Enabled = true,
            DifficultyAnswer_1 = 1,
        }
    }

}


Config.Noti = {

    --Notifications types:
    success = 'success',
    error = 'error',
    info = 'inform',

    --Notification time:
    time = 5000,
}

function notifications(notitype, message, time)
    --Change this trigger for your notification system keeping the variables
    --TriggerEvent("RiP-Notify:Notify", notitype, time, 'Meth Van', message)
    lib.notify({
        title = 'Meth Van',
        description = message,
        type = notitype,
        duration = time
    })
end