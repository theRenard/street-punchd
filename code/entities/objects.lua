objs = {}

function add_object(obj)
  add(objs, obj)
end

function remove_object(obj)
  objs = {}
end

function clear_objects()
  objs = {}
end

function draw_objects()
  ordered = {}
  for obj in all(objs) do
    ordered[obj.z] = ordered[obj.z] or {} -- ensure table is there
    add(ordered[obj.z], obj)
  end
  for i = 0, 127 do
    -- or whatever your min/max Y is
    for obj in all(ordered[i]) do
      if obj.col then
        pal(obj.col[1], obj.col[2])
      end
      sspr(obj.sx, obj.sy, obj.sw, obj.sh, obj.x, obj.y, obj.sw, obj.sh, obj.flip)
      if obj.col then
        pal(obj.col[1], obj.col[1])
      end
    end
  end
end