## Joe Telafici - 

## R script to get Federal Register summary data for a date range



GetFRData <- function (startdate=date(), enddate=NULL, type="rule", searchterm="") {

    library(dplyr)  
    library(XML)
  
    ## Parameters
    ## startdate - first publication date, inclusive of search in %m/%d/Y format; defaults to today
    ## enddate - last publication date, inclusive of search in %m/%d/%Y format; defaults to empty
    ## type = one of rule, proposed, presidential
    ## searchterm - a word or phrase in the title of the documents returned (all words must be present in the title)
    
    csvurl <- "https://www.federalregister.gov/documents/search.csv?conditions[publication_date][gte]=02/26/2018&conditions[publication_date][lte]=03/02/2018&conditions[type][]=RULE"
    baseurl <- "https://www.federalregister.gov/documents/search.json?conditions"
    bulkXMLpath <- "https://www.gpo.gov/fdsys/bulkdata/FR/2018/03/FR-2018-03-01.xml"
    
    b1 <- "%5B"
    b2 <- "%5D"
    s1 <- "%2F"
    rulestr <- "RULE"
    propstr <- "PRORULE"
    presstr <- "PRESDOCU"
    
    
    foo = url("https://www.federalregister.gov/documents/search?conditions%5Btype%5D%5B%5D=RULE")
    htmlcode = readLines(foo)
    close (foo)
    bar <- htmlTreeParse(htmlcode, useInternalNodes = T)
    xpathSApply(xmlRoot(bar), "//title", xmlValue)
    
    #mycsv <- read.csv(url(csvurl))
    myxml <- htmlTreeParse("https://www.gpo.gov/fdsys/bulkdata/FR/2018/03/FR-2018-03-01.xml")
    
    xp_proposed <- "//PRORULE"
    xp_rule <- "//RULE"
    xp_pres <- "//PRESDOCU//HD"
    xp_subject <- "/PREAMB/SUBJECT"
    xp_subagency <- "/PREAMB/SUBAGY"
    xp_agency <- "/PREAMB/AGENCY"
    xp_friendly_agency <- "/PREAMB/AGY/P"
    
    library(dplyr)
    berry <- tbl_df(dingle)
    
}


GetSCOTUSData <- function  (startdate=date(), enddate=NULL, type="opinion") {
  
  library(dplyr)  
  library(XML)
  library(stringr)
  
  ## Parameters
  ## startdate - first publication date, inclusive of search in %m/%d/Y format; defaults to today
  ## enddate - last publication date, inclusive of search in %m/%d/%Y format; defaults to empty
  ## type = one of "rule, proposed, presidential"opinion" (default) or "arguments"
  
  argurl <- "https://www.supremecourt.gov/oral_arguments/calendars/MonthlyArgumentCalFebruary2018.html"
  opinurl <-"https://www.supremecourt.gov/opinions/slipopinion/17"
  
  xp_arg <- "//table[@class='MsoNormalTable']/tr[position()>1]/td//span"
  opin_arg <- "//table/tbody/tr[position()>1]"
  
  
  foo = url(argurl)
  htmlcode = readLines(foo)
  close (foo)
  bar <- htmlTreeParse(htmlcode, useInternalNodes = T)
  myargdata <- xpathSApply(xmlRoot(bar), xp_arg, xmlValue)
  myargdata <- myargdata[str_length(myargdata)>1]
  myargdata <- lapply (myargdata, function(y) gsub (",\n..", ", ", y))
  myargdata <- lapply (myargdata, function(y) gsub ("^.\n..", "", y))
  myargdata <- lapply (myargdata, function(y) gsub ("V.\n..", "V. ", y))
  myargdata <- lapply (myargdata, function(y) gsub ("\n..", " ", y))
  myargdata <- str_trim(lapply (myargdata, function(y) gsub ("\\s+", " ", y)))
  myargdata <- myargdata[unlist(lapply (myargdata, function(y) grepl ('^[^\\(]', y)))]
  arguments <- tbl_df(myargdata)
  arguments
  #as.Date(myargdata[1], "%A, %B %d")
  
  foo = url(opinurl)
  htmlcode = readLines(foo)
  close (foo)
  bar <- htmlTreeParse(htmlcode, useInternalNodes = T)
  myopindata <- xpathSApply(xmlRoot(bar), opin_arg, xmlValue)
  myopindata
  

}

