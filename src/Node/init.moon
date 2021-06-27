import insert from table
import remove from table


class Node
  new: (nameId, img, x, y) =>
    @name = nameId
    @children = {}
    @visible = true

    @x, @y = x, y -- cord in parent
    @sx, @sy = 1, 1 -- scale
    @rot = 0 -- rotation
    @px, @py = 0, 0 -- Center
    @ox, @oy = 0, 0 -- offset

    @layer = 1 -- top layers < 1

    @controls = {}

    @distance  = 100 -- dist from camera

    @Animate = nil
    @drawable = img
    @editorSprite = nil -- only visible in editor mode
    @colorFilter = {1,1,1,1}

    @physics = {}
    @isStatic  = false

    @onUpdate = {}


  attachUpdateCb: (updt) ->
    @onUpdate = updt

  addChild: (child) ->
    -- assert child.__class ~= self, "Child must be a Node."
    insert @children, child

  removeChild: (child) ->
    remove @children, child

  upadte: (dt) ->
    for _,c in ipairs @controls
      if c.enabled
        c\updatedt

    if @Animate ~= nil
      @Animate dt
    @updateChildren dt

  updateChildren: (dt) ->
    if @children == nil
      return
    for _,c in ipairs @children
      c\update dt

  draw: ->
    Graphics.setColor @colorFilter
    if @drawable ~= nil
      Graphics.draw @drawable, @distance / 100 * (@x + @px),
        @distance / 100 * (@y + @py), @rot, @distance / 100,
        @distance / 100, @ox, @oy

    if @children ~= nil
      for _, c in ipairs @children
        c.px = @px + @x
        c.py = @py + @y
        c\draw!

  -- Controls handling
  addControl: (ctrl) ->
    c = ctrl\fork!
    c.parent = self
    insert @controls, c

  getControl: (name) ->
    for _, c in ipairs @controls
      if c.name == name
        return c
    return nil

  removeControl: (name) ->
    for _, c in ipairs @controls
      if c.name == name
        remove @controls, _
        break

  getDimensions: ->
    @getWidth! * (@distance / 100), @getHeight! * (@distance / 100)

  getWidth: ->
    if @drawable ~= nil
      @drawable\getWidth! * (@distance / 100)
    elseif @editorSprite ~= nil
      @editorSprite\getWidth! * (@distance / 100)
    else
      0

  getHeight: ->
    if @drawable ~= nil
      @drawable\getHeight! * (@distance / 100)
    elseif @editorSprite ~= nil
      @editorSprite\getHeight! * (@distance / 100)
    else
      0

  getRealPos: ->
    @x - @ox * (@distance / 100), @y - @oy * (@distance / 100)

  getPos: ->
    @x * (@distance / 100),@y * (@distance / 100)

  getSize: ->
    if @drawable == nil
      if @editorSprite == nil
        0, 0
      @editorSprite\getWidth! * (@distance / 100), @editorSprite\getHeight! * (@distance / 100)
    @drawable\getWidth! * (@distance / 100), @drawable\getHeight! * (@distance / 100)








