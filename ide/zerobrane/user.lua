--[[--
  Use this file to specify System preferences.
  Review [examples](+/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/cfg/user-sample.lua) or check [online documentation](http://studio.zerobrane.com/documentation.html) for details.
--]]--

-- Style preferences
local G = ...
styles = G.loadfile('cfg/tomorrow.lua')('Palleton')
stylesoutshell = styles -- also apply the same scheme to Output/Console windows

local luaspec = G.ide.specs.lua
luaspec.keywords[3] = luaspec.keywords[3] .. [[
      Agent Automaton Cell CellularSpace Chart Choice Clock Directory Environment Event File Flow
      Group InternetSender Jump Layer Log Mandatory Map Model Neighborhood Project Random SocialNetwork Society
      State TextScreen Timer Trajectory UnitTest VisualTable]]

luaspec.keywords[4] = luaspec.keywords[4] .. [[
      forEachAgent forEachCell forEachCellPair forEachConnection forEachElement forEachNeighbor forEachNeighborhood 
      forEachFile forEachDirectory forEachOrderedElement forEachSocialNetwork import
      createNeighboorhood createSocialNetwork createPlacement
      greaterByCoord greaterByAttribute integrate]]

luaspec.keywords[3] = string.gsub(luaspec.keywords[3], "select ", "")

-- Editor preferences
editor.fontsize = 14 -- this is mapped to ide.config.editor.fontsize
editor.fontname = "Consolas"
-- to disable indicators (underlining) on function calls
-- styles.indicator.fncall = nil
-- to change the type of the indicator used for function calls
-- styles.indicator.fncall.st = wxstc.wxSTC_INDIC_HIDDEN
styles.indicator = {}

filehistorylength = 20 -- this is mapped to ide.config.filehistorylength

-- Output preferences
outputshell.fontname = "Consolas"-- set font name.
outputshell.fontsize = 14 -- set font size (the default value is 11 on OSX).

-- to have 4 spaces when TAB is used in the editor
editor.tabwidth = 4

-- to specify language to use in the IDE (requires a file in cfg/i18n folder)
language = "en"

-- Path to TerraME
-- Example:
-- path.terrame_install = "C:\\TerraME\\bin"
