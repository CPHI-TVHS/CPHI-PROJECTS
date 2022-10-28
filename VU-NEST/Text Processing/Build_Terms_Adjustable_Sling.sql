--Nest mesh sling Notes

--Adj_sling category:

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_adj_sling;

select *
into Nest.mesh_notes_detail_adj_sling
from
(
		  SELECT 'Adjustable_Sling' as Category, 'adj_sling'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%adjustable sling%'
	UNION SELECT 'Adjustable_Sling' as Category, 'amus'					as Term, * FROM dbo.Note WHERE (note_text COLLATE Latin1_General_CS_AS like '% AMUS %')
	UNION SELECT 'Adjustable_Sling' as Category, 'removable_dev'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%removable device%'
	UNION SELECT 'Adjustable_Sling' as Category, 'tension_sling'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%tension the sling%'
	UNION SELECT 'Adjustable_Sling' as Category, 'remeex'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%remeex%'
	UNION SELECT 'Adjustable_Sling' as Category, 'varitensor'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%varitensor%'
	UNION SELECT 'Adjustable_Sling' as Category, 'neomedic'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%neomedic%'
	UNION SELECT 'Adjustable_Sling' as Category, 'vert_vag_incision'	as Term, * FROM dbo.Note WHERE lower(note_text) like '%vertical vaginal incision%'
	UNION SELECT 'Adjustable_Sling' as Category, 'diss_pubic_rami'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%dissection to pubic rami%'
	UNION SELECT 'Adjustable_Sling' as Category, 'polypropylene'		as Term, * FROM dbo.Note WHERE lower(note_text) like '%polypropylene%'
	UNION SELECT 'Adjustable_Sling' as Category, 'hypogastric_level'	as Term, * FROM dbo.Note WHERE lower(note_text) like '%hypogastric level%'
	UNION SELECT 'Adjustable_Sling' as Category, 'transvag_adj_tape'	as Term, * FROM dbo.Note WHERE lower(note_text) like '%transvaginal adjustable tape%'
	UNION SELECT 'Adjustable_Sling' as Category, 'ajust'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%ajust%'
) U --end main select into
;

--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Adj_Sling;
GO

select
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, case
		When N.Person_ID is not null 
		then count(distinct note_id)
		else 0
	  end as Adj_sling_Notes_Count

	, sum(case term when 'adj_sling'			then 1 else 0 end) as Adj_Sling_adj_sling		
	, sum(case term when 'amus'					then 1 else 0 end) as Adj_Sling_amus			
	, sum(case term when 'removable_dev'		then 1 else 0 end) as Adj_Sling_removable_dev
	, sum(case term when 'tension_sling'		then 1 else 0 end) as Adj_Sling_tension_sling	
	, sum(case term when 'remeex'				then 1 else 0 end) as Adj_Sling_remeex		
	, sum(case term when 'varitensor'			then 1 else 0 end) as Adj_Sling_varitensor		
	, sum(case term when 'neomedic'				then 1 else 0 end) as Adj_Sling_neomedic			
	, sum(case term when 'vert_vag_incision'	then 1 else 0 end) as Adj_Sling_vert_vag_incision	
	, sum(case term when 'diss_pubic_rami'		then 1 else 0 end) as Adj_Sling_diss_pubic_rami																		  
	, sum(case term when 'polypropylene'		then 1 else 0 end) as Adj_Sling_polypropylene	
	, sum(case term when 'hypogastric_level'	then 1 else 0 end) as Adj_Sling_hypogastric_level					
	, sum(case term when 'transvag_adj_tape'	then 1 else 0 end) as Adj_Sling_transvag_adj_tape	
	, sum(case term when 'ajust'				then 1 else 0 end) as Adj_Sling_ajust	
				
into
	Nest.Mesh_Terms_Adj_Sling
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_adj_sling as N
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