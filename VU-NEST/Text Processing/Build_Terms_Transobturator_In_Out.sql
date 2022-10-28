--Nest mesh sling Notes

--Tranobturator In/Out Unknown category: 

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_Transob_In_Out;

select *
into Nest.mesh_notes_detail_Transob_In_Out
from
(
			SELECT 'Transobturator_In_Out' as Category, 'transob_in_out'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%transobturator in/out%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'tvt_o'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%tvt-o%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'tot_o'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%tot-o%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'in_to_out'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%in- to- out%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'in_to_out'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%in-to-out%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'vag_periurethral_diss'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%vaginal periurethral dissections to the skin%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'inside_out'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%inside-out%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'helical_passers'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%helical passers%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'vagina_to_groin'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%vagina to the groin%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'winged_guide'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%winged guide%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'wing_guide'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%wing guide%'
	UNION	SELECT 'Transobturator_In_Out' as Category, 'hugging_inf_pub_ramus'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%hugging inferior pubic ramus%'
) U --end main select into
;


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Transob_In_Out;
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
	  as Transob_In_Out_Notes_Count

	, sum(case term when 'transob_in_out'			then 1 else 0 end) as Transob_In_Out_transob_in_out
	, sum(case term when 'tvt_o'					then 1 else 0 end) as Transob_In_Out_tvt_o
	, sum(case term when 'tot_o'					then 1 else 0 end) as Transob_In_Out_tot_o
	, sum(case term when 'in_to_out'				then 1 else 0 end) as Transob_In_Out_in_to_out
	, sum(case term when 'vag_periurethral_diss'	then 1 else 0 end) as Transob_In_Out_vag_periurethral_diss
	, sum(case term when 'inside_out'				then 1 else 0 end) as Transob_In_Out_inside_out
	, sum(case term when 'helical_passers'			then 1 else 0 end) as Transob_In_Out_helical_passers
	, sum(case term when 'vagina_to_groin'			then 1 else 0 end) as Transob_In_Out_vagina_to_groin
	, sum(case term when 'winged_guide'				then 1 else 0 end) as Transob_In_Out_winged_guide
	, sum(case term when 'wing_guide'				then 1 else 0 end) as Transob_In_Out_wing_guide
	, sum(case term when 'hugging_inf_pub_ramus'	then 1 else 0 end) as Transob_In_Out_hugging_inf_pub_ramus
into
	Nest.Mesh_Terms_Transob_In_Out
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_Transob_In_Out as N
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