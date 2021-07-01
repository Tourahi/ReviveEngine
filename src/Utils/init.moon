io = io
import random from math
import concat from table

DumpErr = (msg) ->
  print "ERROR :" .. msg

ReadAll = (file) ->
  f = io.open file, "rb"
  if f ~= nil
    data = f\read "*all"
    f\close!
    data
  else
    DumpErr "Unable to load file " .. file
    nil

FileExists = (name) ->
  f = io.open name, "r"
  if f ~= nil
    io.close f
    true
  else
    false

Fork = (o, seen) ->
  seen = seen or {}
  if o == nil
    nil
  if seen[o]
    seen[o]

  new_o = {}
  if type o == 'table'
    seen[o] = new_o

    for k, v in next, o, nil
      new_o[Fork(k, seen)] = Fork v, seen
    setmetatable new_o, Fork(getmetatable(o), seen)
  else
    new_o = o

  new_o

RadomString = (len) ->
  len = len or 8
  if len < 1
    nil
  arr = {}
  for i = 1, len
    arr[i] = string.char random(97, 122)
  concat arr

ExportString = (s) ->
  string.format "%q", s

table.save = (tbl, fileName) ->
  charS, charE = "   ", "\n"
  file, err = io.open fileName, "wb"
  if err
    err

  -- Init vars
  tables, lookup = { tbl }, { [tbl]: 1 }
  file\write "return {" .. charE

  for idx, t in ipairs tables
    file\write "-- Table: {" .. idx .. "}" .. charE
    file\write "{" .. charE
    thandled = {}

    for i, v in ipairs t
      thandled[i] = true
      stype = type v
      if stype == "table"
        if not lookup[v]
          table.insert tables, v
          lookup[v] = #tables
        file\write charS .. "{" .. lookup[v] .. "}," .. charE
      elseif stype == "string"
        file\write charS .. ExportString(v) .. "," .. charE
      elseif stype == "number"
        file\write charS .. tostring(v) .. "," .. charE

    for i, v in pairs t
      if not thandled[i]
        str = ""
        stype = type i
        -- idx
        if stype == "table"
          if not lookup[i]
            table.insert tables, i
            lookup[i] = #tables
          str = charS .. "[{" .. lookup[i] .. "]}="
        elseif stype == "string"
          str = charS .. "[" .. ExportString(i) .. "]="
        elseif stype == "number"
          str = charS .. "[" .. tostring(i) .. "]="

        if str ~= ""
          stype = type v
          if stype == "table"
            if not lookup[v]
              table.insert tables, v
              lookup[v] = #tables
            file\write str .. "{" .. lookup[v] .. "}," ..charE
          elseif stype == "string"
            file\write str .. ExportString( v ) .. "," .. charE
          elseif stype == "number"
            file\write str .. tostring( v ) .. "," .. charE
    file\write  "}," .. charE
  file\write "}"
  file\close!





{:FileExists, :ReadAll, :DumpErr, :Fork, :RadomString}
