-- Author : Kazaa

fx_version 'cerulean'
game 'gta5'

shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

dependencies {
    'es_extended',
    'ox_target',
    'ox_inventory'
}
