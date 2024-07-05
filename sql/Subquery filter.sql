SELECT
    wt.PK_ID,
    wt.BlobColumn,
    wt.AllTheColumns...
FROM dbo.WideTable wt
    INNER JOIN
    (
        SELECT
            PK_ID
        FROM dbo.WideTable
        WHERE IndexableColumn = 1
            AND AnotherIndexableColumn = 2
    ) wt_filter
        ON wt.PK_ID = wt_filter.PK_ID
