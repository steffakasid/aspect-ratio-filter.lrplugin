function concatTables(targetTable, sourceTable)
    for _, v in ipairs(sourceTable) do table.insert(targetTable, v) end
end