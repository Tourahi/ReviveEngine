Utils = assert require "src.Utils"

class Control
  new: (name, enabled = true) =>
    @name = name
    @enabled = enabled
    @parent = nil
    @updateCB = nil -- update callback


  update: (dt) =>
    if @updateCB ~= nil and @enabled
      @updateCB self, dt

  enable: =>
    @enabled = true

  disable: =>
    @enabled = false

  remove: =>
    @parent\removeControl self

  fork: =>
    c_control = Utils.Fork self
    c_control.updateCB = @updateCB
    c_control

