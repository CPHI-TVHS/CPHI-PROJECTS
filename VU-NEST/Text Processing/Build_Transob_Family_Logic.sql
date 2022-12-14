--Add logic for transob 'family'--
/*
use RD_OMOP;
GO
*/


drop table if exists Nest.mesh_notes_output_by_category
GO

select * 
into nest.mesh_notes_output_by_category
from
(
SELECT distinct 
	    R.person_ID
	  , P.Person_Source_Value
      , R.index_surgery_date
      , R.Patient_Notes_Count
      , R.Mesh_Sling_Notes_Count
      , R.Mesh_Sling_Mentions_Count
      , R.No_Mesh_Sling_Notes_Count
      , R.No_Mesh_Sling_Mentions_Count
      , R.Retropubic_Notes_Count
      , R.Retropubic_Mentions_Count
      , R.Transob_Unk_Notes_Count
      , R.Transob_Unk_Mentions_Count

	  --Transobturator 'Family' logic
	  , case
			when (R.Transob_In_Out_Mentions_Count = 0 and R.Transob_Out_In_Mentions_Count = 0) 
			then R.Transob_Unk_Mentions_Count

			when (R.Transob_In_Out_Mentions_Count > 0 or R.Transob_Out_In_Mentions_Count > 0) 
			then 0

			when 
				R.Transob_In_Out_Mentions_Count > 0 
				and R.Transob_Out_In_Mentions_Count > 0 
				and (R.Transob_In_Out_Mentions_Count = R.Transob_Out_In_Mentions_Count) 
			then (R.Transob_In_Out_Mentions_Count + 1)
		end as Transob_Unk_Fam_Mentions_Count
		 
      , R.Transob_In_Out_Notes_Count
      , R.Transob_In_Out_Mentions_Count
      , R.Transob_Out_In_Notes_Count
      , R.Transob_Out_In_Mentions_Count
      , R.Sngl_Inc_Notes_Count
      , R.Sngl_Inc_Mentions_Count
      , R.Adj_sling_Notes_Count
      , R.Adj_sling_Mentions_Count
      , R.Burch_Notes_Count
      , R.Burch_Mentions_Count
      , R.Bulking_Notes_Count
      , R.Bulking_Mentions_Count
from 
	Nest.mesh_category_sums as R
	join 
	dbo.person as P
		on R.person_id = P.person_id
) sub
;


drop table if exists Nest.mesh_notes_output_by_term
GO

select * 
into nest.mesh_notes_output_by_term
from
(
SELECT 
	P.Person_Source_Value
	,R.*

	  --Transobturator 'Family' logic
	  , case
			when (R.Transob_In_Out_Mentions_Count = 0 and R.Transob_Out_In_Mentions_Count = 0) 
			then R.Transob_Unk_Mentions_Count

			when (R.Transob_In_Out_Mentions_Count > 0 or R.Transob_Out_In_Mentions_Count > 0) 
			then 0

			when 
				R.Transob_In_Out_Mentions_Count > 0 
				and R.Transob_Out_In_Mentions_Count > 0 
				and (R.Transob_In_Out_Mentions_Count = R.Transob_Out_In_Mentions_Count) 
			then (R.Transob_In_Out_Mentions_Count + 1)
		end as Transob_Unk_Fam_Mentions_Count

from 
	Nest.mesh_category_sums as R
	join 
	dbo.person as P
		on R.person_id = P.person_id
) sub
;
