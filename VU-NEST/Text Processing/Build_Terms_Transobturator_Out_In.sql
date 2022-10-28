--Nest mesh sling Notes

--Tranobturator Out/In category:

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_Transob_Out_In;

select *
into Nest.mesh_notes_detail_Transob_Out_In
from
(
			SELECT 'Transobturator_Out_In' as Category, 'transob_out_in'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%transobturator out/in%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'monarc'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%monarc%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'tot'							as Term, * FROM dbo.Note WHERE (note_text COLLATE Latin1_General_CS_AS like '%TOT%' and lower(note_text) not like '%tot-o%')
	UNION	SELECT 'Transobturator_Out_In' as Category, 'out_to_in'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%out- to- in%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'out_to_in'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%out-to-in%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'genitofemoral_folds'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%genitofemoral folds%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'lateral_to_vagina'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%from skin laterally to vagina%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'through_ob_foramen'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%passage through the obturator foramen%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'groin_to_vagina'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%outside of groin into vagina%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'outside_in'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%outside-in%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'ischio_ramus'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%ischiopubic ramus%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'exit_through_vagina'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%exit through vagina%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'finger_introduced'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%finger introduced into the tract%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'groin_to_vagina'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%groin to the vagina%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'behind_inf_pubic_ramus'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%behind inferior pubic ramus%'
	UNION	SELECT 'Transobturator_Out_In' as Category, 'post_to_add_longus_ten'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%posterior to adductor longus tendon%'
) U --end main select into
;


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Transob_Out_In;
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
	  as Transob_Out_In_Notes_Count

	, sum(case term when 'transob_out_in'				then 1 else 0 end) as Transob_Out_In_transob_out_in
	, sum(case term when 'monarc'						then 1 else 0 end) as Transob_Out_In_monarc
	, sum(case term when 'tot'							then 1 else 0 end) as Transob_Out_In_tot
	, sum(case term when 'out_to_in'					then 1 else 0 end) as Transob_Out_In_out_to_in
	, sum(case term when 'genitofemoral_folds'			then 1 else 0 end) as Transob_Out_In_genitofemoral_folds
	, sum(case term when 'lateral_to_vagina'			then 1 else 0 end) as Transob_Out_In_lateral_to_vagina
	, sum(case term when 'through_ob_foramen'			then 1 else 0 end) as Transob_Out_In_through_ob_foramen
	, sum(case term when 'outside_in'					then 1 else 0 end) as Transob_Out_In_outside_in
	, sum(case term when 'ischio_ramus'					then 1 else 0 end) as Transob_Out_In_ischio_ramus
	, sum(case term when 'exit_through_vagina'			then 1 else 0 end) as Transob_Out_In_exit_through_vagina
	, sum(case term when 'finger_introduced'			then 1 else 0 end) as Transob_Out_In_finger_introduced
	, sum(case term when 'groin_to_vagina'				then 1 else 0 end) as Transob_Out_In_groin_to_vagina
	, sum(case term when 'behind_inf_pubic_ramus'		then 1 else 0 end) as Transob_Out_In_behind_inf_pubic_ramus
	, sum(case term when 'post_to_add_longus_ten'		then 1 else 0 end) as Transob_Out_In_post_to_add_longus_ten
into
	Nest.Mesh_Terms_Transob_Out_In
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_Transob_Out_In as N
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