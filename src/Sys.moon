import filesystem from love
import insert from table
Sys = {}


-- FILES
Sys.enumFiles = (path, filter)->
  recurciveEnum = (path, files) ->
    items = filesystem.getDirectoryItems path
    for _, item in ipairs items
      file = path .. "/" .. item
      file_info = filesystem.getInfo file
      if file_info.type == 'file'
        insert files, file
      elseif file_info.type == 'directory'
        recurciveEnum file, files

  files = {}
  recurciveEnum path, files
  if filter
    filtredFiles = {}
    for _, file in ipairs files
      if file\find filter
        insert filtredFiles, file\left(filter)\right(path .. "/")
    filtredFiles
  else
    files


