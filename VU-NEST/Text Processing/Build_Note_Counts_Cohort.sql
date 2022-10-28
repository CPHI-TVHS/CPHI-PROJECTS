--Nest mesh sling Notes 

/*
use RD_OMOP;
GO
*/


drop table if exists Nest.mesh_patient_cohort;
GO

select
	N.PERSON_ID
	, P.person_source_value
	, N.INDEX_SURGERY_DATE
	, count (distinct N.note_ID) as Patient_Notes_Count
into
	Nest.mesh_patient_cohort
from
	dbo.Note as N
	join
	dbo.Person as P
		on N.PERSON_ID = P.person_id
group by
	N.PERSON_ID
	, P.person_source_value
	, N.INDEX_SURGERY_DATE
;