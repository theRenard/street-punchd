-- Cyclist entity configuration
cyclist = {}

-- Sprite sheet coordinates for animation frames
cyclist_sprite_frames = { 0, 24, 48, 72 }
cyclist_animation_speed = 0.2  -- Animation speed
cyclist_x_max = 150    -- Right boundary for cyclist movement
cyclist_x_min = -50    -- Left boundary for cyclist movement

function init_cyclists()
  -- Initial position and properties
  cyclist.x = cyclist_x_max
  cyclist.y = 70
  cyclist.width = 24     -- Sprite width
  cyclist.height = 24     -- Sprite height
  cyclist.speed = 1      -- Movement speed
  cyclist.direction = 1   -- Direction (1 = right, -1 = left)
  cyclist.frame = 0       -- Animation frame counter
  cyclist.z_order = 1     -- Z-order for drawing
  cyclist.palette = { 5, 0 }  -- Color palette
  cyclist.flip = false

  cyclist.collision_box_offset_x = 3
  cyclist.collision_box_offset_y = 19
  cyclist.collision_box_width = 18
  cyclist.collision_box_height = 5

  add_object(cyclist)
  reset_cyclists()
end

function reset_cyclists()
  -- Randomly choose starting side (left or right)
  local start_from_left = rnd() < 0.5
  cyclist.x = start_from_left and cyclist_x_min or cyclist_x_max
  -- Random y position within screen boundaries
  cyclist.y = randint(walking_boundaries[2], walking_boundaries[4])
  -- Set direction based on starting side
  cyclist.direction = start_from_left and 1 or -1
  cyclist.flip = cyclist.direction == -1
end

function update_cyclists()
  -- Update animation frame
  cyclist.frame += cyclist_animation_speed
  if cyclist.frame >= #cyclist_sprite_frames then cyclist.frame = 0 end

  -- Set sprite properties
  cyclist.sprite_x = cyclist_sprite_frames[flr(cyclist.frame) + 1]
  cyclist.sprite_y = 40
  cyclist.sprite_width = 24
  cyclist.sprite_height = 24

  -- Move in current direction
  cyclist.x += cyclist.speed * cyclist.direction

  -- Reset if cyclist goes out of bounds
  if cyclist.x < cyclist_x_min or cyclist.x > cyclist_x_max then
    reset_cyclists()
  end

  -- Update z-order for proper drawing
  cyclist.z_order = cyclist.y + cyclist.height

  -- Create dust particles behind the cyclist when moving
  if rnd(100) < 20 then
    -- Position dust behind the cyclist based on their direction
    local dust_x = cyclist.x + (cyclist.direction == 1 and -8 or cyclist.width + 8)
    create_dust(dust_x + randfloat(-3, 3), cyclist.y + cyclist.height - 2, 1)
  end
end

function draw_cyclists()
  -- Debug: Show current x position

  -- Debug: Draw collision box
  if debug == 1 then
    rect(cyclist.x, cyclist.y, cyclist.x + cyclist.width, cyclist.y + cyclist.height, 8)
  end

  if debug == 1 then
    rect(cyclist.x + cyclist.collision_box_offset_x, cyclist.y + cyclist.collision_box_offset_y, cyclist.x + cyclist.collision_box_offset_x + cyclist.collision_box_width, cyclist.y + cyclist.collision_box_offset_y + cyclist.collision_box_height, 7)
  end
end