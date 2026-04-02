fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "nui/index.html"

files {
	"nui/index.html",
	"nui/app.js",
	"nui/style.css",
	"imagens/*",
	"imagens/**/*"
}

shared_scripts {
	"config.lua"
}

client_scripts {
	"@vrp/lib/Utils.lua",
	"client-side/core.lua"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/core.lua"
}

dependency "vrp"
