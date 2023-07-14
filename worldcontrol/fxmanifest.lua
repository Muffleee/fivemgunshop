fx_version "cerulean"
game "gta5"
lua54 "yes"

author "mulmer"

description 'Simple script to sync time and weather between clients'
version '1.0.0'

-- Client
client_scripts {
    "config.lua",
    "client/c_worldcontrol.lua"
}


-- Server
server_scripts {
    "config.lua",
    "server/s_worldcontrol.lua"
}