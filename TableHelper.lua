function concatTables(targetTable, sourceTable)
    for _, v in ipairs(sourceTable) do table.insert(targetTable, v) end
end

function getTableSize(t)
    local count = 0
    if t ~= nil then for _ in pairs(t) do count = count + 1 end end
    return count
end
