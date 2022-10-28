--Nest mesh sling Notes

--Transobturator Unknown category:

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_Transob_Unk;

select *
into Nest.mesh_notes_detail_Transob_Unk
from
(
			SELECT 'Transobturator_Unknown' as Category, 'transob_unk'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%transobturator unknown%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'transobturator'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%transobturator%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'to_sling'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%to sling%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'transob_sling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%transobturator sling%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'transob_tape'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%transobturator tape%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'clitoris'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%clitoris%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'groin_incision'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%groin incision%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'obturator_foramen'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%obturator foramen%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'exit_through_groin'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%exit through groin%'
	UNION	SELECT 'Transobturator_Unknown' as Category, 'transob_mus'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%transob-mus%'
) U --end main select into
;


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Transob_Unk;
GO

select
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count

	, case
		When N.Person_ID is not null 
		then count(distinct note_id)
		else 0
	  end 
	  as Transob_Unk_Notes_Count

	, sum(case term when 'transob_unk'				then 1 else 0 end)  as Transob_Unk_transob_unk		
	, sum(case term when 'transobturator'			then 1 else 0 end)  as Transob_Unk_transobturator	
	, sum(case term when 'to_sling'					then 1 else 0 end)  as Transob_Unk_to_sling			
	, sum(case term when 'transob_sling'			then 1 else 0 end)  as Transob_Unk_transob_sling
	, sum(case term when 'transob_tape'				then 1 else 0 end)  as Transob_Unk_transob_tape
	, sum(case term when 'clitoris'					then 1 else 0 end)  as Transob_Unk_clitoris		
	, sum(case term when 'groin_incision'			then 1 else 0 end)  as Transob_Unk_groin_incision
	, sum(case term when 'obturator_foramen'		then 1 else 0 end)  as Transob_Unk_obturator_foramen
	, sum(case term when 'exit_through_groin'		then 1 else 0 end)  as Transob_Unk_exit_through_groin
	, sum(case term when 'transob_mus'				then 1 else 0 end)  as Transob_Unk_transob_mus

into
	Nest.Mesh_Terms_Transob_Unk
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_Transob_Unk as N
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