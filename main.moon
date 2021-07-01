
-- Requiring to catch syntaxe bugs
assert require "src.Globals"
Node = assert require "src.Node"
Utils = assert require "src.Utils"
export B = assert require "third-party/Binocles"

with love
  .load = () ->
    math.randomseed os.time!
    print Utils.FileExists "ToDoLog.md"
    print Utils.RadomString 9
