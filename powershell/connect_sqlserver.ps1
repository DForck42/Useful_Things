<#
  simple invocation
#>

Invoke-SQLCmd


<#
  need to pass in a data table
#>

try
{
    $sqlConnection = new-object System.Data.SqlClient.SqlConnection
    $sqlConnection.ConnectionString = "Server=ServerName; Database=DBName; Trusted_Connection=True; Connect Timeout=60; MultiSubnetFailover=true;"
    $sqlConnection.Open()
        
    $sqlCommand = new-object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    $sqlCommand.CommandText = "dbo.Insert_Data"
    $sqlCommand.CommandType = [System.Data.CommandType]::StoredProcedure
    $sqlCommand.CommandTimeout = 60
    $sqlCommand.Parameters.Add("@Results", [System.Data.SqlDbType]::Structured).value = $DataTable
    

    $tbl = New-Object System.Data.DataTable
    $sqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $sqlAdapter.SelectCommand = $sqlCommand


    [void]$sqlAdapter.Fill($tbl)
}
catch
{
    Write-Host -ForegroundColor Red "An error occurred trying to pass results to the sp dbo.Insert_DAta"
    Write-Error $_.Exception.Message
}
finally
{
    $sqlConnection.Close()
}
