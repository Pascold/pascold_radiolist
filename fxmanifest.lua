fx_version 'adamant'
game 'gta5'
author 'Pascold'
description 'Radio List'
lua54 'yes'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_script '@ox_lib/init.lua'

ui_page 'index.html'

files {
    'index.html'
}

depedencies {
    'ox_lib',
    'oxmysql',
    'pma-voice'
}