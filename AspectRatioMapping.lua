require 'MathRound'
require "Logger"

ratioMapping = {
    ['0.5'] = '9:16',
    ['0.7'] = '2:3',
    ['0.8'] = '3:4',
    ['1'] = '1:1',
    ['1.3'] = '4:3',
    ['1.5'] = '3:2',
    ['1.6'] = '16:10',
    ['1.8'] = '16:9'
}

function getRatioMapping(nummericAspectRatio)
  local roundedNummericRatio = round(nummericAspectRatio, 1)
  logger:debug('Rounder nummeric ratio '..roundedNummericRatio)
  local mappedRatio = ratioMapping[tostring(roundedNummericRatio)]

  if mappedRatio == nil then mappedRatio = 'unkown' end

    return mappedRatio
end
