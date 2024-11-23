CREATE OR REPLACE TABLE CRASHES AS
(SELECT 
 CRASH_RECORD_ID
,TO_DATE(TRY_TO_TIMESTAMP(CRASH_DATE, 'MM/DD/YYYY HH12:MI:SS AM')) AS CRASH_DATE 
,TO_TIME(TRY_TO_TIMESTAMP(CRASH_DATE, 'MM/DD/YYYY HH12:MI:SS AM')) AS CRASH_TIME
,WEATHER_CONDITION
,LIGHTING_CONDITION
,CRASH_TYPE AS CAR_INJURY
,DAMAGE
,CASE 
WHEN PRIM_CONTRIBUTORY_CAUSE IN ('UNABLE TO DETERMINE','NOT APPLICABLE') THEN SEC_CONTRIBUTORY_CAUSE
ELSE PRIM_CONTRIBUTORY_CAUSE
END AS CRASH_CAUSE
,TRY_CAST(STREET_NO AS INTEGER) AS STREET_NUMBER
,STREET_DIRECTION
,STREET_NAME
,MOST_SEVERE_INJURY
,TRY_CAST(INJURIES_TOTAL AS INTEGER) AS INJURIES_TOTAL
,TRY_CAST(INJURIES_FATAL AS INTEGER) AS INJURIES_FATAL
,TRY_CAST(INJURIES_INCAPACITATING AS INTEGER) AS INJURIES_INCAPACITATING
,TRY_CAST(INJURIES_NON_INCAPACITATING AS INTEGER) AS INJURIES_NON_INCAPACITATING
,TRY_CAST(CRASH_HOUR AS INTEGER) AS CRASH_HOUR
,TRY_CAST(CRASH_DAY_OF_WEEK AS INTEGER) AS CRASH_DAY_OF_WEEK
,TRY_CAST(CRASH_MONTH AS INTEGER) AS CRASH_MONTH
,CASE 
WHEN CRASH_MONTH IN ('12','1','2') THEN 'WINTER'
WHEN CRASH_MONTH IN ('3','4','5') THEN 'SPRING'
WHEN CRASH_MONTH IN ('6','7','8') THEN 'SUMMER'
WHEN CRASH_MONTH IN ('9','10','11') THEN 'AUTUMN'
END AS SEASON
,LATITUDE
,LONGITUDE
,LOCATION
FROM CRASHES_CRASHES
WHERE EXTRACT(YEAR FROM TRY_TO_TIMESTAMP(CRASH_DATE, 'MM/DD/YYYY HH12:MI:SS AM')) = 2023)
;