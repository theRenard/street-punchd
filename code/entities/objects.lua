game_objects = {}

function add_object(game_object)
  add(game_objects, game_object)
end

function remove_object(game_object)
  game_objects = {}
end

function clear_objects()
  game_objects = {}
end

function draw_objects()
  local ordered_objects = {}
  for game_object in all(game_objects) do
    ordered_objects[game_object.z_order] = ordered_objects[game_object.z_order] or {}
    add(ordered_objects[game_object.z_order], game_object)
  end
  for z = 0, 127 do
    for game_object in all(ordered_objects[z]) do
      if game_object.palette then
        pal(game_object.palette[1], game_object.palette[2])
      end
      sspr(game_object.sprite_x, game_object.sprite_y, game_object.sprite_width, game_object.sprite_height, game_object.x, game_object.y, game_object.sprite_width, game_object.sprite_height, game_object.flip)
      if game_object.palette then
        pal(game_object.palette[1], game_object.palette[1])
      end
    end
  end
end