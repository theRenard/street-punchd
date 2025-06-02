-- Status UI element (Player Energy)
status = {
  x = 4,
  y = 120,
  w = 100,  -- 10 segments * 10 pixels
  h = 8,   -- 10 pixels height
  col = 7,
  segments = 10,
  current_segments = 10,
  segment_width = 3,
  segment_gap = 0
}

function update_status()
  -- Update segments based on collision
  if collision and not status.collision_handled then
    status.current_segments = max(0, status.current_segments - 1)
    status.collision_handled = true
  elseif not collision then
    status.collision_handled = false
  end

  -- Update color based on segments
  if status.current_segments <= 2 then
    status.col = 14  -- Red when low energy
  elseif status.current_segments <= 5 then
    status.col = 8   -- Orange when medium energy
  else
    status.col = 7   -- White when high energy
  end
end

function draw_status()
  -- Draw background
  rect(status.x, status.y, status.x + status.w, status.y + status.h, 0)

  -- Draw segments
  local current_x = status.x
  for i = 1, status.segments do
    if i <= status.current_segments then
      rect(current_x, status.y, current_x + status.segment_width, status.y + status.h, status.col)
    end
    current_x += status.segment_width + status.segment_gap
  end
end

function add_segment()
  status.current_segments = min(status.segments, status.current_segments + 1)
end

function remove_segment()
  status.current_segments = max(0, status.current_segments - 1)
end