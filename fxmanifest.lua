fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author '1OSaft'
description 'Reworked Methcar from Kuzkay'
version '1.0.2'

dependencies {'es_extended', 'ox_lib'}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
    'locales/*.lua',
}
client_scripts {
    'client/client.lua'
}
server_scripts {
    'server/server.lua',
    'logs/config.log.lua'
}
