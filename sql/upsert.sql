https://sqlperformance.com/2020/09/locking/upsert-anti-pattern

BEGIN TRANSACTION;
  update dest WITH (UPDLOCK, SERIALIZABLE) 
      set dest.column = 'value'
  from dest
      left outer join src
          on dest.column = src.column
  where src.column is null;
  
  
  insert into dest
  (
      column
  )
  select
      src.column
  from src
      left outer join dest
          on src.column = dest.column
  where dest.pk_id is null;
COMMIT TRANSACTION;
