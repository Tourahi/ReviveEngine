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



{:FileExists, :ReadAll, :DumpErr, :Fork, :RadomString}
