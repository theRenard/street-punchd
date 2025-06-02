-- Cyclist entity configuration
c = {}

-- Sprite sheet coordinates for animation frames
c_sprite = { 0, 24, 48, 72 }
c_speed = 0.2  -- Animation speed
x_max = 150    -- Right boundary for cyclist movement
x_min = -50    -- Left boundary for cyclist movement

function init_cyclists()
  -- Initial position and properties
  c.x = x_max
  c.y = 70
  c.w = 24     -- Sprite width
  c.h = 24     -- Sprite height
  c.s = 1      -- Movement speed
  c.d = 1   -- Direction (1 = right, -1 = left)
  c.f = 0      -- Animation frame counter
  c.z = 1      -- Z-order for drawing
  c.col = { 5, 0 }  -- Color palette
  c.flip = false

  c.cx = 3
  -- x offset from sprite
  c.cy = 19
  -- y offset from sprite
  c.cw = 18
  -- collision width
  c.ch = 5

  add_object(c)
  reset_cyclists()
end

function reset_cyclists()
  -- Randomly choose starting side (left or right)
  local start_from_left = rnd() < 0.5
  c.x = start_from_left and x_min or x_max
  -- Random y position within screen boundaries
  c.y = randint(boundaries[2], boundaries[4])
  -- Set direction based on starting side
  c.d = start_from_left and 1 or -1
  c.flip = c.d == -1
end

function update_cyclists()
  -- Update animation frame
  c.f += c_speed
  if c.f >= #c_sprite then c.f = 0 end

  -- Set sprite properties
  c.sx = c_sprite[flr(c.f) + 1]
  c.sy = 40
  c.sw = 24
  c.sh = 24

  -- Move in current direction
  c.x += c.s * c.d

  -- Reset if cyclist goes out of bounds
  if c.x < x_min or c.x > x_max then
    reset_cyclists()
  end

  -- Update z-order for proper drawing
  c.z = c.y + c.h
end

function draw_cyclists()
  -- Debug: Show current x position

  -- Debug: Draw collision box
  if debug == 1 then
    rect(c.x, c.y, c.x + c.w, c.y + c.h, 8)
  end

  if debug == 1 then
    rect(c.x + c.cx, c.y + c.cy, c.x + c.cx + c.cw, c.y + c.cy + c.ch, 7)
  end
end