# NEST_Mesh_Functions.R #

# Function to load factor data
load_factor <- function(pat){
  l <- list.files(path=p, pattern=pat, full.names=TRUE) %>%
    map_df(~read_csv(.x, col_types=cols(.default="c", "n_missing"="n",
                                        "perc_missing"="n", "n_nonmiss"="n")))
  return(l)
}

# Function to load numeric data
load_numeric <- function(pat){
  l <- list.files(path=p, pattern=pat, full.names=TRUE) %>%
    map_df(~read_csv(.x, col_types=cols(.default="n", "field"="c", "site"="c",
                                        "n_nonmiss"="c", "version"="c")))
}

load_comp <- function(pat){
  l <- list.files(path=p, pattern=pat, full.names=TRUE) %>%
    map_df(~read_csv(.x, col_types=cols(.default="n", "field"="c", "site"="c", "version"="c")))
  return(l)
}

# Function to prepare missing data & descriptive statistics by site
prep_miss_site <- function(anydat, grouping, order_gp, n_sites=ns, fac=FALSE){
  anydat <- anydat[anydat$group == grouping,]
  if(fac == TRUE){
    if(grouping == "Outcomes"){
      # Correct coding bug for binary infection variables
      anydat$n_missing[anydat$field == "INFECTION7d"] <- 0
      anydat$perc_missing[anydat$field == "INFECTION7d"] <- 0.000
      anydat$n_missing[anydat$field == "INFECTION14d"] <- 0
      anydat$perc_missing[anydat$field == "INFECTION14d"] <- 0.000
      anydat$n_missing[anydat$field == "INFECTION30d"] <- 0
      anydat$perc_missing[anydat$field == "INFECTION30d"] <- 0.000
    }
    anydat <- anydat %>%
      mutate(perc_yes_new = ifelse(n_yes != "[1-10]", 
                                   format(round(100*as.numeric(n_yes)/n_nonmiss,
                                                digits=0), nsmall=0), NA),
             print = paste(n_yes, " (", perc_yes_new, "%); [", n_missing, "]", sep=""))
  }
  if(fac == FALSE){
    anydat <- anydat %>%
      mutate(print = paste(format(round(mean, digits=2), nsmall=2), " (", 
                           format(round(std, digits=2), nsmall=2), "); [", n_missing, "]", sep="")) 
  }
  anydat <- anydat[with(anydat, order(site)),]
  if(fac == TRUE){
    anydat$N <- anydat$n_missing + anydat$n_nonmiss
    counts <- anydat %>%
      group_by(site) %>%
      mutate(N = max(N, na.rm=TRUE))
    counts_sub <- cbind("Count of all procedures (N)",
                     matrix(counts$N[seq(1, nrow(counts), nrow(counts)/n_sites)], 
                            nrow=1, ncol=n_sites, byrow=TRUE))
  }
  anydat_sub <- anydat[c("field", "label", "site", "print")]
  anydat_long <- anydat_sub %>%
    group_by(label) %>%
    gather("print", key=variable, value=number) %>%
    unite(combi, variable, site) %>%
    spread(combi, number)
  anydat_long <- anydat_long[match(order_gp, anydat_long$field),]
  colnames(anydat_long) <- gsub('print_', '', colnames(anydat_long))
  colnames(anydat_long) <- gsub('label', 'Field', colnames(anydat_long))
  anydat_long <- anydat_long[-1]
  anydat_long <- data.frame(anydat_long)
  if(fac == TRUE){
    colnames(counts_sub) <- colnames(anydat_long)
    anydat_long <- rbind(counts_sub, anydat_long)
  }
  return(anydat_long)
}

# Function to prepare aggregate missing data & descriptives
prep_miss_agg <- function(anydat, grouping, order_gp, m_fields, n_fields, n_sites=ns, fac=FALSE, overall=FALSE){
  if(fac == TRUE){
    anydat <- anydat[anydat$group == grouping,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat <- anydat %>%
      group_by(field) %>% 
      mutate(n_nonmiss = ifelse(n_nonmiss == "[1-10]", 1, as.numeric(n_nonmiss)),
             aggregate_n_nonmiss = cumsum(n_nonmiss),
             aggregate_n_missing = cumsum(n_missing),
             total = aggregate_n_missing + aggregate_n_nonmiss,
             aggregate_perc_miss = format(round(100*(aggregate_n_missing / total), digits=0), nsms=0),
             n_yes = ifelse(n_yes == "[1-10]", 1, as.numeric(n_yes)),
             aggregate_n_yes = cumsum(n_yes),
             aggregate_n_nonmiss = cumsum(n_nonmiss),
             aggregate_perc_yes = format(round(100*(aggregate_n_yes / aggregate_n_nonmiss), digits=0), nsms=0),
             print_it = paste(aggregate_n_yes, " (", aggregate_perc_yes, "%); [", aggregate_n_missing,
                              "]", sep=""))
    anydat_cut <- data.frame(tail(anydat, n=length(anydat$field)/n_sites)) 
    anydat_sub <- anydat_cut[, c("field", "label", "print_it")]
    anydat_sub <- anydat_sub[match(order_gp, anydat_sub$field),]
    anydat_sub <- anydat_sub[-1] #Drop column 'field'
    return(anydat_sub)
  }
  if(fac == FALSE){
    anydat <- anydat[anydat$group == grouping,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(n_nonmiss = ifelse(n_nonmiss == "[1-10]", 1, as.numeric(n_nonmiss)),
             aggregate_n_nonmiss = cumsum(n_nonmiss),
             aggregate_n_missing = cumsum(n_missing),
             total = aggregate_n_missing + aggregate_n_nonmiss,
             aggregate_perc_miss = format(round(100*(aggregate_n_missing / total), digits=0), nsms=0))
    anydat_cut <- data.frame(tail(anydat, n=length(anydat$field)/n_sites))
    anydat_cut <- anydat_cut[c("field", "label", "aggregate_n_missing", "aggregate_perc_miss")]
    ## Calculate weighted mean and SD
    anydat_sub <- anydat[c("field", "label", "site", "mean", "n_nonmiss")]
    anydat_long <- anydat_sub %>%
      group_by(field) %>%
      gather("mean", "n_nonmiss", key=variable, value=number) %>%
      unite(combi, variable, site) %>%
      spread(combi, number)
    anydat_long <- data.frame(anydat_long)
    count_mean_na <- anydat_long %>%
      group_by(field) %>%
      select(starts_with("mean")) %>% 
      is.na %>%
      rowSums
    anydat_long <- cbind(anydat_long, count_mean_na)
    ## Overall and By Approach (with Cornell)
    if(overall == TRUE){
      anydat_long <- anydat_long %>%
        group_by(field) %>%
        mutate(wtd_mean = format(round(wtd.mean(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo, mean_Cornell),
                                                weights=c(n_nonmiss_VUMC, n_nonmiss_Yale, n_nonmiss_Lahey, n_nonmiss_Mayo, n_nonmiss_Cornell), #survey weights
                                                normwt=FALSE, na.rm=TRUE), digits=2), nsmall=2),
               wtd_var = ifelse(count_mean_na < n_sites, wtd.var(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo, mean_Cornell),
                                                                 weights=c(n_nonmiss_VUMC, n_nonmiss_Yale, n_nonmiss_Lahey, n_nonmiss_Mayo, n_nonmiss_Cornell),
                                                                 normwt=FALSE, na.rm=TRUE, method='unbiased'), NA),
               wtd_std = format(round(sqrt(wtd_var), digits=2), nsmall=2))
    }
    
    ## Overall and By Approach (without Cornell)
    if(overall == FALSE){
      anydat_long <- anydat_long %>%
        group_by(field) %>%
        mutate(wtd_mean = format(round(wtd.mean(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo),
                                                weights=c(n_nonmiss_VUMC, n_nonmiss_Yale, n_nonmiss_Lahey, n_nonmiss_Mayo), #survey weights
                                                normwt=FALSE, na.rm=TRUE), digits=2), nsmall=2),
               wtd_var = ifelse(count_mean_na < n_sites, wtd.var(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo),
                                                                 weights=c(n_nonmiss_VUMC, n_nonmiss_Yale, n_nonmiss_Lahey, n_nonmiss_Mayo),
                                                                 normwt=FALSE, na.rm=TRUE, method='unbiased'), NA),
               wtd_std = format(round(sqrt(wtd_var), digits=2), nsmall=2))
    
    }
    anydat_long_cut <- anydat_long[c("field", "wtd_mean", "wtd_std")]
    anydat_merge <- merge(anydat_cut, anydat_long_cut, all.x=TRUE, by="field")
    anydat_merge <- anydat_merge %>%
      mutate(print_it = paste(wtd_mean, " (", wtd_std, "); [", aggregate_n_missing, "]", sep=""))
    anydat_merge <- anydat_merge[, c("field", "label", "print_it")]
    anydat_merge <- anydat_merge[match(order_gp, anydat_merge$field),]
    anydat_merge <- anydat_merge[-1] #Drop column 'field'
    return(anydat_merge)
  }
}

# Function to print missing data
print_miss <- function(fmr, far, frr, fir, ftr, fur,
                       nmr, nar, nrr, nir, ntr, nur,
                       gp, fo, no, dat_factor, dat_numeric, 
                       agg=FALSE, ns=nsites, nsc=nsites_c){
  # Aggregate
  if (agg == TRUE){
    fm <- prep_miss_agg(fmr, grouping=gp, order_gp=fo, n_sites=nsc, fac=TRUE, overall=TRUE) 
    fa <- prep_miss_agg(far, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    fr <- prep_miss_agg(frr, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    fi <- prep_miss_agg(fir, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    ft <- prep_miss_agg(ftr, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    fu <- prep_miss_agg(fur, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    if (gp != "Active Medications" & gp != "Primary Procedure Characteristics") {
    nm <- prep_miss_agg(nmr, grouping=gp, order_gp=no, n_sites=nsc, fac=FALSE, overall=TRUE) 
    na <- prep_miss_agg(nar, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
    nr <- prep_miss_agg(nrr, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
    ni <- prep_miss_agg(nir, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
    nt <- prep_miss_agg(ntr, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
    nu <- prep_miss_agg(nur, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
    }
    if (gp == "Active Medications" | gp == "Primary Procedure Characteristics") {
      nm <- NA
      na <- NA
      nr <- NA
      ni <- NA
      nt <- NA
      nu <- NA
    }
    m <- rbind(fm, nm)
    a <- rbind(fa, na)
    r <- rbind(fr, nr)
    i <- rbind(fi, ni)
    t <- rbind(ft, nt)
    u <- rbind(fu, nu)
    pri <- cbind(m, subset(a, select=c("print_it")), subset(r, select=c("print_it")), 
               subset(i, select=c("print_it")), subset(t, select=c("print_it")),
               subset(u, select=c("print_it")))
    colnames(pri) <- c("Field", "Overall", "Adjustable Sling (AMUS)", "Retro-Pubic (RPMUS)",
                       "Single Incision (SIMUS)", "Trans-Obturator (TOMUS)", "Unknown Approach")
  }
  # By Site
  if (agg == FALSE){
    fa <- prep_miss_site(dat_factor, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE)
    if (gp != "Active Medications" & gp != "Primary Procedure Characteristics") {
      na <- prep_miss_site(dat_numeric, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE)
    }
    if (gp == "Active Medications" | gp == "Primary Procedure Characteristics") {
      na <- NA
    }
    pri <- rbind(fa, na)
  }
  knitr::kable(pri, align='lcccccc', "html", col.names=colnames(pri), escape=FALSE,
               table.attr='class="table-fixed-header"') %>%
    kable_styling(position="left", full_width=TRUE, bootstrap_options=c("striped", "hover", "condensed")) %>%
    scroll_box(height="500px")
}

prep_comp_site <- function(anydat, order_gp, cat){
  anydat <- anydat %>%
    group_by(field) %>%
    mutate(total = n_both_present + n_structured_only + n_chart_only + n_both_null,
           perc_both_present = format(round(100*(n_both_present / total), digits=0), nsms=0),
           perc_structured_only = format(round(100*(n_structured_only / total), digits=0), nsms=0),
           perc_chart_only = format(round(100*(n_chart_only / total), digits=0), nsms=0),
           perc_both_null = format(round(100*(n_both_null / total), digits=0), nsms=0))
  if(cat == "both present"){
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(n_both_present, " (", perc_both_present, "%)", sep=""))
  }
  if(cat == "structured only"){
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(n_structured_only, " (", perc_structured_only, "%)", sep=""))
  }
  if(cat == "chart only"){
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(n_chart_only, " (", perc_chart_only, "%)", sep=""))
  }
  if(cat == "both null"){
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(n_both_null, " (", perc_both_null, "%)", sep=""))
  }
  anydat_sub <- anydat[c("field", "label", "site", "print")]
  anydat_long <- anydat_sub %>%
    group_by(field) %>%
    gather("print", key=variable, value=number) %>%
    unite(combi, variable, site) %>%
    spread(combi, number)
  anydat_long <- anydat_long[match(order_gp, anydat_long$field),]
  anydat_long <- anydat_long[-1]
  colnames(anydat_long) <- gsub('print_', '', colnames(anydat_long))
  colnames(anydat_long) <- gsub('label', 'Field', colnames(anydat_long))
  return(anydat_long)
}

prep_comp_agg <- function(anydat, grouping, order_gp, n_sites=ns){
  anydat <- anydat[anydat$group == grouping,]
  anydat <- anydat[with(anydat, order(site)),]
  anydat <- anydat %>%
    group_by(label) %>%
    mutate(aggregate_n_both_present = cumsum(n_both_present),
           aggregate_n_structured_only = cumsum(n_structured_only),
           aggregate_n_chart_only = cumsum(n_chart_only),
           aggregate_n_both_null = cumsum(n_both_null)) 
  anydat_cut <- data.frame(tail(anydat, n=length(anydat$field)/n_sites))
  anydat_cut$aggregate_total <- anydat_cut$aggregate_n_both_present + anydat_cut$aggregate_n_structured_only +
    anydat_cut$aggregate_n_chart_only + anydat_cut$aggregate_n_both_null
  anydat_cut <- anydat_cut %>%
    group_by(label) %>%
    mutate(perc_both_present = format(round(100*(aggregate_n_both_present / aggregate_total), digits=0), nsms=0),
           perc_structured_only = format(round(100*(aggregate_n_structured_only / aggregate_total), digits=0), nsms=0),
           perc_chart_only = format(round(100*(aggregate_n_chart_only / aggregate_total), digits=0), nsms=0),
           perc_both_null = format(round(100*(aggregate_n_both_null / aggregate_total), digits=0), nsms=0),
           print_both_present = paste(aggregate_n_both_present, " (", perc_both_present, "%)", sep=""),
           print_structured_only = paste(aggregate_n_structured_only, " (", perc_structured_only, "%)", sep=""),
           print_chart_only = paste(aggregate_n_chart_only, " (", perc_chart_only, "%)", sep=""),
           print_both_null = paste(aggregate_n_both_null, " (", perc_both_null, "%)", sep=""))
  anydat_sub <- anydat_cut[c("field", "label", "print_both_present", "print_structured_only", 
                             "print_chart_only", "print_both_null")]
  anydat_sub <- anydat_sub[match(order_gp, anydat_sub$field),]
  anydat_sub <- anydat_sub[-1]
  colnames(anydat_sub) <- c("Field", "Both Present", "Structured Only", "Chart Only", "Both Null")
  return(anydat_sub)
}

print_comp <- function(dat_factor, dat_numeric, gp, fo, no, c, agg=FALSE, ns=nsites){
  # Aggregate
  if (agg == TRUE){
    fa <- prep_comp_agg(dat_factor, grouping=gp, order_gp=fo, n_sites=ns)
    na <- prep_comp_agg(dat_numeric, grouping=gp, order_gp=no, n_sites=ns)
  }
  # By Site
  if (agg == FALSE){
    fa <- prep_comp_site(dat_factor, order_gp=fo, cat=c)
    na <- prep_comp_site(dat_numeric, order_gp=no, cat=c)
  }
  ra <- rbind(fa, na)
  knitr::kable(ra, align='lccccc', "html", col.names=colnames(ra), escape=FALSE,
               table.attr='class="table-fixed-header"') %>%
    kable_styling(position="left", full_width=TRUE, bootstrap_options=c("striped", "hover", "condensed")) %>%
    scroll_box(height="500px")
} 

prep_concord_site <- function(anydat, grouping, order_gp, fac=FALSE){
  # Add labels, groups, order
  if(fac == TRUE){
    anydat <- anydat[anydat$group == grouping,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(n_concordant, " (", format(round(perc_concordant, digits=0), nsms=0), "%)", sep=""))
    anydat_sub <- anydat[c("field", "label", "site", "print")]
    anydat_long <- anydat_sub %>%
      group_by(field) %>%
      gather("print", key=variable, value=number) %>%
      unite(combi, variable, site) %>%
      spread(combi, number)
    anydat_long <- anydat_long[match(order_gp, anydat_long$field),]
    anydat_long <- anydat_long[-1]
  }
  if(fac == FALSE){
    anydat <- anydat[anydat$group == grouping,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(format(round(mean, digits=2), nsms=2), " (", 
                           format(round(std, digits=2), nsms=2), ")", sep=""))
    anydat_sub <- anydat[c("field", "label", "site", "print")]
    anydat_long <- anydat_sub %>%
      group_by(field) %>%
      gather("print", key=variable, value=number) %>%
      unite(combi, variable, site) %>%
      spread(combi, number)
    anydat_long <- anydat_long[match(order_gp, anydat_long$field),]
    anydat_long <- anydat_long[-1]
  }
  colnames(anydat_long) <- gsub('print_', '', colnames(anydat_long))
  colnames(anydat_long) <- gsub('label', 'Field', colnames(anydat_long))
  return(anydat_long)
}

prep_concord_agg <- function(anydat, grouping, order_gp, n_sites=ns, fac=FALSE, overall=FALSE){
  if(fac == TRUE){
    anydat <- anydat[anydat$group == grouping,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(aggregate_n_concordant = cumsum(n_concordant),
             aggregate_n_both_present = cumsum(n_both_present),
             aggregate_n_structured_only = cumsum(n_structured_only),
             aggregate_n_chart_only = cumsum(n_chart_only),
             aggregate_n_both_null = cumsum(n_both_null)) 
    anydat_cut <- data.frame(tail(anydat, n=length(anydat$field)/n_sites))
    anydat_cut$aggregate_total <- anydat_cut$aggregate_n_both_present + 
                                  anydat_cut$aggregate_n_structured_only +
                                  anydat_cut$aggregate_n_chart_only +
                                  anydat_cut$aggregate_n_both_null
    anydat_cut <- data.frame(anydat_cut)
    g <- BinomCI(anydat_cut$aggregate_n_concordant, anydat_cut$aggregate_total, conf.level=0.95, method="wald")
    dg <- cbind(anydat_cut, g)
    dg$est <- format(round(dg$est, digits=3), nsms=3)
    dg$lwr.ci <- format(round(dg$lwr.ci, digits=3), nsms=3)
    dg$upr.ci <- format(round(dg$upr.ci, digits=3), nsms=3)
    dg$print <- paste(dg$est, " (", dg$lwr.ci, ", ", dg$upr.ci, ")", sep="")
    rownames(dg) <- 1:nrow(dg)
    dg_sub <- dg[c("field", "label", "print")]
    dg_sub <- dg_sub[match(order_gp, dg_sub$field),]
    dg_sub <- dg_sub[-1]
    return(dg_sub)
  }
  if(fac == FALSE){
    anydat <- anydat[anydat$group == grouping,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat_sub <- anydat[c("field", "label", "site", "mean", "n_both_present")]
    anydat_long <- anydat_sub %>%
      group_by(field) %>%
      gather("mean", "n_both_present", key=variable, value=number) %>%
      unite(combi, variable, site) %>%
      spread(combi, number)
    anydat_long <- data.frame(anydat_long)
    count_mean_na <- anydat_long %>%
      group_by(field) %>%
      select(starts_with("mean")) %>%
      is.na %>%
      rowSums
    anydat_long <- cbind(anydat_long, count_mean_na)
    # Overall and By Approach (with Cornell)
    if(overall == TRUE){
      anydat_long <- anydat_long %>%
        group_by(field) %>%
        mutate(wtd_mean = wtd.mean(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo, mean_Cornell),
                                   weights=c(n_both_present_VUMC, n_both_present_Yale, 
                                             n_both_present_Lahey, n_both_present_Mayo, n_both_present_Cornell), #survey weights
                                   normwt=FALSE, na.rm=TRUE),
               wtd_var = ifelse(count_mean_na < n_sites, wtd.var(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo, mean_Cornell),
                                                                 weights=c(n_both_present_VUMC, n_both_present_Yale, 
                                                                           n_both_present_Lahey, n_both_present_Mayo, n_both_present_Cornell),
                                                                 normwt=FALSE, na.rm=TRUE, method='unbiased'), NA),
               wtd_std = sqrt(wtd_var),
               print = paste(format(round(wtd_mean, digits=2), nsms=2), " (",
                             format(round(wtd_std, digits=2), nsms=2), ")", sep=""))
    }
    # Overall and By Approach (without Cornell)
    if(overall == FALSE){
    anydat_long <- anydat_long %>%
      group_by(field) %>%
      mutate(wtd_mean = wtd.mean(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo),
                                 weights=c(n_both_present_VUMC, n_both_present_Yale, 
                                           n_both_present_Lahey, n_both_present_Mayo), #survey weights
                                 normwt=FALSE, na.rm=TRUE),
             wtd_var = ifelse(count_mean_na < n_sites, wtd.var(c(mean_VUMC, mean_Yale, mean_Lahey, mean_Mayo),
                                                               weights=c(n_both_present_VUMC, n_both_present_Yale, 
                                                                         n_both_present_Lahey, n_both_present_Mayo),
                                                               normwt=FALSE, na.rm=TRUE, method='unbiased'), NA),
             wtd_std = sqrt(wtd_var),
             print = paste(format(round(wtd_mean, digits=2), nsms=2), " (",
                           format(round(wtd_std, digits=2), nsms=2), ")", sep=""))
    }
    anydat_long_sub <- anydat_long[c("field", "label", "print")]
    anydat_cut <- data.frame(tail(anydat_long_sub, n=length(anydat_sub$field)/n_sites))
    anydat_cut <- anydat_cut[match(order_gp, anydat_cut$field),]
    anydat_cut <- anydat_cut[-1]
    return(anydat_cut)
  }
}

print_concord <- function(fmr, far, frr, fir, ftr, fur,
                          nmr, nar, nrr, nir, ntr, nur,
                          gp, fo, no, dat_factor, dat_numeric,
                          agg=FALSE, ns=nsites, nsc=nsites_c){
  # Aggregate
  if (agg == TRUE){
    fm <- prep_concord_agg(fmr, grouping=gp, order_gp=fo, n_sites=nsc, fac=TRUE, overall=TRUE) 
    fa <- prep_concord_agg(far, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    fr <- prep_concord_agg(frr, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    fi <- prep_concord_agg(fir, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    ft <- prep_concord_agg(ftr, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    fu <- prep_concord_agg(fur, grouping=gp, order_gp=fo, n_sites=ns, fac=TRUE, overall=TRUE) 
    if (gp != "Active Medications" & gp != "Primary Procedure Characteristics") {
      nm <- prep_concord_agg(nmr, grouping=gp, order_gp=no, n_sites=nsc, fac=FALSE, overall=TRUE) 
      na <- prep_concord_agg(nar, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
      nr <- prep_concord_agg(nrr, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
      ni <- prep_concord_agg(nir, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
      nt <- prep_concord_agg(ntr, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
      nu <- prep_concord_agg(nur, grouping=gp, order_gp=no, n_sites=ns, fac=FALSE, overall=TRUE) 
    }
    if (gp == "Active Medications" | gp == "Primary Procedure Characteristics") {
      nm <- NA
      na <- NA
      nr <- NA
      ni <- NA
      nt <- NA
      nu <- NA
    }
    m <- rbind(fm, nm)
    a <- rbind(fa, na)
    r <- rbind(fr, nr)
    i <- rbind(fi, ni)
    t <- rbind(ft, nt)
    u <- rbind(fu, nu)
    pri <- cbind(m, subset(a, select=c("print")), subset(r, select=c("print")), 
                 subset(i, select=c("print")), subset(t, select=c("print")),
                 subset(u, select=c("print")))
    colnames(pri) <- c("Field", "Overall", "Adjustable Sling (AMUS)", "Retro-Pubic (RPMUS)",
                       "Single Incision (SIMUS)", "Trans-Obturator (TOMUS)", "Unknown Approach")
  }
  # By Site
  if (agg == FALSE){
    fa <- prep_concord_site(dat_factor, grouping=gp, order_gp=fo, fac=TRUE)
    if (gp != "Active Medications" & gp != "Primary Procedure Characteristics") {
      na <- prep_concord_site(dat_numeric, grouping=gp, order_gp=no, fac=FALSE)
    }
    if (gp == "Active Medications" | gp == "Primary Procedure Characteristics") {
      na <- NA
    }
    pri <- rbind(fa, na)
  }
  knitr::kable(pri, align='lccccc', "html", col.names=colnames(pri), escape=FALSE,
               table.attr='class="table-fixed-header"') %>%
    kable_styling(position="left", full_width=TRUE, bootstrap_options=c("striped", "hover", "condensed")) %>%
    scroll_box(height="500px")
} 

prep_valid_site <- function(anydat, order_gp, n_sites=ns){
  anydat <- anydat %>%
      group_by(field) %>%
      mutate(print = paste(format(round(perc_concordant, digits=0), nsmall=0), "% (",
                           format(round(perc_tp, digits=0), nsmall=0), "%, ",
                           format(round(perc_tn, digits=0), nsmall=0), "%, ",
                           format(round(perc_fp, digits=0), nsmall=0), "%, ",
                           format(round(perc_fn, digits=0), nsmall=0), "%)", sep=""))
  anydat <- anydat[anydat$field %in% order_gp,]
  anydat <- anydat[with(anydat, order(site)),]
  macro <- anydat %>%
    group_by(site) %>%
    mutate(macro_perc_concordant = mean(perc_concordant, na.rm=TRUE),
           macro_perc_tp = mean(perc_tp, na.rm=TRUE),
           macro_perc_tn = mean(perc_tn, na.rm=TRUE),
           macro_perc_fp = mean(perc_fp, na.rm=TRUE),
           macro_perc_fn = mean(perc_fn, na.rm=TRUE),
           print_m = paste(format(round(macro_perc_concordant, digits=0), nsmall=0), "% (",
                           format(round(macro_perc_tp, digits=0), nsmall=0), "%, ",
                           format(round(macro_perc_tn, digits=0), nsmall=0), "%, ",
                           format(round(macro_perc_fp, digits=0), nsmall=0), "%, ",
                           format(round(macro_perc_fn, digits=0), nsmall=0), "%)", sep=""))
  counts <- cbind("Count of all procedures (N)", 
                  matrix(anydat$N[seq(1, nrow(anydat), nrow(anydat)/n_sites)],
                  nrow=1, ncol=n_sites, byrow=TRUE))
  macro_sub <- cbind("Overall (macro average)",
                     matrix(macro$print_m[seq(1, nrow(macro), nrow(macro)/n_sites)], 
                            nrow=1, ncol=n_sites, byrow=TRUE))
  anydat_sub <- anydat[c("field", "label", "site", "print")]
  anydat_long <- anydat_sub %>%
    group_by(field) %>%
    gather("print", key=variable, value=number) %>%
    unite(combi, variable, site) %>%
    spread(combi, number)
  anydat_long <- anydat_long[match(order_gp, anydat_long$field),]
  anydat_long <- anydat_long[-1]
  colnames(counts) <- colnames(anydat_long)
  colnames(macro_sub) <- colnames(anydat_long)
  anydat_long <- rbind(counts, macro_sub, anydat_long)
  colnames(anydat_long) <- gsub('print_', '', colnames(anydat_long))
  colnames(anydat_long) <- gsub('label', 'Field', colnames(anydat_long))
  return(anydat_long)
}

prep_valid_agg <- function(anydat, order_gp, n_sites=ns){
    anydat <- anydat[anydat$field %in% order_gp,]
    anydat <- anydat[with(anydat, order(site)),]
    anydat <- anydat %>%
      group_by(field) %>%
      mutate(agg_n_concordant = cumsum(n_concordant),
             agg_total = cumsum(N),
             agg_n_tp = cumsum(n_tp),
             agg_n_tn = cumsum(n_tn),
             agg_n_fp = cumsum(n_fp),
             agg_n_fn = cumsum(n_fn),
             agg_perc_concordant = as.numeric(format(round(100*(agg_n_concordant / agg_total),
                                                digits=0), nsmall=0)),
             agg_perc_tp = as.numeric(format(round(100*(agg_n_tp / agg_total),
                                        digits=0), nsmall=0)),
             agg_perc_tn = as.numeric(format(round(100*(agg_n_tn / agg_total),
                                              digits=0), nsmall=0)),
             agg_perc_fp = as.numeric(format(round(100*(agg_n_fp / agg_total),
                                              digits=0), nsmall=0)),
             agg_perc_fn = as.numeric(format(round(100*(agg_n_fn / agg_total),
                                              digits=0), nsmall=0)),
             print = paste(agg_perc_concordant, "% (",
                           agg_perc_tp, "%, ",
                           agg_perc_tn, "%, ",
                           agg_perc_fp, "%, ",
                           agg_perc_fn, "%)", sep="")) 
    macro <- anydat %>%
      group_by(site) %>%
      mutate(macro_perc_concordant = mean(agg_perc_concordant, na.rm=TRUE),
             macro_perc_tp = mean(agg_perc_tp, na.rm=TRUE),
             macro_perc_tn = mean(agg_perc_tn, na.rm=TRUE),
             macro_perc_fp = mean(agg_perc_fp, na.rm=TRUE),
             macro_perc_fn = mean(agg_perc_fn, na.rm=TRUE),
             print_m = paste(format(round(macro_perc_concordant, digits=0), nsmall=0), "% (",
                             format(round(macro_perc_tp, digits=0), nsmall=0), "%, ",
                             format(round(macro_perc_tn, digits=0), nsmall=0), "%, ",
                             format(round(macro_perc_fp, digits=0), nsmall=0), "%, ",
                             format(round(macro_perc_fn, digits=0), nsmall=0), "%)", sep=""))
    counts <- cbind("Count of all procedures (N)", 
                    sum(anydat$N[seq(1, nrow(anydat), nrow(anydat)/n_sites)]))
    macro_sub <- cbind("Overall (macro average)",
                       macro$print_m[seq(1, nrow(macro), nrow(macro)/n_sites)])
    macro_sub <- matrix(macro_sub[n_sites,], nrow=1, ncol=2, byrow=TRUE)
    anydat_sub <- anydat[c("field", "label", "print")]
    anydat_sub <- data.frame(tail(anydat_sub, n=length(anydat$field)/n_sites))
    anydat_long <- anydat_sub[match(order_gp, anydat_sub$field),]
    anydat_long <- anydat_long[-1]
    colnames(counts) <- colnames(anydat_long)
    colnames(macro_sub) <- colnames(anydat_long)
    anydat_long <- rbind(counts, macro_sub, anydat_long)
    colnames(anydat_long) <- gsub('print', 'Overall', colnames(anydat_long))
    colnames(anydat_long) <- gsub('label', 'Field', colnames(anydat_long)) 
    return(anydat_long)
}

print_valid <- function(anydat, fo, ns=nsites){
  cc <- prep_valid_agg(anydat, order_gp=fo, n_sites=ns)
  dd <- prep_valid_site(anydat, order_gp=fo, n_sites=ns)
  ff <- cbind(cc, dd[,2:(ns+1)])
  knitr::kable(ff, align='lccccc', "html", col.names=colnames(ff), escape=FALSE,
             table.attr='class="table-fixed-header"') %>%
  kable_styling(position="left", full_width=TRUE, bootstrap_options=c("striped", "hover", "condensed")) %>%
  scroll_box(height="500px")
}