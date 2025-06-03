-- Score UI element
score = {
  value = 0,
  col = 7   -- White color by default
}

function update_score()
  -- Update score based on game events
  -- This can be expanded based on scoring mechanics
end

function draw_score()
  local margin = 6
  local screen_width = 128
  local score_str = '000134'
  local text_width = #score_str * 4 -- 4px per char in Pico-8 font
  local x = (screen_width - text_width) / 2
  local y = margin
  -- Draw border (1px around)
  for dx = -1, 1 do
    for dy = -1, 1 do
      if not (dx == 0 and dy == 0) then
        print(score_str, x + dx, y + dy, 0)
      end
    end
  end
  -- Draw main text
  print(score_str, x, y, score.col)
end

function add_points(points)
  score.value += points
end

function reset_score()
  score.value = 0
end