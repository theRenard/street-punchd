p = {}
p_sprite = { 0, 16, 32, 48 }
ani_spd = 0.25

function init_player()
  p.x = 60
  p.y = 60
  p.w = 16
  p.h = 32
  p.dx = 0
  p.dy = 0
  p.m = 0
  p.f = 0
  p.d = 1
  p.s = 1
  p.z = 0
  -- Collision box (smaller than sprite)
  p.cx = 0
  -- x offset from sprite
  p.cy = 4
  -- y offset from sprite
  p.cw = 16
  -- collision width
  p.ch = 28
  p.sx = 0
  p.col = { 9, 0 }
  -- collision height
  add_object(p)
end

function update_player()
  p.dx = 0
  p.dy = 0
  p.m = 0

  -- Check if movement is possible in each direction
  local can_move_up = p.y + p.cy > boundaries[2]
  local can_move_down = p.y + p.cy + p.ch < boundaries[4]
  local can_move_left = p.x + p.cx > boundaries[1]
  local can_move_right = p.x + p.cx + p.cw < boundaries[3]

  -- Movement input with collision box bounds
  if (btn(⬆️) and can_move_up) p.dy -= p.s
  if (btn(⬇️) and can_move_down) p.dy += p.s
  if (btn(⬅️) and can_move_left) p.dx -= p.s
  if (btn(➡️) and can_move_right) p.dx += p.s

  -- Update direction
  if p.dx != 0 then
    p.d = p.dx > 0 and 1 or -1
  end

  -- Apply movement
  if p.dx != 0 or p.dy != 0 then
    local a = atan2(p.dx, p.dy)
    p.x += cos(a) * p.s
    p.y += sin(a) * p.s
  end

  -- Update animation
  if btn(⬅️) or btn(➡️) or
     ((btn(⬆️) and can_move_up) or
      (btn(⬇️) and can_move_down)) then
    p.f += ani_spd
    if p.f >= #p_sprite then p.f = 0 end
  else
    p.f = 0
  end

  -- Update speed based on collision box hitting left/right boundaries and horizontal movement
  local left_edge = p.x + p.cx
  local right_edge = p.x + p.cx + p.cw
  local is_horizontal = btn(⬅️) or btn(➡️)
  speed = ((left_edge <= boundaries[1] or right_edge >= boundaries[3]) and is_horizontal) and (0.40 * p.d) or 0

  -- Draw player
  local flip = p.d ~= 1

  p.flip = flip
  p.sx = p_sprite[flr(p.f) + 1]
  p.sy = 0
  p.sw = 16
  p.sh = 32
  p.z = flr(p.y + p.h)
end

function draw_player()
  -- Draw boundary lines
  if debug == 1 then
    line(boundaries[1], boundaries[2], boundaries[1], boundaries[4], 7) -- Left vertical
    line(boundaries[3], boundaries[2], boundaries[3], boundaries[4], 7) -- Right vertical
    line(boundaries[1], boundaries[2], boundaries[3], boundaries[2], 7) -- Top horizontal
    line(boundaries[1], boundaries[4], boundaries[3], boundaries[4], 7) -- Bottom horizontal
  end

  -- Draw collision box on top
  if debug == 1 then
    rect(p.x + p.cx, p.y + p.cy, p.x + p.cx + p.cw, p.y + p.cy + p.ch, 8)
  end
end