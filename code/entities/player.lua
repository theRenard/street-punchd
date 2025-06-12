player = {}
player_sprite_frames = { 0, 16, 32, 48 }
player_animation_speed = 0.25
player_cyclist_collision = false
btn_pressed = false

function init_player()
  player.x = 60
  player.y = 60
  player.width = 16
  player.height = 32
  player.velocity_x = 0
  player.velocity_y = 0
  player.movement = 0
  player.frame = 0
  player.direction = 1
  player.speed = 1
  player.z_order = 0
  player.is_attacking = false
  player.attack_timer = 0
  -- Collision box (smaller than sprite)
  player.collision_offset_x = 0
  -- x offset from sprite
  player.collision_offset_y = 4
  -- y offset from sprite
  player.collision_width = 16
  -- collision width
  player.collision_height = 28
  player.collision_box_offset_x = 0
  -- x offset from sprite
  player.collision_box_offset_y = 27
  -- y offset from sprite
  player.collision_box_width = 16
  -- collision width
  player.collision_box_height = 5
  player.sprite_x = 0
  player.energy = 100
  player.palette = { 9, 0 }
  -- collision height
  add_object(player)
end

function update_player()
  player.velocity_x = 0
  player.velocity_y = 0
  player.movement = 0

  -- Check if movement is possible in each direction
  local can_move_up = player.y + player.collision_offset_y > walking_boundaries[2]
  local can_move_down = player.y + player.collision_offset_y + player.collision_height < walking_boundaries[4]
  local can_move_left = player.x + player.collision_offset_x > walking_boundaries[1]
  local can_move_right = player.x + player.collision_offset_x + player.collision_width < walking_boundaries[3]

  -- Check collision with cyclist
  local player_collision_box = {
    x = player.x + player.collision_box_offset_x,
    y = player.y + player.collision_box_offset_y,
    w = player.collision_box_width,
    h = player.collision_box_height
  }

  local cyclist_collision_box = {
    x = cyclist.x + cyclist.collision_box_offset_x,
    y = cyclist.y + cyclist.collision_box_offset_y,
    w = cyclist.collision_box_width,
    h = cyclist.collision_box_height
  }

  -- Check if collision boxes overlap
  player_cyclist_collision =
    player_collision_box.x < cyclist_collision_box.x + cyclist_collision_box.w and
    player_collision_box.x + player_collision_box.w > cyclist_collision_box.x and
    player_collision_box.y < cyclist_collision_box.y + cyclist_collision_box.h and
    player_collision_box.y + player_collision_box.h > cyclist_collision_box.y

  -- Movement input with collision box bounds
  if (btn(⬆️) and can_move_up) player.velocity_y -= player.speed
  if (btn(⬇️) and can_move_down) player.velocity_y += player.speed
  if (btn(⬅️) and can_move_left) player.velocity_x -= player.speed
  if (btn(➡️) and can_move_right) player.velocity_x += player.speed

  if btn(❎) and not player.is_attacking and not btn_pressed then
    player.is_attacking = true
    btn_pressed = true
  end

  if not btn(❎) then
    btn_pressed = false
  end

  if player.is_attacking then
    player.attack_timer += 1
    if player.attack_timer >= 10 then
      player.is_attacking = false
      player.attack_timer = 0
    end
  end

  -- Update direction
  if player.velocity_x != 0 then
    player.direction = player.velocity_x > 0 and 1 or -1
  end

  -- Apply movement
  if player.velocity_x != 0 or player.velocity_y != 0 then
    local angle = atan2(player.velocity_x, player.velocity_y)
    player.x += cos(angle) * player.speed
    player.y += sin(angle) * player.speed
  end

  -- Update animation
  if btn(⬅️) or btn(➡️) or
     ((btn(⬆️) and can_move_up) or
      (btn(⬇️) and can_move_down)) then
    player.frame += player_animation_speed
    if player.frame >= #player_sprite_frames then player.frame = 0 end
  else
    player.frame = 0
  end

  -- Update speed based on collision box hitting left/right boundaries and horizontal movement
  local left_edge = player.x + player.collision_offset_x
  local right_edge = player.x + player.collision_offset_x + player.collision_width
  local is_horizontal = btn(⬅️) or btn(➡️)
  scroll_speed = ((left_edge <= walking_boundaries[1] or right_edge >= walking_boundaries[3]) and is_horizontal) and (0.40 * player.direction) or 0

  -- Draw player
  local flip = player.direction ~= 1

  player.flip = flip
  player.sprite_x = player_sprite_frames[flr(player.frame) + 1]
  player.sprite_y = 0
  player.sprite_width = 16
  player.sprite_height = 32
  player.z_order = flr(player.y + player.height)

  if player_cyclist_collision then
    player.palette = { 14, 0 }
    if player.energy > 0 then
      player.energy -= 1
    end
  else
    if player.is_attacking then
      player.palette = { 9, 8 }
    else
      player.palette = { 9, 0 }
    end
  end

  -- Create dust particles when player is moving
  if (player.velocity_x != 0 or player.velocity_y != 0) and rnd(100) < 15 then
    create_dust(player.x + randfloat(-4, 4), player.y + player.height - 2, 1)
  end
end

function draw_player()
  -- Draw boundary lines
  if debug == 1 then
    line(walking_boundaries[1], walking_boundaries[2], walking_boundaries[1], walking_boundaries[4], 7) -- Left vertical
    line(walking_boundaries[3], walking_boundaries[2], walking_boundaries[3], walking_boundaries[4], 7) -- Right vertical
    line(walking_boundaries[1], walking_boundaries[2], walking_boundaries[3], walking_boundaries[2], 7) -- Top horizontal
    line(walking_boundaries[1], walking_boundaries[4], walking_boundaries[3], walking_boundaries[4], 7) -- Bottom horizontal
  end

  -- Draw collision box on top
  if debug == 1 then
    rect(player.x + player.collision_offset_x, player.y + player.collision_offset_y, player.x + player.collision_offset_x + player.collision_width, player.y + player.collision_offset_y + player.collision_height, 8)
  end

  if debug == 1 then
    rect(player.x + player.collision_box_offset_x, player.y + player.collision_box_offset_y, player.x + player.collision_box_offset_x + player.collision_box_width, player.y + player.collision_box_offset_y + player.collision_box_height, player_cyclist_collision and 14 or 7)
  end
end