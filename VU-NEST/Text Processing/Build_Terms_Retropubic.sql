--Nest mesh sling Notes

--Retropubic category:

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_retropubic;

select *
into Nest.mesh_notes_detail_retropubic
from
(
			SELECT 'Retropubic' as Category, 'retropubic'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%retropubic%'
	UNION	SELECT 'Retropubic' as Category, 'retropubal_mid'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%retropubal midurethral%'
	UNION	SELECT 'Retropubic' as Category, 'rmus'						as Term, * FROM dbo.Note WHERE (note_text COLLATE Latin1_General_CS_AS like '% RMUS %')
	UNION	SELECT 'Retropubic' as Category, 'abd_incision'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%abdominal incision%'
	UNION	SELECT 'Retropubic' as Category, 'pubic_symphysis'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%pubic symphysis%'
	UNION	SELECT 'Retropubic' as Category, 'retro_mus'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%retro-mus%'
	UNION	SELECT 'Retropubic' as Category, 'trocar_retro_vag'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%trocar passed retropubically from the vagina%'
	UNION	SELECT 'Retropubic' as Category, 'two_abd_incisions'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%two small abdominal incisions%'
	UNION	SELECT 'Retropubic' as Category, 'above_pubic_bone'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%above the pubic bone%'
	UNION	SELECT 'Retropubic' as Category, 'space_retzius'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%space of retzius%'
	UNION	SELECT 'Retropubic' as Category, 'post_wall_pubic_symph'	as Term, * FROM dbo.Note WHERE lower(note_text) like '%posterior wall of pubic symphysis %'
	UNION	SELECT 'Retropubic' as Category, 'supra_skin incision'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%suprapubic skin incision%'
	UNION	SELECT 'Retropubic' as Category, 'top_down'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%top down approach%'
	UNION	SELECT 'Retropubic' as Category, 'sparc'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%sparc%'
	UNION	SELECT 'Retropubic' as Category, 'bottom_up'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%bottom up approach%'
	UNION	SELECT 'Retropubic' as Category, 'retro_space'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%retropubic space%'
	UNION	SELECT 'Retropubic' as Category, 'retzius_space'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%retzius space%'
	UNION	SELECT 'Retropubic' as Category, 'urogenital_tri'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%urogenital triangle%'
	UNION	SELECT 'Retropubic' as Category, 'endopelvic_fasc'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%endopelvic fascia%'
	UNION	SELECT 'Retropubic' as Category, 'bladder_neck'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%bladder neck%'
) U --end main select into
;

--(36120 row(s) affected) on 2021_0224 in 00:17


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Retropubic;
GO

select
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, case
		When N.Person_ID is not null 
		then count(distinct note_id)
		else 0
	  end as Retropubic_Notes_Count

	, sum(case term when 'retropubic'				then 1 else 0 end) as Retropubic_retropubic
	, sum(case term when 'retropubal_mid'			then 1 else 0 end) as Retropubic_retropubal_mid
	, sum(case term when 'rmus'						then 1 else 0 end) as Retropubic_rmus
	, sum(case term when 'abd_incision'				then 1 else 0 end) as Retropubic_abd_incision
	, sum(case term when 'pubic_symphysis'			then 1 else 0 end) as Retropubic_pubic_symphysis
	, sum(case term when 'retro_mus'				then 1 else 0 end) as Retropubic_retro_mus
	, sum(case term when 'trocar_retro_vag'			then 1 else 0 end) as Retropubic_trocar_retro_vag
	, sum(case term when 'two_abd_incisions'		then 1 else 0 end) as Retropubic_two_abd_incisions							  
	, sum(case term when 'above_pubic_bone'			then 1 else 0 end) as Retropubic_above_pubic_bone
	, sum(case term when 'space_retzius'			then 1 else 0 end) as Retropubic_space_retzius
	, sum(case term when 'post_wall_pubic_symph'	then 1 else 0 end) as Retropubic_post_wall_pubic_symph
	, sum(case term when 'supra_skin_incision'		then 1 else 0 end) as Retropubic_supra_skin_incision
	, sum(case term when 'top_down'					then 1 else 0 end) as Retropubic_top_down
	, sum(case term when 'sparc'					then 1 else 0 end) as Retropubic_sparc
	, sum(case term when 'bottom_up'				then 1 else 0 end) as Retropubic_bottom_up
	, sum(case term when 'retro_space'				then 1 else 0 end) as Retropubic_retro_space
	, sum(case term when 'retzius_space'			then 1 else 0 end) as Retropubic_retzius_space
	, sum(case term when 'urogenital_tri'			then 1 else 0 end) as Retropubic_urogenital_tri
	, sum(case term when 'endopelvic_fasc'			then 1 else 0 end) as Retropubic_endopelvic_fasc
	, sum(case term when 'bladder_neck'				then 1 else 0 end) as Retropubic_bladder_neck		
into
	Nest.Mesh_Terms_Retropubic
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_retropubic as N
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