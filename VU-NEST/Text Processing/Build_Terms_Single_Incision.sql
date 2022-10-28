--Nest mesh sling Notes

--Single Incision category: 

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_Sngl_Inc;

select *
into Nest.mesh_notes_detail_Sngl_Inc
from
(
		  SELECT 'Sngl_Inc' as Category, 'mini_sling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%minisling%'
	UNION SELECT 'Sngl_Inc' as Category, 'mini_sling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%mini-sling%'
	UNION SELECT 'Sngl_Inc' as Category, 'mini_sling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%mini sling%'
	UNION SELECT 'Sngl_Inc' as Category, 'miniarc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%miniarc%'
	UNION SELECT 'Sngl_Inc' as Category, 'ajust'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%ajust%'
	UNION SELECT 'Sngl_Inc' as Category, 'solyx'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%solyx%'
	UNION SELECT 'Sngl_Inc' as Category, 'ophira'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%ophira%'
	UNION SELECT 'Sngl_Inc' as Category, 'miniarc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%mini arc%'
	UNION SELECT 'Sngl_Inc' as Category, 'miniarc'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%miniarc%'
	UNION SELECT 'Sngl_Inc' as Category, 'perm_anch'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%permanent anchor%'
	UNION SELECT 'Sngl_Inc' as Category, 'u_config'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%u configuration%'
	UNION SELECT 'Sngl_Inc' as Category, 'h_config'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%h configuration%'
	UNION SELECT 'Sngl_Inc' as Category, 'hammock_config'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%hammock configuration%'
	UNION SELECT 'Sngl_Inc' as Category, 'anch_urog_diaphragm'	as Term, * FROM dbo.Note WHERE lower(note_text) like '%anchored to urogenital diaphragm%'
	UNION SELECT 'Sngl_Inc' as Category, 'obtur_membrane'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%obturator membrane%'
	UNION SELECT 'Sngl_Inc' as Category, 'tvt_secur'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%tvt-secur%'
	UNION SELECT 'Sngl_Inc' as Category, 'minitapes'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%minitapes%'
	UNION SELECT 'Sngl_Inc' as Category, 'single_incision'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%single-incision sling%'
) U --end main select into
;


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Sngl_Inc;
GO

select
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, case
		When N.Person_ID is not null 
		then count(distinct note_id)
		else 0
	  end as Sngl_Inc_Notes_Count

	, sum(case term when 'mini_sling'				then 1 else 0 end) as Sngl_Inc_mini_sling
	, sum(case term when 'miniarc'					then 1 else 0 end) as Sngl_Inc_miniarc
	, sum(case term when 'ajust'					then 1 else 0 end) as Sngl_Inc_ajust
	, sum(case term when 'solyx'					then 1 else 0 end) as Sngl_Inc_solyx
	, sum(case term when 'ophira'					then 1 else 0 end) as Sngl_Inc_ophira
	, sum(case term when 'fixed_obtur'				then 1 else 0 end) as Sngl_Inc_fixed_obtur
	, sum(case term when 'perm_anch'				then 1 else 0 end) as Sngl_Inc_perm_anch
	, sum(case term when 'u_config'					then 1 else 0 end) as Sngl_Inc_u_config
	, sum(case term when 'h_config'					then 1 else 0 end) as Sngl_Inc_h_config
	, sum(case term when 'hammock_config'			then 1 else 0 end) as Sngl_Inc_hammock_config
	, sum(case term when 'anch_urog_diaphragm'		then 1 else 0 end) as Sngl_Inc_anch_urog_diaphragm
	, sum(case term when 'obtur_membrane'			then 1 else 0 end) as Sngl_Inc_obtur_membrane
	, sum(case term when 'tvt_secur'				then 1 else 0 end) as Sngl_Inc_tvt_secur
	, sum(case term when 'minitapes'				then 1 else 0 end) as Sngl_Inc_minitapes
into
	Nest.Mesh_Terms_Sngl_Inc
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_Sngl_Inc as N
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