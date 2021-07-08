import insert from table
import sort from table

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

  attachUpdateEvent: (e) =>
    @onUpdate = e

  addNode: (n) =>
    insert @nodes, n
    sort @nodes, (o1, o2) ->
      if o1.distance == o2.distance
        o1.layer > o2.layer
      else
        o1.distance > o2.distance


