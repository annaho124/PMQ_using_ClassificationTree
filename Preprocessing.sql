''' Convert data type of date_time column into datetime2 '''
update data_X
set
date_time = cast(date_time as datetime2)

update proposal.dbo.data_Y
set
date_time = cast(date_time as datetime2)

''' Split data in date_time column into year, month, day, hour to merge data in attribute column and 
join with table data_Y'''
ALTER TABLE data_X
ADD
YYYY int,
MM int,
DD int,
HH int

update data_X
set
YYYY = year(date_time),
MM = month(date_time),
DD = day(date_time),
HH = datepart(hour, date_time)

ALTER TABLE data_Y
ADD
YYYY int,
MM int,
DD int,
HH int

update data_Y
set
YYYY = year(date_time),
MM = month(date_time),
DD = day(date_time),
HH = datepart(hour, date_time)

''' Get the average value of T1,... T5 by using average value of (T_1_1, T_1_2, T_1_3),... (T_5_1, T_5_2, T_5_3)
respectively'''
'''alter table data_X
ADD
T1 INT,
T2 INT,
T3 INT,
T4 INT,
T5 INT

update data_X
set
T1 = cast(T1 as float),
T2 = cast(T2 as float),
T3 = cast(T3 as float),
T4 = cast(T4 as float),
T5 = cast(T5 as float) '''

alter table data_X
ADD
T1 float,
T2 float,
T3 float,
T4 float,
T5 float

update data_X
set
T1 = (T_data_1_1 + T_data_1_2 + T_data_1_3)/3,
T2 = (T_data_2_1 + T_data_2_2 + T_data_2_3)/3,
T3 = (T_data_3_1 + T_data_3_2 + T_data_3_3)/3,
T4 = (T_data_4_1 + T_data_4_2 + T_data_4_3)/3,
T5 = (T_data_5_1 + T_data_5_2 + T_data_5_3)/3

''' Drop column '''
alter table data_X
drop column
T_data_1_1, T_data_1_2, T_data_1_3,
T_data_2_1, T_data_2_2, T_data_2_3,
T_data_3_1, T_data_3_2, T_data_3_3,
T_data_4_1, T_data_4_2, T_data_4_3,
T_data_5_1, T_data_5_2, T_data_5_3

''' Split data train, test  and joining with data_Y to get the quality value'''
'''with training_data(YYYY, MM, DD, HH, AH_data, H_data, T1_hour, T2_hour, T3_hour, T4_hour, T5_hour)
as
(select 
YYYY, MM, DD, HH,
AH_data, H_data,
avg(T1) as T1_hour, 
avg(T2) as T2_hour, 
avg(T3) as T3_hour, 
avg(T4) as T4_hour, 
avg(T5) as T5_hour
from proposal.dbo.data_X
where YYYY = '2015'
and MM in (1,2,3,4,5,6,7)
group by YYYY, MM, DD, HH)

select a.YYYY, a.MM, a.DD, a.HH, a.AH, a.H, a.T1_hour, 
a.T2_hour, a.T3_hour, a.T4_hour, a.T5_hour, b.quality
from training_data a
join proposal.dbo.data_Y b
on a.YYYY = b.YYYY
and a.MM = b.MM
and a.DD = b.DD
and a.HH = b.HH '''

''' Merge data T1,..T5 group by hour and split the train, test data'''
use proposal
select 
YYYY, MM, DD, HH,
AH_data, H_data,
T1, T2, T3, T4, T5
into dtrain
from data_X
where YYYY = '2015'
and MM in (1,2,3,4,5,6,7)

use proposal
select 
YYYY, MM, DD, HH,
AH_data, H_data,
T1, T2, T3, T4, T5
into dtest
from data_X
where YYYY = '2015'
and MM in (8,9,10,11,12)

select 
YYYY, MM, DD, HH,
avg(T1) as T1_hour,
avg(T2) as T2_hour,
avg(T3) as T3_hour,
avg(T4) as T4_hour,
avg(T5) as T5_hour,
avg(H_data) as H_hour,
avg(AH_data) as AH_hour
into training_data
from dtrain
group by YYYY, MM, DD, HH
order by YYYY, MM, DD, HH

select 
YYYY, MM, DD, HH,
avg(T1) as T1_hour,
avg(T2) as T2_hour,
avg(T3) as T3_hour,
avg(T4) as T4_hour,
avg(T5) as T5_hour,
avg(H_data) as H_hour,
avg(AH_data) as AH_hour
into test_data
from dtest
group by YYYY, MM, DD, HH
order by YYYY, MM, DD, HH

drop table dtrain

drop table dtest

''' Joining with data_Y to get the quality'''
select a.YYYY, a.MM, a.DD,
a.HH, a.AH_hour, a.H_hour,
a.T1_hour, a.T2_hour,
a.T3_hour, a.T4_hour,
a.T5_hour, b.quality
into training_dataXY
from training_data a
inner join data_Y b
on a.YYYY = b.YYYY
and a.MM = b.MM
and a.DD = b.DD
and a.HH = b.HH

select a.YYYY, a.MM, a.DD,
a.HH, a.AH_hour, a.H_hour,
a.T1_hour, a.T2_hour,
a.T3_hour, a.T4_hour,
a.T5_hour, b.quality
into test_dataXY
from test_data a
inner join data_Y b
on a.YYYY = b.YYYY
and a.MM = b.MM
and a.DD = b.DD
and a.HH = b.HH

''' Rounding the value in columns'''
update proposal.dbo.training_dataXY
set
AH_hour = round(AH_hour, 3),
H_hour = round(H_hour, 3),
T1_hour = round(T1_hour, 3),
T2_hour = round(T2_hour, 3),
T3_hour = round(T3_hour, 3),
T4_hour = round(T4_hour, 3),
T5_hour = round(T5_hour, 3)

update proposal.dbo.test_dataXY
set
AH_hour = round(AH_hour, 3),
H_hour = round(H_hour, 3),
T1_hour = round(T1_hour, 3),
T2_hour = round(T2_hour, 3),
T3_hour = round(T3_hour, 3),
T4_hour = round(T4_hour, 3),
T5_hour = round(T5_hour, 3)