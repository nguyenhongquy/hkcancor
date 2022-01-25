# HKCANCOR
Sentence-final particles are an important feature of Cantonese speech. They are not easily translated into English, and their (grammatical) functions are often conveyed by intonation patterns. The analysis of sentence final particles (SFP) relies heavily on authentic spoken data. We would like to use MYSQL to build a relational database that is easy to access and do queries concerning SFPs. 
In this project, we make use of PyCantonese, a Python library for Cantonese linguistics and natural language processing. PyCantonese comes with a built-in corpus, namely Hong Kong Cantonese Corpus (HKCanCor).
# Collect
* Cantonese.sql creates tables in the database
* HKCanCor.py inserts records into tables
# Prepare
* list_of_sfps.sql: basic analysis concerning frequencies of SFPs in the corpus.
* SFP-example.sql searches for full sentences with SFPs that match our research interest. 
# Access
* Cantonese_queries.xml: output of result queries.
* frequency.xslt & examples.xslt: transform the query results from XML format to HTML format.
* xslt-transformer.py: executes codes in frequency.xslt and examples.xslt
* frequency.htm: all tables concerning frequencies of SFPs.
* examples.htm: list of sentences that match our research interest.
# References:
* Li, B. (2006). Chinese final particles and the syntax of the periphery. Leiden University.
* Luke, K. K., & Wong, M. L. (2015). The Hong Kong Cantonese corpus: design and uses. Journal of Chinese Linguistics, 25(2015), 309-330.
* Matthews, S., & Yip, V. (1994). Cantonese: A comprehensive grammar. Routledge.
* http://compling.hss.ntu.edu.sg/hkcancor/
* https://pycantonese.org/
