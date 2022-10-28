--Nest mesh sling Notes

--Mesh Sling category:

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_Mesh_Sling;

select *
into Nest.mesh_notes_detail_Mesh_Sling
from
(
			SELECT 'Mesh_Sling' as Category, 'synthetic'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%synthetic%'
	UNION	SELECT 'Mesh_Sling' as Category, 'implant'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%implant%' and lower(note_text) not like '%implanted%'
	UNION	SELECT 'Mesh_Sling' as Category, 'erosion'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%erosion%'
	UNION	SELECT 'Mesh_Sling' as Category, 'minisling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%minisling%'
	UNION	SELECT 'Mesh_Sling' as Category, 'minisling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%mini-sling%'
	UNION	SELECT 'Mesh_Sling' as Category, 'minisling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%mini sling%'
	UNION	SELECT 'Mesh_Sling' as Category, 'boston_scientific'	as Term, * FROM dbo.Note WHERE lower(note_text) like '%boston scientific%'
	UNION	SELECT 'Mesh_Sling' as Category, 'advantage_fit'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%advantage fit%'
	UNION	SELECT 'Mesh_Sling' as Category, 'mentor'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%mentor%'
	UNION	SELECT 'Mesh_Sling' as Category, 'caldera'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%caldera%'
	UNION	SELECT 'Mesh_Sling' as Category, 'desara_tv'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%desara tv%'
	UNION	SELECT 'Mesh_Sling' as Category, 'gmd_universal'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%gmd universal%'
	UNION	SELECT 'Mesh_Sling' as Category, 'lynx_suprapubic'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%lynx suprapubic%'
	UNION	SELECT 'Mesh_Sling' as Category, 'miniarc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%miniarc%'
	UNION	SELECT 'Mesh_Sling' as Category, 'miniarc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%mini-arc%'
	UNION	SELECT 'Mesh_Sling' as Category, 'monarc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%monarc%'
	UNION	SELECT 'Mesh_Sling' as Category, 'solyx'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%solyx%'
	UNION	SELECT 'Mesh_Sling' as Category, 'sparc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%sparc%'
	UNION	SELECT 'Mesh_Sling' as Category, 'gynecare'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%gynecare%'
	UNION	SELECT 'Mesh_Sling' as Category, 'tvt_o'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%tvt-o%'
	UNION	SELECT 'Mesh_Sling' as Category, 'obtryx'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%obtryx curved%'
	UNION	SELECT 'Mesh_Sling' as Category, 'obtryx'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%obtryx%'
	UNION	SELECT 'Mesh_Sling' as Category, 'obtryx'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%obtryx halo%'
	UNION	SELECT 'Mesh_Sling' as Category, 'tape'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%tape%'
	
) U --end main select into
;


--Patient level rollup------------------------------------------------------
drop table if exists Nest.mesh_terms_mesh_sling;
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
	  as Mesh_Sling_Notes_Count

	,    sum(case term when 'synthetic'				then 1 else 0 end)  as Mesh_Sling_synthetic
	,    sum(case term when 'implant'				then 1 else 0 end)  as Mesh_Sling_implant
	,    sum(case term when 'erosion'				then 1 else 0 end)	as Mesh_Sling_erosion
	,	 sum(case term when 'minisling'				then 1 else 0 end)  as Mesh_Sling_minisling
	,    sum(case term when 'boston_scientific'		then 1 else 0 end)  as Mesh_Sling_boston_scientific
	,    sum(case term when 'advantage_fit'			then 1 else 0 end)  as Mesh_Sling_advantage_fit
	,    sum(case term when 'mentor'				then 1 else 0 end)  as Mesh_Sling_mentor
	,    sum(case term when 'caldera'				then 1 else 0 end)  as Mesh_Sling_caldera
	,    sum(case term when 'desara_tv'				then 1 else 0 end)  as Mesh_Sling_desara_tv
	,    sum(case term when 'gmd_universal'			then 1 else 0 end)  as Mesh_Sling_gmd_universal
	,    sum(case term when 'lynx_suprapubic'		then 1 else 0 end)  as Mesh_Sling_lynx_suprapubic
	,    sum(case term when 'miniarc'				then 1 else 0 end)  as Mesh_Sling_miniarc
	,    sum(case term when 'monarc'				then 1 else 0 end)  as Mesh_Sling_monarc
	,    sum(case term when 'solyx'					then 1 else 0 end)  as Mesh_Sling_solyx
	,    sum(case term when 'sparc'					then 1 else 0 end)  as Mesh_Sling_sparc
	,    sum(case term when 'gynecare'				then 1 else 0 end)  as Mesh_Sling_gynecare
	,    sum(case term when 'tvt_o'					then 1 else 0 end)  as Mesh_Sling_tvt_o
	,    sum(case term when 'obtryx_curved'			then 1 else 0 end)  as Mesh_Sling_obtryx_curved
	,    sum(case term when 'obtryx'				then 1 else 0 end)  as Mesh_Sling_obtryx
	,    sum(case term when 'obtryx_halo'			then 1 else 0 end)  as Mesh_Sling_obtryx_halo
	,    sum(case term when 'tape'					then 1 else 0 end)  as Mesh_Sling_tape
into
	Nest.mesh_terms_mesh_sling
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_Mesh_Sling as N
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
