--Weights
/*
use RD_OMOP;
GO
*/

drop table if exists Nest.mesh_terms_weighted;
GO

select
	a.PERSON_ID
	, a.index_surgery_date
	, a.Patient_Notes_Count

	, b.Mesh_Sling_Notes_Count
	, 5 * b.Mesh_Sling_synthetic					as Mesh_Sling_synthetic
	, 1 * b.Mesh_Sling_implant						as Mesh_Sling_implant
	, 1 * b.Mesh_Sling_erosion						as Mesh_Sling_erosion
	, 5 * b.Mesh_Sling_minisling					as Mesh_Sling_minisling
	, 1 * b.Mesh_Sling_boston_scientific			as Mesh_Sling_boston_scientific
	, 5 * b.Mesh_Sling_advantage_fit				as Mesh_Sling_advantage_fit
	, 1 * b.Mesh_Sling_mentor						as Mesh_Sling_mentor
	, 2 * b.Mesh_Sling_caldera						as Mesh_Sling_caldera
	, 2 * b.Mesh_Sling_desara_tv					as Mesh_Sling_desara_tv
	, 2 * b.Mesh_Sling_gmd_universal				as Mesh_Sling_gmd_universal
	, 2 * b.Mesh_Sling_lynx_suprapubic				as Mesh_Sling_lynx_suprapubic
	, 5 * b.Mesh_Sling_miniarc						as Mesh_Sling_miniarc
	, 5 * b.Mesh_Sling_monarc						as Mesh_Sling_monarc
	, 5 * b.Mesh_Sling_solyx						as Mesh_Sling_solyx
	, 5 * b.Mesh_Sling_sparc						as Mesh_Sling_sparc
	, 5 * b.Mesh_Sling_gynecare						as Mesh_Sling_gynecare
	, 1 * b.Mesh_Sling_tvt_o						as Mesh_Sling_tvt_o
	, 5 * b.Mesh_Sling_obtryx_curved				as Mesh_Sling_obtryx_curved
	, 5 * b.Mesh_Sling_obtryx						as Mesh_Sling_obtryx
	, 5 * b.Mesh_Sling_obtryx_halo					as Mesh_Sling_obtryx_halo
	, 5 * b.Mesh_Sling_tape							as Mesh_Sling_tape

	, c.No_Mesh_Sling_Notes_Count
	, 1 * c.No_Mesh_Sling_no_mesh_sling				as No_Mesh_Sling_no_mesh_sling	
	, 5 * c.No_Mesh_Sling_autologous				as No_Mesh_Sling_autologous
	, 2 * c.No_Mesh_Sling_fascial					as No_Mesh_Sling_fascial	
	, 5 * c.No_Mesh_Sling_cadaveric					as No_Mesh_Sling_cadaveric	
	, 5 * c.No_Mesh_Sling_porcine					as No_Mesh_Sling_porcine	
	, 5 * c.No_Mesh_Sling_allograft					as No_Mesh_Sling_allograft	
	, 1 * c.No_Mesh_Sling_pubovaginal				as No_Mesh_Sling_pubovaginal	
	, 1 * c.No_Mesh_Sling_xenograft					as No_Mesh_Sling_xenograft
	, 2 * c.No_Mesh_Sling_graft						as No_Mesh_Sling_graft
	, 1 * c.No_Mesh_Sling_abd_wall_fix				as No_Mesh_Sling_abd_wall_fix					  
	, 1 * c.No_Mesh_Sling_lyodura					as No_Mesh_Sling_lyodura
	, 2 * c.No_Mesh_Sling_rectus_sheath				as No_Mesh_Sling_rectus_sheath	
	, 1 * c.No_Mesh_Sling_bladder_neck				as No_Mesh_Sling_bladder_neck
	, 1 * c.No_Mesh_Sling_proximal_urethra			as No_Mesh_Sling_proximal_urethra
	, 2 * c.No_Mesh_Sling_harvest					as No_Mesh_Sling_harvest
	, 1 * c.No_Mesh_Sling_urogenital_tri			as No_Mesh_Sling_urogenital_tri
	, 1 * c.No_Mesh_Sling_endopelvic_fascia			as No_Mesh_Sling_endopelvic_fascia
	, 1 * c.No_Mesh_Sling_pereyra_needle			as No_Mesh_Sling_pereyra_needle
	, 1 * c.No_Mesh_Sling_fascia_lata				as No_Mesh_Sling_fascia_lata
	, 1 * c.No_Mesh_Sling_tutoplast					as No_Mesh_Sling_tutoplast
	, 1 * c.No_Mesh_Sling_alloderm					as No_Mesh_Sling_alloderm
	, 1 * c.No_Mesh_Sling_repliform					as No_Mesh_Sling_repliform	  
	, 1 * c.No_Mesh_Sling_axis						as No_Mesh_Sling_axis
	, 1 * c.No_Mesh_Sling_pelvisoft					as No_Mesh_Sling_pelvisoft
	, 1 * c.No_Mesh_Sling_pelvilace					as No_Mesh_Sling_pelvilace
	, 1 * c.No_Mesh_Sling_xenform					as No_Mesh_Sling_xenform	
	, 1 * c.No_Mesh_Sling_prolene					as No_Mesh_Sling_prolene	
	, 1 * c.No_Mesh_Sling_polypropylene				as No_Mesh_Sling_polypropylene
	, 1 * c.No_Mesh_Sling_gore_tex					as No_Mesh_Sling_gore_tex
	, 1 * c.No_Mesh_Sling_mersilene					as No_Mesh_Sling_mersilene

	, d.Retropubic_Notes_Count
	, 2 * d.Retropubic_retropubic					as Retropubic_retropubic
	, 2 * d.Retropubic_retropubal_mid				as Retropubic_retropubal_mid
	, 2 * d.Retropubic_rmus							as Retropubic_rmus
	, 1 * d.Retropubic_abd_incision					as Retropubic_abd_incision
	, 1 * d.Retropubic_pubic_symphysis				as Retropubic_pubic_symphysis
	, 1 * d.Retropubic_retro_mus					as Retropubic_retro_mus
	, 1 * d.Retropubic_trocar_retro_vag				as Retropubic_trocar_retro_vag
	, 2 * d.Retropubic_two_abd_incisions			as Retropubic_two_abd_incisions	
	, 1 * d.Retropubic_above_pubic_bone				as Retropubic_above_pubic_bone
	, 1 * d.Retropubic_space_retzius				as Retropubic_space_retzius
	, 1 * d.Retropubic_post_wall_pubic_symph		as Retropubic_post_wall_pubic_symph
	, 1 * d.Retropubic_supra_skin_incision			as Retropubic_supra_skin_incision
	, 1 * d.Retropubic_top_down						as Retropubic_top_down
	, 1 * d.Retropubic_sparc						as Retropubic_sparc
	, 1 * d.Retropubic_bottom_up					as Retropubic_bottom_up
	, 2 * d.Retropubic_retro_space					as Retropubic_retro_space
	, 1 * d.Retropubic_retzius_space				as Retropubic_retzius_space
	, 2 * d.Retropubic_urogenital_tri				as Retropubic_urogenital_tri
	, 1 * d.Retropubic_endopelvic_fasc				as Retropubic_endopelvic_fasc
	, 2 * d.Retropubic_bladder_neck					as Retropubic_bladder_neck	

	, e.Transob_Unk_Notes_Count
	, 1 * e.Transob_Unk_transob_unk					as Transob_Unk_transob_unk		
	, 2 * e.Transob_Unk_transobturator				as Transob_Unk_transobturator	
	, 1 * e.Transob_Unk_to_sling					as Transob_Unk_to_sling			
	, 1 * e.Transob_Unk_transob_sling				as Transob_Unk_transob_sling
	, 1 * e.Transob_Unk_transob_tape				as Transob_Unk_transob_tape
	, 1 * e.Transob_Unk_clitoris					as Transob_Unk_clitoris		
	, 2 * e.Transob_Unk_groin_incision				as Transob_Unk_groin_incision
	, 2 * e.Transob_Unk_obturator_foramen			as Transob_Unk_obturator_foramen
	, 2 * e.Transob_Unk_exit_through_groin			as Transob_Unk_exit_through_groin
	, 2 * e.Transob_Unk_transob_mus					as Transob_Unk_transob_mus

	, f.Transob_In_Out_Notes_Count
	, 2 * f.Transob_In_Out_transob_in_out			as Transob_In_Out_transob_in_out
	, 2 * f.Transob_In_Out_tvt_o					as Transob_In_Out_tvt_o
	, 2 * f.Transob_In_Out_tot_o					as Transob_In_Out_tot_o
	, 1 * f.Transob_In_Out_in_to_out				as Transob_In_Out_in_to_out
	, 1 * f.Transob_In_Out_vag_periurethral_diss	as Transob_In_Out_vag_periurethral_diss
	, 1 * f.Transob_In_Out_inside_out				as Transob_In_Out_inside_out
	, 1 * f.Transob_In_Out_helical_passers			as Transob_In_Out_helical_passers
	, 1 * f.Transob_In_Out_vagina_to_groin			as Transob_In_Out_vagina_to_groin
	, 1 * f.Transob_In_Out_winged_guide				as Transob_In_Out_winged_guide
	, 1 * f.Transob_In_Out_wing_guide				as Transob_In_Out_wing_guide
	, 1 * f.Transob_In_Out_hugging_inf_pub_ramus	as Transob_In_Out_hugging_inf_pub_ramus

	, g.Transob_Out_In_Notes_Count
	, 2 * g.Transob_Out_In_transob_out_in			as Transob_Out_In_transob_out_in
	, 1 * g.Transob_Out_In_monarc					as Transob_Out_In_monarc
	, 2 * g.Transob_Out_In_tot						as Transob_Out_In_tot
	, 1 * g.Transob_Out_In_out_to_in				as Transob_Out_In_out_to_in
	, 1 * g.Transob_Out_In_genitofemoral_folds		as Transob_Out_In_genitofemoral_folds
	, 1 * g.Transob_Out_In_lateral_to_vagina		as Transob_Out_In_lateral_to_vagina
	, 1 * g.Transob_Out_In_through_ob_foramen		as Transob_Out_In_through_ob_foramen
	, 1 * g.Transob_Out_In_outside_in				as Transob_Out_In_outside_in
	, 1 * g.Transob_Out_In_ischio_ramus				as Transob_Out_In_ischio_ramus
	, 1 * g.Transob_Out_In_exit_through_vagina		as Transob_Out_In_exit_through_vagina
	, 1 * g.Transob_Out_In_finger_introduced		as Transob_Out_In_finger_introduced
	, 1 * g.Transob_Out_In_groin_to_vagina			as Transob_Out_In_groin_to_vagina
	, 1 * g.Transob_Out_In_behind_inf_pubic_ramus	as Transob_Out_In_behind_inf_pubic_ramus
	, 1 * g.Transob_Out_In_post_to_add_longus_ten	as Transob_Out_In_post_to_add_longus_ten

	, h.Sngl_Inc_Notes_Count
	, 2 * h.Sngl_Inc_mini_sling						as Sngl_Inc_mini_sling
	, 2 * h.Sngl_Inc_miniarc						as Sngl_Inc_miniarc
	, 1 * h.Sngl_Inc_ajust							as Sngl_Inc_ajust
	, 1 * h.Sngl_Inc_solyx							as Sngl_Inc_solyx
	, 1 * h.Sngl_Inc_ophira							as Sngl_Inc_ophira
	, 1 * h.Sngl_Inc_fixed_obtur					as Sngl_Inc_fixed_obtur			
	, 2 * h.Sngl_Inc_perm_anch						as Sngl_Inc_perm_anch
	, 1 * h.Sngl_Inc_u_config						as Sngl_Inc_u_config
	, 1 * h.Sngl_Inc_h_config						as Sngl_Inc_h_config
	, 1 * h.Sngl_Inc_hammock_config					as Sngl_Inc_hammock_config
	, 1 * h.Sngl_Inc_anch_urog_diaphragm			as Sngl_Inc_anch_urog_diaphragm
	, 1 * h.Sngl_Inc_obtur_membrane					as Sngl_Inc_obtur_membrane
	, 1 * h.Sngl_Inc_tvt_secur						as Sngl_Inc_tvt_secur
	, 1 * h.Sngl_Inc_minitapes						as Sngl_Inc_minitapes

	, i.Adj_Sling_Notes_Count
	, 2 * i.Adj_Sling_adj_sling						as Adj_Sling_adj_sling		
	, 2 * i.Adj_Sling_amus							as Adj_Sling_amus			
	, 1 * i.Adj_Sling_removable_dev					as Adj_Sling_removable_dev
	, 1 * i.Adj_Sling_tension_sling					as Adj_Sling_tension_sling	
	, 1 * i.Adj_Sling_remeex						as Adj_Sling_remeex		
	, 1 * i.Adj_Sling_varitensor					as Adj_Sling_varitensor		
	, 1 * i.Adj_Sling_neomedic						as Adj_Sling_neomedic			
	, 1 * i.Adj_Sling_vert_vag_incision				as Adj_Sling_vert_vag_incision	
	, 1 * i.Adj_Sling_diss_pubic_rami				as Adj_Sling_diss_pubic_rami	
	, 1 * i.Adj_Sling_polypropylene					as Adj_Sling_polypropylene	
	, 1 * i.Adj_Sling_hypogastric_level				as Adj_Sling_hypogastric_level					
	, 1 * i.Adj_Sling_transvag_adj_tape				as Adj_Sling_transvag_adj_tape	
	, 2 * i.Adj_Sling_ajust							as Adj_Sling_ajust	

	, j.Burch_Notes_Count
	, 2 * j.Burch_burch								as Burch_burch
	, 1 * j.Burch_coloposuspension					as Burch_coloposuspension
	, 1 * j.Burch_dissection_retropubic				as Burch_dissection_retropubic
	, 1 * j.Burch_fixation_anterior					as Burch_fixation_anterior
	, 2 * j.Burch_transabdominal_Ureth				as Burch_transabdominal_Ureth
	, 1 * j.Burch_posterior_periosteal				as Burch_posterior_periosteal
	, 1 * j.Burch_pectineal_ligament				as Burch_pectineal_ligament
	, 1 * j.Burch_coopers_ligament					as Burch_coopers_ligament
	, 1 * j.Burch_low_transverse_incision			as Burch_low_transverse_incision
	, 2 * j.Burch_transabdominal_colpo				as Burch_transabdominal_colpo
	, 2 * j.Burch_open_colpo						as Burch_open_colpo
	, 2 * j.Burch_retropubic_urethropexy			as Burch_retropubic_urethropexy
	, 1 * j.Burch_retropubic_colpo					as Burch_retropubic_colpo
	, 1 * j.Burch_lap_colpo							as Burch_lap_colpo

	, k.Bulking_Notes_Count
	, 2 * k.Bulking_bulking							as Bulking_bulking
	, 1 * k.Bulking_coaptite						as Bulking_coaptite
	, 1 * k.Bulking_durasphere						as Bulking_durasphere
	, 1 * k.Bulking_macroplastique					as Bulking_macroplastique
	, 2 * k.Bulking_uba								as Bulking_uba
	, 2 * k.Bulking_urethral_bulking				as Bulking_urethral_bulking
	, 1 * k.Bulking_particulate_uba					as Bulking_particulate_uba
	, 1 * k.Bulking_non_particulate_uba				as Bulking_non_particulate_uba
	, 1 * k.Bulking_polyacrylamide_hydrogel			as Bulking_polyacrylamide_hydrogel
	, 1 * k.Bulking_bulkamid						as Bulking_bulkamid
	, 1 * k.Bulking_silicone_polymer				as Bulking_silicone_polymer
	, 1 * k.Bulking_calcium_hydroxylapatite			as Bulking_calcium_hydroxylapatite
	, 1 * k.Bulking_deflux							as Bulking_deflux
	, 1 * k.Bulking_contigen						as Bulking_contigen
	, 1 * k.Bulking_tegress							as Bulking_tegress
	, 1 * k.Bulking_permacol						as Bulking_permacol
	, 1 * k.Bulking_zuidex							as Bulking_zuidex
	, 1 * k.Bulking_polytef							as Bulking_polytef
	, 1 * k.Bulking_bovine_collagen					as Bulking_bovine_collagen
	, 1 * k.Bulking_porcine_dermal_collagen			as Bulking_porcine_dermal_collagen
	, 1 * k.Bulking_silicone_particles				as Bulking_silicone_particles
	, 1 * k.Bulking_carbon_coated_beads				as Bulking_carbon_coated_beads
	, 1 * k.Bulking_polytetraflouroethylene			as Bulking_polytetraflouroethylene
	, 1 * k.Bulking_ethylene_vinyl_alcohol			as Bulking_ethylene_vinyl_alcohol
	, 1 * k.Bulking_autologous_fat					as Bulking_autologous_fat
	, 1 * k.Bulking_uryx							as Bulking_uryx
	, 1 * k.Bulking_Dex_hyal_acid_comp				as Bulking_Dex_hyal_acid_comp
	, 1 * k.Bulking_Botox							as Bulking_Botox

into
	Nest.mesh_terms_weighted
from 
	Nest.mesh_patient_cohort as a
	left join
	Nest.Mesh_Terms_Mesh_Sling as b
		on a.person_ID = b.person_id and a.index_surgery_date = b.index_surgery_date
	left join
	Nest.Mesh_Terms_No_Mesh_Sling as c
		on a.person_ID = c.person_id and a.index_surgery_date = c.index_surgery_date
	left join
	Nest.Mesh_Terms_Retropubic as d
		on a.person_ID = d.person_id and a.index_surgery_date = d.index_surgery_date
	left join
	Nest.Mesh_Terms_Transob_Unk as e
		on a.person_ID = e.person_id and a.index_surgery_date = e.index_surgery_date
	left join
	Nest.Mesh_Terms_Transob_In_Out as f
		on a.person_ID = f.person_id and a.index_surgery_date = f.index_surgery_date
	left join
	Nest.Mesh_Terms_Transob_Out_In as g
		on a.person_ID = g.person_id and a.index_surgery_date = g.index_surgery_date
	left join
	Nest.Mesh_Terms_Sngl_Inc as h
		on a.person_ID = h.person_id and a.index_surgery_date = h.index_surgery_date
	left join
	Nest.Mesh_Terms_Adj_Sling as i
		on a.person_ID = i.person_id and a.index_surgery_date = i.index_surgery_date
	left join
	Nest.Mesh_Terms_Burch as j
		on a.person_ID = j.person_id and a.index_surgery_date = j.index_surgery_date
	left join
	Nest.Mesh_Terms_Bulking as k
		on a.person_ID = k.person_id and a.index_surgery_date = k.index_surgery_date
;

