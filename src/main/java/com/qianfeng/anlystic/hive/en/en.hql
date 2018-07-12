--先创建表
create external table if not exists ods_logs(
s_time string,
en string,
ver string,
u_ud string,
u_mid string,
u_sid string,
c_time string,
language  string,
b_iev string,
b_rst string,
p_url string,
p_ref string,
tt string,
pl string,
o_id string,
`on` string,
cut string,
cua string,
pt string,
ca string,
ac string,
kv_ string,
du string,
os string,
os_v string,
browser string,
browser_v string,
country string,
province string,
city string
)
partitioned by(month String,day string)
row format delimited fields terminated by '\001'
;

--加载数据
load data inpath '/ods/month=07/day=09' into table ods_logs partition(month=07,day=09);


--在原始表中抽取数据，放在dw层
create external table if not exists dw_event(
s_time string,
en string,
pl string,
ca string,
ac string
)
partitioned by(month String,day string)
row format delimited fields terminated by '\001'
;


from ods_logs
insert into table dw_event partition(month=07,day=09)
select s_time,en,pl,ca,ac;
