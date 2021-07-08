import insert from table
import remove from table
import sort from table
Graphics = love.graphics

class Scene
  new: (id, w, h) =>
    @nodes = {}
    @bgColor = {1,1,1,1}
    @w = w
    @h = h
    @name = id
    @onUpdate = nil
    @onLoad = nil
    @onExit = nil
    @staticNodes = {}
    @doLoad = nil
    @doUpdate = nil

    -- Add scene to the project if editing mode is On

  attachUpdateEvent: (e) =>
    @onUpdate = e

  addNode: (n) =>
    insert @nodes, n
    sort @nodes, (o1, o2) ->
      if o1.distance == o2.distance
        o1.layer > o2.layer
      else
        o1.distance > o2.distance

  addStaticNode: (n) =>
    insert @staticNodes, n
    sort @staticNodes, (o1, o2) ->
      if o1.distance == o2.distance
        o1.layer > o2.layer
      else
        o1.distance > o2.distance

  removeNode: (n) =>
    for i, v in ipairs @nodes
      if v == n
        remove @nodes, i
        return

  load: =>
    if @doLoad ~= nil
      @doLoad!

  exit: =>
    if @onExit ~= nil
      @onExit!

  updateNodes: (dt) =>
    for _, v in ipairs @nodes
      v\update dt

  update: (dt) =>
    if @doUpdate ~= nil
      @doUpdate self, dt
    @updateNodes dt

  draw: =>
    Graphics.setBackgroundColor @bgColor
    for _, v in ipairs @nodes
      v\draw!

  refreshNodes: =>
    sort @nodes, (o1, o2) ->
      o1.layer > o2.layer
