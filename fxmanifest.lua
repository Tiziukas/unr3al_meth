fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author '1OSaft'
description 'Reworked Methcar from Kuzkay'
version '1.0.0'

dependencies {'es_extended', 'ox_lib'}


shared_scripts {
    '@ox_lib/init.lua',
    '@msk_core/import.lua',
    'config.lua',
    'Locales.lua'
}
client_scripts {
    'client.lua',
}
server_scripts {
    'server.lua',
    "Logs/config.log.lua",
}
