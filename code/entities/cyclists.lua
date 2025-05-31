cyclists = {}

s = { 0, 24, 48, 72 }

function init_cyclists()
  cyclists.x = 50
  cyclists.y = 70
  cyclists.w = 24
  cyclists.h = 24
  cyclists.speed = 1
  cyclists.direction = 1
  cyclists.frame = 0
  cyclists.frame_count = 4
  cyclists.frame_time = 0.25
  cyclists.frame_index = 1
  cyclists.z = 1

  add_object(cyclists)
end

function update_cyclists()
  cyclists.frame = cyclists.frame + cyclists.frame_time
  if cyclists.frame >= cyclists.frame_count then
    cyclists.frame = 0
  end
  cyclists.sx = s[flr(cyclists.frame)]
  cyclists.sy = 40
  cyclists.sw = 24
  cyclists.sh = 24
  cyclists.flip = cyclists.direction
  cyclists.x = cyclists.x
  cyclists.y = cyclists.y
  cyclists.z = cyclists.y + cyclists.h
end

function draw_cyclists()
  -- pal(5, 0)
  -- pal(5, 5)

  if debug == 1 then
    rect(cyclists.x, cyclists.y, cyclists.x + cyclists.w, cyclists.y + cyclists.h, 8)
  end

end