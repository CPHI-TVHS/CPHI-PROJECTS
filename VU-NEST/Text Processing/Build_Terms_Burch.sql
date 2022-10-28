--Nest mesh sling Notes

--BURCH category: 

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_burch;

select *
into Nest.mesh_notes_detail_burch
from
(
		  SELECT 'Burch' as Category, 'burch' as Term, *					FROM dbo.Note WHERE lower(note_text) like '%burch%'
	UNION SELECT 'Burch' as Category, 'coloposuspension' as Term, *			FROM dbo.Note WHERE lower(note_text) like '%coloposuspension%'
	UNION SELECT 'Burch' as Category, 'dissection retropubic' as Term, *	FROM dbo.Note WHERE lower(note_text) like '%dissection of the retropubic space%'
	UNION SELECT 'Burch' as Category, 'fixation anterior' as Term, *		FROM dbo.Note WHERE lower(note_text) like '%fixation anterior vaginal wall endopelvic fascia %'
	UNION SELECT 'Burch' as Category, 'transabdominal' as Term, *			FROM dbo.Note WHERE lower(note_text) like '%transabdominal urethropexy%'
	UNION SELECT 'Burch' as Category, 'posterior periosteal' as Term, *		FROM dbo.Note WHERE lower(note_text) like '%posterior periosteal fascia%'
	UNION SELECT 'Burch' as Category, 'pectineal ligament' as Term, *		FROM dbo.Note WHERE lower(note_text) like '%pectineal ligament%'
	UNION SELECT 'Burch' as Category, 'coopers ligament' as Term, *			FROM dbo.Note WHERE lower(note_text) like '%cooper''s ligament%' --need apostrophe
	UNION SELECT 'Burch' as Category, 'low transverse incision' as Term, *	FROM dbo.Note WHERE lower(note_text) like '%low transverse incision%'
	UNION SELECT 'Burch' as Category, 'transabdominal colpo' as Term, *		FROM dbo.Note WHERE lower(note_text) like '%transabdominal colposuspension%'
	UNION SELECT 'Burch' as Category, 'open colpo' as Term, *				FROM dbo.Note WHERE lower(note_text) like '%open colpo%'
	UNION SELECT 'Burch' as Category, 'retropubic urethropexy' as Term, *	FROM dbo.Note WHERE lower(note_text) like '%retropubic urethropexy%'
	UNION SELECT 'Burch' as Category, 'retropubic colpo' as Term, *			FROM dbo.Note WHERE lower(note_text) like '%retropubic colposuspension%'
	UNION SELECT 'Burch' as Category, 'lap colpo' as Term, *				FROM dbo.Note WHERE lower(note_text) like '%lap colpo%'

) U --end main select into
;

--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Burch;
GO

select
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, case
		When N.Person_ID is not null 
		then count(distinct note_id)
		else 0
	  end as Burch_Notes_Count

	, sum(case term when 'burch'								then 1 else 0 end) as Burch_burch
	, sum(case term when 'coloposuspension'						then 1 else 0 end) as Burch_coloposuspension
	, sum(case term when 'issection retropubic'					then 1 else 0 end) as Burch_dissection_retropubic
	, sum(case term when 'fixation anterior'					then 1 else 0 end) as Burch_fixation_anterior
	, sum(case term when 'transabdominal'						then 1 else 0 end) as Burch_transabdominal_Ureth
	, sum(case term when 'posterior periosteal'					then 1 else 0 end) as Burch_posterior_periosteal
	, sum(case term when 'pectineal ligament'					then 1 else 0 end) as Burch_pectineal_ligament
	, sum(case term when 'coopers ligament'						then 1 else 0 end) as Burch_coopers_ligament
	, sum(case term when 'low transverse incision'				then 1 else 0 end) as Burch_low_transverse_incision
	, sum(case term when 'transabdominal colpo'					then 1 else 0 end) as Burch_transabdominal_colpo
	, sum(case term when 'low transveropen colpose incision'	then 1 else 0 end) as Burch_open_colpo
	, sum(case term when 'retropubic urethropexy'				then 1 else 0 end) as Burch_retropubic_urethropexy
	, sum(case term when 'retropubic colpo'						then 1 else 0 end) as Burch_retropubic_colpo
	, sum(case term when 'lap colpo'							then 1 else 0 end) as Burch_lap_colpo

into
	Nest.Mesh_Terms_Burch
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_burch as N
		on C.Person_ID = N.PERSON_ID
group by
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, N.Person_ID 
order by
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, N.Person_ID
;