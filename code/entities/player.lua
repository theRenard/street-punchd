p = {}
b = { 20, 5, 110, 115 }
s = { 0, 16, 32, 48 }

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
  p.s = 1.2
  p.z = 0
  -- Collision box (smaller than sprite)
  p.cx = 0
  -- x offset from sprite
  p.cy = 4
  -- y offset from sprite
  p.cw = 16
  -- collision width
  p.ch = 28
  -- collision height
  add_object(p)
end

function update_player()
  p.dx = 0
  p.dy = 0
  p.m = 0

  -- Check if movement is possible in each direction
  local can_move_up = p.y + p.cy > b[2]
  local can_move_down = p.y + p.cy + p.ch < b[4]
  local can_move_left = p.x + p.cx > b[1]
  local can_move_right = p.x + p.cx + p.cw < b[3]

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
    p.f += 0.25
    if p.f > 3 then p.f = 0 end
  else
    p.f = 0
  end

  -- Update speed based on collision box hitting left/right boundaries and horizontal movement
  local left_edge = p.x + p.cx
  local right_edge = p.x + p.cx + p.cw
  local is_horizontal = btn(⬅️) or btn(➡️)
  speed = ((left_edge <= b[1] or right_edge >= b[3]) and is_horizontal) and (0.40 * p.d) or 0
  if debug == 1 then
    print(speed)
  end

  -- Draw player
  local flip = p.d ~= 1
  p.y = flr(p.y)

  p.flip = flip
  p.sx = s[flr(p.f) + 1]
  p.sy = 0
  p.sw = 16
  p.sh = 32
  p.z = p.y + p.h
end

function draw_player()
  -- Draw boundary lines
  if debug == 1 then
    line(b[1], b[2], b[1], b[4], 7) -- Left vertical
    line(b[3], b[2], b[3], b[4], 7) -- Right vertical
    line(b[1], b[2], b[3], b[2], 7) -- Top horizontal
    line(b[1], b[4], b[3], b[4], 7) -- Bottom horizontal
  end

  print(p.z, 0, 0, 7)

  -- change trousers color from yellow to black
  -- pal(9, 0)
  -- sspr(s.x, s.y, s.w, s.h, p.x, p.y, s.w, s.h, flip)
  -- pal(9, 9)

  -- Draw collision box on top
  if debug == 1 then
    rect(p.x + p.cx, p.y + p.cy, p.x + p.cx + p.cw, p.y + p.cy + p.ch, 8)
  end
end