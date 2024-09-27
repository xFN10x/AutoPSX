local ui = require "ui"
local Window = ui.Window(rtbuilder, "M3U Creator", "fixed", 244, 141)
Window.name = 'Window'
Window.type = 'Window'
Window:loadicon()
Window.icon = nil
Window.align = nil
Window.y = "408"
Window.x = "602"
Window.font = 'Segoe UI'
Window.cursor = 'arrow'
Window.width = "244"
Window.enabled = true
Window.fontsize = "9"
Window.topmost = false
Window.transparency = "255"
Window.menu = nil
Window.bgcolor = "0"
Window.fullscreen = false
Window.title = 'M3U Creator'
Window.traytooltip = ''
Window.height = "141"
Window.fontstyle = { ['heavy'] = false,['strike'] = false,['underline'] = false,['italic'] = false,['thin'] = true,['bold'] = false }
Window.style = 'single'

local CreateUseButton = ui.Button(Window, [[Create and Use]], 124, 104, 116, 28)
CreateUseButton.name = 'CreateUseButton'
CreateUseButton.type = 'Button'
CreateUseButton:loadicon()
CreateUseButton.icon = nil
CreateUseButton.hastext = true
CreateUseButton.text = [[Create and Use]]
CreateUseButton.align = nil
CreateUseButton.visible = true
CreateUseButton.y = "104"
CreateUseButton.font = 'Segoe UI'
CreateUseButton.width = "116"
CreateUseButton.enabled = true
CreateUseButton.fontsize = "9"
CreateUseButton.textalign = [[center]]
CreateUseButton.cursor = 'arrow'
CreateUseButton.tooltip = ''
CreateUseButton.height = "28"
CreateUseButton.x = "124"
CreateUseButton.fontstyle = { ['heavy'] = false,['strike'] = false,['underline'] = false,['italic'] = false,['thin'] = true,['bold'] = false }

local CreateButton = ui.Button(Window, [[Create]], 4, 104, 116, 28)
CreateButton.name = 'CreateButton'
CreateButton.type = 'Button'
CreateButton:loadicon()
CreateButton.icon = nil
CreateButton.hastext = true
CreateButton.text = [[Create]]
CreateButton.align = nil
CreateButton.visible = true
CreateButton.y = "104"
CreateButton.font = 'Segoe UI'
CreateButton.width = "116"
CreateButton.enabled = true
CreateButton.fontsize = "9"
CreateButton.textalign = [[center]]
CreateButton.cursor = 'arrow'
CreateButton.tooltip = ''
CreateButton.height = "28"
CreateButton.x = "4"
CreateButton.fontstyle = { ['heavy'] = false,['strike'] = false,['underline'] = false,['italic'] = false,['thin'] = true,['bold'] = false }

local List1 = ui.List(Window, {}, 4, 4, 148, 84)
List1.items = { }
List1.name = 'List1'
List1.type = 'List'
List1.icons = { }
List1.tooltip = ''
List1.align = nil
List1.visible = true
List1.y = "4"
List1.selected = nil
List1.font = 'Segoe UI'
List1.width = "148"
List1.enabled = true
List1.border = true
List1.cursor = 'arrow'
List1.style = 'text'
List1.fontsize = "9"
List1.height = "84"
List1.x = "4"
List1.fontstyle = { ['heavy'] = false,['strike'] = false,['underline'] = false,['italic'] = false,['thin'] = true,['bold'] = false }

local addcuefile = ui.Button(Window, "Add Cue", 156, 4, 85, 28)
addcuefile.name = 'addcuefile'
addcuefile.type = 'Button'
addcuefile:loadicon()
addcuefile.icon = nil
addcuefile.hastext = true
addcuefile.text = [[Add Cue]]
addcuefile.align = nil
addcuefile.visible = true
addcuefile.y = "4"
addcuefile.font = 'Segoe UI'
addcuefile.width = "85"
addcuefile.enabled = true
addcuefile.fontsize = "9"
addcuefile.textalign = [[center]]
addcuefile.cursor = 'arrow'
addcuefile.tooltip = ''
addcuefile.height = "28"
addcuefile.x = "156"
addcuefile.fontstyle = { ['heavy'] = false,['strike'] = false,['underline'] = false,['italic'] = false,['thin'] = true,['bold'] = false }
local compo = {}
compo["Window"] = Window
compo['CreateUseButton'] = CreateUseButton
compo['CreateButton'] = CreateButton
compo['List1'] = List1
compo['addcuefile'] = addcuefile
return compo
