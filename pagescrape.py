from lxml import html
from lxml import etree
import time
from datetime import date
import requests

#Supreme Court Scraping

page = requests.get('https://www.supremecourt.gov/')
tree = html.fromstring(page.content)
#This will create a list of buyers:
decision = tree.xpath('//div[@class="recentdecisions"]/ul/li/a/text()')
#This will create a list of prices
calendar = tree.xpath('//table[@class="rcMainTable"]/tbody/tr/td/a/text()')
calendarres = tree.xpath('//table[@class="rcMainTable"]/tbody/tr/td/@title')

print ('SCOTUS SECTION')
print ('\nLatest SCOTUS decisions:')
for decisions in decision :
    print (decisions)

print ('\nLatest SCOTUS schedule:')
for i in range(len(calendar)): 
    print (calendar[i], ': ', calendarres[i], end='\n')

#FR Scraping
print ('FEDERAL REGISTER SECTION') 

#Federal Register Scraping

    
#Rules
#today = date(2017, 9, 12)
today = date.today()

ruletype = 'RULE#'
rulespage = 'https://www.federalregister.gov/documents/search?conditions%5Bpublication_date%5D%5Bis%5D=' + today.isoformat() + '&conditions%5Btype%5D=' + ruletype
#print (rulespage)
page = requests.get(rulespage)
tree = html.fromstring(page.content)
#This will create a list of rules:
rules = tree.xpath('//div[@class="document-wrapper"]/h5/a/text()')
ruleurls = tree.xpath('//div[@class="document-wrapper"]/h5/a/@href')
ruleagency = tree.xpath('//div[@class="document-wrapper"]/p/a/text()')

print ('\nNew Federal Register Rules')
for i in range(len(rules)):
    print (rules[i], ': (', ruleagency[i], ') :', ruleurls[i], end='\n')

ruletype = 'PRORULE#'
prorulespage = 'https://www.federalregister.gov/documents/search?conditions%5Bpublication_date%5D%5Bis%5D=' + today.isoformat() + '&conditions%5Btype%5D=' + ruletype
#print (prorulespage)
proposed = requests.get(prorulespage)
tree = html.fromstring(proposed.content)
#This will create a list of rules:
prorules = tree.xpath('//div[@class="document-wrapper"]/h5/a/text()')
proruleurls = tree.xpath('//div[@class="document-wrapper"]/h5/a/@href')

print ('\nNew Federal Register Proposed Rules')

for i in range(len(prorules)):
    print (prorules[i], ': (', proruleurls[i], ')', end='\n')
        
ruletype = 'PRESDOCU#'
presrulespage = 'https://www.federalregister.gov/documents/search?conditions%5Bpublication_date%5D%5Bis%5D=' + today.isoformat() + '&conditions%5Btype%5D=' + ruletype
#print (presrulespage)
execorders = requests.get(presrulespage)
tree = html.fromstring(execorders.content)
#This will create a list of rules:
eos = tree.xpath('//div[@class="document-wrapper"]/h5/a/text()')
eosurls = tree.xpath('//div[@class="document-wrapper"]/h5/a/@href')

print ('\nNew Federal Register Presidential Documents')
for i in range(len(eos)):
    print (eos[i], ': (', eosurls[i], ')', end='\n')


# House Meeting scraping


househomepage = 'https://www.house.gov/'
#print (househomepage)
housepage = requests.get(househomepage)
tree = html.fromstring(housepage.content)
#This will create a list of rules:
meetings = tree.xpath('//table[@class="schedule"]/tbody/tr/td/a/text()')
committees = tree.xpath('//table[@class="schedule"]/tbody/tr/td/em/text()')

print ('\nHouse Committee Meetings: ', len(committees))
for i in range(len(committees)):
    print (meetings[i], ': (', committees[i], ')', end='\n')

    
# adding a comment    

# adding feature 1

# adding feature 2

