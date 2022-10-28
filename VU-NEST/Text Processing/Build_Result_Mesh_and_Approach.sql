--determine result for 'mesh/no mesh' and result for approach
/*
use RD_OMOP;
GO
*/


drop table if exists Nest.mesh_result_mesh_and_approach;
GO

with approach_pivot_row1 as
(
		select * from 
		(
		select
			person_id
			, index_surgery_date
			, Approach
			, value
			, row_number() over (partition by person_id order by value desc) as rownumber
		--FROM [Nest].[mesh_notes_output_by_category]
		FROM [Nest].[mesh_notes_output_by_term]
		cross apply
		(
		  select 'Retropubic', [Retropubic_Mentions_Count] union all
		  select 'Transob_Unk', [Transob_Unk_Fam_Mentions_Count] union all
		  select 'Transob_In_Out', [Transob_In_Out_Mentions_Count] union all
		  select 'Transob_Out_In', [Transob_Out_In_Mentions_Count] union all
		  select 'Sngl_Inc', [Sngl_Inc_Mentions_Count] union all
		  select 'Adj_sling', [Adj_sling_Mentions_Count] union all
		  select 'Burch', [Burch_Mentions_Count]
		) c(Approach,value)
		where person_id is not null
		) s
		where rownumber = 1
)

,approach_pivot_row2 as
(
		select * from 
		(
		select
			person_id
			, index_surgery_date
			, Approach
			, value
			, row_number() over (partition by person_id order by value desc) as rownumber
		--FROM [Nest].[mesh_notes_output_by_category]
		FROM [Nest].[mesh_notes_output_by_term]
		cross apply
		(
		  select 'Retropubic', [Retropubic_Mentions_Count] union all
		  select 'Transob_Unk', [Transob_Unk_Fam_Mentions_Count] union all
		  select 'Transob_In_Out', [Transob_In_Out_Mentions_Count] union all
		  select 'Transob_Out_In', [Transob_Out_In_Mentions_Count] union all
		  select 'Sngl_Inc', [Sngl_Inc_Mentions_Count] union all
		  select 'Adj_sling', [Adj_sling_Mentions_Count] union all
		  select 'Burch', [Burch_Mentions_Count]
		) c(Approach,value)
		where person_id is not null
		) s
		where rownumber = 2
)

SELECT 
	 R.Person_ID as Person_ID_
	 , R. Index_surgery_Date as Index_Surgery_Date_ 
	 , '' as REDCap_ID
	 , '' as Mesh_YN
	 , '' as Approach
	 , case
			when (Mesh_Sling_Mentions_Count + Adj_sling_Mentions_Count) > (No_Mesh_Sling_Mentions_Count + Bulking_Mentions_Count) 
			then 'Yes'

			when (Mesh_Sling_Mentions_Count + Adj_sling_Mentions_Count) < (No_Mesh_Sling_Mentions_Count + Bulking_Mentions_Count) 
			then 'No'

			else 'Indeterminate'
		end as REGEX_Mesh_YN

	  , case	
			when ar1.value > ar2.value then ar1.Approach
			when ar1.value < ar2.value then ar2.Approach	--this should never happen
			else 'Indeterminate'
		end as REGEX_Approach

	  , R.*
  into
	nest.mesh_result_mesh_and_approach
  from 
	nest.mesh_notes_output_by_term as R
	left join 
	approach_pivot_row1 as ar1
		on R.person_id = ar1.person_ID
	left join 
	approach_pivot_row2 as ar2
		on R.person_ID = ar2.person_ID
  where 
	R.person_id is not null
  order by 
	R.person_id
;


/*
Output:
select * from nest.mesh_result_mesh_and_approach order by person_id;
*/

