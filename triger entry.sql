--------------פורצדורות---------------

---------------בס"ד פורצדורת כניסה-----------------
Create procedure enter (@boatId int) as 
begin
declare @thisBoatId int
declare @importance int
declare @count int
declare @countRow int
set @count=1
set @countRow=(select count(*) from dbo.importanceBoats2(@importance))
set @importance=(select importance from cargos join boats on cargos.cargoId=boats.cargoId where boatId=@boatId)
set @thisBoatId=@boatId
set @boatId=(select top (@count) b from
(select boatId,importance as b,row_number() over(order by importance desc) as row from dbo.importanceBoats2(@importance))q1)
-----------בודק האם יש בספינה קודמת לו---------------
 while(@count<=@countRow and dbo.checkEnter(@boatId)=0 )
 begin
	  set @count=@count+1
	  set @boatId=(select top (@count) b from
	  (select boatId,importance as b,row_number() over(order by importance desc) as row
	  from dbo.importanceBoats2(@importance))q1)
 end
 if(@count>@countRow)
	set @boatId=@thisBoatId
 if(dbo.checkEnter(@boatId)=1)
	begin
  -------------הפעלת עדכונים בשל כניסת ספינה---------
  insert into exits values(@boatId,)
  update entrys set dateTimePass=getdate()
  declare crsTools cursor for  --------הפעלת פורצדורת עדכון כלים
  select toolId, amount from unLoadingTools join cargos 
  on unLoadingTools.cargoId=cargos.cargoId join boats
  on boats.cargoId=cargos.cargoId
  where boatId=@boatId
  open crsTools
  declare @s1 int
  declare @s2 int
  Fetch next from crs Into @s1,@s2
  While @@fetch_status=0
  begin
     exec updateToolsAvaliableMinus @s1, @s2
	 Fetch next from crs Into @s1,@s2
  end
  Close crsTools
  Deallocate crsTools
 end
end
go
---------------בס"ד פורצדורת עדכון כלים----------------
create procedure updateToolsAvaliableMinus(@toolId int, @amount int) as
begin
update tools set amountAvaliable=amountAvaliable-@amount
where toolId=@toolId
end
go
---------------פונקציית בדיקת חשיבות המחזירה טבלה------
----------------------פונקציות-----------------------------------------------------
alter function importanceBoats2(@importance int)
returns @importanceTable table (boatId int, importance int)
as
begin
insert into @importanceTable
select entrys.boatId ,importance from entrys join boats
on entrys.boatId=boats.boatId join cargos on boats.cargoId=cargos.cargoId
where importance+3<@importance 
return
end
go
--------------------🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢---------------------------
----------------פונקצית בדיקת כניסה-----------------
alter function checkEnter(@boatid int)
returns int
as
begin
declare @x int, @y int, @w int,@m datetime,@r int
set @x=(select contentPort from definitions)
set @y=(select sum(content) from boats join exits on boats.boatId=exits.boatId)
set @w=(select content from boats where @boatid=boatId)
set @m=(select dateTimeEntry from entrys where boatId=@boatid)
-----בדיקת התאמת מעבר------
if(dateadd(hour,-1,getdate())<=(select dateTimepass from exits))
	return 0
----בדיקת התאמת קבולת----
if(@x-@y<@w)
	return 0
----בדיקת התאמת כלים פנויים----
if exists
(select amountAvaliable from tools where amountAvaliable <
(select amount from unLoadingTools join boats
on unLoadingTools.cargoId=boats.cargoId
where boatId=@boatid))
	return 0
return 1
end
go
-----------פורצדורת סיום פריקה--------------------------------------------
create procedure finishUnloading(@boatId int) as
begin
  declare crsTools cursor for  
  select toolId, amount from unLoadingTools join cargos 
  on unLoadingTools.cargoId=cargos.cargoId join boats
  on boats.cargoId=cargos.cargoId
  where boatId=@boatId
  open crsTools
  declare @s1 int
  declare @s2 int
  Fetch next from crs Into @s1,@s2
  While @@fetch_status=0
  begin
     exec updateToolsAvaliablePluss @s1, @s2
	 Fetch next from crs Into @s1,@s2
  end
  Close crsTools
  Deallocate crsTools
 end
 go

-----------------פרוצדורת עדכון כלים-------------------------------------------------------
create procedure updateToolsAvaliablePluss(@toolId int, @amount int) as
	begin
	update tools set amountAvaliable=amountAvaliable+@amount where  toolId=@toolId
	end
	go
--------------פרוצדורת יציאה-----------------------------------------
Create procedure exitProcedure (@boatId int) as 
begin
if(dateadd(hour,-1,getdate())>(select dateTimepass from entrys))
begin
	update  exits set dateTimePass=getdate()
	declare @boatIdEnter int 
	set @boatIdEnter=(select boatId from entrys where dateTimeEntry in (select min(dateTimeEntry) from entrys))
	exec enter @boatIdEnter
end
end
go
----------------טריגר יציאה------------------------------------------------------------------------------------------
create trigger tExit on exits 
for insert
as
if insert dateTimePass and (select finishUnloading from exits)=0
begin
    print 'you not finish unloading'
	rollback transaction
end

--------------------------------------------------------
create view tableBoat
select 