Graphics = love.graphics
Window = love.window

class Camera
  new: (x, y) =>
    -- scale
    @sx = 1
    @sy = 1
    -- width height
    @w = 0
    @h = 0
    -- rotation
    @rot = 0
    @x = x
    @y = y
    @scene = nil

  attach: (s) =>
    @scene = s
    @w = s.w
    @h = s.h

  setScale: (sx, sy) =>
    @sx = sx
    @sy = sy
    Graphics.scale sx, sy

  set: =>
    Graphics.push!
    Graphics.rotate -@rot
    Graphics.scale 1 / @sx, 1 / @sy
    Graphics.translate -@x, -@y

  unset: =>
    Graphics.pop!

  update: (dt) =>
    if @scene ~= nil
      @scene\update dt

  setPos: (x, y) =>
    @x = x
    @y = y

  draw: =>
    @set!
    if @scene ~= nil
      @scene\draw!
    @unset!


  focus: (x, y) =>
    wx, wy = Window.getWidth!, Window.getHeight!
    if @x > x and @x < @x + @wx and @y > y and @y < @y + wy
      return
    @setPos x - (wx/2), y - (wy/2)




