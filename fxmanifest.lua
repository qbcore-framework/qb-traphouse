fx_version 'cerulean'
game 'gta5'

description 'QB-Traphouse'
version '2.0.0'

ui_page 'html/index.html'

shared_scripts {
	'config.lua',
    '@qb-core/shared/locale.lua',
	'locales/en.lua'
}
client_script {
    'client/*.lua',
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/CircleZone.lua',
}

server_script 'server/*.lua'

server_exports {
    'AddHouseItem',
    'RemoveHouseItem',
    'GetInventoryData',
    'CanItemBeSaled'
}

files {
    'html/*'
}

lua54 'yes'