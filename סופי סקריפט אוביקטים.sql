USE [port]
GO
/****** Object:  UserDefinedFunction [dbo].[checkEnter]    Script Date: 18/03/2024 14:16:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢🚢---------------------------
----------------פונקצית בדיקת כניסה-----------------
CREATE function [dbo].[checkEnter](@boatid int)
returns int
as
begin
declare @x int, @y int, @w int,@m datetime,@r int
set @x=(select contentPort from definitions)
set @y=(select sum(content) from boats where boatid in
(select boatid from boats intersect select boatid from exits ))
set @w=(select content from boats where @boatid=boatId)
set @m=(select min(dateTimeEntry) from entrys where boatId=@boatid and dateTimePass is null)
-----בדיקת התאמת מעבר------
/*if exists(select dateTimepass from exits where dateTimepass>dateadd(hour,-1,getdate()))
begin
	return 0
end*/
----בדיקת התאמת קבולת----
if(@x-@y<@w)
begin
	return 0
end
----בדיקת התאמת כלים פנויים----
if exists
(select thisToolid from
(select amountAvaliable,toolId as thisToolid from tools)q1
join
(select amount,toolId from unLoadingTools join boats
on unLoadingTools.cargoId=boats.cargoId
where boatId=@boatid)q2
on q1.thisToolid=q2.toolId
where amountAvaliable-amount<0)
begin
	return 0
end
return 1
end
GO
/****** Object:  UserDefinedFunction [dbo].[importanceBoats2]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------פונקציית בדיקת חשיבות המחזירה טבלה------
----------------------פונקציות-----------------------------------------------------
CREATE function [dbo].[importanceBoats2](@importance int)
returns @importanceTable table (boatId int, importance int)
as
begin
insert into @importanceTable
select entrys.boatId ,importance from entrys join boats
on entrys.boatId=boats.boatId join cargos on boats.cargoId=cargos.cargoId
where importance+2<@importance and dateTimePass is null
return
end
GO
/****** Object:  View [dbo].[theBoat]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------

CREATE view [dbo].[theBoat]
As
select min(boatName) as 'boat name',min(cargoname) as 'cargo name',max(entrys.dateTimePass) as 'the last date '
,avg(datediff(day,entrys.datetimepass,exits.dateTimePass)) as 'זמן שהות באזור הנמל'
,count(*) as 'כמות הפעמים שעגנה בנמל'
from  cargos join  boats
on boats.cargoId=cargos.cargoId
left join entrys 
on boats.boatId=entrys.boatId
left join exits 
on boats.boatId=exits.boatId
group by boats.boatId
GO
/****** Object:  StoredProcedure [dbo].[enter]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------פורצדורות---------------
---------------בס"ד פורצדורת כניסה-----------------
CREATE procedure [dbo].[enter] (@boatId int) as 
begin
declare @thisBoatId int
declare @importance int
declare @count int
declare @countRow int
set @count=1
set @countRow=(select count(*) from dbo.importanceBoats2(@importance))
if(@countRow>1)
begin
set @importance=(select importance from cargos join boats on cargos.cargoId=boats.cargoId where boatId=@boatId)
set @thisBoatId=@boatId
set @boatId=(select b from
(select boatId as b,importance ,row_number() over(order by importance) as row 
from dbo.importanceBoats2(@importance))q1 where row=@count)
-----------בודק האם יש בספינה קודמת לו---------------
 while(@count<=@countRow and dbo.checkEnter(@boatId)=0 )
 begin
	  set @count=@count+1
	  set @boatId=(select b from 
	  (select boatId as b,importance ,row_number() over(order by importance ) as row
	  from dbo.importanceBoats2(@importance))q1 where row=@count)
end
 if(@count=@countRow)
begin
	set @boatId=@thisBoatId

end
else
 print 'ship '+cast(@boatId as varchar(10))+' was importance from you please try again soon '
 end
 if(dbo.checkEnter(@boatId)=1)
begin
  -------------הפעלת עדכונים בשל כניסת ספינה---------
  update entrys set dateTimePass=getdate() where dateTimePass is null 
  and boatId=@boatId
  insert into exits values(@boatId,dateadd(day,2,getdate()),null,0)
  declare crsTools cursor for  --------הפעלת פורצדורת עדכון כלים
  select toolId, amount from unLoadingTools join cargos 
  on unLoadingTools.cargoId=cargos.cargoId join boats
  on boats.cargoId=cargos.cargoId
  where boatId=@boatId
  open crsTools
  declare @s1 int
  declare @s2 int
  Fetch next from crsTools Into @s1,@s2
  While @@fetch_status=0
  begin
     exec updateToolsAvaliableMinus @s1, @s2
	 Fetch next from crsTools Into @s1,@s2
  end
  Close crsTools
  Deallocate crsTools
 end
 -----------------------
 else
   print 'you cant cross now please try again soon '
   --------
end



GO
/****** Object:  StoredProcedure [dbo].[exitProcedure]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------פרוצדורת יציאה-----------------------------
CREATE procedure [dbo].[exitProcedure] (@boatId int) as 
begin
if @boatId not in (select boatId from exits where dateTimePass is null)
begin
     print 'erore you dont...'
end
else
begin
--if exists(select dateTimepass from entrys where dateTimepass>dateadd(hour,-1,getdate()))
--begin
if 0 in  (select finishUnloading from exits where boatid=@boatid)
begin
	print 'you not finish unloding you cant exit now'
end
else
begin
	update  exits set dateTimePass=getdate() where dateTimePass is null 
	and boatId=@boatId
	declare @boatIdEnter int 
	set @boatIdEnter=(select top(1) boatId from entrys where dateTimePass is null and dateTimeEntry in (select min(dateTimeEntry) from entrys where dateTimePass is null))
   if @boatIdEnter is not null
   begin
   declare @c varchar(10)
   set @c=(select boatName from  boats where boatId=@boatIdEnter)
    print 'i try enter the ship '+cast(@boatIdEnter as varchar(10))+'-'+substring(@c,0,10)
     exec enter @boatIdEnter
   end
end
end
end
--end
GO
/****** Object:  StoredProcedure [dbo].[finishUnloading]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------פורצדורת סיום פריקה--------------------------------------------
CREATE procedure [dbo].[finishUnloading](@boatId int) as
begin
if 0  in (select finishUnloading from exits where boatId=@boatId)
begin
  declare crsTools cursor for  
  select toolId, amount from unLoadingTools join cargos 
  on unLoadingTools.cargoId=cargos.cargoId join boats
  on boats.cargoId=cargos.cargoId
  where boatId=@boatId
  open crsTools
  declare @s1 int
  declare @s2 int
  Fetch next from crsTools Into @s1,@s2
  While @@fetch_status=0
  begin
     exec updateToolsAvaliablePluss @s1, @s2
	 Fetch next from crsTools Into @s1,@s2
  end
  Close crsTools
  Deallocate crsTools
  update exits set finishUnloading=1 where boatId=@boatId
 end
 else 
 print'you cant finish unloading agin'
 end
GO
/****** Object:  StoredProcedure [dbo].[updateToolsAvaliable]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[updateToolsAvaliable](@toolId int, @amount int) as
begin
update tools set amountAvaliable=amountAvaliable-@amount
where toolId=@toolId
end
GO
/****** Object:  StoredProcedure [dbo].[updateToolsAvaliableMinus]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------בס"ד פורצדורת עדכון כלים----------------
CREATE procedure [dbo].[updateToolsAvaliableMinus](@toolId int, @amount int) as
begin
update tools set amountAvaliable=amountAvaliable-@amount
where toolId=@toolId
end
GO
/****** Object:  StoredProcedure [dbo].[updateToolsAvaliablePluss]    Script Date: 18/03/2024 14:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------פרוצדורת עדכון כלים-------------------------------------------------------
CREATE procedure [dbo].[updateToolsAvaliablePluss](@toolId int, @amount int) as
	begin
	update tools set amountAvaliable=amountAvaliable+@amount where  toolId=@toolId
	end
GO
