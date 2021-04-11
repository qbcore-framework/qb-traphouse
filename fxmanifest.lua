fx_version 'cerulean'
game 'gta5'

description 'QB-Traphouse'
version '1.0.0'

ui_page "html/index.html"

client_scripts {
    'client/main.lua',
    'config.lua',
}

server_scripts {
    'server/main.lua',
    'config.lua'
}

server_exports {
    'AddHouseItem',
    'RemoveHouseItem',
    'GetInventoryData',
    'CanItemBeSaled',
}

files {
    'html/*',
}