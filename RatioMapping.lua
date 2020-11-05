require 'MathRound'

ratioMapping = {
    ['0.5'] = '9:16',
    ['0.6'] = '2:3',
    ['0.7'] = '3:4',
    ['1'] = '1:1',
    ['1.3'] = '4:3',
    ['1.5'] = '3:2',
    ['1.6'] = '16:10',
    ['1.8'] = '16:9'
}

function getRatioMapping(nummericAspectRatio)
    return ratioMapping[tostring(round(nummericAspectRatio, 1))]
end