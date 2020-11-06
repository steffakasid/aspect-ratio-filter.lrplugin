require 'MathRound'
require "Logger"

ratioMapping = {
    ['0.5'] = '16:9',
    ['0.7'] = '3:2',
    ['0.8'] = '4:3',
    ['1'] = '1:1',
    ['1.3'] = '3:4',
    ['1.5'] = '2:3',
    ['1.6'] = '10:16',
    ['1.8'] = '9:16'
}

function getRatioMapping(nummericAspectRatio)
  local roundedNummericRatio = round(nummericAspectRatio, 1)
  logger:debug('Rounder nummeric ratio '..roundedNummericRatio)
  local mappedRatio = ratioMapping[tostring(roundedNummericRatio)]

  if mappedRatio == nil then mappedRatio = 'unkown' end

    return mappedRatio
end
