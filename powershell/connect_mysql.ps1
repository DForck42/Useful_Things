[void][Reflection.Assembly]::LoadWithPartialName('MySQL.Data')

$Credentials = [get them wherever they are stored, preferably something like Thycotic]
$MySQLUserName = $Credentials[0]
$MySQLPassword = $Credentials[1]

try
{
    $ConnectionString = "server=ServerName; user id=$MySQLUserName; password=$MySQLPassword;"

    $MySQLConnection = New-Object MySql.Data.MySqlClient.MySqlConnection
    $MySQLConnection.ConnectionString = $ConnectionString
    $MySQLConnection.Open()

    $MySQLCommand = New-Object MySql.Data.MySqlClient.MySqlCommand
    $MySQLCommand.Connection = $MySQLConnection
    $MySQLCommand.CommandText = "SELECT 1 as a" <# query to run #>

    $MySQLDataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
    $MySQLDataAdapter.SelectCommand = $MySQLCommand

    $MySQLDataSet = New-Object System.Data.DataSet

    $NumberOfRecords = $MySQLDataAdapter.Fill($MySQLDataSet, "data")
}
catch
{
  <# handle errors here #>
}
finally
{
    $MySQLConnection.Close()
}


$Credentials = $null
$MySQLUserName = $null
$MySQLPassword = $null
