----Build note counts----


--Prerequisites--
/* 
Some assumptions about data sources for these scripts:

1) A dataset called dbo.person exists in your database,
and that table contains the columns Person_ID and Person_source_value.
(Person_ID is the OMOP patient identifier,
and Person_source_value is your source system patient identifier, such as MRN)

2) A dataset called dbo.note exists in your database, and that table contains the following columns: 
Person_ID, INDEX_SURGERY_DATE, VISIT_OCCURRENCE_ID, NOTE_ID, NOTE_DATE, NOTE_TITLE, and NOTE_TEXT.
(Person_ID is used to link to the dbo.person dataset)
*/


/*
Directly below, change 'RD_OMOP' to the name of the database where your Notes table is stored, and then Execute the two lines:

use RD_OMOP
GO
*/


/*
In the lines below, change 'U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0409' 
to the folder name where you copied the set of scripts
*/


/*
In SQL Server Management Studio, selecting SQLCMD mode is needed
(select 'Query' in menu, then select 'SQLCMD Mode'). 
Then select the lines below, and Execute.
*/


:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Note_Counts_Cohort.sql

:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Adjustable_Sling.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Bulking.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Burch.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Mesh_Sling.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_No_Mesh_Sling.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Retropubic.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Single_Incision.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Transobturator_In_Out.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Transobturator_Out_In.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Transobturator_Unknown.sql

:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Terms_Weighting.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Category_Sums.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Transob_Family_Logic.sql
:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Result_Mesh_and_Approach.sql

:r U:\NEST\Regex_Scripts\NEST_Mesh_Notes_Package_2021_0419\Build_Output.sql


