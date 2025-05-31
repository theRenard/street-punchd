c = {}

c_sprite = { 0, 24, 48, 72 }
c_speed = 0.2

function init_cyclists()
  c.x = 50
  c.y = 70
  c.w = 24
  c.h = 24
  c.s = 1
  c.direction = 1
  c.f = 0
  c.z = 1
  c.col = { 5, 0 }

  add_object(c)
end

function update_cyclists()
  c.f += c_speed
  if c.f >= #c_sprite then c.f = 0 end
  c.sx = c_sprite[flr(c.f) + 1]
  c.sy = 40
  c.sw = 24
  c.sh = 24
  c.flip = c.direction
  c.x = c.x
  c.y = c.y
  c.z = c.y + c.h
end

function draw_cyclists()
  if debug == 1 then
    rect(c.x, c.y, c.x + c.w, c.y + c.h, 8)
  end

end