local file = nil
local debug = false
local log = sys.File("log")
local outputfolder = nil
local probar = nil
local prowin = nil
local ui = require("ui")
local sys = require("sys")
local net = require("net")
local console = require("console")
log:open("write")
local function betterprint(text)
  print(text)
  log:writeln(text)
end
local function negate(bool)
  if bool then
   return false
   
  else
    return true
  end
end
betterprint("Setting up...")
local gameId = nil
local tempfolder = nil
-- Important Variables
local win = ui.Window("MPGT: AutoPSX","fixed",300,150)
local filetext = ui.Entry(win,"No file selected...",9,27,251,20)
local outputtext = ui.Entry(win,"No output folder selected...",9,56,224,20)
local selectfileButton = ui.Button(win,"...",264,27,28,20)
local outputfileButton = ui.Button(win,"...",237,56,57,20)
local convertbutton = ui.Button(win,"Convert",180,85,111,40)
filetext.enabled = false
filetext.textlimit = 40
outputtext.enabled = false
outputtext.textlimit = 40
win:show()
win.menu = ui.Menu()
local aboutmenu = win.menu:add("About", ui.Menu("AutoPSX on Github","Debug Mode"))
function aboutmenu.submenu:onClick(item)
    if item.text == "AutoPSX on Github" then
      sys.cmd("start https://github.com/xFN10x/AutoPSX")
    elseif item.text == "Debug Mode" then
      debug = negate(debug)
      item.checked = negate(item.checked)
    end
end

win:show()
betterprint("Done")
console:clear(console.bgcolor)
local function consolegreet()
  betterprint(" ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░░▒▓███████▓▒░ ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░ \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ \n░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░ ░▒▓██████▓▒░  \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░  ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ \n░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░   ░▒▓█▓▒░   ░▒▓██████▓▒░░▒▓█▓▒░      ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░\nMade by _FN10_")
betterprint("Convert PSX games to eboots without the hassle!\n\n")
end
consolegreet()
-- Functions
local function SetupConversionWindow ()
 -- if not delete then
    prowin = ui.Window("Converting...","fixed",200,100)
    probar = ui.Progressbar(prowin,9,60,182,31)
    local cancelbutton = ui.Button(prowin,"Cancel",9,36,182,20)
    local label = ui.Label(prowin,"Converting...",9,10)
    win:showmodal(prowin)
    if probar ~= nil then probar:advance(8) end
 -- else
    
 -- end
end
local function magiclines( str )
    local pos = 1;
    return function()
        if not pos then return nil end
        local  p1, p2 = string.find( str, "\r?\n", pos )
        local line
        if p1 then
            line = str:sub( pos, p1 - 1 )
            pos = p2 + 1
        else
            line = str:sub( pos )
            pos = nil
        end
        return line
    end
end
local function get_line(filename, line_number)
  local i = 0
  for line in magiclines(filename) do
    i = i + 1
    if i == line_number then
      return line
    end
  end
  return nil -- line not found
end
local function GetGameID (file)
  file:open("read","utf8")
  local s = file:read()
  local finsd,end1 = string.find(s, "%a%a%a%a_%d%d%d%d%d")
  if probar ~= nil then probar:advance(8) end
  if finsd == nil then
    return false
  end
  betterprint(finsd) 
  local id = string.sub(s, finsd,end1)
  betterprint("Game id is ",id)
  if probar ~= nil then probar:advance(0) end
  return id
end
local function GetGameCover (gameid,dest)
  local des = nil
  betterprint("Getting ","https://username:pass@raw.githubusercontent.com".."/xlenore/psx-covers/refs/heads/main/covers/default/"..gameid:gsub("_","-")..".jpg")
  local http = net.Http("https://username:pass@raw.githubusercontent.com")
  local puthttp, output = await(http:download("/xlenore/psx-covers/refs/heads/main/covers/default/"..gameid:gsub("_","-")..".jpg"))
  if probar ~= nil then probar:advance(6) end
  if debug then
    des = ui.savedialog("Save Cover to...",false,"JPEG Image (*.jpg)|*.jpg|All files (*.*)|*.*")
    if probar ~= nil then probar:advance(6) end
  else
    des = sys.File(dest.fullpath.."/cover.jpg")
    if probar ~= nil then probar:advance(6) end
   -- des:open():move()
  end
  output["file"]:open("read","binary")
  des:open("write","binary")
  des:write(output["file"]:read())
  http:close()
  if probar ~= nil then probar:advance(6) end
  des:close()
  if probar ~= nil then probar:advance(6) end
  return des.fullpath
end
local function CreateIcon (tempfolderfullpath)
  local icon0 = sys.File(tempfolderfullpath.."/icon0.png")
  sys.File(sys.currentdir.."/programs/imagemag/ICON0.PNG"):copy(icon0.fullpath)
  betterprint(sys.currentdir.."/programs/imagemag/magick.exe")
  if probar ~= nil then probar:advance(4) end
  sys.cmd(sys.currentdir.."/programs/imagemag/magick.exe".." mogrify -resize 70x70 "..tempfolderfullpath.."/cover.jpg")
  if probar ~= nil then probar:advance(4) end
  sys.cmd(sys.currentdir.."/programs/imagemag/magick.exe".." "..tempfolderfullpath.."/cover.jpg "..tempfolderfullpath.."/cover.png") --Convert to PNG
  if probar ~= nil then probar:advance(4) end
  sys.cmd(sys.currentdir.."/programs/imagemag/magick.exe "..tempfolderfullpath.."/cover.png"..' -gravity center -background transparent -extent  80x80 '..tempfolderfullpath.."/cover.png")
  if probar ~= nil then probar:advance(4) end
  betterprint("canvas size ",sys.currentdir.."/programs/imagemag/magick.exe"..tempfolderfullpath.."/cover.png".." -gravity center -extent -background rgba(255, 0, 0, 1.0) 80x80 "..tempfolderfullpath.."/cover.png")
  sys.cmd(sys.currentdir.."/programs/imagemag/magick.exe".." composite -gravity center "..icon0.fullpath.." "..tempfolderfullpath.."/cover.png "..tempfolderfullpath.."/finshed.png")
  if probar ~= nil then probar:advance(4) end
  return sys.File(tempfolderfullpath.."/finshed.png")
end
local function GetTrackFileFromCue(cue,track)
  if not cue.exists then ui.error("Fatal Error\nCue doesn't exist. (ERR3)") win:hide() return false end
  local function processstring(l)
    local s = l:gsub('" BINARY',"") 
    return s:gsub('FILE "',"")
  end
  local cuefile = cue
  local tracks = 0
  cuefile:open("read","utf8")
  local i = 1
  local tracklines = {}
  local cueread = cuefile:read()
  for l in magiclines(cueread) do
    i = i+1
    --if l:find("FILE ") ~= nil then
    --  
    if l:find("TRACK %d%d") ~= nil then
      local ss = string.sub(l,l:find("%d%d"))
      tracklines[ss] = processstring(get_line(cueread,i-2))
      tracks = tracks+1
    end
  end
  
  local cuedir = cue.directory
  if not cuedir.exists then ui.error("Fatal Error\nCue DIR doesn't exist. (ERR4)") win:hide() return false end
  if tracklines[track] == nil then betterprint("Cue dont done exist!") return false end
  
  local binfile = sys.File(cuedir.fullpath.."/"..tracklines[track])
  if binfile.exists then
    cuefile:close()
    betterprint("Got Track file name, ",binfile.name," with track amount ",tracks)
    if probar ~= nil then probar:advance(6) end
    return binfile,tracks
  else
    ui.error("Fatal Error\nFiles Cue reported dont exist. (ERR1)")
    win:hide()
  end
end
local function FinalStep (tempfolderfullpath,cue)
  local function lastfinalstep (eboot)
    if sys.File(outputfolder.fullpath.."/EBOOT.PBP").exists then 
      local confirm = ui.confirm(outputfolder.fullpath.."/EBOOT.PBP".." already exists. Replace it?")
      if confirm == "cancel" or confirm == "no" then
        tempfolder:removeall()
        console:clear("console.bgcolor")
        prowin:hide()
        consolegreet()
        return true
      elseif confirm == "yes" then
        sys.File(outputfolder.fullpath.."/EBOOT.PBP"):remove()
      end
    end
    if eboot:copy(outputfolder.fullpath.."/EBOOT.PBP") == nil then ui.error("Fatal Error\nFailed EBOOT copy. (ERR6)") win:hide() return false end
    if probar ~= nil then probar:advance(10000) end
    ui.info("EBOOT.PBP built to "..outputfolder.fullpath.."/EBOOT.PBP"..".")
    tempfolder:removeall()
    prowin:hide()
    console:clear("console.bgcolor")
    consolegreet()
    --for each
    return true
  end
  local mainfolderfullpath = tempfolderfullpath.."/mainfolder"
  local program = sys.File(sys.currentdir.."/programs/psxpack/psxpackager.exe")
  local newprogram = program:copy(tempfolderfullpath.."/mainfolder/psxpack.exe")
  local resourcefolder = sys.Directory(sys.currentdir.."/programs/psxpack/Resources/")
  local newresourcefolder = sys.Directory(tempfolderfullpath.."/mainfolder/Resources/")
  betterprint("Cue name",cue.name)
  --local command = mainfolderfullpath..'/psxpack.exe -i\\"'..mainfolderfullpath.."/"..cue.name..'\\" --import --resource-format \\"'..mainfolderfullpath..'\\"/%R`ESOURCE%.%EXT%'
  newresourcefolder:make()
  for file in each(resourcefolder:list("*.*")) do
    print(type(file))
    if type(file) == "table" or type(file) == "file" then
      betterprint("Copying",file.name,tempfolderfullpath.."/mainfolder/Resources/"..file.name)
      file:copy(tempfolderfullpath.."/mainfolder/Resources/"..file.name) 
    end
  end 
  if probar ~= nil then probar:advance(4) end
  if newprogram == nil then ui.error("Fatal Error\nFailed Copy. (ERR5)") win:hide() return false end
 -- betterprint(mainfolderfullpath..'/psxpack.exe -i"'..mainfolderfullpath.."/"..cue.name..'" --import --resource-format "'..mainfolderfullpath..'"\\%RESOURCE\\%.\\%EXT\\%')
  local command = mainfolderfullpath..'/psxpack.exe -i"'..mainfolderfullpath.."/"..cue.name..'" --import --resource-format "'..mainfolderfullpath..'"%RESOURCE%.%EXT%'
  if not sys.cmd(command) then betterprint("Error! Retrying CMDS...") if not sys.cmd(mainfolderfullpath..'/psxpack.exe -i"'..mainfolderfullpath.."/"..cue.name..'" --import --resource-format "'..mainfolderfullpath..'"%RESOURCE%.%EXT%') then ui.error("Fatal Error\nFailed CMD. (ERR7)") win:hide() return false end end
  if probar ~= nil then probar:advance(8) end
  for file in each(resourcefolder:list("*.pbp")) do
    lastfinalstep(file)
    break
  end 
end
local function SetupConversionFolder (tempfolderfullpath,cue,gameid,coverfile)
  betterprint("Setting up folder.")
  local function step3 (newfolderpath,cue,gamid)
    betterprint("step3")
    local gtftc,trackamount = GetTrackFileFromCue(cue,"01")
    for i = 0,trackamount,1 do
      if tostring(i):len() == 1 then
        local gtffcc = GetTrackFileFromCue(cue,"0"..tostring(i))
        if gtffcc then gtffcc:copy(newfolderpath.."/"..gtffcc.name) end
      elseif tostring(i):len() == 2 then
        local gtffcc = GetTrackFileFromCue(cue,""..tostring(i))
        if gtffcc then gtffcc:copy(newfolderpath.."/"..gtffcc.name) end
      end
    end
    cue:copy(newfolderpath.."/"..cue.name)
    if probar ~= nil then probar:advance(4) end
    coverfile:copy(newfolderpath.."/".."ICON0.png") 
    if probar ~= nil then probar:advance(4) end
    FinalStep(tempfolderfullpath,cue)
    if probar ~= nil then probar:advance(4) end
  end
  local function step2 (newfolderpath)
    betterprint("step2")
    local pic0 = sys.File(newfolderpath.."/PIC0.png")
    local couldtherealpic0pleasestandup = sys.File(sys.currentdir.."/programs/psxpack/PIC0.png")
    betterprint(sys.currentdir.."/programs/psxpack/PIC0.png")
    if couldtherealpic0pleasestandup.exists then
      couldtherealpic0pleasestandup:copy(pic0.fullpath)
      step3(newfolderpath,cue,gameid)
    else 
      return false
    end
  end
  local newfolder = sys.Directory(tempfolderfullpath.."/mainfolder")
  local newfolderpath = newfolder.fullpath
  if newfolder:make() then
    step2(newfolderpath)
  elseif newfolder.exists then
    step2(newfolderpath)
  else
    ui.error("Fatal Error\nCouldnt create folder. (ERR2)")
    win:hide()
    return false
  end
end
local function Convert (Cue)
  local function convert2(gameid)
    betterprint("Verifyed GameID ",gameid)
    local gamecoverpath = GetGameCover(gameid,tempfolder)
    local icon = CreateIcon(tempfolder.fullpath)
    SetupConversionFolder(tempfolder.fullpath,Cue,gameId,icon)
  end
  SetupConversionWindow()
 -- local binfile = 
  tempfolder = sys.tempdir("mgt")
  if debug then
    sys.cmd("explorer "..tempfolder.fullpath)
  end
  
  local track1,trackamount = GetTrackFileFromCue(Cue,"01")
  local ggi = GetGameID(track1)
  if ggi then
    gameId = ggi
    convert2(gameId)
  else
    ui.error("Failed to find GameID from track 1!\nPlease Type it Manually")
    local window = ui.Window("MPGT: Manual GameID","fixed",200,100)
    local textbox = ui.Entry(window,"XXXX_XXXXX",63,18,128,20)
    local text1 = ui.Label(window,"Game ID",9,18,54,20)
    local text2 = ui.Label(window,"Please include the underscore. (e.g. SLUS_00072)",9,47,182)
    local submitbutton = ui.Button(window,"Submit",9,65,182)
    local done = false
    text2.fontsize = 6
    text1.textalign = "center"
    text2.textalign = "center"
    win:showmodal(window)
    for i = 0,20,1 do
      window:tofront()
    end
    function submitbutton.onClick()
      local s = textbox.text
      local patern = string.find(s,"%a%a%a%a_%d%d%d%d%d")
      if patern == nil then
        ui.error("ID Format incorrect.")
      else
        gameId = s
        convert2(gameId)
      end
    end
  end
end


local function UpdateChoosenFile(efile,ftype)
  if ftype == "cue" then
    file = efile 
    filetext.text = efile.fullpath
    return true
  else
    return false 
  end
end
local function UpdateOutputFolder(folder)
  outputfolder = folder 
  outputtext.text = folder.fullpath
  return true
end
--Non-local functions
--function filebutton.onClick()
--  file = ui.opendialog("Open CUE",false,"PS1 CUE files (*.cue)|*.cue|All Files (*.*)|*.*")
--  Convert(file)
--end
function selectfileButton.onClick()
  local choosenfile = ui.opendialog("Open CUE",false,"PS1 CUE files (*.cue)|*.cue|All Files (*.*)|*.*")
  if choosenfile then
    local update = UpdateChoosenFile(choosenfile,"cue")
    if not update then ui.error("Not Supported") return false end
  else
    return false
  end
end
function outputfileButton.onClick()
  UpdateOutputFolder(ui.dirdialog("Choose output folder..."))
end
function convertbutton.onClick() 
  if file == nil then
    ui.error("No File selected")
    return false
  elseif outputfolder ~= nil then
    Convert(file)
  elseif outputfolder == nil then
    ui.error("No Output folder selected.")
    return false
  end
end


while win.visible do
  ui.update()
end
tempfolder:removeall()