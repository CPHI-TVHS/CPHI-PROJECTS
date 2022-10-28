--sum the categories after weighting of the terms
/*
use RD_OMOP;
GO
*/

drop table if exists Nest.mesh_category_sums;
GO

select
	PERSON_ID
	, index_surgery_date
	, Patient_Notes_Count

,(
	Mesh_Sling_synthetic
	+ Mesh_Sling_implant
	+ Mesh_Sling_erosion
	+ Mesh_Sling_minisling
	+ Mesh_Sling_boston_scientific
	+ Mesh_Sling_advantage_fit
	+ Mesh_Sling_mentor
	+ Mesh_Sling_caldera
	+ Mesh_Sling_desara_tv
	+ Mesh_Sling_gmd_universal
	+ Mesh_Sling_lynx_suprapubic
	+ Mesh_Sling_miniarc
	+ Mesh_Sling_monarc
	+ Mesh_Sling_solyx
	+ Mesh_Sling_sparc
	+ Mesh_Sling_gynecare
	+ Mesh_Sling_tvt_o
	+ Mesh_Sling_obtryx_curved
	+ Mesh_Sling_obtryx
	+ Mesh_Sling_obtryx_halo
	+ Mesh_Sling_tape
) as Mesh_Sling_Mentions_Count

,(
	No_Mesh_Sling_no_mesh_sling	
	+ No_Mesh_Sling_autologous
	+ No_Mesh_Sling_fascial	
	+ No_Mesh_Sling_cadaveric	
	+ No_Mesh_Sling_porcine	
	+ No_Mesh_Sling_allograft	
	+ No_Mesh_Sling_pubovaginal	
	+ No_Mesh_Sling_xenograft
	+ No_Mesh_Sling_graft
	+ No_Mesh_Sling_abd_wall_fix					  
	+ No_Mesh_Sling_lyodura
	+ No_Mesh_Sling_rectus_sheath	
	+ No_Mesh_Sling_bladder_neck
	+ No_Mesh_Sling_proximal_urethra
	+ No_Mesh_Sling_harvest
	+ No_Mesh_Sling_urogenital_tri
	+ No_Mesh_Sling_endopelvic_fascia
	+ No_Mesh_Sling_pereyra_needle
	+ No_Mesh_Sling_fascia_lata
	+ No_Mesh_Sling_tutoplast
	+ No_Mesh_Sling_alloderm
	+ No_Mesh_Sling_repliform	  
	+ No_Mesh_Sling_axis
	+ No_Mesh_Sling_pelvisoft
	+ No_Mesh_Sling_pelvilace
	+ No_Mesh_Sling_xenform	
	+ No_Mesh_Sling_prolene	
	+ No_Mesh_Sling_polypropylene
	+ No_Mesh_Sling_gore_tex
	+ No_Mesh_Sling_mersilene
) as No_Mesh_Sling_Mentions_Count

,(
	Retropubic_retropubic
	+ Retropubic_retropubal_mid
	+ Retropubic_rmus
	+ Retropubic_abd_incision
	+ Retropubic_pubic_symphysis
	+ Retropubic_retro_mus
	+ Retropubic_trocar_retro_vag
	+ Retropubic_two_abd_incisions	
	+ Retropubic_above_pubic_bone
	+ Retropubic_space_retzius
	+ Retropubic_post_wall_pubic_symph
	+ Retropubic_supra_skin_incision
	+ Retropubic_top_down
	+ Retropubic_sparc
	+ Retropubic_bottom_up
	+ Retropubic_retro_space
	+ Retropubic_retzius_space
	+ Retropubic_urogenital_tri
	+ Retropubic_endopelvic_fasc
	+ Retropubic_bladder_neck
) as Retropubic_Mentions_Count

,(
	Transob_Unk_transob_unk		
	+ Transob_Unk_transobturator	
	+ Transob_Unk_to_sling			
	+ Transob_Unk_transob_sling
	+ Transob_Unk_transob_tape
	+ Transob_Unk_clitoris		
	+ Transob_Unk_groin_incision
	+ Transob_Unk_obturator_foramen
	+ Transob_Unk_exit_through_groin
	+ Transob_Unk_transob_mus
) as Transob_Unk_Mentions_Count

,(
	Transob_In_Out_transob_in_out
	+ Transob_In_Out_tvt_o
	+ Transob_In_Out_tot_o
	+ Transob_In_Out_in_to_out
	+ Transob_In_Out_vag_periurethral_diss
	+ Transob_In_Out_inside_out
	+ Transob_In_Out_helical_passers
	+ Transob_In_Out_vagina_to_groin
	+ Transob_In_Out_winged_guide
	+ Transob_In_Out_wing_guide
	+ Transob_In_Out_hugging_inf_pub_ramus
) as Transob_In_Out_Mentions_Count

,( 
	Transob_Out_In_transob_out_in
	+ Transob_Out_In_monarc
	+ Transob_Out_In_tot
	+ Transob_Out_In_out_to_in
	+ Transob_Out_In_genitofemoral_folds
	+ Transob_Out_In_lateral_to_vagina
	+ Transob_Out_In_through_ob_foramen
	+ Transob_Out_In_outside_in
	+ Transob_Out_In_ischio_ramus
	+ Transob_Out_In_exit_through_vagina
	+ Transob_Out_In_finger_introduced
	+ Transob_Out_In_groin_to_vagina
	+ Transob_Out_In_behind_inf_pubic_ramus
	+ Transob_Out_In_post_to_add_longus_ten
) as Transob_Out_In_Mentions_Count

,(	
	Sngl_Inc_mini_sling
	+ Sngl_Inc_miniarc
	+ Sngl_Inc_ajust
	+ Sngl_Inc_solyx
	+ Sngl_Inc_ophira
	+ Sngl_Inc_fixed_obtur			
	+ Sngl_Inc_perm_anch
	+ Sngl_Inc_u_config
	+ Sngl_Inc_h_config
	+ Sngl_Inc_hammock_config
	+ Sngl_Inc_anch_urog_diaphragm
	+ Sngl_Inc_obtur_membrane
	+ Sngl_Inc_tvt_secur
	+ Sngl_Inc_minitapes
) as Sngl_Inc_Mentions_Count

,(
	Adj_Sling_adj_sling		
	+ Adj_Sling_amus			
	+ Adj_Sling_removable_dev
	+ Adj_Sling_tension_sling	
	+ Adj_Sling_remeex		
	+ Adj_Sling_varitensor		
	+ Adj_Sling_neomedic			
	+ Adj_Sling_vert_vag_incision	
	+ Adj_Sling_diss_pubic_rami	
	+ Adj_Sling_polypropylene	
	+ Adj_Sling_hypogastric_level					
	+ Adj_Sling_transvag_adj_tape	
	+ Adj_Sling_ajust	
) as Adj_Sling_Mentions_Count

,(
	Burch_burch
	+ Burch_coloposuspension
	+ Burch_dissection_retropubic
	+ Burch_fixation_anterior
	+ Burch_transabdominal_Ureth
	+ Burch_posterior_periosteal
	+ Burch_pectineal_ligament
	+ Burch_coopers_ligament
	+ Burch_low_transverse_incision
	+ Burch_transabdominal_colpo
	+ Burch_open_colpo
	+ Burch_retropubic_urethropexy
	+ Burch_retropubic_colpo
	+ Burch_lap_colpo
) as Burch_Mentions_Count

,(
	Bulking_bulking
	+ Bulking_coaptite
	+ Bulking_durasphere
	+ Bulking_macroplastique
	+ Bulking_uba
	+ Bulking_urethral_bulking
	+ Bulking_particulate_uba
	+ Bulking_non_particulate_uba
	+ Bulking_polyacrylamide_hydrogel
	+ Bulking_bulkamid
	+ Bulking_silicone_polymer
	+ Bulking_calcium_hydroxylapatite
	+ Bulking_deflux
	+ Bulking_contigen
	+ Bulking_tegress
	+ Bulking_permacol
	+ Bulking_zuidex
	+ Bulking_polytef
	+ Bulking_bovine_collagen
	+ Bulking_porcine_dermal_collagen
	+ Bulking_silicone_particles
	+ Bulking_carbon_coated_beads
	+ Bulking_polytetraflouroethylene
	+ Bulking_ethylene_vinyl_alcohol
	+ Bulking_autologous_fat
	+ Bulking_uryx
	+ Bulking_Dex_hyal_acid_comp
	+ Bulking_Botox
) as Bulking_Mentions_Count

    , Mesh_Sling_Notes_Count
	, Mesh_Sling_synthetic					
	, Mesh_Sling_implant						
	, Mesh_Sling_erosion						
	, Mesh_Sling_minisling					
	, Mesh_Sling_boston_scientific			
	, Mesh_Sling_advantage_fit				
	, Mesh_Sling_mentor						
	, Mesh_Sling_caldera						
	, Mesh_Sling_desara_tv					
	, Mesh_Sling_gmd_universal				
	, Mesh_Sling_lynx_suprapubic				
	, Mesh_Sling_miniarc						
	, Mesh_Sling_monarc						
	, Mesh_Sling_solyx						
	, Mesh_Sling_sparc						
	, Mesh_Sling_gynecare						
	, Mesh_Sling_tvt_o						
	, Mesh_Sling_obtryx_curved				
	, Mesh_Sling_obtryx						
	, Mesh_Sling_obtryx_halo					
	, Mesh_Sling_tape							

	, No_Mesh_Sling_Notes_Count
	, No_Mesh_Sling_no_mesh_sling				
	, No_Mesh_Sling_autologous				
	, No_Mesh_Sling_fascial					
	, No_Mesh_Sling_cadaveric					
	, No_Mesh_Sling_porcine					
	, No_Mesh_Sling_allograft					
	, No_Mesh_Sling_pubovaginal				
	, No_Mesh_Sling_xenograft					
	, No_Mesh_Sling_graft						
	, No_Mesh_Sling_abd_wall_fix				
	, No_Mesh_Sling_lyodura					
	, No_Mesh_Sling_rectus_sheath				
	, No_Mesh_Sling_bladder_neck				
	, No_Mesh_Sling_proximal_urethra			
	, No_Mesh_Sling_harvest					
	, No_Mesh_Sling_urogenital_tri			
	, No_Mesh_Sling_endopelvic_fascia			
	, No_Mesh_Sling_pereyra_needle			
	, No_Mesh_Sling_fascia_lata				
	, No_Mesh_Sling_tutoplast					
	, No_Mesh_Sling_alloderm					
	, No_Mesh_Sling_repliform					
	, No_Mesh_Sling_axis						
	, No_Mesh_Sling_pelvisoft					
	, No_Mesh_Sling_pelvilace					
	, No_Mesh_Sling_xenform					
	, No_Mesh_Sling_prolene					
	, No_Mesh_Sling_polypropylene				
	, No_Mesh_Sling_gore_tex					
	, No_Mesh_Sling_mersilene					

	, Retropubic_Notes_Count
	, Retropubic_retropubic					
	, Retropubic_retropubal_mid				
	, Retropubic_rmus							
	, Retropubic_abd_incision					
	, Retropubic_pubic_symphysis				
	, Retropubic_retro_mus					
	, Retropubic_trocar_retro_vag				
	, Retropubic_two_abd_incisions			
	, Retropubic_above_pubic_bone				
	, Retropubic_space_retzius				
	, Retropubic_post_wall_pubic_symph		
	, Retropubic_supra_skin_incision			
	, Retropubic_top_down						
	, Retropubic_sparc						
	, Retropubic_bottom_up					
	, Retropubic_retro_space					
	, Retropubic_retzius_space				
	, Retropubic_urogenital_tri				
	, Retropubic_endopelvic_fasc				
	, Retropubic_bladder_neck					

	, Transob_Unk_Notes_Count
	, Transob_Unk_transob_unk					
	, Transob_Unk_transobturator				
	, Transob_Unk_to_sling					
	, Transob_Unk_transob_sling				
	, Transob_Unk_transob_tape				
	, Transob_Unk_clitoris					
	, Transob_Unk_groin_incision				
	, Transob_Unk_obturator_foramen			
	, Transob_Unk_exit_through_groin			
	, Transob_Unk_transob_mus					

	, Transob_In_Out_Notes_Count
	, Transob_In_Out_transob_in_out			
	, Transob_In_Out_tvt_o					
	, Transob_In_Out_tot_o					
	, Transob_In_Out_in_to_out				
	, Transob_In_Out_vag_periurethral_diss	
	, Transob_In_Out_inside_out				
	, Transob_In_Out_helical_passers			
	, Transob_In_Out_vagina_to_groin			
	, Transob_In_Out_winged_guide				
	, Transob_In_Out_wing_guide				
	, Transob_In_Out_hugging_inf_pub_ramus	

	, Transob_Out_In_Notes_Count
	, Transob_Out_In_transob_out_in			
	, Transob_Out_In_monarc					
	, Transob_Out_In_tot						
	, Transob_Out_In_out_to_in				
	, Transob_Out_In_genitofemoral_folds		
	, Transob_Out_In_lateral_to_vagina		
	, Transob_Out_In_through_ob_foramen		
	, Transob_Out_In_outside_in				
	, Transob_Out_In_ischio_ramus				
	, Transob_Out_In_exit_through_vagina		
	, Transob_Out_In_finger_introduced		
	, Transob_Out_In_groin_to_vagina			
	, Transob_Out_In_behind_inf_pubic_ramus	
	, Transob_Out_In_post_to_add_longus_ten	

	, Sngl_Inc_Notes_Count
	, Sngl_Inc_mini_sling						
	, Sngl_Inc_miniarc						
	, Sngl_Inc_ajust							
	, Sngl_Inc_solyx							
	, Sngl_Inc_ophira							
	, Sngl_Inc_fixed_obtur					
	, Sngl_Inc_perm_anch						
	, Sngl_Inc_u_config						
	, Sngl_Inc_h_config						
	, Sngl_Inc_hammock_config					
	, Sngl_Inc_anch_urog_diaphragm			
	, Sngl_Inc_obtur_membrane					
	, Sngl_Inc_tvt_secur						
	, Sngl_Inc_minitapes						

	, Adj_Sling_Notes_Count
	, Adj_Sling_adj_sling						
	, Adj_Sling_amus							
	, Adj_Sling_removable_dev					
	, Adj_Sling_tension_sling					
	, Adj_Sling_remeex						
	, Adj_Sling_varitensor					
	, Adj_Sling_neomedic						
	, Adj_Sling_vert_vag_incision				
	, Adj_Sling_diss_pubic_rami				
	, Adj_Sling_polypropylene					
	, Adj_Sling_hypogastric_level				
	, Adj_Sling_transvag_adj_tape				
	, Adj_Sling_ajust							

	, Burch_Notes_Count
	, Burch_burch								
	, Burch_coloposuspension					
	, Burch_dissection_retropubic				
	, Burch_fixation_anterior					
	, Burch_transabdominal_Ureth				
	, Burch_posterior_periosteal				
	, Burch_pectineal_ligament				
	, Burch_coopers_ligament					
	, Burch_low_transverse_incision			
	, Burch_transabdominal_colpo				
	, Burch_open_colpo						
	, Burch_retropubic_urethropexy			
	, Burch_retropubic_colpo					
	, Burch_lap_colpo							

	, Bulking_Notes_Count
	, Bulking_bulking							
	, Bulking_coaptite						
	, Bulking_durasphere						
	, Bulking_macroplastique					
	, Bulking_uba								
	, Bulking_urethral_bulking				
	, Bulking_particulate_uba					
	, Bulking_non_particulate_uba				
	, Bulking_polyacrylamide_hydrogel			
	, Bulking_bulkamid						
	, Bulking_silicone_polymer				
	, Bulking_calcium_hydroxylapatite			
	, Bulking_deflux							
	, Bulking_contigen						
	, Bulking_tegress							
	, Bulking_permacol						
	, Bulking_zuidex							
	, Bulking_polytef							
	, Bulking_bovine_collagen					
	, Bulking_porcine_dermal_collagen			
	, Bulking_silicone_particles				
	, Bulking_carbon_coated_beads				
	, Bulking_polytetraflouroethylene			
	, Bulking_ethylene_vinyl_alcohol			
	, Bulking_autologous_fat					
	, Bulking_uryx							
	, Bulking_Dex_hyal_acid_comp				
	, Bulking_Botox							

into
	Nest.mesh_category_sums
from
	Nest.mesh_terms_weighted as W
;