fx_version "adamant"
game "gta5"
lua54 "yes"
author "Evádete"
description "Simple kmenu script"

client_scripts {
    "src/client/*.lua"
}

server_scripts {
    "src/server/*.lua"
}

shared_scripts {
    "data.lua",
    "@es_extended/imports.lua"
    "@ox_lib/init.lua"
}