local lg = love.graphics

function drawField (source)
  local i, j
  lg.setColor(255, 255, 255, 255)
  for i = 0, iter.width - 1 do
    for j = 0, iter.height - 1 do
      if iter.field[i][j].state ~= 0 then
        lg.rectangle('fill', i * tileDim + (W - iter.width * tileDim) / 2, j * tileDim + (H - iter.height * tileDim) / 2, tileDim, tileDim)
      --[[else
        print("tile ["..i.." "..j.."]")]]
      end
    end
  end
  --[[lg.setColor(0, 2, 10, 255)
  for i = 1, iter.width - 1 do
    lg.rectangle('fill', (i * tileDim) - 1 + (W - iter.width * tileDim) / 2, (H - iter.height * tileDim) / 2, 2, H - (H - iter.height * tileDim))
  end
  for j = 1, iter.height - 1 do
    lg.rectangle('fill', (W - iter.width * tileDim) / 2, (j * tileDim) - 1 + (H - iter.height * tileDim) / 2, W - (W - iter.width * tileDim), 2)
  end]]
end
