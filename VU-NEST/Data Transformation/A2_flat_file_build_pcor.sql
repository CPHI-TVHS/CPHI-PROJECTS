/*******************************************************
Using PCOR. schema for PCOR table name. can search and replace schema

*SEPERATE MED FILE (Temp_drug_class.sql) BUILD REQUIRED FIRST* 
	USES ##temp_drug_class table on line 1788

Lab build starts at line 1041
Main build starts at line 1610
Final build starts at line 1830

***************** 12/10/2020 changes **********************
1. line 57; Remove 57220 CPT
2. line 535; Remove 70.51 ICD
3. line 1780; Smoking logic change in WHERE clause
4. line 1911; Menopause logic change; > 51 at time of surgery then default menopause to 1

********************************************************/
if OBJECT_ID('tempdb..##Temp_Drug_class') IS NULL
CREATE TABLE ##Temp_Appendix_Import
(
	Class_name varchar(40)
	, rxnorm_cui varchar(100)
)
GO
;

/**********************************************************
Import Appendix from Data Dictionary
**********************************************************/

if OBJECT_ID('tempdb..#Temp_Appendix_Import') IS NOT NULL drop table #Temp_Appendix_Import
CREATE TABLE #Temp_Appendix_Import
(
	Category varchar(40)
	, Descriptive varchar(100)
	, CodeType varchar(100)
	, Code varchar(100)
);

INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','SLING','CPT4','57288');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','LAP_SLING','CPT4','51992');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','57287'); --Suggest not use for index (useful for reoperation) 10/12/2020
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51845');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51990');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51715');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51840');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51841');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51845');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51990');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','51992');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53440');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53442');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53444');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53445');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53446');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53447');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53448');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53449');
--INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','53500');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','58267'); --Suggest add 10/12/2020
--INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','NON_SLING','CPT4','57220'); --Suggest add 10/12/2020

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD9CM','V61.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD10CM','Z64.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD9CM','V61.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD10CM','Z64.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','SNOMED','364325004');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','SNOMED','452221000000100');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','SNOMED','440681000000102');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','LOINC','11977-6');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD9CM','627.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD10CM','N95.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD9CM','256.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD10CM','E28.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD9CM','627.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Women’s Health History','ICD10CM','N95.0');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation','CPT4','57287');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation','CPT4','10120');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD9CM','459.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD9CM','998.11');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD9CM','623.8');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD9CM','596.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD10CM','R58');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD10CM','N99.820');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Hemorrhage/Bleeding','ICD10CM','N99.821');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD9CM','956.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10CM','S84.10XA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD9CM','956.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10CM','S74.8X9A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD9CM','956.8');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD9CM','956.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S30');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S31');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S32');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S33');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S34');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S35');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S36');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S37');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S38');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Nerve Injury','ICD10CM','S39');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Pain','ICD9CM','338.21'); 
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Pain','ICD10CM','G89.21');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Pain','ICD9CM','338.28'); 
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Pain','ICD9CM','338.29');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Pain','ICD10CM','G89.28');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Pain','ICD10CM','R10.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Mesh Exposure and erosion','ICD9CM','629.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Mesh Exposure and erosion','ICD9CM','629.32');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Mesh Exposure and erosion','ICD10CM','T83.711');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Mesh Exposure and erosion','ICD10CM','T83.721');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urinary Retention','CPT4','53500');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urinary Retention','ICD9CM','788.20');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urinary Retention','ICD9CM','788.21');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10CM','R33.8');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10CM','R33.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urgency of Urination','ICD9CM','788.63');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urgency of Urination','ICD10CM','R39.15');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urgency of Urination','ICD10CM','R33.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urg Incontinence','ICD9CM','788.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Urg Incontinence','ICD10CM','N39.41');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Bowel Injury','ICD9CM','569.83');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Bowel Injury','ICD10CM','S36');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Bladder/Urethral injury','ICD9CM','596.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Bladder/Urethral injury','ICD9CM','867.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Bladder/Urethral injury','ICD10CM','S37');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Infection','ICD9CM','686.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Infection','ICD9CM','998.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Infection','ICD9CM','999.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Infection','ICD9CM','998.51');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Infection','ICD9CM','998.59');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Infection','ICD10CM','T81');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD9CM','568.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Retropublic hematoma','ICD10CM','K66.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Retropublic hematoma','ICD9CM','568.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Retropublic hematoma','ICD9CM','459.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10PCS','0TPD07Z');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10PCS','0TPD0JZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10PCS','0TPD0KZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10PCS','0TWD07Z');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10PCS','0TWD0JZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Indication','ICD10PCS','0TWD0KZ');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','ICD9CM','625.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','ICD9CM','788.33');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','ICD10CM','N39.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','ICD10CM','N39.46');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51715');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','ICD9Proc','59.72');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','ICD10PCS','3E0K3GC'); 
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51990');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51992');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51999');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51840');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51841');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51845');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','57220');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Re-Operation/Recurrent SUI','CPT4','51800');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Removal','CPT4','57287');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Removal','CPT4','57295');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD9CM','625.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','R10.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD9CM','338.29');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','G89.29');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD9CM','789.09');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','R10.30');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD9CM','338.28');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','G89.28');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD9CM','625.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','N94.10');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','N94.12');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','N94.11');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Chronic Pain','ICD10CM','N94.19');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.41');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','596.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','598.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','598.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','598.8');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','598.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','599.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','599.69');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.21');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.29');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.61');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.62');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.65');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','CPT4','51701');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','CPT4','51702');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N32.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','SNOMED','762262008');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','599.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','590.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','625.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','599.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.33');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.34');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.35');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.36');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.37');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.38');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD9CM','788.39');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N36.42');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','R32');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.41');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.46');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.42');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.43');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.44');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.45');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.490');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Voiding symptoms','ICD10CM','N39.498');

INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.01');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.02');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.03');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.84');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.04');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.05');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.00');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.09');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.7');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.83');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.10');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.11');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.12');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N99.3');

INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','CPT4','51715');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD9Proc','59.72');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD10PCS','3E0K3GC');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD10PCS','3E0K4GC');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','CPT4','51990');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','CPT4','51992');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD9Proc','59.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD9Proc','59.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD10PCS','0TSD0ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD10PCS','0TSD4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','CPT4','51841');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','CPT4','51840');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','CPT4','51845');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD10PCS','0TSC0ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','SUI without Mesh','ICD10PCS','0TSC4ZZ');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','939.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','939.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.39');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.59');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.65');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.69');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.7');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.76');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.79');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','939.0');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','629.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','629.32');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','996.76');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','V58.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','998.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD9CM','778.2');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T83.498A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T85.698A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T85.79XA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T83.598A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T85.79XA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T85.9XXA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T83.89XA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T85.898A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T19.0XXA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T19.2XXA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T19.9XXA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Mesh Erosion','ICD10CM','T83.721S');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Urethral Fistula','ICD9CM','599.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Urethral Fistula','ICD10CM','N36.0');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T83.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10PCS','30233N1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10PCS','30233P1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10PCS','30233H1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T81.49XA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T81.40XS');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T81.41');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T81.43');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T83.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T83.6');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','R33.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Exclusion','Surgical Complication','ICD9CM','629.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Exclusion','Surgical Complication','ICD9CM','629.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Exclusion','Surgical Complication','ICD9CM','629.32');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD9CM','599.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','N36.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T83.711');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Complication','ICD10CM','T83.721');

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Prior Abdominal Surgery','ICD10CM','V15.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Prior Abdominal Surgery','ICD10CM','Z92.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Prior Abdominal Surgery','ICD10CM','N30.4');

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','00846');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','00855');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','00944');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','01962');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','01963');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','01969');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45126');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','51597');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','51925');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','56308');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58150');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58152');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58180');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58200');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58205');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58210');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58240');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58260');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58262');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58263');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58265');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58267');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58270');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58275');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58280');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','68.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10CM','Z90.711');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','00850');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59500');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59501');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59520');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59521');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59540');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59541');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9CM','649.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10CM','O75.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44950');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44955');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44960');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44970');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49315');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','56315');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9CM','V45.79');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10CM','Z90.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49505');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49507');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49520');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49521');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49525');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49550');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49553');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49555');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49557');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49560');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49561');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49565');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49566');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49570');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49572');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49585');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49587');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49590');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49650');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49651');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49652');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49653');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49654');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49655');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49656');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49657');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49659');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','53.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0WQF0ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0WQF3ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0WQF4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47562');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47563');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47564');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47600');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47605');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47610');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47612');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','47620');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','51.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','51.04');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FT40ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44139');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44140');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44204');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44205');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44206');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44141');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44143');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44144');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44145');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44146');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44147');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44150');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44151');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44157');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44158');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44160');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44320');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44322');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44799');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45110');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45111');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45112');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45113');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45114');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45119');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45120');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45121');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45123');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44204');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44205');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44206');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44207');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44208');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44210');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44211');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44212');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44213');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44238');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45395');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','45397');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','45.8');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','45.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','45.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','45.83');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DTE4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DTE0ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DTE7ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DTE8ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44108');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','44005');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58660');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58740');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','53500');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','54.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','54.51');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','54.59');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DN84ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DNE4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DNJ4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DNU4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DNV4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0DNW4ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN04ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN44ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN48ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN54ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN64ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN74ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN84ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FN94ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0FNG8ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58661');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','49321-51');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58940');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9CM','V45.77');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10CM','Z90.722');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10CM','Z90.721');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','43631');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','43632');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','43633');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','43634');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9CM','V45.75');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10CM','Z90.3');

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58285');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58290'); 
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58291');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58292');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58293');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58294');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58541');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58542');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58543');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58544');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58548');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58550');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58552');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58553');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58554');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58570');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58571');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58572');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58573');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58575');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58951');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58953');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','58954');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59135');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59525');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59560');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59561');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59580');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','59581');

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','57260-51');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','57282');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','57267');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','57270');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','57240');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','CPT4','61809');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','70.50');
--INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','70.51');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD9Proc','70.52');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0JQC0ZZ');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Concomitant surgical procedures','ICD10PCS','0JQC3ZZ');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','996.69');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','T85.79XA');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','567.22');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','K65.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','614.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','N73.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','614.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','616.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','N73.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','614.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','N73.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','614.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','N73.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','N73.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD9CM','682.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Surgical Site Infection','ICD10CM','L02.215');

INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.712');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.712A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.712D');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.712S');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.722');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.722A');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.722D');
INSERT INTO #Temp_Appendix_Import VALUES ('Outcome','Organ Mesh Perforation (vagina, urinary tract)','ICD10CM','T83.722S');

INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','CPT4','57260');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','CPT4','57240');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','CPT4','57268');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.0');

INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.10');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.11');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.12');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N81.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Pelvic Organ Prolapse Repair Surgery Plus Mesh Urinary Sling','ICD10CM','N99.3');

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Urodynamic Testing','CPT4','51741');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Urodynamic Testing','CPT4','51729');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Urodynamic Testing','CPT4','51784');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Urodynamic Testing','CPT4','51785');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Urodynamic Testing','CPT4','51797');	

INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57288');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','51992');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.53');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.54');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.55');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.63');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.64');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.78');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.93');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.94'); 
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.95'); 
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57267');

INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Surgical Route','ICD9Proc','59.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Surgical Route','ICD9Proc','59.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Surgical Route','ICD9Proc','59.71');
INSERT INTO #Temp_Appendix_Import VALUES ('Covariate','Surgical Route','ICD9Proc','59.79');

INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','45560');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57240');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57250');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57265');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57260');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57260');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57268');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57120');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57282');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57283');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57267');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57289');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57287');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','57295');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','58400');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','58410');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','58270');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','58293');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','CPT4','58294');

INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','625.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','599.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.32');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.33');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.34');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.35');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.36');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.37');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.38');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD9CM','788.39');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N36.42');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','R32');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.41');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.46');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.42');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.43');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.44');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.45');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.490');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Urinary incontinence','ICD10CM','N39.4');

INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.01');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.02');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.03');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.84');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.04');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD9CM','618.05');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.09');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.7');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.83');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD9CM','618.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.11');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.12');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.82');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N99.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.85');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Diagnoses','Prolapse','ICD10CM','N81.81');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.83');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N88.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.84');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.89');
INSERT INTO #Temp_Appendix_Import VALUES ('Condition','Prolapse','ICD10CM','N81.9');

INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.53');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','69.2');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.77');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.78');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.8');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.92');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.93');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','70.95');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.3');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.39');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.4');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.49');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.6');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.69');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.59');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.7');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.79');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.31');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.41');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.51');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.61');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.71');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.9');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.5');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.51');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.59');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.7');
INSERT INTO #Temp_Appendix_Import VALUES ('Exposure','Procedure','ICD9Proc','68.79');

INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','Surgery Indication','CPT4','57288');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','Surgery Indication','CPT4','57287');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','Surgery Indication','CPT4','51992');

INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','Urethral Divericulum','ICD9CM','619.0');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','Urethral Divericulum','ICD9CM','599.1');
INSERT INTO #Temp_Appendix_Import VALUES ('Inc/Excl','Urethral Divericulum','ICD9CM','599.2');


INSERT INTO #Temp_Appendix_Import VALUES('Outcome','PostProceduralPain','SNOMED','225908003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','102447009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','123756000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','161541000119104');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','161788002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','198436008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','203453001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','21237001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','21801002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','266607004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','266677000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','301783004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','31351009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','32369003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','32590007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','403319002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','403325003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','403389006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','408386002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','68811000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','76498008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','76742009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','Menopause','SNOMED','84788008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','106281000119103');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','10753491000119101');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','10754881000119104');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','110141000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','111552007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','11530004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','11687002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','120731000119103');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','127013003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','127014009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','138881000119106');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','138891000119109');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','138911000119106');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','138921000119104');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','1501000119109');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','1521000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','1531000119102');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','1551000119108');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','161445009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','171183004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','190330002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','190331003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','190368000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','190388001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','190389009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','190416008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','193489006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','197605007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','199223000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','199225007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','199226008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','199228009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','199229001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','199230006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','201724008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','23045005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','232020009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','236500003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','237599002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','237633009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','25093002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','28032008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','312912001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','313435000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','313436004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','314893005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','314903002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','314904008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','359642000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','367991000119101');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','368051000119109');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','368601000119102');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','368711000119106');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','368741000119105');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','39181008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','395204000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','399864000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','40791000119105');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','419100001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420270002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420279001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420436000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420486006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420514000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420662003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420715001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420756003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420789003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420825003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420868002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','420918009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421075007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421305000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421326000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421365002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421437000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421468001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421631007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421725003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421750000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421847006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421893009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421895002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','421920002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422014003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422034002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422088007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422099009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422126006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422166005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','422275004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','426705001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','426875007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','426907004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','427027005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','427134009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','427571000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','427943001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','428007007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','428896009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','43959009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','44054006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','443694000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','444073006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','46635009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','46894009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','472971004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','4855003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','49817004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','5368009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','59276001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','609563008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','609564002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','609567009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','60961000119107');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','60971000119101');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','704144000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','712882000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','712883005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','713702000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','713703005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','713704004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','713705003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','713706002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','71771000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','719216001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','72021000119109');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','73211009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','739681000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','75022004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','76751001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','769217008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','769218003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','771000119108');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','81531005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','82541000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','82571000119107');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','84371000119108');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','8801005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','97331000119101');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryDM','SNOMED','9859006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','CPT4','4050F');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','CPT4','61322');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','CPT4','61323');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','DRG','304');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','DRG','305');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','104931000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','10725009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','11399002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','1201005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','123799005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','129161000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','14973001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','153811000119105');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','160357008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','161501007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','162659009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','169465000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','171222001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','194783001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','194785008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','194788005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','194791005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198941007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198942000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198944004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198945003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198946002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198947006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198949009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198965005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198966006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198997005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','198999008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','199000005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','199002002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','199005000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','199008003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','206596003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','23130000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','233815004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','233947005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','233950008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','234072000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','234075003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','237279007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','24042004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','276792008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','276794009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','28119000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','288250001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','31992008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','34742003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','360578005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','367390009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','371125006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','371622005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','37618003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','40521000119100');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','417312002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','4210003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','423674003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','426012001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','429198000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','472790001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','48146000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','48194001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','52698002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','56218007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','57684003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','59621000');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','67359005');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','68267002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','697898008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','697910001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','697930002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','70272006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','70995007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','73410007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','75150001');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','78975002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','82771000119102');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','86041002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','8762007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','88223008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHTN','SNOMED','89242004');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryCAD','SNOMED','233844002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryCAD','SNOMED','371803003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryCAD','SNOMED','371804009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryCAD','SNOMED','428375006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryPVD','SNOMED','400047006');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryPVD','SNOMED','428171009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','129589009');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','190774002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','238040008');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','267434003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','268552003');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','299465007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','402474007');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','402727002');
INSERT INTO #Temp_Appendix_Import VALUES('Covariates','PreSurgeryHLD','SNOMED','55822004');


--------------------------------------------------------------------->Cohort
/**********************************************************
MAIN COHORT BUILD
**********************************************************/


	if OBJECT_ID('tempdb..#MESH_SLING') IS NOT NULL drop table #MESH_SLING
	SELECT patid as person_id
	, admit_date as procedure_date
	INTO #MESH_SLING
	FROM V_procedures a
	WHERE px in 
	(
	'57288', '51992', '57287', '51845', '51990', '51715', '51840','51841','51845','51990','51992','53440','53442','53444','53445','53446','53447','53448','53449'
	)
	and raw_px_type = 'CPT4'
	GROUP BY patid
	, admit_date;


/********************************************************** Medication
Medication class list build

1. get all parent child relationship from ATC 4th Level grouping
**********************************************************/


/********************************************************** Medication
Medication class list build

2. Get the top 50 medication class of ATC 4th Level grouping
**********************************************************/



/********************************************************** LABS
LAB GROUPING BUILD
**********************************************************/

if OBJECT_ID('tempdb..#LabTests_LOINC_Key') IS NOT NULL drop table #LabTests_LOINC_Key  
CREATE TABLE #LabTests_LOINC_Key(
	LabTestID int NOT NULL,
	ActiveVersionNumber int NOT NULL,		
	Description varchar(250) NULL,
	LabTestAbbr varchar(50) NOT NULL UNIQUE );

if OBJECT_ID('tempdb..#LabTests_LOINC_Codes') IS NOT NULL drop table #LabTests_LOINC_Codes  
CREATE TABLE #LabTests_LOINC_Codes(
	LabTestID int NOT NULL,
	VersionNumber int NOT NULL,
	CodeValue varchar(50) NOT NULL
);

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(1,1,'Creatinine, Blood Serum Plasma, Point, mg/dLS Units','Creat_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (1, 1, N'21232-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (1, 1, N'35203-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (1, 1, N'2160-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (1, 1, N'38483-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(2,1,'Creatinine, Blood Serum Plasma, Point, mmol/L Units','Creat_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (2, 1, N'77140-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (2, 1, N'35203-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (2, 1, N'59826-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (2, 1, N'14682-9');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(3,1,'Potassium, Blood Serum Plasma, Point, mmol/L Units','K_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'2824-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'32713-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'41656-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'39789-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'39790-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'77142-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'42569-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'6298-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (3, 1, N'2823-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(4,1,'Glucose, Blood Serum Plasma, Point, mg/dL Units','Glucose_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'6777-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'2340-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'2341-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'41651-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'41652-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'32016-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'41653-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'74774-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'35211-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'2339-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (4, 1, N'2345-7');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(5,1,'Urea Nitrogen, Blood Serum Plasma, Point, mg/dL Units','BUN_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (5, 1, N'12961-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (5, 1, N'12962-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (5, 1, N'12963-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (5, 1, N'35234-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (5, 1, N'6299-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (5, 1, N'3094-0');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(6,1,'Carbon Dioxide, Blood Serum Plasma, Point, mmol/L','CO2_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'16551-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'34728-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'41647-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'57920-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'57922-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'51781-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'77143-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'2028-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'48391-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'2026-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'2027-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'20565-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (6, 1, N'19223-7');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(7,1,'Sodium, Blood Serum Plasma, Point, mmol/L','Na_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'12907-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'32717-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'41657-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'39791-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'39792-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'77139-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'42570-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'2947-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (7, 1, N'2951-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(8,1,'Chloride, Blood Serum Plasma, Point, mmol/L','Cl_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'2073-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'41649-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'41650-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'51590-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'77138-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'2075-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (8, 1, N'2069-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(9,1,'Calcium, Blood Serum Plasma, Point, mg/dL','Ca_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (9, 1, N'49765-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (9, 1, N'35246-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (9, 1, N'17861-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(10,1,'Calcium, Blood Serum Plasma, Point, mmol/L','Ca_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (10, 1, N'1996-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (10, 1, N'42593-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (10, 1, N'42857-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (10, 1, N'25583-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (10, 1, N'35246-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (10, 1, N'2000-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(11,1,'Hemoglobin, Blood Serum Plasma, Point, gm/dL','Hgb_BSP_gm');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'42243-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'14775-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'55782-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'76768-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'76769-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'61180-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'30351-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'30352-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'20509-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'35183-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'718-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'30313-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (11, 1, N'30350-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(12,1,'Leukocytes, Blood Serum Plasma, Point, x10*3/uL','WBC_BSP_cnt');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (12, 1, N'804-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (12, 1, N'62239-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (12, 1, N'26464-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (12, 1, N'6690-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (12, 1, N'49498-9');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(13,1,'Platelets, Blood Serum Plasma, Point, x10*3/uL','Plt_BSP_cnt');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'26516-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'5907-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'13056-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'778-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'62244-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'26515-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'777-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'49497-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (13, 1, N'74464-9');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(14,1,'Mean Corpuscular Volume, Blood Serum Plasma, Point, fL','MCV_BSP_fL');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (14, 1, N'62242-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (14, 1, N'30428-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (14, 1, N'787-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(15,1,'mean corpuscular hemoglobin concentration, Blood Serum Plasma, Point, fL','MCHC_BSP_gm');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (15, 1, N'28540-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (15, 1, N'62246-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (15, 1, N'786-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(16,1,'UA Specific Gravity, Urine, Point','Sp_Gravity_UA');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (16, 1, N'50562-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (16, 1, N'53326-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (16, 1, N'5810-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (16, 1, N'5811-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (16, 1, N'2965-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(17,1,'UA Ketones, Urine, Point','Ketones_UA');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'59158-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'49779-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'57734-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'33903-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'22702-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'50557-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'5797-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (17, 1, N'2514-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(18,1,'UA Nitrite, Urine, Point','Nitrite_UA');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (18, 1, N'2657-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (18, 1, N'20407-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (18, 1, N'32710-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (18, 1, N'5802-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (18, 1, N'50558-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(19,1,'UA Hemoglobin, Urine, Point','Hgb_UA');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (19, 1, N'726-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (19, 1, N'57751-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (19, 1, N'725-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (19, 1, N'5794-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (19, 1, N'49137-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (19, 1, N'50559-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(20,1,'UA RBC, Urine, Point','RBC_UA_cnt');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'30391-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'799-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'53292-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'33051-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'20409-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'798-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (20, 1, N'57747-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(21,1,'UA Protein, Urine, Point','Protein_UA');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'50749-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'27298-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'26034-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'57735-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'2887-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'20454-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'5804-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'50561-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'2888-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (21, 1, N'53525-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(22,1,'Aspartate Aminotransferase, BloodSerumPlasma, Point','AST_BSP');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (22, 1, N'16412-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (22, 1, N'30239-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (22, 1, N'88112-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (22, 1, N'1920-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(23,1,'Alanine Aminotransferase, BloodSerumPlasma, Point','ALT_BSP');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (23, 1, N'76625-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (23, 1, N'16324-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (23, 1, N'1743-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (23, 1, N'1744-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (23, 1, N'77144-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (23, 1, N'1742-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(24,1,'Bilirubin Total, BloodSerumPlasma, Point','Bili_Total_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (24, 1, N'42719-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (24, 1, N'59827-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (24, 1, N'59828-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (24, 1, N'35194-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (24, 1, N'1975-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(25,1,'Bilirubin Total, BloodSerumPlasma, Point','Bili_Total_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (25, 1, N'89871-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (25, 1, N'89872-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (25, 1, N'54363-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (25, 1, N'77137-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (25, 1, N'35194-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (25, 1, N'14631-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(26,1,'INR, BloodSerumPlasma, Point','INR_BSP');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (26, 1, N'46418-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (26, 1, N'34714-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(27,1,'Albumin, BloodSerumPlasma, Point','Albumin_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (27, 1, N'76631-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (27, 1, N'61151-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (27, 1, N'61152-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (27, 1, N'77148-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (27, 1, N'1751-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (27, 1, N'2862-1');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(28,1,'Albumin, BloodSerumPlasma, Point','Albumin_BSP_mmmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (28, 1, N'62234-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (28, 1, N'62235-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (28, 1, N'54347-0');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(29,1,'Prothombin Time, BloodSerumPlasma, Point','PT_BSP');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (29, 1, N'46417-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (29, 1, N'5964-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(30,1,'Partial Thromboplastin Time, BloodSerumPlasma, Point','PTT_BSP');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (30, 1, N'50754-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (30, 1, N'16631-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (30, 1, N'5898-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (30, 1, N'14979-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (30, 1, N'3173-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (30, 1, N'43734-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(31,1,'Thyrotropin, BloodSerumPlasma, Point','TSH_BSP_miu');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (31, 1, N'3015-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (31, 1, N'3016-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (31, 1, N'29575-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (31, 1, N'11580-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (31, 1, N'11579-0');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(32,1,'Thyrotropin, BloodSerumPlasma, Point','TSH_BSP_other');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (32, 1, N'20452-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (32, 1, N'27975-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (32, 1, N'14297-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (32, 1, N'29574-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (32, 1, N'55462-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(33,1,'Thyroxine, BloodSerumPlasma, Point','T4_BSP_ug');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (33, 1, N'3025-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (33, 1, N'35226-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (33, 1, N'3026-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (33, 1, N'31144-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (33, 1, N'83119-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(34,1,'Cholesterol Total, BloodSerumPlasma, Point','Chol_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (34, 1, N'35200-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (34, 1, N'2093-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (34, 1, N'50339-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (34, 1, N'2565-0');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(35,1,'Cholesterol Total, BloodSerumPlasma, Point','Chol_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (35, 1, N'35200-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (35, 1, N'14647-2');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(36,1,'HDL Cholesterol, BloodSerumPlasma, Point','HDL_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (36, 1, N'2086-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (36, 1, N'35197-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (36, 1, N'2085-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (36, 1, N'49130-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (36, 1, N'18263-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(37,1,'HDL Cholesterol, BloodSerumPlasma, Point','HDL_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (37, 1, N'35197-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (37, 1, N'14646-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(38,1,'LDL Cholesterol, BloodSerumPlasma, Point','LDL_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'2090-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'35198-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'18262-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'2089-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'13457-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'49132-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'55440-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (38, 1, N'18261-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(39,1,'LDL Cholesterol, BloodSerumPlasma, Point','LDL_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (39, 1, N'35198-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (39, 1, N'39469-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (39, 1, N'69419-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (39, 1, N'22748-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(40,1,'Triglycerides, BloodSerumPlasma, Point','Trig_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (40, 1, N'3049-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (40, 1, N'12951-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (40, 1, N'35217-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (40, 1, N'3043-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (40, 1, N'2571-8');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(41,1,'Triglycerides, BloodSerumPlasma, Point','Trig_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (41, 1, N'35217-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (41, 1, N'14927-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (41, 1, N'70218-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(42,1,'HgbA1c %, BloodSerumPlasma, Point','HgbA1c_BSP');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'4548-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'59261-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'17856-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'17855-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'4549-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'62388-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (42, 1, N'71875-9');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(43,1,'Magnesium, BloodSerumPlasma, Point','Magnesium_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (43, 1, N'26746-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (43, 1, N'21377-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (43, 1, N'35249-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (43, 1, N'19123-9');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(44,1,'Magnesium, BloodSerumPlasma, Point','Magnesium_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (44, 1, N'2593-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (44, 1, N'11554-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (44, 1, N'35249-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (44, 1, N'2597-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (44, 1, N'2601-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(45,1,'Phosphate, BloodSerumPlasma, Point','Phosphate_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (45, 1, N'20941-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (45, 1, N'2774-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (45, 1, N'35221-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (45, 1, N'2777-1');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(46,1,'Phosphate, BloodSerumPlasma, Point','Phosphate_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (46, 1, N'35221-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (46, 1, N'14879-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (46, 1, N'24519-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (46, 1, N'24520-9');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(47,1,'Ionized Calcium, BloodSerumPlasma, Point','I_Calcium_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (47, 1, N'17863-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (47, 1, N'38230-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (47, 1, N'59470-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (47, 1, N'59471-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (47, 1, N'42567-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (47, 1, N'17864-0');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(48,1,'Ionized Calcium, BloodSerumPlasma, Point','I_Caclium_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'13959-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'47596-2');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'41644-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'41645-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'41646-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'34581-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'42567-8');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'1994-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'12180-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (48, 1, N'1995-0');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(49,1,'Iron, BloodSerumPlasma, Point','Iron_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (49, 1, N'35214-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (49, 1, N'2498-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(50,1,'Iron, BloodSerumPlasma, Point','Iron_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (50, 1, N'35214-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (50, 1, N'14798-3');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(51,1,'Ferritin, BloodSerumPlasma, Point','Ferritin_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (51, 1, N'24373-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (51, 1, N'20567-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (51, 1, N'35209-6');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (51, 1, N'2276-4');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(52,1,'Ferritin, BloodSerumPlasma, Point','Ferritin_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (52, 1, N'14723-1');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (52, 1, N'35209-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(53,1,'Transferrin, BloodSerumPlasma, Point','Transferrin_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (53, 1, N'35229-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (53, 1, N'3034-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(54,1,'Transferrin, BloodSerumPlasma, Point','Transferrin_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (54, 1, N'35229-4');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (54, 1, N'22674-6');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(55,1,'Total Iron binding capacity, BloodSerumPlasma, Point','TIBC_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (55, 1, N'35215-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (55, 1, N'2500-7');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(56,1,'Total Iron binding capacity, BloodSerumPlasma, Point','TIBC_BSP_mmol');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (56, 1, N'35215-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (56, 1, N'14800-7');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(57,1,'Troponin I, BloodSerumPlasma, Point','Trop_I_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (57, 1, N'49563-0');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (57, 1, N'10839-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (57, 1, N'42757-5');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (57, 1, N'89579-7');

INSERT INTO #LabTests_LOINC_Key(LabTestID,ActiveVersionNumber,Description,LabTestAbbr)
VALUES(58,1,'Troponin T, BloodSerumPlasma, Point','Trop_T_BSP_mg');

INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (58, 1, N'6597-9');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (58, 1, N'6598-7');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (58, 1, N'48425-3');
INSERT INTO #LabTests_LOINC_Codes (LabTestID, VersionNumber, CodeValue) VALUES (58, 1, N'67151-1');



/**************************************************************
**CUSTOM MAPPING** will need to modify for each site
HGB_UA, NITRITE_UA have no numeric value. 
Need to compile a list of Value source value from measurement table for HGB_UA and NITRITE_UA and assign a binary value. 

***************************************************************/

if OBJECT_ID('tempdb..#Temp_Lab_sourcevalue_map') IS NOT NULL drop table #Temp_Lab_sourcevalue_map
CREATE TABLE #Temp_Lab_sourcevalue_map
(
	Value_Source_Value varchar(100)
	, ValueAsNumber int
);

INSERT INTO #Temp_Lab_sourcevalue_map VALUES('NEGATIVE',0);
INSERT INTO #Temp_Lab_sourcevalue_map VALUES('NI',0);
INSERT INTO #Temp_Lab_sourcevalue_map VALUES('OT',0);
INSERT INTO #Temp_Lab_sourcevalue_map VALUES('NORMAL',0);
INSERT INTO #Temp_Lab_sourcevalue_map VALUES('POSITIVE',1);
INSERT INTO #Temp_Lab_sourcevalue_map VALUES('INVALID',0);


------------------------------------------------------------------------>
/**************************************************************
MAIN data build

***************************************************************/


if OBJECT_ID('tempdb..#MESH_APPENDIX') IS NOT NULL drop table #MESH_APPENDIX
	SELECT Import.descriptive
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, condition.report_date as valuedate
	, condition.raw_condition_type
	, condition.raw_condition
	, condition.condition
	, NULL as ValueAsNumber
	, NULL as SourceValue
	, 'Condition' as TableName
	, conditionid as Primary_id
	INTO #MESH_APPENDIX
	FROM #Temp_Appendix_Import as Import
	JOIN PCOR.condition as condition
		ON condition.condition = Import.code
		AND condition.raw_condition_type = Import.CodeType
	JOIN #MESH_SLING as MESH_SLING
		ON condition.patid = MESH_SLING.person_id        
UNION
	SELECT Import.descriptive
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, procedure_table.px_date as valuedate
	, procedure_table.raw_px_type
	, procedure_table.raw_px
	, procedure_table.raw_ppx
	, NULL as ValueAsNumber
	, NULL as SourceValue
	, 'Procedure' as TableName
	, proceduresid as Primary_id
	FROM #Temp_Appendix_Import as Import
	JOIN PCOR.[procedures] as procedure_table
	    ON procedure_table.px = Import.code
		and procedure_table.raw_px_type = Import.CodeType
	JOIN #MESH_SLING as MESH_SLING
		ON procedure_table.patid = MESH_SLING.person_id        
UNION 
	SELECT a.descriptive
	, a.person_id
	, a.procedure_date
	, a.value_date
	, a.code_type
	, a.dx
	, a.raw_dx
	, a.valueasnumber
	, a.SourceValue
	, a.tablename
	, a.primary_id
	FROM
	(
		SELECT Import.descriptive
		, MESH_SLING.person_id
		, MESH_SLING.procedure_date
		, Diagnosis.admit_date as valuedate
		, case when Diagnosis.dx_type = '09' THEN 'ICD9CM' 
			WHEN Diagnosis.dx_type = '10' THEN 'ICD10CM'
			WHEN Diagnosis.dx_type = 'SM' THEN 'SNOMED' ELSE NULL END as code_type
		, Diagnosis.dx
		, Diagnosis.raw_dx
		, NULL as ValueAsNumber
		, NULL as SourceValue
		, 'Diagnosis' as TableName
		, Diagnosis.diagnosisid as Primary_id
		FROM #Temp_Appendix_Import as Import
		JOIN PCOR.diagnosis as Diagnosis
			ON Diagnosis.dx = Import.code
		JOIN #MESH_SLING as MESH_SLING
			ON Diagnosis.patid = MESH_SLING.person_id
	) as a
		JOIN #Temp_Appendix_Import as b
		 ON a.code_type = b.codetype
UNION
	SELECT 'Visit_Post'
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, visit_post.admit_date as valuedate
	,NULL as Vocabulary_id
	,NULL as Concept_code
	,NULL as Concept_name
	,NULL as ValueAsNumber
	,NULL as SourceValue
	,'Visit' as TableName
	, encounterid as Primary_id
	FROM #MESH_SLING as MESH_SLING
	JOIN PCOR.ENCOUNTER as visit_post
		ON MESH_SLING.person_id = visit_post.patid
		AND MESH_SLING.procedure_date < visit_post.admit_date
		AND datediff(day,MESH_SLING.procedure_date, visit_post.admit_date) <= 365
UNION
	SELECT 'Visit_Prior'
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, visit_prior.admit_date as valuedate
	,NULL as Vocabulary_id
	,NULL as Concept_code
	,NULL as Concept_name
	,NULL as ValueAsNumber
	,NULL as SourceValue
	,'Visit' as TableName
	, encounterid as Primary_id
	FROM #MESH_SLING as MESH_SLING 
	JOIN PCOR.ENCOUNTER as visit_prior
		ON visit_prior.patid = MESH_SLING.person_id
		AND visit_prior.admit_date < MESH_SLING.procedure_date
		AND datediff(day,visit_prior.admit_date,MESH_SLING.procedure_date) <= 365
UNION
	SELECT 'BMI'
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, VITAL.measure_date as valuedate
	,NULL as Vocabulary_id
	,NULL as Concept_code
	,NULL as Concept_name
	,VITAL.original_bmi as ValueAsNumber
	,NULL as SourceValue
	,'VITAL' as TableName
	, vitalid as Primary_id
	FROM PCOR.VITAL 
	JOIN #MESH_SLING as MESH_SLING 
		ON VITAL.patid = mesh_sling.person_id
	WHERE vital.ORIGINAL_BMI is not null
UNION
	SELECT 'Height'
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, VITAL.measure_date as valuedate
	,NULL as Vocabulary_id
	,NULL as Concept_code
	,NULL as Concept_name
	,PCOR.VITAL.HT as ValueAsNumber
	,NULL as SourceValue
	,'VITAL' as TableName
	, vitalid as Primary_id
	FROM PCOR.VITAL 
	JOIN #MESH_SLING as MESH_SLING 
		ON VITAL.patid = mesh_sling.person_id
	WHERE vital.HT is not null
UNION
	SELECT 'Weight'
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, VITAL.measure_date as valuedate
	,NULL as Vocabulary_id
	,NULL as Concept_code
	,NULL as Concept_name
	,VITAL.WT as ValueAsNumber
	,NULL as SourceValue
	,'VITAL' as TableName
	, vitalid as Primary_id
	FROM PCOR.VITAL 
	JOIN #MESH_SLING as MESH_SLING 
		ON VITAL.patid = mesh_sling.person_id
	WHERE vital.WT is not null	          
UNION
  SELECT 'Smoking'
  , MESH_SLING.person_id
  , MESH_SLING.procedure_date
  , VITAL.measure_date as valuedate
  ,NULL as Vocabulary_id
  ,NULL as Concept_code
  ,NULL as Concept_name
  ,case when VITAL.SMOKING = 'UN' THEN NULL else Vital.smoking END as ValueAsNumber
  ,NULL as SourceValue
  ,'VITAL' as TableName
  , vitalid as Primary_id
  FROM PCOR.VITAL 
    JOIN #MESH_SLING as MESH_SLING 
      ON VITAL.patid = mesh_sling.person_id
  WHERE VITAL.smoking is not null and vital.smoking in ('01','02','03','05','07','08') 
UNION
	SELECT *
	FROM
	(
		SELECT
		drug_class.class_name
		, MESH_SLING.person_id
		, MESH_SLING.procedure_date
		, CASE WHEN rx_end_date IS NOT NULL THEN rx_end_date
			WHEN rx_days_supply IS NOT NULL OR rx_days_supply > 0 THEN DATEADD(day,rx_days_supply,rx_start_date) 
			ELSE DATEADD(DAY,1,rx_start_date) END AS value_date
		,NULL as Vocabulary_id
		,drug.rxnorm_cui as Concept_code
		,NULL as ValueAsNumber
		,NULL as Concept_name
		,NULL as SourceValue
		,'prescribing' as TableName
		,prescribingid as Primary_id
		FROM #MESH_SLING as MESH_SLING 
		JOIN PCOR.prescribing as drug
			ON drug.patid = MESH_SLING.person_id
		JOIN ##Temp_Drug_Class as drug_class
			ON drug.rxnorm_cui = drug_class.rxnorm_cui
	) as a
	WHERE value_date < procedure_date
	AND datediff(day,value_date,procedure_date) <= 182

UNION 
	SELECT LABTESTS_LOINC_KEY.labtestabbr
	, MESH_SLING.person_id
	, MESH_SLING.procedure_date
	, LAB_RESULT_CM.result_date as valuedate
	,NULL as Vocabulary_id
	,NULL as Concept_code
	,NULL as Concept_name
	, CASE when LAB_RESULT_CM.result_num is null and map.ValueAsNumber is not null THEN map.ValueAsNumber
		ELSE LAB_RESULT_CM.result_num END as ValueAsNumber
	,NULL as SourceValue
	, 'LAB_RESULT_CM' as TableName
	, LAB_RESULT_CM.lab_result_cm_id as Primary_id
	FROM PCOR.LAB_RESULT_CM
	JOIN #MESH_SLING as MESH_SLING
		ON LAB_RESULT_CM.patid = MESH_SLING.person_id
	JOIN #LABTESTS_LOINC_CODES as LABTESTS_LOINC_CODES
		ON LAB_RESULT_CM.lab_loinc = LABTESTS_LOINC_CODES.codevalue
	JOIN #LABTESTS_LOINC_KEY as LABTESTS_LOINC_KEY
		ON LABTESTS_LOINC_KEY.labtestid = LABTESTS_LOINC_CODES.labtestid   
	LEFT JOIN #Temp_Lab_sourcevalue_map as map
		ON map.value_source_value = lab_result_cm.result_qual

/********************************************************************
FINAL BUILD
********************************************************************/
-------------------------------------------------------------------------------> FINAL SECTION 0
if OBJECT_ID('tempdb..#MESH_FINAL0') IS NOT NULL drop table #MESH_FINAL0;

SELECT MESH_SLING.person_id as PatID
, MESH_PERSON.birth_date as DateTimeBirth
, death.DEATH_DATE as DateTimeDeath
, MESH_SLING.procedure_date as DateTimeSurgery
, max(inpat_follow.discharge_date) as inpat_follow
, max(outpat_follow.discharge_date) as outpat_follow

, case when NON_SLING.person_id is not null then 1 else 0 end NON_SLING
, case when LAP_SLING.person_id is not null then 1 else 0 end LAP_SLING

, CASE WHEN MESH_PERSON.sex = 'F' THEN 1 ELSE 0 END AS Female
, CASE WHEN MESH_PERSON.race ='01' THEN 'American Indian or Alaska Native'
    WHEN MESH_PERSON.race ='02' THEN 'Asian'
    WHEN MESH_PERSON.race ='03' THEN 'Black'
    WHEN MESH_PERSON.race ='04' THEN 'Native Hawaiian or Other Pacific Islander'
    WHEN MESH_PERSON.race ='05' THEN 'White'
    else 'No matching concept' END as Race
, CASE WHEN MESH_PERSON.hispanic = 'Y' THEN 1 ELSE 0 END as Hispanic

INTO #MESH_FINAL0
FROM #MESH_SLING as MESH_SLING
JOIN PCOR.DEMOGRAPHIC as MESH_PERSON
  ON MESH_SLING.person_id = MESH_PERSON.patid

LEFT JOIN PCOR.DEATH as death
  ON MESH_SLING.person_id = death.patid

LEFT JOIN PCOR.ENCOUNTER as inpat_follow
  ON MESH_SLING.person_id = inpat_follow.patid
  and inpat_follow.enc_type = 'IP'
  and inpat_follow.discharge_date > MESH_SLING.procedure_date
  and datediff(DAY, MESH_SLING.procedure_date, inpat_follow.discharge_date) > 365  

LEFT JOIN PCOR.ENCOUNTER as outpat_follow
  ON MESH_SLING.person_id = outpat_follow.patid
  and outpat_follow.enc_type = 'AV'  
  and outpat_follow.discharge_date > MESH_SLING.procedure_date
  and datediff(day,MESH_SLING.procedure_date, outpat_follow.discharge_date) > 365  

LEFT JOIN #MESH_APPENDIX as NON_SLING
  ON MESH_SLING.person_id = NON_SLING.person_id
  and NON_SLING.descriptive = 'NON_SLING'

LEFT JOIN #MESH_APPENDIX as LAP_SLING
  ON MESH_SLING.person_id = LAP_SLING.person_id    
  and LAP_SLING.descriptive = 'LAP_SLING'
GROUP BY
  MESH_PERSON.birth_date
, death.DEATH_DATE
, MESH_PERSON.sex
, MESH_PERSON.HISPANIC
, MESH_PERSON.race
, MESH_SLING.person_id
, MESH_SLING.procedure_date
, NON_SLING.person_id
, LAP_SLING.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 0a
if OBJECT_ID('tempdb..#MESH_FINAL0a') IS NOT NULL drop table #MESH_FINAL0a;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
cast(avg(BMI.valueasnumber) as numeric(10,2)) as BMI,
case when SurgeryIndication.person_id is not null then 1 else 0 end SUI_Ind, 
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC
, case when DATEPART(YEAR, DATETIMESURGERY) - DATEPART(YEAR, DATETIMEBIRTH) > 51 then 1 
	when Menopause.person_id is not null then 1 else 0 end HistoryMenopause 
, case when ReOperation.person_id is not null then min(ReOperation.valuedate) else NULL end DateTimeReoperation --post
, case when MeshRemoval.person_id is not null then min(MeshRemoval.valuedate) else NULL end DateTimeRemoval --post

INTO #MESH_FINAL0a 
FROM #MESH_FINAL0 AS MESH_SLING

LEFT JOIN #MESH_APPENDIX as BMI --prior
  ON MESH_SLING.PATID = BMI.person_id
  and MESH_SLING.DATETIMESURGERY > BMI.valuedate
  and datediff(DAY,BMI.valuedate, MESH_SLING.DATETIMESURGERY) <= 365
  and BMI.descriptive = 'BMI'

LEFT JOIN #MESH_APPENDIX as SurgeryIndication
  ON MESH_SLING.PATID = SurgeryIndication.person_id
  and SurgeryIndication.descriptive = 'Surgery Indication'   

LEFT JOIN #MESH_APPENDIX as Menopause
  ON MESH_SLING.PATID = Menopause.person_id
  and Menopause.descriptive = 'Menopause'

left join #MESH_APPENDIX as ReOperation --post
  ON MESH_SLING.PATID = ReOperation.person_id
  and ReOperation.descriptive = 'Re-Operation'   
  and ReOperation.valuedate > MESH_SLING.DATETIMESURGERY 
  and datediff(day,MESH_SLING.DATETIMESURGERY, ReOperation.valuedate) > 2   

left join #MESH_APPENDIX as MeshRemoval --post
  ON MESH_SLING.PATID = MeshRemoval.person_id
  and MeshRemoval.descriptive = 'Mesh Removal'
  and MeshRemoval.valuedate > MESH_SLING.DATETIMESURGERY 
  and DATEDIFF(day,MESH_SLING.DATETIMESURGERY, MeshRemoval.valuedate) > 2 

GROUP BY 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI.person_id,
SurgeryIndication.person_id,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC
, Menopause.person_id
, ReOperation.person_id
, MeshRemoval.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 0b
if OBJECT_ID('tempdb..#MESH_FINAL0b') IS NOT NULL drop table #MESH_FINAL0b;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
case when ReOperation_Indication.person_id is not null then 1 else 0 end INDICATION_REOPERATION, 
DATETIMEREMOVAL

, case when PostProceduralPain.person_id is not null then min(PostProceduralPain.valuedate) else NULL end DateTimePain --post
, case when PreChronicPain.person_id is not null then 1 else 0 end PreHistoryChronicPain -- pre
, case when PeriChronicPain.person_id is not null then 1 else 0 end PeriHistoryChronicPain -- peri
, case when PostChronicPain.person_id is not null then 1 else 0 end PostHistoryChronicPain -- post

INTO #MESH_FINAL0b 
FROM #MESH_FINAL0a AS MESH_SLING
left join #MESH_APPENDIX as PostProceduralPain --post
  ON MESH_SLING.PATID = PostProceduralPain.person_id
  and PostProceduralPain.descriptive = 'PostProceduralPain'
  and PostProceduralPain.valuedate > MESH_SLING.DATETIMESURGERY
  and PostProceduralPain.valuedate <= DATEADD(month,3,MESH_SLING.DATETIMESURGERY)
  and PostProceduralPain.ValueAsNumber > 3

left join #MESH_APPENDIX as PreChronicPain
  ON MESH_SLING.PATID = PreChronicPain.person_id
  and PreChronicPain.descriptive = 'Chronic Pain'
  and PreChronicPain.valuedate < MESH_SLING.DATETIMESURGERY
  and datediff(day,PreChronicPain.valuedate, MESH_SLING.DATETIMESURGERY) <= 365
  and datediff(day,PreChronicPain.valuedate, MESH_SLING.DATETIMESURGERY) >= 2 

left join #MESH_APPENDIX as PeriChronicPain
  ON MESH_SLING.PATID = PeriChronicPain.person_id
  and PeriChronicPain.descriptive = 'Chronic Pain'
  and abs(datediff(day,MESH_SLING.DATETIMESURGERY, PeriChronicPain.valuedate)) <= 1 

left join #MESH_APPENDIX as PostChronicPain
  ON MESH_SLING.PATID = PostChronicPain.person_id
  and PostChronicPain.descriptive = 'Chronic Pain'
  and PostChronicPain.valuedate > MESH_SLING.DATETIMESURGERY 
  and datediff(day,MESH_SLING.DATETIMESURGERY, PostChronicPain.valuedate) > 2

left join #MESH_APPENDIX as ReOperation_Indication --post
  ON MESH_SLING.PATID = ReOperation_Indication.person_id
  and ReOperation_Indication.descriptive like '%Re-Operation/%'
  and DATETIMEREOPERATION > ReOperation_Indication.valuedate     
  and datediff(day, ReOperation_Indication.valuedate, DATETIMEREOPERATION)<=180
  and datediff(day, ReOperation_Indication.valuedate, DATETIMEREOPERATION)>=4 
  
GROUP BY
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
DATETIMEREMOVAL
, PostProceduralPain.person_id
, PreChronicPain.person_id
, PeriChronicPain.person_id
, PostChronicPain.person_id
, ReOperation_Indication.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 1
if OBJECT_ID('tempdb..#MESH_FINAL1') IS NOT NULL drop table #MESH_FINAL1;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN

, case when PreVoidingSymptoms.person_id is not null then max(PreVoidingSymptoms.valuedate) else NULL end PreDateTimeVoiding --pre
, case when PeriVoidingSymptoms.person_id is not null then max(PeriVoidingSymptoms.valuedate) else NULL end PeriDateTimeVoiding --peri
, case when PostVoidingSymptoms.person_id is not null then min(PostVoidingSymptoms.valuedate) else NULL end PostDateTimeVoiding --post

INTO #MESH_FINAL1 
FROM #MESH_FINAL0b AS MESH_SLING

left join #MESH_APPENDIX as PreVoidingSymptoms
  ON MESH_SLING.PATID = PreVoidingSymptoms.person_id
  and PreVoidingSymptoms.descriptive = 'Voiding symptoms'
  and MESH_SLING.DATETIMESURGERY > PreVoidingSymptoms.valuedate
  and DATEDIFF(day,PreVoidingSymptoms.valuedate,MESH_SLING.DATETIMESURGERY ) <= 365
  and DATEDIFF(day,PreVoidingSymptoms.valuedate,MESH_SLING.DATETIMESURGERY ) >=2

left join #MESH_APPENDIX as PeriVoidingSymptoms
  ON MESH_SLING.PATID = PeriVoidingSymptoms.person_id
  and PeriVoidingSymptoms.descriptive = 'Voiding symptoms'
  and abs(datediff(day,MESH_SLING.DATETIMESURGERY, PeriVoidingSymptoms.valuedate)) <= 1

left join #MESH_APPENDIX as PostVoidingSymptoms
  ON MESH_SLING.PATID = PostVoidingSymptoms.person_id
  and PostVoidingSymptoms.descriptive = 'Voiding symptoms'
  and PostVoidingSymptoms.valuedate > MESH_SLING.DATETIMESURGERY 
  and DATEDIFF(day,MESH_SLING.DATETIMESURGERY, PostVoidingSymptoms.valuedate) > 2   

GROUP BY
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN
, PreVoidingSymptoms.person_id
, PeriVoidingSymptoms.person_id
, PostVoidingSymptoms.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 1a
if OBJECT_ID('tempdb..#MESH_FINAL1a') IS NOT NULL drop table #MESH_FINAL1a;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING
, case when MeshErosion.person_id is not null then min(MeshErosion.valuedate) else NULL end DateTimeErosion --post
, case when UrethralFistula.person_id is not null then min(UrethralFistula.valuedate) else NULL end DateTimeFistula -- post

, case when PreAbSurg.person_id is not null then 1 else 0 end PreAbSurg 
, case when PeriAbSurg.person_id is not null then 1 else 0 end PeriAbSurg
, case when PostAbSurg.person_id is not null then 1 else 0 end PostAbSurg 

, case when Infection.person_id is not null then min(Infection.valuedate) else NULL end DateTimeInfection --post
, case when Perforation.person_id is not null then min(Perforation.valuedate) else NULL end DateTimePerforation --post

--InsurancePayer
, case when Urodynamic.person_id is not null then 1 else 0 end UrodynamicTesting
-- Surgical Route
, case when Smoking.person_id is not null then 1 else 0 end HistorySmoking
INTO #MESH_FINAL1a 
FROM #MESH_FINAL1 AS MESH_SLING 
  left join #MESH_APPENDIX as MeshErosion --post
  ON MESH_SLING.PATID = MeshErosion.person_id
  and MeshErosion.descriptive = 'Mesh Erosion'
  and MeshErosion.valuedate > MESH_SLING.DATETIMESURGERY 
  and DATEDIFF(day, MESH_SLING.DATETIMESURGERY, MeshErosion.valuedate) > 2   

left join #MESH_APPENDIX as UrethralFistula --post
  ON MESH_SLING.PATID = UrethralFistula.person_id
  and UrethralFistula.descriptive = 'Urethral Fistula'
  and UrethralFistula.valuedate > MESH_SLING.DATETIMESURGERY 
  and DATEDIFF(day,MESH_SLING.DATETIMESURGERY, UrethralFistula.valuedate) > 2   

  left join #MESH_APPENDIX as PreAbSurg 
  ON MESH_SLING.PATID = PreAbSurg.person_id
  and PreAbSurg.descriptive = 'Concomitant surgical procedures'
  and MESH_SLING.DATETIMESURGERY > PreAbSurg.valuedate
  and DATEDIFF(day,PreAbSurg.valuedate,MESH_SLING.DATETIMESURGERY) <= 365  
  and DATEDIFF(day,PreAbSurg.valuedate,MESH_SLING.DATETIMESURGERY) >= 2

left join #MESH_APPENDIX as PeriAbSurg 
  ON MESH_SLING.PATID = PeriAbSurg.person_id
  and PeriAbSurg.descriptive = 'Concomitant surgical procedures'
  and abs(datediff(day,MESH_SLING.DATETIMESURGERY, PeriAbSurg.valuedate)) <= 1

left join #MESH_APPENDIX as PostAbSurg 
  ON MESH_SLING.PATID = PostAbSurg.person_id
  and PostAbSurg.descriptive = 'Concomitant surgical procedures'
  and PostAbSurg.valuedate > MESH_SLING.DATETIMESURGERY 
  and datediff(day,MESH_SLING.DATETIMESURGERY, PostAbSurg.valuedate) > 2   

left join #MESH_APPENDIX as Infection --Post
  ON MESH_SLING.PATID = Infection.person_id
  and Infection.descriptive = 'Surgical Site Infection'
  and Infection.valuedate > MESH_SLING.DATETIMESURGERY 
  and datediff(day,MESH_SLING.DATETIMESURGERY, Infection.valuedate) > 2 

left join #MESH_APPENDIX as Perforation --Post
  ON MESH_SLING.PATID = Perforation.person_id
  and Perforation.descriptive = 'Organ Mesh Perforation (vagina, urinary tract)'
  and Perforation.valuedate > MESH_SLING.DATETIMESURGERY 
  and datediff(day,MESH_SLING.DATETIMESURGERY, Perforation.valuedate) > 2  

left join #MESH_APPENDIX as Urodynamic
  ON MESH_SLING.PATID = Urodynamic.person_id
  and Urodynamic.descriptive = 'Urodynamic Testing'

left join #MESH_APPENDIX as Smoking
  ON MESH_SLING.PATID = Smoking.person_id
  and Smoking.descriptive = 'Smoking'  

GROUP BY
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING
, MeshErosion.person_id
, UrethralFistula.person_id
, PreAbSurg.person_id
, PeriAbSurg.person_id
, PostAbSurg.person_id
, Infection.person_id
, Perforation.person_id
, Urodynamic.person_id
, Smoking.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 2
if OBJECT_ID('tempdb..#MESH_FINAL2') IS NOT NULL drop table #MESH_FINAL2;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING

, case when PreSurgeryDM.person_id is not null then 1 else 0 end PreSurgeryDM
, case when PreSurgeryHTN.person_id is not null then 1 else 0 end PreSurgeryHTN
, case when PreSurgeryCAD.person_id is not null then 1 else 0 end PreSurgeryCAD
, case when PreSurgeryPVD.person_id is not null then 1 else 0 end PreSurgeryPVD
, case when PreSurgeryHLD.person_id is not null then 1 else 0 end PreSurgeryHLD

, case when visit_prior.person_id is not null then 1 else 0 end as VisitYearPriorSurgery
, case when visit_post.person_id is not null then 1 else 0 end as VisitYearPostSurgery

, case when PriorProlapse.person_id is not null then 1 else 0 end PriorProlapse
INTO #MESH_FINAL2 
FROM #MESH_FINAL1a as MESH_SLING
left join #MESH_APPENDIX as PreSurgeryDM
  ON MESH_SLING.PATID = PreSurgeryDM.person_id
  and MESH_SLING.DATETIMESURGERY > PreSurgeryDM.valuedate
  and datediff(day,PreSurgeryDM.valuedate, MESH_SLING.DATETIMESURGERY) <= 365 --pre
  and datediff(day,PreSurgeryDM.valuedate, MESH_SLING.DATETIMESURGERY) >= 2
  and PreSurgeryDM.descriptive = 'PreSurgeryDM'

left join #MESH_APPENDIX as PreSurgeryHTN
  ON MESH_SLING.PATID = PreSurgeryHTN.person_id
  and MESH_SLING.DATETIMESURGERY > PreSurgeryHTN.valuedate
  and datediff(day,PreSurgeryHTN.valuedate, MESH_SLING.DATETIMESURGERY) <= 365 --pre
  and datediff(day,PreSurgeryHTN.valuedate, MESH_SLING.DATETIMESURGERY) >= 2
  and PreSurgeryHTN.descriptive = 'PreSurgeryHTN'  

 left join #MESH_APPENDIX as PreSurgeryCAD
  ON MESH_SLING.PATID = PreSurgeryCAD.person_id
  and MESH_SLING.DATETIMESURGERY > PreSurgeryCAD.valuedate
  and datediff(day,PreSurgeryCAD.valuedate, MESH_SLING.DATETIMESURGERY) <= 365 --pre
  and datediff(day,PreSurgeryCAD.valuedate, MESH_SLING.DATETIMESURGERY) >= 2
  and PreSurgeryCAD.descriptive = 'PreSurgeryCAD'   

 left join #MESH_APPENDIX as PreSurgeryPVD
  ON MESH_SLING.PATID = PreSurgeryPVD.person_id
  and MESH_SLING.DATETIMESURGERY > PreSurgeryPVD.valuedate
  and datediff(day, PreSurgeryPVD.valuedate, MESH_SLING.DATETIMESURGERY) <= 365 --pre
  and datediff(day, PreSurgeryPVD.valuedate, MESH_SLING.DATETIMESURGERY) >= 2
  and PreSurgeryPVD.descriptive = 'PreSurgeryPVD'   

  left join #MESH_APPENDIX as PreSurgeryHLD
  ON MESH_SLING.PATID = PreSurgeryHLD.person_id
  and MESH_SLING.DATETIMESURGERY > PreSurgeryHLD.valuedate
  and datediff(day,PreSurgeryHLD.valuedate,MESH_SLING.DATETIMESURGERY) <= 365 --pre
  and datediff(day,PreSurgeryHLD.valuedate,MESH_SLING.DATETIMESURGERY) >= 2
  and PreSurgeryHLD.descriptive = 'PreSurgeryHLD' 

  LEFT JOIN #MESH_APPENDIX as visit_post --post
  ON MESH_SLING.PATID = visit_post.person_id
  and visit_post.descriptive = 'Visit_Post'

  LEFT JOIN #MESH_APPENDIX as visit_prior --post
  ON MESH_SLING.PATID = visit_prior.person_id
  and visit_prior.descriptive = 'Visit_Prior'

  LEFT JOIN #MESH_APPENDIX as PriorProlapse
  ON MESH_SLING.PATID = PriorProlapse.person_id
  and PriorProlapse.descriptive = 'Prolapse'
  and PriorProlapse.valuedate < MESH_SLING.DATETIMESURGERY

 GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PreSurgeryDM.person_id,
PreSurgeryHTN.person_id,
PreSurgeryCAD.person_id,
PreSurgeryPVD.person_id,
PreSurgeryHLD.person_id,
PriorProlapse.person_id,
visit_prior.person_id,
visit_post.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 3
if OBJECT_ID('tempdb..#MESH_FINAL3') IS NOT NULL drop table #MESH_FINAL3;

SELECT 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
case when PriorSUI.person_id is not null then 1 else 0 end PriorSUI
,case when PriorDivericulum.person_id is not null then 1 else 0 end PriorDivericulum --PriorDivericulum
,case when ConcomitantSurgical.person_id is not null then 1 else 0 end ConcomitantSurg -- falls under abdominal surgery?

, case when ATC_First_generation_cephalosporins.person_id is not null then 1 else 0 end ATC_First_generation_cephalosporins
, case when ATC_Anilides.person_id is not null then 1 else 0 end ATC_Anilides
, case when ATC_Natural_and_semisynthetic_estrogens_plain.person_id is not null then 1 else 0 end ATC_Natural_and_semisynthetic_estrogens_plain

INTO #MESH_FINAL3
FROM #MESH_FINAL2 as MESH_SLING
 left join #MESH_APPENDIX as PriorSUI
  ON MESH_SLING.patid = PriorSUI.person_id
  and PriorSUI.descriptive = 'SUI without Mesh'
  and PriorSUI.valuedate < MESH_SLING.DATETIMESURGERY

left join #MESH_APPENDIX as PriorDivericulum
  ON MESH_SLING.patid = PriorDivericulum.person_id
  and PriorDivericulum.descriptive = 'Urethral Divericulum'
  and PriorDivericulum.valuedate < MESH_SLING.DATETIMESURGERY  
  and datediff(day,PriorDivericulum.valuedate, MESH_SLING.DATETIMESURGERY) <= 90

left join #MESH_APPENDIX as ConcomitantSurgical
  ON MESH_SLING.patid = ConcomitantSurgical.person_id
  and abs(datediff(day,MESH_SLING.DATETIMESURGERY, ConcomitantSurgical.valuedate)) <= 1
  and ConcomitantSurgical.descriptive = 'Concomitant surgical procedures'  

left join #MESH_APPENDIX as ATC_First_generation_cephalosporins
  ON MESH_SLING.patid =ATC_First_generation_cephalosporins.person_id
  and ATC_First_generation_cephalosporins.descriptive = 'ATC_First_generation_cephalosporins'
  and ATC_First_generation_cephalosporins.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_First_generation_cephalosporins.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Anilides
  ON MESH_SLING.patid =ATC_Anilides.person_id
  and ATC_Anilides.descriptive = 'ATC_Anilides'
  and ATC_Anilides.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Anilides.valuedate,MESH_SLING.DATETIMESURGERY) <= 182   

  left join #MESH_APPENDIX as ATC_Natural_and_semisynthetic_estrogens_plain
  ON MESH_SLING.patid =ATC_Natural_and_semisynthetic_estrogens_plain.person_id
  and ATC_Natural_and_semisynthetic_estrogens_plain.descriptive = 'ATC_Natural_and_semisynthetic_estrogens_plain'
  and ATC_Natural_and_semisynthetic_estrogens_plain.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Natural_and_semisynthetic_estrogens_plain.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 


GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PriorSUI.person_id,
PriorDivericulum.person_id,
ConcomitantSurgical.person_id,
ATC_First_generation_cephalosporins.person_id,
ATC_Anilides.person_id,
ATC_Natural_and_semisynthetic_estrogens_plain.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 4
if OBJECT_ID('tempdb..#MESH_FINAL4') IS NOT NULL drop table #MESH_FINAL4;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN
, case when ATC_Proton_pump_inhibitors.person_id is not null then 1 else 0 end ATC_Proton_pump_inhibitors
, case when ATC_Drugs_for_urinary_frequency_and_incontinence.person_id is not null then 1 else 0 end ATC_Drugs_for_urinary_frequency_and_incontinence
, case when ATC_Electrolyte_solutions.person_id is not null then 1 else 0 end ATC_Electrolyte_solutions
, case when ATC_HMG_CoA_reductase_inhibitors.person_id is not null then 1 else 0 end ATC_HMG_CoA_reductase_inhibitors
INTO #MESH_FINAL4
FROM #MESH_FINAL3 as MESH_SLING

left join #MESH_APPENDIX as ATC_Proton_pump_inhibitors
  ON MESH_SLING.patid =ATC_Proton_pump_inhibitors.person_id
  and ATC_Proton_pump_inhibitors.descriptive = 'ATC_Proton_pump_inhibitors'
  and ATC_Proton_pump_inhibitors.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Proton_pump_inhibitors.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Drugs_for_urinary_frequency_and_incontinence
  ON MESH_SLING.patid =ATC_Drugs_for_urinary_frequency_and_incontinence.person_id
  and ATC_Drugs_for_urinary_frequency_and_incontinence.descriptive = 'ATC_Drugs_for_urinary_frequency_and_incontinence'
  and ATC_Drugs_for_urinary_frequency_and_incontinence.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Drugs_for_urinary_frequency_and_incontinence.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Electrolyte_solutions
  ON MESH_SLING.patid =ATC_Electrolyte_solutions.person_id
  and ATC_Electrolyte_solutions.descriptive = 'ATC_Electrolyte_solutions'
  and ATC_Electrolyte_solutions.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Electrolyte_solutions.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_HMG_CoA_reductase_inhibitors
  ON MESH_SLING.patid =ATC_HMG_CoA_reductase_inhibitors.person_id
  and ATC_HMG_CoA_reductase_inhibitors.descriptive = 'ATC_HMG_CoA_reductase_inhibitors'
  and ATC_HMG_CoA_reductase_inhibitors.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_HMG_CoA_reductase_inhibitors.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 


GROUP BY
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN
,ATC_Proton_pump_inhibitors.person_id
,ATC_Drugs_for_urinary_frequency_and_incontinence.person_id
,ATC_Electrolyte_solutions.person_id
,ATC_HMG_CoA_reductase_inhibitors.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 5
if OBJECT_ID('tempdb..#MESH_FINAL5') IS NOT NULL drop table #MESH_FINAL5;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS
, case when ATC_Natural_opium_alkaloids.person_id is not null then 1 else 0 end ATC_Natural_opium_alkaloids
, case when ATC_Serotonin_5HT3_antagonists.person_id is not null then 1 else 0 end ATC_Serotonin_5HT3_antagonists
, case when ATC_Selective_serotonin_reuptake_inhibitors.person_id is not null then 1 else 0 end ATC_Selective_serotonin_reuptake_inhibitors
INTO #MESH_FINAL5
FROM #MESH_FINAL4 as MESH_SLING

left join #MESH_APPENDIX as ATC_Natural_opium_alkaloids
  ON MESH_SLING.patid =ATC_Natural_opium_alkaloids.person_id
  and ATC_Natural_opium_alkaloids.descriptive = 'ATC_Natural_opium_alkaloids'
  and ATC_Natural_opium_alkaloids.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Natural_opium_alkaloids.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Serotonin_5HT3_antagonists
  ON MESH_SLING.patid =ATC_Serotonin_5HT3_antagonists.person_id
  and ATC_Serotonin_5HT3_antagonists.descriptive = 'ATC_Serotonin_5HT3_antagonists'
  and ATC_Serotonin_5HT3_antagonists.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Serotonin_5HT3_antagonists.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Selective_serotonin_reuptake_inhibitors
  ON MESH_SLING.patid =ATC_Selective_serotonin_reuptake_inhibitors.person_id
  and ATC_Selective_serotonin_reuptake_inhibitors.descriptive = 'ATC_Selective_serotonin_reuptake_inhibitors'
  and ATC_Selective_serotonin_reuptake_inhibitors.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Selective_serotonin_reuptake_inhibitors.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS
,ATC_Natural_opium_alkaloids.person_id
,ATC_Serotonin_5HT3_antagonists.person_id
,ATC_Selective_serotonin_reuptake_inhibitors.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 6
if OBJECT_ID('tempdb..#MESH_FINAL6') IS NOT NULL drop table #MESH_FINAL6;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS

, case when ATC_Other_antiepileptics.person_id is not null then 1 else 0 end ATC_Other_antiepileptics
, case when ATC_ACE_inhibitors_plain.person_id is not null then 1 else 0 end ATC_ACE_inhibitors_plain
, case when ATC_Other_antidepressants.person_id is not null then 1 else 0 end ATC_Other_antidepressants

INTO #MESH_FINAL6
FROM #MESH_FINAL5 as MESH_SLING

left join #MESH_APPENDIX as ATC_Other_antiepileptics
  ON MESH_SLING.patid =ATC_Other_antiepileptics.person_id
  and ATC_Other_antiepileptics.descriptive = 'ATC_Other_antiepileptics'
  and ATC_Other_antiepileptics.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Other_antiepileptics.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_ACE_inhibitors_plain
  ON MESH_SLING.patid =ATC_ACE_inhibitors_plain.person_id
  and ATC_ACE_inhibitors_plain.descriptive = 'ATC_ACE_inhibitors_plain'
  and ATC_ACE_inhibitors_plain.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_ACE_inhibitors_plain.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Other_antidepressants
  ON MESH_SLING.patid =ATC_Other_antidepressants.person_id
  and ATC_Other_antidepressants.descriptive = 'ATC_Other_antidepressants'
  and ATC_Other_antidepressants.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Other_antidepressants.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

GROUP BY 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS
,ATC_Other_antiepileptics.person_id
,ATC_ACE_inhibitors_plain.person_id
,ATC_Other_antidepressants.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 7
if OBJECT_ID('tempdb..#MESH_FINAL7') IS NOT NULL drop table #MESH_FINAL7;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS
, case when ATC_Thiazides_plain.person_id is not null then 1 else 0 end ATC_Thiazides_plain
, case when ATC_Other_urologicals.person_id is not null then 1 else 0 end ATC_Other_urologicals
, case when ATC_Fluoroquinolones.person_id is not null then 1 else 0 end ATC_Fluoroquinolones
, case when ATC_Beta_blocking_agents_selective.person_id is not null then 1 else 0 end ATC_Beta_blocking_agents_selective

INTO #MESH_FINAL7
FROM #MESH_FINAL6 as MESH_SLING

left join #MESH_APPENDIX as ATC_Thiazides_plain
  ON MESH_SLING.patid =ATC_Thiazides_plain.person_id
  and ATC_Thiazides_plain.descriptive = 'ATC_Thiazides_plain'
  and ATC_Thiazides_plain.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Thiazides_plain.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Other_urologicals
  ON MESH_SLING.patid =ATC_Other_urologicals.person_id
  and ATC_Other_urologicals.descriptive = 'ATC_Other_urologicals'
  and ATC_Other_urologicals.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Other_urologicals.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Fluoroquinolones
  ON MESH_SLING.patid =ATC_Fluoroquinolones.person_id
  and ATC_Fluoroquinolones.descriptive = 'ATC_Fluoroquinolones'
  and ATC_Fluoroquinolones.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Fluoroquinolones.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Beta_blocking_agents_selective
  ON MESH_SLING.patid =ATC_Beta_blocking_agents_selective.person_id
  and ATC_Beta_blocking_agents_selective.descriptive = 'ATC_Beta_blocking_agents_selective'
  and ATC_Beta_blocking_agents_selective.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Beta_blocking_agents_selective.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS
,ATC_Thiazides_plain.person_id
,ATC_Other_urologicals.person_id
,ATC_Fluoroquinolones.person_id
,ATC_Beta_blocking_agents_selective.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 8
if OBJECT_ID('tempdb..#MESH_FINAL8') IS NOT NULL drop table #MESH_FINAL8;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE
, case when ATC_Benzodiazepine_derivatives.person_id is not null then 1 else 0 end ATC_Benzodiazepine_derivatives
, case when ATC_Nitrofuran_derivatives.person_id is not null then 1 else 0 end ATC_Nitrofuran_derivatives
, case when ATC_Opium_alkaloids_and_derivatives.person_id is not null then 1 else 0 end ATC_Opium_alkaloids_and_derivatives
--, case when ATC_Benzodiazepine_derivatives.person_id is not null then 1 else 0 end ATC_Benzodiazepine_derivatives
, case when ATC_Thyroid_hormones.person_id is not null then 1 else 0 end ATC_Thyroid_hormones
INTO #MESH_FINAL8
FROM #MESH_FINAL7 as MESH_SLING

left join #MESH_APPENDIX as ATC_Benzodiazepine_derivatives
  ON MESH_SLING.patid =ATC_Benzodiazepine_derivatives.person_id
  and ATC_Benzodiazepine_derivatives.descriptive = 'ATC_Benzodiazepine_derivatives'
  and ATC_Benzodiazepine_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Benzodiazepine_derivatives.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Nitrofuran_derivatives
  ON MESH_SLING.patid =ATC_Nitrofuran_derivatives.person_id
  and ATC_Nitrofuran_derivatives.descriptive = 'ATC_Nitrofuran_derivatives'
  and ATC_Nitrofuran_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Nitrofuran_derivatives.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Opium_alkaloids_and_derivatives
  ON MESH_SLING.patid =ATC_Opium_alkaloids_and_derivatives.person_id
  and ATC_Opium_alkaloids_and_derivatives.descriptive = 'ATC_Opium_alkaloids_and_derivatives'
  and ATC_Opium_alkaloids_and_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Opium_alkaloids_and_derivatives.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Thyroid_hormones
  ON MESH_SLING.patid =ATC_Thyroid_hormones.person_id
  and ATC_Thyroid_hormones.descriptive = 'ATC_Thyroid_hormones'
  and ATC_Thyroid_hormones.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Thyroid_hormones.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE
,ATC_Benzodiazepine_derivatives.person_id
,ATC_Nitrofuran_derivatives.person_id
,ATC_Opium_alkaloids_and_derivatives.person_id
--,ATC_Benzodiazepine_derivatives.person_id
,ATC_Thyroid_hormones.person_id
;
-------------------------------------------------------------------------------> FINAL SECTION 9
if OBJECT_ID('tempdb..#MESH_FINAL9') IS NOT NULL drop table #MESH_FINAL9;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES

, case when ATC_Amides.person_id is not null then 1 else 0 end ATC_Amides
, case when ATC_Glucocorticoids.person_id is not null then 1 else 0 end ATC_Glucocorticoids
, case when ATC_Propionic_acid_derivatives.person_id is not null then 1 else 0 end ATC_Propionic_acid_derivatives
, case when ATC_Angiotensin_II_antagonists_plain.person_id is not null then 1 else 0 end ATC_Angiotensin_II_antagonists_plain
, case when ATC_Dihydropyridine_derivatives.person_id is not null then 1 else 0 end ATC_Dihydropyridine_derivatives
, case when ATC_Phenothiazine_derivatives.person_id is not null then 1 else 0 end ATC_Phenothiazine_derivatives

INTO #MESH_FINAL9
FROM #MESH_FINAL8 as MESH_SLING

left join #MESH_APPENDIX as ATC_Amides
  ON MESH_SLING.patid =ATC_Amides.person_id
  and ATC_Amides.descriptive = 'ATC_Amides'
  and ATC_Amides.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Amides.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Glucocorticoids
  ON MESH_SLING.patid =ATC_Glucocorticoids.person_id
  and ATC_Glucocorticoids.descriptive = 'ATC_Glucocorticoids'
  and ATC_Glucocorticoids.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Glucocorticoids.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Propionic_acid_derivatives
  ON MESH_SLING.patid =ATC_Propionic_acid_derivatives.person_id
  and ATC_Propionic_acid_derivatives.descriptive = 'ATC_Propionic_acid_derivatives'
  and ATC_Propionic_acid_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Propionic_acid_derivatives.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Angiotensin_II_antagonists_plain
  ON MESH_SLING.patid =ATC_Angiotensin_II_antagonists_plain.person_id
  and ATC_Angiotensin_II_antagonists_plain.descriptive = 'ATC_Angiotensin_II_antagonists_plain'
  and ATC_Angiotensin_II_antagonists_plain.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Angiotensin_II_antagonists_plain.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Dihydropyridine_derivatives
  ON MESH_SLING.patid =ATC_Dihydropyridine_derivatives.person_id
  and ATC_Dihydropyridine_derivatives.descriptive = 'ATC_Dihydropyridine_derivatives'
  and ATC_Dihydropyridine_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Dihydropyridine_derivatives.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Phenothiazine_derivatives
  ON MESH_SLING.patid =ATC_Phenothiazine_derivatives.person_id
  and ATC_Phenothiazine_derivatives.descriptive = 'ATC_Phenothiazine_derivatives'
  and ATC_Phenothiazine_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Phenothiazine_derivatives.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES
,ATC_Amides.person_id
,ATC_Glucocorticoids.person_id
,ATC_Propionic_acid_derivatives.person_id
,ATC_Angiotensin_II_antagonists_plain.person_id
,ATC_Dihydropyridine_derivatives.person_id
,ATC_Phenothiazine_derivatives.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 10
if OBJECT_ID('tempdb..#MESH_FINAL10') IS NOT NULL drop table #MESH_FINAL10;

SELECT PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES

, case when ATC_Phenylpiperidine_derivatives.person_id is not null then 1 else 0 end ATC_Phenylpiperidine_derivatives
, case when ATC_H2_receptor_antagonists.person_id is not null then 1 else 0 end ATC_H2_receptor_antagonists
, case when ATC_Acetic_acid_derivatives_and_related_substances.person_id is not null then 1 else 0 end ATC_Acetic_acid_derivatives_and_related_substances
, case when ATC_Corticosteroids_plain.person_id is not null then 1 else 0 end ATC_Corticosteroids_plain
, case when ATC_Other_antihistamines_for_systemic_use.person_id is not null then 1 else 0 end ATC_Other_antihistamines_for_systemic_use
, case when ATC_Vitamin_D_and_analogues.person_id is not null then 1 else 0 end ATC_Vitamin_D_and_analogues
, case when ATC_Piperazine_derivatives.person_id is not null then 1 else 0 end ATC_Piperazine_derivatives
, case when ATC_Sulfonamides_plain.person_id is not null then 1 else 0 end ATC_Sulfonamides_plain
, case when ATC_Non_selective_monoamine_reuptake_inhibitors.person_id is not null then 1 else 0 end ATC_Non_selective_monoamine_reuptake_inhibitors

INTO #MESH_FINAL10
FROM #MESH_FINAL9 as MESH_SLING
left join #MESH_APPENDIX as ATC_Phenylpiperidine_derivatives
  ON MESH_SLING.patid =ATC_Phenylpiperidine_derivatives.person_id
  and ATC_Phenylpiperidine_derivatives.descriptive = 'ATC_Phenylpiperidine_derivatives'
  and ATC_Phenylpiperidine_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Phenylpiperidine_derivatives.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_H2_receptor_antagonists
  ON MESH_SLING.patid =ATC_H2_receptor_antagonists.person_id
  and ATC_H2_receptor_antagonists.descriptive = 'ATC_H2_receptor_antagonists'
  and ATC_H2_receptor_antagonists.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_H2_receptor_antagonists.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Acetic_acid_derivatives_and_related_substances
  ON MESH_SLING.patid =ATC_Acetic_acid_derivatives_and_related_substances.person_id
  and ATC_Acetic_acid_derivatives_and_related_substances.descriptive = 'ATC_Acetic_acid_derivatives_and_related_substances'
  and ATC_Acetic_acid_derivatives_and_related_substances.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Acetic_acid_derivatives_and_related_substances.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Corticosteroids_plain
  ON MESH_SLING.patid =ATC_Corticosteroids_plain.person_id
  and ATC_Corticosteroids_plain.descriptive = 'ATC_Corticosteroids_plain'
  and ATC_Corticosteroids_plain.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Corticosteroids_plain.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Other_antihistamines_for_systemic_use
  ON MESH_SLING.patid =ATC_Other_antihistamines_for_systemic_use.person_id
  and ATC_Other_antihistamines_for_systemic_use.descriptive = 'ATC_Other_antihistamines_for_systemic_use'
  and ATC_Other_antihistamines_for_systemic_use.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Other_antihistamines_for_systemic_use.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Vitamin_D_and_analogues
  ON MESH_SLING.patid =ATC_Vitamin_D_and_analogues.person_id
  and ATC_Vitamin_D_and_analogues.descriptive = 'ATC_Vitamin_D_and_analogues'
  and ATC_Vitamin_D_and_analogues.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Vitamin_D_and_analogues.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

left join #MESH_APPENDIX as ATC_Piperazine_derivatives
  ON MESH_SLING.patid =ATC_Piperazine_derivatives.person_id
  and ATC_Piperazine_derivatives.descriptive = 'ATC_Piperazine_derivatives'
  and ATC_Piperazine_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Piperazine_derivatives.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182

left join #MESH_APPENDIX as ATC_Sulfonamides_plain
  ON MESH_SLING.patid =ATC_Sulfonamides_plain.person_id
  and ATC_Sulfonamides_plain.descriptive = 'ATC_Sulfonamides_plain'
  and ATC_Sulfonamides_plain.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Sulfonamides_plain.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182

left join #MESH_APPENDIX as ATC_Non_selective_monoamine_reuptake_inhibitors
  ON MESH_SLING.patid =ATC_Non_selective_monoamine_reuptake_inhibitors.person_id
  and ATC_Non_selective_monoamine_reuptake_inhibitors.descriptive = 'ATC_Non_selective_monoamine_reuptake_inhibitors'
  and ATC_Non_selective_monoamine_reuptake_inhibitors.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Non_selective_monoamine_reuptake_inhibitors.valuedate, MESH_SLING.DATETIMESURGERY ) <= 182 

GROUP BY PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES
,ATC_Phenylpiperidine_derivatives.person_id
,ATC_H2_receptor_antagonists.person_id
,ATC_Acetic_acid_derivatives_and_related_substances.person_id
,ATC_Corticosteroids_plain.person_id
,ATC_Other_antihistamines_for_systemic_use.person_id
,ATC_Vitamin_D_and_analogues.person_id
,ATC_Piperazine_derivatives.person_id
,ATC_Sulfonamides_plain.person_id
,ATC_Non_selective_monoamine_reuptake_inhibitors.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 11
if OBJECT_ID('tempdb..#MESH_FINAL11') IS NOT NULL drop table #MESH_FINAL11;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS

, case when ATC_Other_centrally_acting_agents.person_id is not null then 1 else 0 end ATC_Other_centrally_acting_agents
, case when ATC_Biguanides.person_id is not null then 1 else 0 end ATC_Biguanides
, case when ATC_Anesthetics_for_topical_use.person_id is not null then 1 else 0 end ATC_Anesthetics_for_topical_use
, case when ATC_Anesthetics_local.person_id is not null then 1 else 0 end ATC_Anesthetics_local
, case when ATC_Softeners_emollients.person_id is not null then 1 else 0 end ATC_Softeners_emollients
, case when ATC_Other_plain_vitamin_preparations.person_id is not null then 1 else 0 end ATC_Other_plain_vitamin_preparations
, case when ATC_Other_general_anesthetics.person_id is not null then 1 else 0 end ATC_Other_general_anesthetics
, case when ATC_Benzodiazepine_related_drugs.person_id is not null then 1 else 0 end ATC_Benzodiazepine_related_drugs
, case when ATC_Other_quaternary_ammonium_compounds.person_id is not null then 1 else 0 end ATC_Other_quaternary_ammonium_compounds
, case when ATC_Trimethoprim_and_derivatives.person_id is not null then 1 else 0 end ATC_Trimethoprim_and_derivatives
, case when ATC_Opioid_anesthetics.person_id is not null then 1 else 0 end ATC_Opioid_anesthetics

INTO #MESH_FINAL11
FROM #MESH_FINAL10 as MESH_SLING

left join #MESH_APPENDIX as ATC_Other_centrally_acting_agents
  ON MESH_SLING.patid =ATC_Other_centrally_acting_agents.person_id
  and ATC_Other_centrally_acting_agents.descriptive = 'ATC_Other_centrally_acting_agents'
  and ATC_Other_centrally_acting_agents.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Other_centrally_acting_agents.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Biguanides
  ON MESH_SLING.patid =ATC_Biguanides.person_id
  and ATC_Biguanides.descriptive = 'ATC_Biguanides'
  and ATC_Biguanides.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Biguanides.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Anesthetics_for_topical_use
  ON MESH_SLING.patid =ATC_Anesthetics_for_topical_use.person_id
  and ATC_Anesthetics_for_topical_use.descriptive = 'ATC_Anesthetics_for_topical_use'
  and ATC_Anesthetics_for_topical_use.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Anesthetics_for_topical_use.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Anesthetics_local
  ON MESH_SLING.patid =ATC_Anesthetics_local.person_id
  and ATC_Anesthetics_local.descriptive = 'ATC_Anesthetics_local'
  and ATC_Anesthetics_local.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Anesthetics_local.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Softeners_emollients
  ON MESH_SLING.patid =ATC_Softeners_emollients.person_id
  and ATC_Softeners_emollients.descriptive = 'ATC_Softeners_emollients'
  and ATC_Softeners_emollients.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Softeners_emollients.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Other_plain_vitamin_preparations
  ON MESH_SLING.patid =ATC_Other_plain_vitamin_preparations.person_id
  and ATC_Other_plain_vitamin_preparations.descriptive = 'ATC_Other_plain_vitamin_preparations'
  and ATC_Other_plain_vitamin_preparations.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Other_plain_vitamin_preparations.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Other_general_anesthetics
  ON MESH_SLING.patid =ATC_Other_general_anesthetics.person_id
  and ATC_Other_general_anesthetics.descriptive = 'ATC_Other_general_anesthetics'
  and ATC_Other_general_anesthetics.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Other_general_anesthetics.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Benzodiazepine_related_drugs
  ON MESH_SLING.patid =ATC_Benzodiazepine_related_drugs.person_id
  and ATC_Benzodiazepine_related_drugs.descriptive = 'ATC_Benzodiazepine_related_drugs'
  and ATC_Benzodiazepine_related_drugs.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Benzodiazepine_related_drugs.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Other_quaternary_ammonium_compounds
  ON MESH_SLING.patid =ATC_Other_quaternary_ammonium_compounds.person_id
  and ATC_Other_quaternary_ammonium_compounds.descriptive = 'ATC_Other_quaternary_ammonium_compounds'
  and ATC_Other_quaternary_ammonium_compounds.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Other_quaternary_ammonium_compounds.valuedate,MESH_SLING.DATETIMESURGERY) <= 182   

left join #MESH_APPENDIX as ATC_Trimethoprim_and_derivatives
  ON MESH_SLING.patid =ATC_Trimethoprim_and_derivatives.person_id
  and ATC_Trimethoprim_and_derivatives.descriptive = 'ATC_Trimethoprim_and_derivatives'
  and ATC_Trimethoprim_and_derivatives.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day,ATC_Trimethoprim_and_derivatives.valuedate,MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Opioid_anesthetics
  ON MESH_SLING.patid =ATC_Opioid_anesthetics.person_id
  and ATC_Opioid_anesthetics.descriptive = 'ATC_Opioid_anesthetics'
  and ATC_Opioid_anesthetics.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Opioid_anesthetics.valuedate,MESH_SLING.DATETIMESURGERY) <= 182   

GROUP BY
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS
,ATC_Other_centrally_acting_agents.person_id
,ATC_Biguanides.person_id
,ATC_Anesthetics_for_topical_use.person_id
,ATC_Anesthetics_local.person_id
,ATC_Softeners_emollients.person_id
,ATC_Other_plain_vitamin_preparations.person_id
,ATC_Other_general_anesthetics.person_id
,ATC_Benzodiazepine_related_drugs.person_id
,ATC_Other_quaternary_ammonium_compounds.person_id
,ATC_Trimethoprim_and_derivatives.person_id
,ATC_Opioid_anesthetics.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 12
if OBJECT_ID('tempdb..#MESH_FINAL12') IS NOT NULL drop table #MESH_FINAL12;

SELECT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS
, case when ATC_Penicillins_with_extended_spectrum.person_id is not null then 1 else 0 end ATC_Penicillins_with_extended_spectrum
, case when ATC_Intermediate_acting_sulfonamides.person_id is not null then 1 else 0 end ATC_Intermediate_acting_sulfonamides
INTO #MESH_FINAL12
FROM #MESH_FINAL11 as MESH_SLING

left join #MESH_APPENDIX as ATC_Penicillins_with_extended_spectrum
  ON MESH_SLING.patid =ATC_Penicillins_with_extended_spectrum.person_id
  and ATC_Penicillins_with_extended_spectrum.descriptive = 'ATC_Penicillins_with_extended_spectrum'
  and ATC_Penicillins_with_extended_spectrum.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Penicillins_with_extended_spectrum.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

left join #MESH_APPENDIX as ATC_Intermediate_acting_sulfonamides
  ON MESH_SLING.patid =ATC_Intermediate_acting_sulfonamides.person_id
  and ATC_Intermediate_acting_sulfonamides.descriptive = 'ATC_Intermediate_acting_sulfonamides'
  and ATC_Intermediate_acting_sulfonamides.valuedate <= MESH_SLING.DATETIMESURGERY 
  and datediff(day, ATC_Intermediate_acting_sulfonamides.valuedate, MESH_SLING.DATETIMESURGERY) <= 182 

GROUP BY 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS
,ATC_Penicillins_with_extended_spectrum.person_id
,ATC_Intermediate_acting_sulfonamides.person_id
;

-------------------------------------------------------------------------------> FINAL SECTION 13
if OBJECT_ID('tempdb..#MESH_FINAL13') IS NOT NULL drop table #MESH_FINAL13;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,

cast(min(ALT_BSP.valueasnumber) OVER(PARTITION BY ALT_BSP.person_id) as numeric(10,2)) as ALT_BSP_min,
cast(avg(ALT_BSP.valueasnumber) OVER(PARTITION BY ALT_BSP.person_id) as numeric(10,2)) as ALT_BSP_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY ALT_BSP.valueasnumber) OVER(PARTITION BY ALT_BSP.person_id) as numeric(10,2)) as ALT_BSP_median,
cast(max(ALT_BSP.valueasnumber) OVER(PARTITION BY ALT_BSP.person_id) as numeric(10,2)) as ALT_BSP_max,

cast(min(AST_BSP.valueasnumber) OVER(PARTITION BY AST_BSP.person_id) as numeric(10,2)) as AST_BSP_min,
cast(avg(AST_BSP.valueasnumber) OVER(PARTITION BY AST_BSP.person_id) as numeric(10,2)) as AST_BSP_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY AST_BSP.valueasnumber) OVER(PARTITION BY AST_BSP.person_id) as numeric(10,2)) as AST_BSP_median,
cast(max(AST_BSP.valueasnumber) OVER(PARTITION BY AST_BSP.person_id) as numeric(10,2)) as AST_BSP_max,

cast(min(Albumin_BSP_mg.valueasnumber) OVER(PARTITION BY Albumin_BSP_mg.person_id) as numeric(10,2)) as Albumin_BSP_mg_min,
cast(avg(Albumin_BSP_mg.valueasnumber) OVER(PARTITION BY Albumin_BSP_mg.person_id) as numeric(10,2)) as Albumin_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Albumin_BSP_mg.valueasnumber) OVER(PARTITION BY Albumin_BSP_mg.person_id) as numeric(10,2)) as Albumin_BSP_mg_median,
cast(max(Albumin_BSP_mg.valueasnumber) OVER(PARTITION BY Albumin_BSP_mg.person_id) as numeric(10,2)) as Albumin_BSP_mg_max

INTO #MESH_FINAL13
FROM #MESH_FINAL12 as MESH_SLING
  left join #MESH_APPENDIX as ALT_BSP
    ON MESH_SLING.patid =ALT_BSP.person_id
    and ALT_BSP.descriptive = 'ALT_BSP'
    and MESH_SLING.datetimesurgery > ALT_BSP.valuedate
    and datediff(day,ALT_BSP.valuedate, MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day,ALT_BSP.valuedate, MESH_SLING.datetimesurgery) >= 2

    left join #MESH_APPENDIX as AST_BSP
    ON MESH_SLING.patid =AST_BSP.person_id
    and AST_BSP.descriptive = 'AST_BSP'
    and MESH_SLING.datetimesurgery > AST_BSP.valuedate
    and datediff(day, AST_BSP.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, AST_BSP.valuedate,MESH_SLING.datetimesurgery) >= 2  

    left join #MESH_APPENDIX as Albumin_BSP_mg
    ON MESH_SLING.patid =Albumin_BSP_mg.person_id
    and Albumin_BSP_mg.descriptive = 'Albumin_BSP_mg'
    and MESH_SLING.datetimesurgery > Albumin_BSP_mg.valuedate
    and datediff(day, Albumin_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Albumin_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2
 
  ;

  -------------------------------------------------------------------------------> FINAL SECTION 14
if OBJECT_ID('tempdb..#MESH_FINAL14') IS NOT NULL drop table #MESH_FINAL14;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,

cast(min(BUN_BSP_mg.valueasnumber) OVER(PARTITION BY BUN_BSP_mg.person_id) as numeric(10,2)) as BUN_BSP_mg_min,
cast(avg(BUN_BSP_mg.valueasnumber) OVER(PARTITION BY BUN_BSP_mg.person_id) as numeric(10,2)) as BUN_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY BUN_BSP_mg.valueasnumber) OVER(PARTITION BY BUN_BSP_mg.person_id) as numeric(10,2)) as BUN_BSP_mg_median,
cast(max(BUN_BSP_mg.valueasnumber) OVER(PARTITION BY BUN_BSP_mg.person_id) as numeric(10,2)) as BUN_BSP_mg_max,

cast(min(Bili_Total_BSP_mg.valueasnumber) OVER(PARTITION BY Bili_Total_BSP_mg.person_id) as numeric(10,2)) as Bili_Total_BSP_mg_min,
cast(avg(Bili_Total_BSP_mg.valueasnumber) OVER(PARTITION BY Bili_Total_BSP_mg.person_id) as numeric(10,2)) as Bili_Total_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Bili_Total_BSP_mg.valueasnumber) OVER(PARTITION BY Bili_Total_BSP_mg.person_id) as numeric(10,2)) as Bili_Total_BSP_mg_median,
cast(max(Bili_Total_BSP_mg.valueasnumber) OVER(PARTITION BY Bili_Total_BSP_mg.person_id) as numeric(10,2)) as Bili_Total_BSP_mg_max,

cast(min(CO2_BSP_mmol.valueasnumber) OVER(PARTITION BY CO2_BSP_mmol.person_id) as numeric(10,2)) as CO2_BSP_mmol_min,
cast(avg(CO2_BSP_mmol.valueasnumber) OVER(PARTITION BY CO2_BSP_mmol.person_id) as numeric(10,2)) as CO2_BSP_mmol_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY CO2_BSP_mmol.valueasnumber) OVER(PARTITION BY CO2_BSP_mmol.person_id) as numeric(10,2)) as CO2_BSP_mmol_median,
cast(max(CO2_BSP_mmol.valueasnumber) OVER(PARTITION BY CO2_BSP_mmol.person_id) as numeric(10,2)) as CO2_BSP_mmol_max
INTO #MESH_FINAL14
FROM #MESH_FINAL13 as MESH_SLING

    left join #MESH_APPENDIX as BUN_BSP_mg
    ON MESH_SLING.patid =BUN_BSP_mg.person_id
    and BUN_BSP_mg.descriptive = 'BUN_BSP_mg'
    and MESH_SLING.datetimesurgery > BUN_BSP_mg.valuedate
    and datediff(day, BUN_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, BUN_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  
    
    left join #MESH_APPENDIX as Bili_Total_BSP_mg
    ON MESH_SLING.patid =Bili_Total_BSP_mg.person_id
    and Bili_Total_BSP_mg.descriptive = 'Bili_Total_BSP_mg'
    and MESH_SLING.datetimesurgery > Bili_Total_BSP_mg.valuedate
    and datediff(day, Bili_Total_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Bili_Total_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  

    left join #MESH_APPENDIX as CO2_BSP_mmol
    ON MESH_SLING.patid =CO2_BSP_mmol.person_id
    and CO2_BSP_mmol.descriptive = 'CO2_BSP_mmol'
    and MESH_SLING.datetimesurgery > CO2_BSP_mmol.valuedate
    and datediff(day, CO2_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, CO2_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) >= 2  
;

-------------------------------------------------------------------------------> FINAL SECTION 15
if OBJECT_ID('tempdb..#MESH_FINAL15') IS NOT NULL drop table #MESH_FINAL15;

SELECT DISTINCT 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,

cast(min(Ca_BSP_mg.valueasnumber) OVER(PARTITION BY Ca_BSP_mg.person_id) as numeric(10,2)) as Ca_BSP_mg_min,
cast(avg(Ca_BSP_mg.valueasnumber) OVER(PARTITION BY Ca_BSP_mg.person_id) as numeric(10,2)) as Ca_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Ca_BSP_mg.valueasnumber) OVER(PARTITION BY Ca_BSP_mg.person_id) as numeric(10,2)) as Ca_BSP_mg_median,
cast(max(Ca_BSP_mg.valueasnumber) OVER(PARTITION BY Ca_BSP_mg.person_id) as numeric(10,2)) as Ca_BSP_mg_max,

cast(min(Chol_BSP_mg.valueasnumber) OVER(PARTITION BY Chol_BSP_mg.person_id) as numeric(10,2)) as Chol_BSP_mg_min,
cast(avg(Chol_BSP_mg.valueasnumber) OVER(PARTITION BY Chol_BSP_mg.person_id) as numeric(10,2)) as Chol_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Chol_BSP_mg.valueasnumber) OVER(PARTITION BY Chol_BSP_mg.person_id)as numeric(10,2)) as Chol_BSP_mg_median,
cast(max(Chol_BSP_mg.valueasnumber) OVER(PARTITION BY Chol_BSP_mg.person_id) as numeric(10,2)) as Chol_BSP_mg_max,

cast(min(Cl_BSP_mmol.valueasnumber) OVER(PARTITION BY Cl_BSP_mmol.person_id) as numeric(10,2)) as Cl_BSP_mmol_min,
cast(avg(Cl_BSP_mmol.valueasnumber) OVER(PARTITION BY Cl_BSP_mmol.person_id) as numeric(10,2)) as Cl_BSP_mmol_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Cl_BSP_mmol.valueasnumber) OVER(PARTITION BY Cl_BSP_mmol.person_id) as numeric(10,2)) as Cl_BSP_mmol_median,
cast(max(Cl_BSP_mmol.valueasnumber) OVER(PARTITION BY Cl_BSP_mmol.person_id) as numeric(10,2)) as Cl_BSP_mmol_max

INTO #MESH_FINAL15
FROM #MESH_FINAL14 as MESH_SLING

left join #MESH_APPENDIX as Ca_BSP_mg
    ON MESH_SLING.patid =Ca_BSP_mg.person_id
    and Ca_BSP_mg.descriptive = 'Ca_BSP_mg'
    and MESH_SLING.datetimesurgery > Ca_BSP_mg.valuedate
    and datediff(day, Ca_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Ca_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2
   
    left join #MESH_APPENDIX as Chol_BSP_mg
    ON MESH_SLING.patid =Chol_BSP_mg.person_id
    and Chol_BSP_mg.descriptive = 'Chol_BSP_mg'
    and MESH_SLING.datetimesurgery > Chol_BSP_mg.valuedate
    and datediff(day, Chol_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Chol_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2

    left join #MESH_APPENDIX as Cl_BSP_mmol
    ON MESH_SLING.patid =Cl_BSP_mmol.person_id
    and Cl_BSP_mmol.descriptive = 'Cl_BSP_mmol'
    and MESH_SLING.datetimesurgery > Cl_BSP_mmol.valuedate
    and datediff(day, Cl_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Cl_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) >= 2    
;
-------------------------------------------------------------------------------> FINAL SECTION 16
if OBJECT_ID('tempdb..#MESH_FINAL16') IS NOT NULL drop table #MESH_FINAL16;
SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,

cast(min(Creat_BSP_mg.valueasnumber) OVER(PARTITION BY Creat_BSP_mg.person_id) as numeric(10,2)) as Creat_BSP_mg_min,
cast(avg(Creat_BSP_mg.valueasnumber) OVER(PARTITION BY Creat_BSP_mg.person_id) as numeric(10,2)) as Creat_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Creat_BSP_mg.valueasnumber) OVER(PARTITION BY Creat_BSP_mg.person_id) as numeric(10,2)) as Creat_BSP_mg_median,
cast(max(Creat_BSP_mg.valueasnumber) OVER(PARTITION BY Creat_BSP_mg.person_id) as numeric(10,2)) as Creat_BSP_mg_max,

cast(min(Ferritin_BSP_mg.valueasnumber) OVER(PARTITION BY Ferritin_BSP_mg.person_id) as numeric(10,2)) as Ferritin_BSP_mg_min,
cast(avg(Ferritin_BSP_mg.valueasnumber) OVER(PARTITION BY Ferritin_BSP_mg.person_id) as numeric(10,2)) as Ferritin_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Ferritin_BSP_mg.valueasnumber) OVER(PARTITION BY Ferritin_BSP_mg.person_id) as numeric(10,2)) as Ferritin_BSP_mg_median,
cast(max(Ferritin_BSP_mg.valueasnumber) OVER(PARTITION BY Ferritin_BSP_mg.person_id) as numeric(10,2)) as Ferritin_BSP_mg_max,

cast(min(Glucose_BSP_mg.valueasnumber) OVER(PARTITION BY Glucose_BSP_mg.person_id) as numeric(10,2)) as Glucose_BSP_mg_min,
cast(avg(Glucose_BSP_mg.valueasnumber) OVER(PARTITION BY Glucose_BSP_mg.person_id) as numeric(10,2)) as Glucose_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Glucose_BSP_mg.valueasnumber) OVER(PARTITION BY Glucose_BSP_mg.person_id) as numeric(10,2)) as Glucose_BSP_mg_median,
cast(max(Glucose_BSP_mg.valueasnumber) OVER(PARTITION BY Glucose_BSP_mg.person_id) as numeric(10,2)) as Glucose_BSP_mg_max

INTO #MESH_FINAL16
FROM #MESH_FINAL15 as MESH_SLING

    left join #MESH_APPENDIX as Creat_BSP_mg
    ON MESH_SLING.patid =Creat_BSP_mg.person_id
    and Creat_BSP_mg.descriptive = 'Creat_BSP_mg'
    and MESH_SLING.datetimesurgery > Creat_BSP_mg.valuedate
    and datediff(day, Creat_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Creat_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2

    left join #MESH_APPENDIX as Ferritin_BSP_mg
    ON MESH_SLING.patid =Ferritin_BSP_mg.person_id
    and Ferritin_BSP_mg.descriptive = 'Ferritin_BSP_mg'
    and MESH_SLING.datetimesurgery > Ferritin_BSP_mg.valuedate
    and datediff(day, Ferritin_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Ferritin_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  

   left join #MESH_APPENDIX as Glucose_BSP_mg
    ON MESH_SLING.patid =Glucose_BSP_mg.person_id
    and Glucose_BSP_mg.descriptive = 'Glucose_BSP_mg'
    and MESH_SLING.datetimesurgery > Glucose_BSP_mg.valuedate
    and datediff(day, Glucose_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Glucose_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2     

;

-------------------------------------------------------------------------------> FINAL SECTION 17
if OBJECT_ID('tempdb..#MESH_FINAL17') IS NOT NULL drop table #MESH_FINAL17;

SELECT DISTINCT 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max,

cast(min(HDL_BSP_mg.valueasnumber) OVER(PARTITION BY HDL_BSP_mg.person_id) as numeric(10,2)) as HDL_BSP_mg_min,
cast(avg(HDL_BSP_mg.valueasnumber) OVER(PARTITION BY HDL_BSP_mg.person_id) as numeric(10,2)) as HDL_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY HDL_BSP_mg.valueasnumber) OVER(PARTITION BY HDL_BSP_mg.person_id) as numeric(10,2)) as HDL_BSP_mg_median,
cast(max(HDL_BSP_mg.valueasnumber) OVER(PARTITION BY HDL_BSP_mg.person_id) as numeric(10,2)) as HDL_BSP_mg_max,

cast(min(HgbA1c_BSP.valueasnumber) OVER(PARTITION BY HgbA1c_BSP.person_id) as numeric(10,2)) as HgbA1c_BSP_min,
cast(avg(HgbA1c_BSP.valueasnumber) OVER(PARTITION BY HgbA1c_BSP.person_id) as numeric(10,2)) as HgbA1c_BSP_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY HgbA1c_BSP.valueasnumber) OVER(PARTITION BY HgbA1c_BSP.person_id) as numeric(10,2)) as HgbA1c_BSP_median,
cast(max(HgbA1c_BSP.valueasnumber) OVER(PARTITION BY HgbA1c_BSP.person_id) as numeric(10,2)) as HgbA1c_BSP_max,

cast(min(Hgb_BSP_gm.valueasnumber) OVER(PARTITION BY Hgb_BSP_gm.person_id) as numeric(10,2)) as Hgb_BSP_gm_min,
cast(avg(Hgb_BSP_gm.valueasnumber) OVER(PARTITION BY Hgb_BSP_gm.person_id) as numeric(10,2)) as Hgb_BSP_gm_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Hgb_BSP_gm.valueasnumber) OVER(PARTITION BY Hgb_BSP_gm.person_id) as numeric(10,2)) as Hgb_BSP_gm_median,
cast(max(Hgb_BSP_gm.valueasnumber) OVER(PARTITION BY Hgb_BSP_gm.person_id) as numeric(10,2)) as Hgb_BSP_gm_max

INTO #MESH_FINAL17
FROM #MESH_FINAL16 as MESH_SLING
      left join #MESH_APPENDIX as HDL_BSP_mg
    ON MESH_SLING.patid =HDL_BSP_mg.person_id
    and HDL_BSP_mg.descriptive = 'HDL_BSP_mg'
    and MESH_SLING.datetimesurgery > HDL_BSP_mg.valuedate
    and datediff(day, HDL_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, HDL_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2   

      left join #MESH_APPENDIX as HgbA1c_BSP
    ON MESH_SLING.patid =HgbA1c_BSP.person_id
    and HgbA1c_BSP.descriptive = 'HgbA1c_BSP'
    and MESH_SLING.datetimesurgery > HgbA1c_BSP.valuedate
    and datediff(day, HgbA1c_BSP.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, HgbA1c_BSP.valuedate,MESH_SLING.datetimesurgery) >= 2      

      left join #MESH_APPENDIX as Hgb_BSP_gm
    ON MESH_SLING.patid =Hgb_BSP_gm.person_id
    and Hgb_BSP_gm.descriptive = 'Hgb_BSP_gm'
    and MESH_SLING.datetimesurgery > Hgb_BSP_gm.valuedate
    and datediff(day, Hgb_BSP_gm.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Hgb_BSP_gm.valuedate,MESH_SLING.datetimesurgery) >= 2

;
-------------------------------------------------------------------------------> FINAL SECTION 18
if OBJECT_ID('tempdb..#MESH_FINAL18') IS NOT NULL drop table #MESH_FINAL18;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,

cast(min(Hgb_UA.valueasnumber) OVER(PARTITION BY Hgb_UA.person_id) as numeric(10,2)) as Hgb_UA_min,
cast(avg(Hgb_UA.valueasnumber) OVER(PARTITION BY Hgb_UA.person_id) as numeric(10,2)) as Hgb_UA_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Hgb_UA.valueasnumber) OVER(PARTITION BY Hgb_UA.person_id) as numeric(10,2)) as Hgb_UA_median,
cast(max(Hgb_UA.valueasnumber) OVER(PARTITION BY Hgb_UA.person_id) as numeric(10,2)) as Hgb_UA_max,

cast(min(INR_BSP.valueasnumber) OVER(PARTITION BY INR_BSP.person_id) as numeric(10,2)) as INR_BSP_min,
cast(avg(INR_BSP.valueasnumber) OVER(PARTITION BY INR_BSP.person_id) as numeric(10,2)) as INR_BSP_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY INR_BSP.valueasnumber) OVER(PARTITION BY INR_BSP.person_id) as numeric(10,2)) as INR_BSP_median,
cast(max(INR_BSP.valueasnumber) OVER(PARTITION BY INR_BSP.person_id) as numeric(10,2)) as INR_BSP_max,

cast(min(I_Calcium_BSP_mg.valueasnumber) OVER(PARTITION BY I_Calcium_BSP_mg.person_id) as numeric(10,2)) as I_Calcium_BSP_mg_min,
cast(avg(I_Calcium_BSP_mg.valueasnumber) OVER(PARTITION BY I_Calcium_BSP_mg.person_id) as numeric(10,2)) as I_Calcium_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY I_Calcium_BSP_mg.valueasnumber) OVER(PARTITION BY I_Calcium_BSP_mg.person_id) as numeric(10,2)) as I_Calcium_BSP_mg_median,
cast(max(I_Calcium_BSP_mg.valueasnumber) OVER(PARTITION BY I_Calcium_BSP_mg.person_id) as numeric(10,2)) as I_Calcium_BSP_mg_max

INTO #MESH_FINAL18
FROM #MESH_FINAL17 as MESH_SLING

  left join #MESH_APPENDIX as Hgb_UA
    ON MESH_SLING.patid =Hgb_UA.person_id
    and Hgb_UA.descriptive = 'Hgb_UA'
    and MESH_SLING.datetimesurgery > Hgb_UA.valuedate
    and datediff(day, Hgb_UA.valuedate, MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Hgb_UA.valuedate, MESH_SLING.datetimesurgery) >= 2  

  left join #MESH_APPENDIX as INR_BSP
    ON MESH_SLING.patid =INR_BSP.person_id
    and INR_BSP.descriptive = 'INR_BSP'
    and MESH_SLING.datetimesurgery > INR_BSP.valuedate
    and datediff(day, INR_BSP.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, INR_BSP.valuedate,MESH_SLING.datetimesurgery) >= 2  

  left join #MESH_APPENDIX as I_Calcium_BSP_mg
    ON MESH_SLING.patid =I_Calcium_BSP_mg.person_id
    and I_Calcium_BSP_mg.descriptive = 'I_Calcium_BSP_mg'
    and MESH_SLING.datetimesurgery > I_Calcium_BSP_mg.valuedate
    and datediff(day, I_Calcium_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, I_Calcium_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  
;

-------------------------------------------------------------------------------> FINAL SECTION 19
if OBJECT_ID('tempdb..#MESH_FINAL19') IS NOT NULL drop table #MESH_FINAL19;

SELECT DISTINCT 
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,

cast(min(Iron_BSP_mg.valueasnumber) OVER(PARTITION BY Iron_BSP_mg.person_id) as numeric(10,2)) as Iron_BSP_mg_min,
cast(avg(Iron_BSP_mg.valueasnumber) OVER(PARTITION BY Iron_BSP_mg.person_id) as numeric(10,2)) as Iron_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Iron_BSP_mg.valueasnumber) OVER(PARTITION BY Iron_BSP_mg.person_id) as numeric(10,2)) as Iron_BSP_mg_median,
cast(max(Iron_BSP_mg.valueasnumber) OVER(PARTITION BY Iron_BSP_mg.person_id) as numeric(10,2)) as Iron_BSP_mg_max,

cast(min(K_BSP_mmol.valueasnumber) OVER(PARTITION BY K_BSP_mmol.person_id) as numeric(10,2)) as K_BSP_mmol_min,
cast(avg(K_BSP_mmol.valueasnumber) OVER(PARTITION BY K_BSP_mmol.person_id) as numeric(10,2)) as K_BSP_mmol_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY K_BSP_mmol.valueasnumber) OVER(PARTITION BY K_BSP_mmol.person_id) as numeric(10,2)) as K_BSP_mmol_median,
cast(max(K_BSP_mmol.valueasnumber) OVER(PARTITION BY K_BSP_mmol.person_id) as numeric(10,2)) as K_BSP_mmol_max,

cast(min(Ketones_UA.valueasnumber) OVER(PARTITION BY Ketones_UA.person_id) as numeric(10,2)) as Ketones_UA_min,
cast(avg(Ketones_UA.valueasnumber) OVER(PARTITION BY Ketones_UA.person_id) as numeric(10,2)) as Ketones_UA_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Ketones_UA.valueasnumber) OVER(PARTITION BY Ketones_UA.person_id) as numeric(10,2)) as Ketones_UA_median,
cast(max(Ketones_UA.valueasnumber) OVER(PARTITION BY Ketones_UA.person_id) as numeric(10,2)) as Ketones_UA_max

INTO #MESH_FINAL19
FROM #MESH_FINAL18 as MESH_SLING

  left join #MESH_APPENDIX as Iron_BSP_mg
    ON MESH_SLING.patid =Iron_BSP_mg.person_id
    and Iron_BSP_mg.descriptive = 'Iron_BSP_mg'
    and MESH_SLING.datetimesurgery > Iron_BSP_mg.valuedate
    and datediff(day, Iron_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Iron_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  

  left join #MESH_APPENDIX as K_BSP_mmol
    ON MESH_SLING.patid =K_BSP_mmol.person_id
    and K_BSP_mmol.descriptive = 'K_BSP_mmol'
    and MESH_SLING.datetimesurgery > K_BSP_mmol.valuedate
    and datediff(day, K_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, K_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) >= 2  

  left join #MESH_APPENDIX as Ketones_UA
    ON MESH_SLING.patid =Ketones_UA.person_id
    and Ketones_UA.descriptive = 'Ketones_UA'
    and MESH_SLING.datetimesurgery > Ketones_UA.valuedate
    and datediff(day, Ketones_UA.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Ketones_UA.valuedate,MESH_SLING.datetimesurgery) >= 2  

;

-------------------------------------------------------------------------------> FINAL SECTION 20
if OBJECT_ID('tempdb..#MESH_FINAL20') IS NOT NULL drop table #MESH_FINAL20;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,

cast(min(LDL_BSP_mg.valueasnumber) OVER(PARTITION BY LDL_BSP_mg.person_id) as numeric(10,2)) as LDL_BSP_mg_min,
cast(avg(LDL_BSP_mg.valueasnumber) OVER(PARTITION BY LDL_BSP_mg.person_id) as numeric(10,2)) as LDL_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY LDL_BSP_mg.valueasnumber) OVER(PARTITION BY LDL_BSP_mg.person_id) as numeric(10,2)) as LDL_BSP_mg_median,
cast(max(LDL_BSP_mg.valueasnumber) OVER(PARTITION BY LDL_BSP_mg.person_id) as numeric(10,2)) as LDL_BSP_mg_max,

cast(min(MCHC_BSP_gm.valueasnumber) OVER(PARTITION BY MCHC_BSP_gm.person_id) as numeric(10,2)) as MCHC_BSP_gm_min,
cast(avg(MCHC_BSP_gm.valueasnumber) OVER(PARTITION BY MCHC_BSP_gm.person_id) as numeric(10,2)) as MCHC_BSP_gm_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY MCHC_BSP_gm.valueasnumber) OVER(PARTITION BY MCHC_BSP_gm.person_id) as numeric(10,2)) as MCHC_BSP_gm_median,
cast(max(MCHC_BSP_gm.valueasnumber) OVER(PARTITION BY MCHC_BSP_gm.person_id) as numeric(10,2)) as MCHC_BSP_gm_max,

cast(min(MCV_BSP_fL.valueasnumber) OVER(PARTITION BY MCV_BSP_fL.person_id) as numeric(10,2)) as MCV_BSP_fL_min,
cast(avg(MCV_BSP_fL.valueasnumber) OVER(PARTITION BY MCV_BSP_fL.person_id) as numeric(10,2)) as MCV_BSP_fL_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY MCV_BSP_fL.valueasnumber) OVER(PARTITION BY MCV_BSP_fL.person_id) as numeric(10,2)) as MCV_BSP_fL_median,
cast(max(MCV_BSP_fL.valueasnumber) OVER(PARTITION BY MCV_BSP_fL.person_id) as numeric(10,2)) as MCV_BSP_fL_max

INTO #MESH_FINAL20
FROM #MESH_FINAL19 as MESH_SLING

left join #MESH_APPENDIX as LDL_BSP_mg
    ON MESH_SLING.patid =LDL_BSP_mg.person_id
    and LDL_BSP_mg.descriptive = 'LDL_BSP_mg'
    and MESH_SLING.datetimesurgery > LDL_BSP_mg.valuedate
    and datediff(day, LDL_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, LDL_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2     

      left join #MESH_APPENDIX as MCHC_BSP_gm
    ON MESH_SLING.patid =MCHC_BSP_gm.person_id
    and MCHC_BSP_gm.descriptive = 'MCHC_BSP_gm'
    and MESH_SLING.datetimesurgery > MCHC_BSP_gm.valuedate
    and datediff(day, MCHC_BSP_gm.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, MCHC_BSP_gm.valuedate,MESH_SLING.datetimesurgery) >= 2     

      left join #MESH_APPENDIX as MCV_BSP_fL
    ON MESH_SLING.patid =MCV_BSP_fL.person_id
    and MCV_BSP_fL.descriptive = 'MCV_BSP_fL'
    and MESH_SLING.datetimesurgery > MCV_BSP_fL.valuedate
    and datediff(day, MCV_BSP_fL.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, MCV_BSP_fL.valuedate,MESH_SLING.datetimesurgery) >= 2     
  
;

-------------------------------------------------------------------------------> FINAL SECTION 21
if OBJECT_ID('tempdb..#MESH_FINAL21') IS NOT NULL drop table #MESH_FINAL21;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
cast(min(Magnesium_BSP_mg.valueasnumber) OVER(PARTITION BY Magnesium_BSP_mg.person_id) as numeric(10,2)) as Magnesium_BSP_mg_min,
cast(avg(Magnesium_BSP_mg.valueasnumber) OVER(PARTITION BY Magnesium_BSP_mg.person_id) as numeric(10,2)) as Magnesium_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Magnesium_BSP_mg.valueasnumber) OVER(PARTITION BY Magnesium_BSP_mg.person_id) as numeric(10,2)) as Magnesium_BSP_mg_median,
cast(max(Magnesium_BSP_mg.valueasnumber) OVER(PARTITION BY Magnesium_BSP_mg.person_id) as numeric(10,2)) as Magnesium_BSP_mg_max,

cast(min(Na_BSP_mmol.valueasnumber) OVER(PARTITION BY Na_BSP_mmol.person_id) as numeric(10,2)) as Na_BSP_mmol_min,
cast(avg(Na_BSP_mmol.valueasnumber) OVER(PARTITION BY Na_BSP_mmol.person_id) as numeric(10,2)) as Na_BSP_mmol_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Na_BSP_mmol.valueasnumber) OVER(PARTITION BY Na_BSP_mmol.person_id) as numeric(10,2))  as Na_BSP_mmol_median,
cast(max(Na_BSP_mmol.valueasnumber) OVER(PARTITION BY Na_BSP_mmol.person_id) as numeric(10,2)) as Na_BSP_mmol_max,

cast(min(Nitrite_UA.valueasnumber) OVER(PARTITION BY Nitrite_UA.person_id) as numeric(10,2)) as Nitrite_UA_min,
cast(avg(Nitrite_UA.valueasnumber) OVER(PARTITION BY Nitrite_UA.person_id) as numeric(10,2)) as Nitrite_UA_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Nitrite_UA.valueasnumber) OVER(PARTITION BY Nitrite_UA.person_id) as numeric(10,2)) as Nitrite_UA_median,
cast(max(Nitrite_UA.valueasnumber) OVER(PARTITION BY Nitrite_UA.person_id) as numeric(10,2)) as Nitrite_UA_max

INTO #MESH_FINAL21
FROM #MESH_FINAL20 as MESH_SLING
  left join #MESH_APPENDIX as Magnesium_BSP_mg
    ON MESH_SLING.patid =Magnesium_BSP_mg.person_id
    and Magnesium_BSP_mg.descriptive = 'Magnesium_BSP_mg'
    and MESH_SLING.datetimesurgery > Magnesium_BSP_mg.valuedate
    and datediff(day, Magnesium_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Magnesium_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  

      left join #MESH_APPENDIX as Na_BSP_mmol
    ON MESH_SLING.patid = Na_BSP_mmol.person_id
    and Na_BSP_mmol.descriptive = 'Na_BSP_mmol'
    and MESH_SLING.datetimesurgery > Na_BSP_mmol.valuedate
    and datediff(day, Na_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Na_BSP_mmol.valuedate,MESH_SLING.datetimesurgery) >= 2  

      left join #MESH_APPENDIX as Nitrite_UA
    ON MESH_SLING.patid =Nitrite_UA.person_id
    and Nitrite_UA.descriptive = 'Nitrite_UA'
    and MESH_SLING.datetimesurgery > Nitrite_UA.valuedate
    and datediff(day, Nitrite_UA.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Nitrite_UA.valuedate,MESH_SLING.datetimesurgery) >= 2  

;  

-------------------------------------------------------------------------------> FINAL SECTION 22
if OBJECT_ID('tempdb..#MESH_FINAL22') IS NOT NULL drop table #MESH_FINAL22;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
cast(min(PTT_BSP.valueasnumber) OVER(PARTITION BY PTT_BSP.person_id) as numeric(10,2)) as PTT_BSP_min,
cast(avg(PTT_BSP.valueasnumber) OVER(PARTITION BY PTT_BSP.person_id) as numeric(10,2)) as PTT_BSP_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY PTT_BSP.valueasnumber) OVER(PARTITION BY PTT_BSP.person_id) as numeric(10,2)) as PTT_BSP_median,
cast(max(PTT_BSP.valueasnumber) OVER(PARTITION BY PTT_BSP.person_id) as numeric(10,2)) as PTT_BSP_max,

cast(min(Phosphate_BSP_mg.valueasnumber) OVER(PARTITION BY Phosphate_BSP_mg.person_id) as numeric(10,2)) as Phosphate_BSP_mg_min,
cast(avg(Phosphate_BSP_mg.valueasnumber) OVER(PARTITION BY Phosphate_BSP_mg.person_id) as numeric(10,2)) as Phosphate_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Phosphate_BSP_mg.valueasnumber) OVER(PARTITION BY Phosphate_BSP_mg.person_id) as numeric(10,2)) as Phosphate_BSP_mg_median,
cast(max(Phosphate_BSP_mg.valueasnumber) OVER(PARTITION BY Phosphate_BSP_mg.person_id) as numeric(10,2)) as Phosphate_BSP_mg_max,

cast(min(Plt_BSP_cnt.valueasnumber) OVER(PARTITION BY Plt_BSP_cnt.person_id) as numeric(10,2)) as Plt_BSP_cnt_min,
cast(avg(Plt_BSP_cnt.valueasnumber) OVER(PARTITION BY Plt_BSP_cnt.person_id) as numeric(10,2)) as Plt_BSP_cnt_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Plt_BSP_cnt.valueasnumber) OVER(PARTITION BY Plt_BSP_cnt.person_id) as numeric(10,2)) as Plt_BSP_cnt_median,
cast(max(Plt_BSP_cnt.valueasnumber) OVER(PARTITION BY Plt_BSP_cnt.person_id) as numeric(10,2)) as Plt_BSP_cnt_max

INTO #MESH_FINAL22
FROM #MESH_FINAL21 as MESH_SLING
  left join #MESH_APPENDIX as PTT_BSP
    ON MESH_SLING.patid =PTT_BSP.person_id
    and PTT_BSP.descriptive = 'PTT_BSP'
    and MESH_SLING.datetimesurgery > PTT_BSP.valuedate
    and datediff(day, PTT_BSP.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, PTT_BSP.valuedate,MESH_SLING.datetimesurgery) >= 2    

      left join #MESH_APPENDIX as Phosphate_BSP_mg
    ON MESH_SLING.patid =Phosphate_BSP_mg.person_id
    and Phosphate_BSP_mg.descriptive = 'Phosphate_BSP_mg'
    and MESH_SLING.datetimesurgery > Phosphate_BSP_mg.valuedate
    and datediff(day, Phosphate_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Phosphate_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2    

      left join #MESH_APPENDIX as Plt_BSP_cnt
    ON MESH_SLING.patid =Plt_BSP_cnt.person_id
    and Plt_BSP_cnt.descriptive = 'Plt_BSP_cnt'
    and MESH_SLING.datetimesurgery > Plt_BSP_cnt.valuedate
    and datediff(day, Plt_BSP_cnt.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Plt_BSP_cnt.valuedate,MESH_SLING.datetimesurgery) >= 2    

;
-------------------------------------------------------------------------------> FINAL SECTION 23
if OBJECT_ID('tempdb..#MESH_FINAL23') IS NOT NULL drop table #MESH_FINAL23;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
PTT_BSP_min,
PTT_BSP_mean,
PTT_BSP_median,
PTT_BSP_max,
Phosphate_BSP_mg_min,
Phosphate_BSP_mg_mean,
Phosphate_BSP_mg_median,
Phosphate_BSP_mg_max,
Plt_BSP_cnt_min,
Plt_BSP_cnt_mean,
Plt_BSP_cnt_median,
Plt_BSP_cnt_max,
cast(min(Protein_UA.valueasnumber) OVER(PARTITION BY Protein_UA.person_id) as numeric(10,2)) as Protein_UA_min,
cast(avg(Protein_UA.valueasnumber) OVER(PARTITION BY Protein_UA.person_id) as numeric(10,2)) as Protein_UA_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Protein_UA.valueasnumber) OVER(PARTITION BY Protein_UA.person_id) as numeric(10,2)) as Protein_UA_median,
cast(max(Protein_UA.valueasnumber) OVER(PARTITION BY Protein_UA.person_id) as numeric(10,2)) as Protein_UA_max,

cast(min(RBC_UA_cnt.valueasnumber) OVER(PARTITION BY RBC_UA_cnt.person_id) as numeric(10,2)) as RBC_UA_cnt_min,
cast(avg(RBC_UA_cnt.valueasnumber) OVER(PARTITION BY RBC_UA_cnt.person_id) as numeric(10,2)) as RBC_UA_cnt_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY RBC_UA_cnt.valueasnumber) OVER(PARTITION BY RBC_UA_cnt.person_id) as numeric(10,2)) as RBC_UA_cnt_median,
cast(max(RBC_UA_cnt.valueasnumber) OVER(PARTITION BY RBC_UA_cnt.person_id) as numeric(10,2)) as RBC_UA_cnt_max,

cast(min(Sp_Gravity_UA.valueasnumber) OVER(PARTITION BY Sp_Gravity_UA.person_id) as numeric(10,2)) as Sp_Gravity_UA_min,
cast(avg(Sp_Gravity_UA.valueasnumber) OVER(PARTITION BY Sp_Gravity_UA.person_id) as numeric(10,2)) as Sp_Gravity_UA_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Sp_Gravity_UA.valueasnumber) OVER(PARTITION BY Sp_Gravity_UA.person_id) as numeric(10,2)) as Sp_Gravity_UA_median,
cast(max(Sp_Gravity_UA.valueasnumber) OVER(PARTITION BY Sp_Gravity_UA.person_id) as numeric(10,2)) as Sp_Gravity_UA_max

INTO #MESH_FINAL23
FROM #MESH_FINAL22 as MESH_SLING
  left join #MESH_APPENDIX as Protein_UA
    ON MESH_SLING.patid =Protein_UA.person_id
    and Protein_UA.descriptive = 'Protein_UA'
    and MESH_SLING.datetimesurgery > Protein_UA.valuedate
    and datediff(day, Protein_UA.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Protein_UA.valuedate,MESH_SLING.datetimesurgery) >= 2

      left join #MESH_APPENDIX as RBC_UA_cnt
    ON MESH_SLING.patid =RBC_UA_cnt.person_id
    and RBC_UA_cnt.descriptive = 'RBC_UA_cnt'
    and MESH_SLING.datetimesurgery > RBC_UA_cnt.valuedate
    and datediff(day, RBC_UA_cnt.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, RBC_UA_cnt.valuedate,MESH_SLING.datetimesurgery) >= 2

      left join #MESH_APPENDIX as Sp_Gravity_UA
    ON MESH_SLING.patid =Sp_Gravity_UA.person_id
    and Sp_Gravity_UA.descriptive = 'Sp_Gravity_UA'
    and MESH_SLING.datetimesurgery > Sp_Gravity_UA.valuedate
    and datediff(day, Sp_Gravity_UA.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Sp_Gravity_UA.valuedate,MESH_SLING.datetimesurgery) >= 2

;  

-------------------------------------------------------------------------------> FINAL SECTION 24
if OBJECT_ID('tempdb..#MESH_FINAL24') IS NOT NULL drop table #MESH_FINAL24;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
PTT_BSP_min,
PTT_BSP_mean,
PTT_BSP_median,
PTT_BSP_max,
Phosphate_BSP_mg_min,
Phosphate_BSP_mg_mean,
Phosphate_BSP_mg_median,
Phosphate_BSP_mg_max,
Plt_BSP_cnt_min,
Plt_BSP_cnt_mean,
Plt_BSP_cnt_median,
Plt_BSP_cnt_max,
Protein_UA_min,
Protein_UA_mean,
Protein_UA_median,
Protein_UA_max,
RBC_UA_cnt_min,
RBC_UA_cnt_mean,
RBC_UA_cnt_median,
RBC_UA_cnt_max,
Sp_Gravity_UA_min,
Sp_Gravity_UA_mean,
Sp_Gravity_UA_median,
Sp_Gravity_UA_max,
cast(min(T4_BSP_ug.valueasnumber) OVER(PARTITION BY T4_BSP_ug.person_id) as numeric(10,2)) as T4_BSP_ug_min,
cast(avg(T4_BSP_ug.valueasnumber) OVER(PARTITION BY T4_BSP_ug.person_id) as numeric(10,2)) as T4_BSP_ug_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY T4_BSP_ug.valueasnumber) OVER(PARTITION BY T4_BSP_ug.person_id) as numeric(10,2)) as T4_BSP_ug_median,
cast(max(T4_BSP_ug.valueasnumber) OVER(PARTITION BY T4_BSP_ug.person_id) as numeric(10,2)) as T4_BSP_ug_max,

cast(min(TIBC_BSP_mg.valueasnumber) OVER(PARTITION BY TIBC_BSP_mg.person_id) as numeric(10,2)) as TIBC_BSP_mg_min,
cast(avg(TIBC_BSP_mg.valueasnumber) OVER(PARTITION BY TIBC_BSP_mg.person_id) as numeric(10,2)) as TIBC_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY TIBC_BSP_mg.valueasnumber) OVER(PARTITION BY TIBC_BSP_mg.person_id) as numeric(10,2)) as TIBC_BSP_mg_median,
cast(max(TIBC_BSP_mg.valueasnumber) OVER(PARTITION BY TIBC_BSP_mg.person_id) as numeric(10,2)) as TIBC_BSP_mg_max,

cast(min(TSH_BSP_miu.valueasnumber) OVER(PARTITION BY TSH_BSP_miu.person_id) as numeric(10,2)) as TSH_BSP_miu_min,
cast(avg(TSH_BSP_miu.valueasnumber) OVER(PARTITION BY TSH_BSP_miu.person_id) as numeric(10,2)) as TSH_BSP_miu_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY TSH_BSP_miu.valueasnumber) OVER(PARTITION BY TSH_BSP_miu.person_id) as numeric(10,2)) as TSH_BSP_miu_median,
cast(max(TSH_BSP_miu.valueasnumber) OVER(PARTITION BY TSH_BSP_miu.person_id) as numeric(10,2)) as TSH_BSP_miu_max

INTO #MESH_FINAL24
FROM #MESH_FINAL23 as MESH_SLING
  left join #MESH_APPENDIX as T4_BSP_ug
    ON MESH_SLING.patid =T4_BSP_ug.person_id
    and T4_BSP_ug.descriptive = 'T4_BSP_ug'
    and MESH_SLING.datetimesurgery > T4_BSP_ug.valuedate
    and datediff(day, T4_BSP_ug.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, T4_BSP_ug.valuedate,MESH_SLING.datetimesurgery) >= 2 

      left join #MESH_APPENDIX as TIBC_BSP_mg
    ON MESH_SLING.patid =TIBC_BSP_mg.person_id
    and TIBC_BSP_mg.descriptive = 'TIBC_BSP_mg'
    and MESH_SLING.datetimesurgery > TIBC_BSP_mg.valuedate
    and datediff(day, TIBC_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, TIBC_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2 

      left join #MESH_APPENDIX as TSH_BSP_miu
    ON MESH_SLING.patid =TSH_BSP_miu.person_id
    and TSH_BSP_miu.descriptive = 'TSH_BSP_miu'
    and MESH_SLING.datetimesurgery > TSH_BSP_miu.valuedate
    and datediff(day, TSH_BSP_miu.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, TSH_BSP_miu.valuedate,MESH_SLING.datetimesurgery) >= 2 
               
;

-------------------------------------------------------------------------------> FINAL SECTION 25
if OBJECT_ID('tempdb..#MESH_FINAL25') IS NOT NULL drop table #MESH_FINAL25;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
PTT_BSP_min,
PTT_BSP_mean,
PTT_BSP_median,
PTT_BSP_max,
Phosphate_BSP_mg_min,
Phosphate_BSP_mg_mean,
Phosphate_BSP_mg_median,
Phosphate_BSP_mg_max,
Plt_BSP_cnt_min,
Plt_BSP_cnt_mean,
Plt_BSP_cnt_median,
Plt_BSP_cnt_max,
Protein_UA_min,
Protein_UA_mean,
Protein_UA_median,
Protein_UA_max,
RBC_UA_cnt_min,
RBC_UA_cnt_mean,
RBC_UA_cnt_median,
RBC_UA_cnt_max,
Sp_Gravity_UA_min,
Sp_Gravity_UA_mean,
Sp_Gravity_UA_median,
Sp_Gravity_UA_max,
T4_BSP_ug_min,
T4_BSP_ug_mean,
T4_BSP_ug_median,
T4_BSP_ug_max,
TIBC_BSP_mg_min,
TIBC_BSP_mg_mean,
TIBC_BSP_mg_median,
TIBC_BSP_mg_max,
TSH_BSP_miu_min,
TSH_BSP_miu_mean,
TSH_BSP_miu_median,
TSH_BSP_miu_max,
cast(min(Transferrin_BSP_mg.valueasnumber) OVER(PARTITION BY Transferrin_BSP_mg.person_id) as numeric(10,2)) as Transferrin_BSP_mg_min,
cast(avg(Transferrin_BSP_mg.valueasnumber) OVER(PARTITION BY Transferrin_BSP_mg.person_id) as numeric(10,2)) as Transferrin_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Transferrin_BSP_mg.valueasnumber) OVER(PARTITION BY Transferrin_BSP_mg.person_id) as numeric(10,2)) as Transferrin_BSP_mg_median,
cast(max(Transferrin_BSP_mg.valueasnumber) OVER(PARTITION BY Transferrin_BSP_mg.person_id) as numeric(10,2)) as Transferrin_BSP_mg_max,

cast(min(Trig_BSP_mg.valueasnumber) OVER(PARTITION BY Trig_BSP_mg.person_id) as numeric(10,2)) as Trig_BSP_mg_min,
cast(avg(Trig_BSP_mg.valueasnumber) OVER(PARTITION BY Trig_BSP_mg.person_id) as numeric(10,2)) as Trig_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Trig_BSP_mg.valueasnumber) OVER(PARTITION BY Trig_BSP_mg.person_id) as numeric(10,2)) as Trig_BSP_mg_median,
cast(max(Trig_BSP_mg.valueasnumber) OVER(PARTITION BY Trig_BSP_mg.person_id) as numeric(10,2)) as Trig_BSP_mg_max,

cast(min(Trop_I_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_I_BSP_mg.person_id) as numeric(10,2)) as Trop_I_BSP_mg_min,
cast(avg(Trop_I_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_I_BSP_mg.person_id) as numeric(10,2)) as Trop_I_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Trop_I_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_I_BSP_mg.person_id) as numeric(10,2)) as Trop_I_BSP_mg_median,
cast(max(Trop_I_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_I_BSP_mg.person_id) as numeric(10,2)) as Trop_I_BSP_mg_max

INTO #MESH_FINAL25
FROM #MESH_FINAL24 as MESH_SLING
  left join #MESH_APPENDIX as Transferrin_BSP_mg
    ON MESH_SLING.patid =Transferrin_BSP_mg.person_id
    and Transferrin_BSP_mg.descriptive = 'Transferrin_BSP_mg'
    and MESH_SLING.datetimesurgery > Transferrin_BSP_mg.valuedate
    and datediff(day, Transferrin_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Transferrin_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2 

      left join #MESH_APPENDIX as Trig_BSP_mg
    ON MESH_SLING.patid =Trig_BSP_mg.person_id
    and Trig_BSP_mg.descriptive = 'Trig_BSP_mg'
    and MESH_SLING.datetimesurgery > Trig_BSP_mg.valuedate
    and datediff(day, Trig_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Trig_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2 

      left join #MESH_APPENDIX as Trop_I_BSP_mg
    ON MESH_SLING.patid =Trop_I_BSP_mg.person_id
    and Trop_I_BSP_mg.descriptive = 'Trop_I_BSP_mg'
    and MESH_SLING.datetimesurgery > Trop_I_BSP_mg.valuedate
    and datediff(day, Trop_I_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, Trop_I_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2 

 
;

-------------------------------------------------------------------------------> FINAL SECTION 26
if OBJECT_ID('tempdb..#MESH_FINAL26') IS NOT NULL drop table #MESH_FINAL26;

SELECT DISTINCT
PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
PTT_BSP_min,
PTT_BSP_mean,
PTT_BSP_median,
PTT_BSP_max,
Phosphate_BSP_mg_min,
Phosphate_BSP_mg_mean,
Phosphate_BSP_mg_median,
Phosphate_BSP_mg_max,
Plt_BSP_cnt_min,
Plt_BSP_cnt_mean,
Plt_BSP_cnt_median,
Plt_BSP_cnt_max,
Protein_UA_min,
Protein_UA_mean,
Protein_UA_median,
Protein_UA_max,
RBC_UA_cnt_min,
RBC_UA_cnt_mean,
RBC_UA_cnt_median,
RBC_UA_cnt_max,
Sp_Gravity_UA_min,
Sp_Gravity_UA_mean,
Sp_Gravity_UA_median,
Sp_Gravity_UA_max,
T4_BSP_ug_min,
T4_BSP_ug_mean,
T4_BSP_ug_median,
T4_BSP_ug_max,
TIBC_BSP_mg_min,
TIBC_BSP_mg_mean,
TIBC_BSP_mg_median,
TIBC_BSP_mg_max,
TSH_BSP_miu_min,
TSH_BSP_miu_mean,
TSH_BSP_miu_median,
TSH_BSP_miu_max,
Transferrin_BSP_mg_min,
Transferrin_BSP_mg_mean,
Transferrin_BSP_mg_median,
Transferrin_BSP_mg_max,
Trig_BSP_mg_min,
Trig_BSP_mg_mean,
Trig_BSP_mg_median,
Trig_BSP_mg_max,
Trop_I_BSP_mg_min,
Trop_I_BSP_mg_mean,
Trop_I_BSP_mg_median,
Trop_I_BSP_mg_max,

cast(min(Trop_T_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_T_BSP_mg.person_id) as numeric(10,2)) as Trop_T_BSP_mg_min,
cast(avg(Trop_T_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_T_BSP_mg.person_id) as numeric(10,2)) as Trop_T_BSP_mg_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY Trop_T_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_T_BSP_mg.person_id) as numeric(10,2)) as Trop_T_BSP_mg_median,
cast(max(Trop_T_BSP_mg.valueasnumber) OVER(PARTITION BY Trop_T_BSP_mg.person_id) as numeric(10,2)) as Trop_T_BSP_mg_max,


cast(min(WBC_BSP_cnt.valueasnumber) OVER(PARTITION BY WBC_BSP_cnt.person_id) as numeric(10,2)) as WBC_BSP_cnt_min,
cast(avg(WBC_BSP_cnt.valueasnumber) OVER(PARTITION BY WBC_BSP_cnt.person_id) as numeric(10,2)) as WBC_BSP_cnt_mean,
cast(percentile_cont(.5) WITHIN GROUP(ORDER BY WBC_BSP_cnt.valueasnumber) OVER(PARTITION BY WBC_BSP_cnt.person_id) as numeric(10,2)) as WBC_BSP_cnt_median,
cast(max(WBC_BSP_cnt.valueasnumber) OVER(PARTITION BY WBC_BSP_cnt.person_id) as numeric(10,2)) as WBC_BSP_cnt_max

INTO #MESH_FINAL26
FROM #MESH_FINAL25 as MESH_SLING
  left join #MESH_APPENDIX as Trop_T_BSP_mg
    ON MESH_SLING.patid =Trop_T_BSP_mg.person_id
    and Trop_T_BSP_mg.descriptive = 'Trop_T_BSP_mg'
    and MESH_SLING.datetimesurgery > Trop_T_BSP_mg.valuedate
    and datediff(day,Trop_T_BSP_mg.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day,Trop_T_BSP_mg.valuedate,MESH_SLING.datetimesurgery) >= 2  

  left join #MESH_APPENDIX as WBC_BSP_cnt
    ON MESH_SLING.patid =WBC_BSP_cnt.person_id
    and WBC_BSP_cnt.descriptive = 'WBC_BSP_cnt'
    and MESH_SLING.datetimesurgery > WBC_BSP_cnt.valuedate
    and datediff(day, WBC_BSP_cnt.valuedate,MESH_SLING.datetimesurgery) <= 365 --pre
    and datediff(day, WBC_BSP_cnt.valuedate,MESH_SLING.datetimesurgery) >= 2  

;

-------------------------------------------------------------------------------> FINAL SECTION 27
if OBJECT_ID('tempdb..#MESH_FINAL27') IS NOT NULL drop table #MESH_FINAL27;

SELECT
 PATID,
DATETIMEBIRTH,
year(DATETIMEBIRTH) as year_of_birth,
month(DATETIMEBIRTH) as month_of_birth, 
day(DATETIMEBIRTH) as day_of_birth,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
case when MESH_SLING.bmi is null and person_weight.person_id is not null and person_height.person_id is not null
  THEN cast(avg(person_weight.valueasnumber)/ square(avg(person_height.valueasnumber)/100) as numeric(10,2))
  ELSE MESH_SLING.bmi END as BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
PTT_BSP_min,
PTT_BSP_mean,
PTT_BSP_median,
PTT_BSP_max,
Phosphate_BSP_mg_min,
Phosphate_BSP_mg_mean,
Phosphate_BSP_mg_median,
Phosphate_BSP_mg_max,
Plt_BSP_cnt_min,
Plt_BSP_cnt_mean,
Plt_BSP_cnt_median,
Plt_BSP_cnt_max,
Protein_UA_min,
Protein_UA_mean,
Protein_UA_median,
Protein_UA_max,
RBC_UA_cnt_min,
RBC_UA_cnt_mean,
RBC_UA_cnt_median,
RBC_UA_cnt_max,
Sp_Gravity_UA_min,
Sp_Gravity_UA_mean,
Sp_Gravity_UA_median,
Sp_Gravity_UA_max,
T4_BSP_ug_min,
T4_BSP_ug_mean,
T4_BSP_ug_median,
T4_BSP_ug_max,
TIBC_BSP_mg_min,
TIBC_BSP_mg_mean,
TIBC_BSP_mg_median,
TIBC_BSP_mg_max,
TSH_BSP_miu_min,
TSH_BSP_miu_mean,
TSH_BSP_miu_median,
TSH_BSP_miu_max,
Transferrin_BSP_mg_min,
Transferrin_BSP_mg_mean,
Transferrin_BSP_mg_median,
Transferrin_BSP_mg_max,
Trig_BSP_mg_min,
Trig_BSP_mg_mean,
Trig_BSP_mg_median,
Trig_BSP_mg_max,
Trop_I_BSP_mg_min,
Trop_I_BSP_mg_mean,
Trop_I_BSP_mg_median,
Trop_I_BSP_mg_max,
Trop_T_BSP_mg_min,
Trop_T_BSP_mg_mean,
Trop_T_BSP_mg_median,
Trop_T_BSP_mg_max,
WBC_BSP_cnt_min,
WBC_BSP_cnt_mean,
WBC_BSP_cnt_median,
WBC_BSP_cnt_max
INTO #MESH_FINAL27
FROM #MESH_FINAL26 as MESH_SLING 

  LEFT JOIN #MESH_APPENDIX as person_weight --prior
  ON MESH_SLING.PATID = person_weight.person_id
  and MESH_SLING.DATETIMESURGERY > person_weight.valuedate
  --and days_between(MESH_SLING.DATETIMESURGERY, person_weight.valuedate) <= 365
  and person_weight.descriptive = 'Weight'
  and person_weight.valueasnumber < 200

  LEFT JOIN #MESH_APPENDIX as person_height --prior
  ON MESH_SLING.PATID = person_height.person_id
  and MESH_SLING.DATETIMESURGERY > person_height.valuedate
  --and days_between(MESH_SLING.DATETIMESURGERY, person_height.valuedate) <= 365
  and person_height.descriptive = 'Height'
  and person_height.valueasnumber < 250  

GROUP BY
 PATID,
DATETIMEBIRTH,
DATETIMEDEATH,
DATETIMESURGERY,
INPAT_FOLLOW,
OUTPAT_FOLLOW,
BMI,
SUI_IND,
NON_SLING,
LAP_SLING,
FEMALE,
RACE,
HISPANIC,
HistoryMenopause,
DATETIMEREOPERATION,
INDICATION_REOPERATION,
DATETIMEREMOVAL,
DATETIMEPAIN,
PREHISTORYCHRONICPAIN,
PERIHISTORYCHRONICPAIN,
POSTHISTORYCHRONICPAIN,
PREDATETIMEVOIDING,
PERIDATETIMEVOIDING,
POSTDATETIMEVOIDING,
DATETIMEEROSION,
DATETIMEFISTULA,
PREABSURG,
PERIABSURG,
POSTABSURG,
DATETIMEINFECTION,
DATETIMEPERFORATION,
URODYNAMICTESTING,
HISTORYSMOKING,
PRESURGERYDM,
PRESURGERYHTN,
PRESURGERYCAD,
PRESURGERYPVD,
PRESURGERYHLD,
VISITYEARPRIORSURGERY,
VISITYEARPOSTSURGERY,
PRIORPROLAPSE,
PRIORSUI,
PRIORDIVERICULUM,
CONCOMITANTSURG,
ATC_FIRST_GENERATION_CEPHALOSPORINS,
ATC_ANILIDES,
ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN,
ATC_PROTON_PUMP_INHIBITORS,
ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE,
ATC_ELECTROLYTE_SOLUTIONS,
ATC_HMG_COA_REDUCTASE_INHIBITORS,
ATC_NATURAL_OPIUM_ALKALOIDS,
ATC_SEROTONIN_5HT3_ANTAGONISTS,
ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS,
ATC_OTHER_ANTIEPILEPTICS,
ATC_ACE_INHIBITORS_PLAIN,
ATC_OTHER_ANTIDEPRESSANTS,
ATC_THIAZIDES_PLAIN,
ATC_OTHER_UROLOGICALS,
ATC_FLUOROQUINOLONES,
ATC_BETA_BLOCKING_AGENTS_SELECTIVE,
ATC_BENZODIAZEPINE_DERIVATIVES,
ATC_NITROFURAN_DERIVATIVES,
ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES,
ATC_THYROID_HORMONES,
ATC_AMIDES,
ATC_GLUCOCORTICOIDS,
ATC_PROPIONIC_ACID_DERIVATIVES,
ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN,
ATC_DIHYDROPYRIDINE_DERIVATIVES,
ATC_PHENOTHIAZINE_DERIVATIVES,
ATC_PHENYLPIPERIDINE_DERIVATIVES,
ATC_H2_RECEPTOR_ANTAGONISTS,
ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES,
ATC_CORTICOSTEROIDS_PLAIN,
ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE,
ATC_VITAMIN_D_AND_ANALOGUES,
ATC_PIPERAZINE_DERIVATIVES,
ATC_SULFONAMIDES_PLAIN,
ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS,
ATC_OTHER_CENTRALLY_ACTING_AGENTS,
ATC_BIGUANIDES,
ATC_ANESTHETICS_FOR_TOPICAL_USE,
ATC_ANESTHETICS_LOCAL,
ATC_SOFTENERS_EMOLLIENTS,
ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS,
ATC_OTHER_GENERAL_ANESTHETICS,
ATC_BENZODIAZEPINE_RELATED_DRUGS,
ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS,
ATC_TRIMETHOPRIM_AND_DERIVATIVES,
ATC_OPIOID_ANESTHETICS, 
ATC_Penicillins_with_extended_spectrum,
ATC_Intermediate_acting_sulfonamides,
ALT_BSP_min,
ALT_BSP_mean,
ALT_BSP_median,
ALT_BSP_max,
AST_BSP_min,
AST_BSP_mean,
AST_BSP_median,
AST_BSP_max,
Albumin_BSP_mg_min,
Albumin_BSP_mg_mean,
Albumin_BSP_mg_median,
Albumin_BSP_mg_max,
BUN_BSP_mg_min,
BUN_BSP_mg_mean,
BUN_BSP_mg_median,
BUN_BSP_mg_max,
Bili_Total_BSP_mg_min,
Bili_Total_BSP_mg_mean,
Bili_Total_BSP_mg_median,
Bili_Total_BSP_mg_max,
CO2_BSP_mmol_min,
CO2_BSP_mmol_mean,
CO2_BSP_mmol_median,
CO2_BSP_mmol_max,
Ca_BSP_mg_min,
Ca_BSP_mg_mean,
Ca_BSP_mg_median,
Ca_BSP_mg_max,
Chol_BSP_mg_min,
Chol_BSP_mg_mean,
Chol_BSP_mg_median,
Chol_BSP_mg_max,
Cl_BSP_mmol_min,
Cl_BSP_mmol_mean,
Cl_BSP_mmol_median,
Cl_BSP_mmol_max,
Creat_BSP_mg_min,
Creat_BSP_mg_mean,
Creat_BSP_mg_median,
Creat_BSP_mg_max,
Ferritin_BSP_mg_min,
Ferritin_BSP_mg_mean,
Ferritin_BSP_mg_median,
Ferritin_BSP_mg_max,
Glucose_BSP_mg_min,
Glucose_BSP_mg_mean,
Glucose_BSP_mg_median,
Glucose_BSP_mg_max, 
HDL_BSP_mg_min,
HDL_BSP_mg_mean,
HDL_BSP_mg_median,
HDL_BSP_mg_max,
HgbA1c_BSP_min,
HgbA1c_BSP_mean,
HgbA1c_BSP_median,
HgbA1c_BSP_max,
Hgb_BSP_gm_min,
Hgb_BSP_gm_mean,
Hgb_BSP_gm_median,
Hgb_BSP_gm_max,
Hgb_UA_min,
Hgb_UA_mean,
Hgb_UA_median,
Hgb_UA_max,
INR_BSP_min,
INR_BSP_mean,
INR_BSP_median,
INR_BSP_max,
I_Calcium_BSP_mg_min,
I_Calcium_BSP_mg_mean,
I_Calcium_BSP_mg_median,
I_Calcium_BSP_mg_max,
Iron_BSP_mg_min,
Iron_BSP_mg_mean,
Iron_BSP_mg_median,
Iron_BSP_mg_max,
K_BSP_mmol_min,
K_BSP_mmol_mean,
K_BSP_mmol_median,
K_BSP_mmol_max,
Ketones_UA_min,
Ketones_UA_mean,
Ketones_UA_median,
Ketones_UA_max,
LDL_BSP_mg_min,
LDL_BSP_mg_mean,
LDL_BSP_mg_median,
LDL_BSP_mg_max,
MCHC_BSP_gm_min,
MCHC_BSP_gm_mean,
MCHC_BSP_gm_median,
MCHC_BSP_gm_max,
MCV_BSP_fL_min,
MCV_BSP_fL_mean,
MCV_BSP_fL_median,
MCV_BSP_fL_max,
Magnesium_BSP_mg_min,
Magnesium_BSP_mg_mean,
Magnesium_BSP_mg_median,
Magnesium_BSP_mg_max,
Na_BSP_mmol_min,
Na_BSP_mmol_mean,
Na_BSP_mmol_median,
Na_BSP_mmol_max,
Nitrite_UA_min,
Nitrite_UA_mean,
Nitrite_UA_median,
Nitrite_UA_max,
PTT_BSP_min,
PTT_BSP_mean,
PTT_BSP_median,
PTT_BSP_max,
Phosphate_BSP_mg_min,
Phosphate_BSP_mg_mean,
Phosphate_BSP_mg_median,
Phosphate_BSP_mg_max,
Plt_BSP_cnt_min,
Plt_BSP_cnt_mean,
Plt_BSP_cnt_median,
Plt_BSP_cnt_max,
Protein_UA_min,
Protein_UA_mean,
Protein_UA_median,
Protein_UA_max,
RBC_UA_cnt_min,
RBC_UA_cnt_mean,
RBC_UA_cnt_median,
RBC_UA_cnt_max,
Sp_Gravity_UA_min,
Sp_Gravity_UA_mean,
Sp_Gravity_UA_median,
Sp_Gravity_UA_max,
T4_BSP_ug_min,
T4_BSP_ug_mean,
T4_BSP_ug_median,
T4_BSP_ug_max,
TIBC_BSP_mg_min,
TIBC_BSP_mg_mean,
TIBC_BSP_mg_median,
TIBC_BSP_mg_max,
TSH_BSP_miu_min,
TSH_BSP_miu_mean,
TSH_BSP_miu_median,
TSH_BSP_miu_max,
Transferrin_BSP_mg_min,
Transferrin_BSP_mg_mean,
Transferrin_BSP_mg_median,
Transferrin_BSP_mg_max,
Trig_BSP_mg_min,
Trig_BSP_mg_mean,
Trig_BSP_mg_median,
Trig_BSP_mg_max,
Trop_I_BSP_mg_min,
Trop_I_BSP_mg_mean,
Trop_I_BSP_mg_median,
Trop_I_BSP_mg_max,
Trop_T_BSP_mg_min,
Trop_T_BSP_mg_mean,
Trop_T_BSP_mg_median,
Trop_T_BSP_mg_max,
WBC_BSP_cnt_min,
WBC_BSP_cnt_mean,
WBC_BSP_cnt_median,
WBC_BSP_cnt_max,
person_height.person_id,
person_weight.person_id
;