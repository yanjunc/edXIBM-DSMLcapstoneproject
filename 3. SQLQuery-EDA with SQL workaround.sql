/*This SQL file is a workaround for the EDA with SQL lab.*/

/*Task 1 
Names of the unique launch sites in the space mission */
select distinct Launch_Site from dbo.Spacex$

/*Task 2
Display 5 records where launch sites begin with the string 'KSC'*/
select top 5 * from dbo.Spacex$ 
	where Launch_Site like '%KSC%'

/*Task 3
Display the total payload mass carried by boosters launched by NASA (CRS)*/
select sum(PAYLOAD_MASS__KG_) as TotalPayloadMass from dbo.SpaceX$ 
	where Customer = 'NASA (CRS)'

/*Task 4
Display average payload mass carried by booster version F9 v1.1 */
select avg(PAYLOAD_MASS__KG_) as AveragePayloadMass from dbo.SpaceX$ 
	where Booster_Version = 'F9 v1.1'

/*Task 5
List the date where the first succesful landing outcome in drone ship was acheived.*/
select min(Date) as SuccessLandingOutcome from dbo.Spacex$ 
	where [Landing _Outcome] = 'Success (drone ship)'

/*Task 6¶
List the names of the boosters which have success in ground pad and have payload mass greater than 4000 but less than 6000*/
Select Booster_Version from dbo.Spacex$ 
	where [Landing _Outcome] = 'Success (ground pad)' AND Payload_MASS__KG_ > 4000 AND Payload_MASS__KG_ < 6000

/*Task 7
List the total number of successful and failure mission outcomes*/
Select
	(Select Count(Mission_Outcome) from dbo.Spacex$ where Mission_Outcome LIKE '%Success%') as Successful_Mission_Outcomes,
	(Select Count(Mission_Outcome) from dbo.Spacex$ where Mission_Outcome LIKE '%Failure%') as Failure_Mission_Outcomes

/*Task 8
List the names of the booster_versions which have carried the maximum payload mass. Use a subquery*/
Select distinct Booster_Version, MAX(PAYLOAD_MASS__KG_) as [Maximum Payload Mass] 
	from dbo.Spacex$ group by Booster_Version order by [Maximum Payload Mass] desc

/*Task 9
List the records which will display the month names, succesful landing_outcomes in ground pad ,booster versions, launch_site for the months in year 2017*/
Select 
	DateName(month, DateAdd(month, MONTH(CONVERT(date,Date, 105)), 0 ) - 1 )  as Month, 
	Booster_Version, Launch_Site, [Landing _Outcome] from dbo.Spacex$ 
		where  ([Landing _Outcome] = 'Success (ground pad)') and YEAR(CONVERT(date,Date, 105)) = '2017'

/*Task 10
Rank the count of successful landing_outcomes between the date 2010-06-04 and 2017-03-20 in descending order*/
Select Date, Booster_Version, Launch_site, [Landing _Outcome] from dbo.Spacex$ 
	where [Landing _Outcome] like '%Success%' and Date between '2010-06-04' and '2017-03-20' order by Date desc
