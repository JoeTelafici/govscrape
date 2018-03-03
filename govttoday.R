## Joe Telafici - 

## R script to get Federal Register summary data for a date range

GetFRData (startdate=date(), enddate=NULL, type="rule", searchterm="") {
    
    ## Parameters
    ## startdate - first publication date, inclusive of search in %m/%d/Y format; defaults to today
    ## enddate - last publication date, inclusive of search in %m/%d/%Y format; defaults to empty
    ## type = one of rule, proposed, presidential
    ## searchterm - a word or phrase in the title of the documents returned (all words must be present in the title)
    
    baseurl <- "https://www.federalregister.gov/documents/search.json?conditions"
    b1 <- "%5B"
    b2 <- "%5D"
    s1 <- "%2F"
    rulestr <- "RULE"
    propstr <- "PRORULE"
    presstr <- "PRESDOCU"
    
    
}

