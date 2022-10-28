--Nest mesh sling Notes

--No Mesh Sling category: 

/*
use RD_OMOP;
GO
*/

--Gather detail level note records------------------------------------------------------------
drop table if exists Nest.mesh_notes_detail_No_Mesh_Sling;

select *
into Nest.mesh_notes_detail_No_Mesh_Sling
from
(
			SELECT 'No_Mesh_Sling' as Category, 'no_mesh_sling'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%no mesh sling%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'autologous'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%autologous%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'fascial'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%fascial%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'cadaveric'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%cadaveric%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'porcine'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%porcine%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'allograft'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%allograft%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'pubovaginal'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%pubovaginal%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'xenograft'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%xenograft%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'graft'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%graft%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'abd_wall_fix'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%abdominal wall fixation%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'lyodura'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%lyodura%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'rectus_sheath'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%rectus sheath%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'bladder_neck'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%bladder neck%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'proximal_urethra'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%proximal urethra%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'harvest'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%harvest%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'urogenital_tri'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%urogenital triangle%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'endopelvic_fascia'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%endopelvic fascia%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'pereyra_needle'			as Term, * FROM dbo.Note WHERE lower(note_text) like '%pereyra needle%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'fascia_lata'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%fascia lata%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'tutoplast'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%tutoplast%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'alloderm'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%alloderm%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'repliform'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%repliform%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'axis'						as Term, * FROM dbo.Note WHERE lower(note_text) like '%axis%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'pelvisoft'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%pelvisoft%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'pelvilace'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%pelvilace%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'xenform'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%xenform%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'prolene'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%prolene%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'polypropylene'				as Term, * FROM dbo.Note WHERE lower(note_text) like '%polypropylene%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'gore_tex'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%gore-tex%'
	UNION	SELECT 'No_Mesh_Sling' as Category, 'mersilene'					as Term, * FROM dbo.Note WHERE lower(note_text) like '%mersilene%'
) U --end main select into
;


--Patient level rollup------------------------------------------------------
drop table if exists Nest.Mesh_Terms_No_Mesh_Sling;
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
	  as No_Mesh_Sling_Notes_Count

	, sum(case term when 'no_mesh_sling'		then 1 else 0 end) as No_Mesh_Sling_no_mesh_sling
	, sum(case term when 'autologous'			then 1 else 0 end) as No_Mesh_Sling_autologous
	, sum(case term when 'fascial'				then 1 else 0 end) as No_Mesh_Sling_fascial
	, sum(case term when 'cadaveric'			then 1 else 0 end) as No_Mesh_Sling_cadaveric
	, sum(case term when 'porcine'				then 1 else 0 end) as No_Mesh_Sling_porcine
	, sum(case term when 'allograft'			then 1 else 0 end) as No_Mesh_Sling_allograft
	, sum(case term when 'pubovaginal'			then 1 else 0 end) as No_Mesh_Sling_pubovaginal
	, sum(case term when 'xenograft'			then 1 else 0 end) as No_Mesh_Sling_xenograft
	, sum(case term when 'graft'				then 1 else 0 end) as No_Mesh_Sling_graft
	, sum(case term when 'abd_wall_fix'			then 1 else 0 end) as No_Mesh_Sling_abd_wall_fix						  
	, sum(case term when 'lyodura'				then 1 else 0 end) as No_Mesh_Sling_lyodura
	, sum(case term when 'rectus_sheath'		then 1 else 0 end) as No_Mesh_Sling_rectus_sheath
	, sum(case term when 'bladder_neck'			then 1 else 0 end) as No_Mesh_Sling_bladder_neck
	, sum(case term when 'proximal_urethra'		then 1 else 0 end) as No_Mesh_Sling_proximal_urethra
	, sum(case term when 'harvest'				then 1 else 0 end) as No_Mesh_Sling_harvest
	, sum(case term when 'urogenital_tri'		then 1 else 0 end) as No_Mesh_Sling_urogenital_tri
	, sum(case term when 'endopelvic_fascia'	then 1 else 0 end) as No_Mesh_Sling_endopelvic_fascia
	, sum(case term when 'pereyra_needle'		then 1 else 0 end) as No_Mesh_Sling_pereyra_needle
	, sum(case term when 'fascia_lata'			then 1 else 0 end) as No_Mesh_Sling_fascia_lata
	, sum(case term when 'tutoplast'			then 1 else 0 end) as No_Mesh_Sling_tutoplast
	, sum(case term when 'alloderm'				then 1 else 0 end) as No_Mesh_Sling_alloderm
	, sum(case term when 'repliform'			then 1 else 0 end) as No_Mesh_Sling_repliform						  
	, sum(case term when 'axis'					then 1 else 0 end) as No_Mesh_Sling_axis
	, sum(case term when 'pelvisoft'			then 1 else 0 end) as No_Mesh_Sling_pelvisoft
	, sum(case term when 'pelvilace'			then 1 else 0 end) as No_Mesh_Sling_pelvilace
	, sum(case term when 'xenform'				then 1 else 0 end) as No_Mesh_Sling_xenform
	, sum(case term when 'prolene'				then 1 else 0 end) as No_Mesh_Sling_prolene
	, sum(case term when 'polypropylene'		then 1 else 0 end) as No_Mesh_Sling_polypropylene
	, sum(case term when 'gore_tex'				then 1 else 0 end) as No_Mesh_Sling_gore_tex
	, sum(case term when 'mersilene'			then 1 else 0 end) as No_Mesh_Sling_mersilene
into
	Nest.Mesh_Terms_No_Mesh_Sling
from 
	Nest.mesh_patient_cohort as C
	left join
	Nest.mesh_notes_detail_No_Mesh_Sling as N
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
