/*
  this is sample code that can be used to insert, update, or delete records in batches 
  typically, sql server works best in ~5k record transactions, this number may vary depending on what you're doing, so feel free to experiment
*/

drop table if exists #RecordsToIterateOver


DECLARE @BatchSize INT = 5000 /* default of 5k, this can be tweaked depending on what's being done */

/*
  the following are several example of how to populate the temp table #RecordsToIterateOver
  in the examples i'm only grabbing something to uniquely identify each record, if additional data is needed for the process this is probably where you'd include it
*/

  
/*
  id to iterate over already exists
*/
select 
  ID
into #RecordsToIterateOver
from dbo.[Table]


/*
  create an id using row_number()
*/
select 
  row_number() over (order by [column]) as ID
into #RecordsToIterateOver
from dbo.[Table]


declare @i bit = 1 /*used to deterime if the loop needs to keep going*/

  
/*
  iterate over records
*/
while (@i)
begin
  drop table if exists #BatchRecords

  /*get the next batch of records to process*/
  select top (@BatchSize) 
    ID
  into #BatchRecords
  from #RecordsToIterateOver

  /*
    put processing code here, typically an insert, update, or delete statement, but could be more complicated depending on needs
  */


  /*
    delete the records that were just processed
  */
  delete from #RecordsToIterateOver
  where ID in
  (
    select ID
    from #BatchRecords
  )
  
  /*determine if the loop needs to terminate*/
  if not exists(select 1 from #RecordsToIterateOver)
  begin
    set @i = 0
  end
end
