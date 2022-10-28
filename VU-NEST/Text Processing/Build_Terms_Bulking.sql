--Nest mesh sling Notes 

--BULKING category: 

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_bulking;

select *
into Nest.mesh_notes_detail_bulking
from
(	
		  SELECT 'Bulking' as Category, 'bulking' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%bulking%'
	UNION SELECT 'Bulking' as Category, 'uba' as Term, *									FROM dbo.Note WHERE lower(note_text) like '%uba%'
	UNION SELECT 'Bulking' as Category, 'urethral bulking' as Term, *						FROM dbo.Note WHERE lower(note_text) like '%urethral bulking%'
	UNION SELECT 'Bulking' as Category, 'particulate uba' as Term, *						FROM dbo.Note WHERE lower(note_text) like '%particulate uba%'
	UNION SELECT 'Bulking' as Category, 'macroplastique' as Term, *							FROM dbo.Note WHERE lower(note_text) like '%macroplastique%'
	UNION SELECT 'Bulking' as Category, 'durasphere' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%durasphere%'
	UNION SELECT 'Bulking' as Category, 'non particulate uba' as Term, *					FROM dbo.Note WHERE lower(note_text) like '%non-particulate uba%'
	UNION SELECT 'Bulking' as Category, 'non particulate uba' as Term, *					FROM dbo.Note WHERE lower(note_text) like '%non particulate uba%'
	UNION SELECT 'Bulking' as Category, 'polyacrylamide hydrogel' as Term, *				FROM dbo.Note WHERE lower(note_text) like '%polyacrylamide hydrogel%'
	UNION SELECT 'Bulking' as Category, 'bulkamid' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%bulkamid%'
	UNION SELECT 'Bulking' as Category, 'coaptite' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%coaptite%'
	UNION SELECT 'Bulking' as Category, 'silicone polymer' as Term, *						FROM dbo.Note WHERE lower(note_text) like '%silicone polymer%'
	UNION SELECT 'Bulking' as Category, 'calcium hydroxylapatite' as Term, *				FROM dbo.Note WHERE lower(note_text) like '%calcium hydroxylapatite%'
	UNION SELECT 'Bulking' as Category, 'deflux' as Term, *									FROM dbo.Note WHERE lower(note_text) like '%deflux%'
	UNION SELECT 'Bulking' as Category, 'contigen' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%contigen%'
	UNION SELECT 'Bulking' as Category, 'tegress' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%tegress%'
	UNION SELECT 'Bulking' as Category, 'permacol' as Term, *								FROM dbo.Note WHERE lower(note_text) like '%permacol%'
	UNION SELECT 'Bulking' as Category, 'zuidex' as Term, *									FROM dbo.Note WHERE lower(note_text) like '%zuidex%'
	UNION SELECT 'Bulking' as Category, 'polytef' as Term, *								FROM dbo.Note where lower(note_text) like '%polytef%'
	UNION SELECT 'Bulking' as Category, 'bovine collagen' as Term, *						FROM dbo.Note where lower(note_text) like '%bovine collagen%'
	UNION SELECT 'Bulking' as Category, 'porcine dermal collagen' as Term, *				FROM dbo.Note where lower(note_text) like '%porcine dermal collagen%'
	UNION SELECT 'Bulking' as Category, 'silicone particles' as Term, *						FROM dbo.Note where lower(note_text) like '%silicone particles%'
	UNION SELECT 'Bulking' as Category, 'carbon coated beads' as Term, *					FROM dbo.Note where lower(note_text) like '%carbon-coated beads%'
	UNION SELECT 'Bulking' as Category, 'carbon coated beads' as Term, *					FROM dbo.Note where lower(note_text) like '%carbon coated beads%'
	UNION SELECT 'Bulking' as Category, 'dextranomer hyaluronic acid compound' as Term, *	FROM dbo.Note where lower(note_text) like '%dextranomer-hyaluronic acid compound%'
	UNION SELECT 'Bulking' as Category, 'dextranomer hyaluronic acid compound' as Term, *	FROM dbo.Note where lower(note_text) like '%dextranomer hyaluronic acid compounds%'
	UNION SELECT 'Bulking' as Category, 'polytetraflouroethylene' as Term, *				FROM dbo.Note where lower(note_text) like '%polytetraflouroethylene%'
	UNION SELECT 'Bulking' as Category, 'ethylene vinyl alcohol' as Term, *					FROM dbo.Note where lower(note_text) like '%ethylene vinyl alcohol%'
	UNION SELECT 'Bulking' as Category, 'autologous fat' as Term, *							FROM dbo.Note where lower(note_text) like '%autologous fat%'
	UNION SELECT 'Bulking' as Category, 'uryx' as Term, *									FROM dbo.Note where lower(note_text) like '%uryx%'
	UNION SELECT 'Bulking' as Category, 'botox' as Term, *									FROM dbo.Note where lower(note_text) like '%botox%'

) U --end main select into
;

--(9326 row(s) affected) on 2021_0219 in 00:21


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_Bulking;
GO

select
	C.PERSON_ID
	, C.index_surgery_date
	, C.Patient_Notes_Count
	, case
		When N.Person_ID is not null 
		then count(distinct note_id)
		else 0
	  end as Bulking_Notes_Count

	, sum(case term when 'bulking'								then 1 else 0 end) as Bulking_bulking
	, sum(case term when 'coaptite'								then 1 else 0 end) as Bulking_coaptite
	, sum(case term when 'durasphere'							then 1 else 0 end) as Bulking_durasphere
	, sum(case term when 'macroplastique'						then 1 else 0 end) as Bulking_macroplastique
	, sum(case term when 'uba'									then 1 else 0 end) as Bulking_uba
	, sum(case term when 'urethral bulking'						then 1 else 0 end) as Bulking_urethral_bulking
	, sum(case term when 'particulate uba'						then 1 else 0 end) as Bulking_particulate_uba
	, sum(case term when 'non-particulate uba'					then 1 else 0 end) as Bulking_non_particulate_uba
	, sum(case term when 'polyacrylamide hydrogel'				then 1 else 0 end) as Bulking_polyacrylamide_hydrogel
	, sum(case term when 'bulkamid'								then 1 else 0 end) as Bulking_bulkamid
	, sum(case term when 'silicone polymer'						then 1 else 0 end) as Bulking_silicone_polymer
	, sum(case term when 'calcium hydroxylapatite'				then 1 else 0 end) as Bulking_calcium_hydroxylapatite
	, sum(case term when 'deflux'								then 1 else 0 end) as Bulking_deflux
	, sum(case term when 'contigen'								then 1 else 0 end) as Bulking_contigen
	, sum(case term when 'tegress'								then 1 else 0 end) as Bulking_tegress
	, sum(case term when 'permacol'								then 1 else 0 end) as Bulking_permacol
	, sum(case term when 'zuidex'								then 1 else 0 end) as Bulking_zuidex
	, sum(case term when 'polytef'								then 1 else 0 end) as Bulking_polytef
	, sum(case term when 'bovine collagen'						then 1 else 0 end) as Bulking_bovine_collagen
	, sum(case term when 'porcine dermal collagen'				then 1 else 0 end) as Bulking_porcine_dermal_collagen
	, sum(case term when 'silicone particles'					then 1 else 0 end) as Bulking_silicone_particles
	, sum(case term when 'carbon coated beads'					then 1 else 0 end) as Bulking_carbon_coated_beads
	, sum(case term when 'polytetraflouroethylene'				then 1 else 0 end) as Bulking_polytetraflouroethylene
	, sum(case term when 'ethylene vinyl alcohol'				then 1 else 0 end) as Bulking_ethylene_vinyl_alcohol
	, sum(case term when 'autologous fat'						then 1 else 0 end) as Bulking_autologous_fat
	, sum(case term when 'uryx'									then 1 else 0 end) as Bulking_uryx
	, sum(case term when 'dextranomer hyaluronic acid compound' then 1 else 0 end) as Bulking_Dex_hyal_acid_comp
	, sum(case term when 'botox'								then 1 else 0 end) as Bulking_Botox
into
	Nest.Mesh_Terms_Bulking
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_bulking as N
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