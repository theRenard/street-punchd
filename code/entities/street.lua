-- draw street
-- this entity is used to create a background building,
-- it is just a black rectangle with diagonal lines as windows
-- it is used to create a street scene

street = {}
lines = {}

function init_street()
  street.x = 0
  street.y = 64

  for i = 0, 5 do
    lines[i] = {
      x = i * 32,
      y = 96
    }
  end
end

function update_street()
  -- move the dotted lines to the left
  for i = 0, #lines do
    lines[i].x -= speed * 1.5
    if lines[i].x < -32 then
      lines[i].x = 128
    end
  end
  -- move the street to the right
  -- street.x -= speed * 1.5
  -- if street.x < -128 then
  --   street.x = 0
  -- end
end

function draw_street()
  -- Draw the street
  -- Use a sprite in the sprite sheet of dimension of 4 x 64 at position x = 0, y = 64
  -- fill the screen with the street sprite
  for i = 0, 128 / 4 do
    sspr(0, 64, 4, 64, i * 4 + street.x, street.y)
  end

  -- draw the dotted lines
  -- Use a sprite in the sprite sheet of dimension of 8 x 3 at position x = 8, y = 64
  for i = 0, #lines do
    local line = lines[i]
    sspr(16, 64, 16, 3, flr(line.x), flr(line.y))
  end
end

