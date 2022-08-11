#http://www.r-bloggers.com/sparql-with-r-in-less-than-5-minutes/
install.packages("SPARQL")
library(SPARQL) # SPARQL querying package
library(ggplot2)

endpoint <- "https://query.wikidata.org/sparql"
query <- '#Popular eye colors among humans\n#title:Popular eye colors among humans\n#illustrates bubblechart view, count\n\n#defaultView:BubbleChart\nSELECT ?eyeColorLabel (COUNT(?human) AS ?count)\nWHERE\n{\n  ?human wdt:P31 wd:Q5.\n  ?human wdt:P1340 ?eyeColor.\n  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }\n}\nGROUP BY ?eyeColorLabel'
useragent <- paste("WDQS-Example", R.version.string) # TODO adjust this; see https://w.wiki/CX6

qd <- SPARQL(endpoint,query,curl_args=list(useragent=useragent))
df <- qd$results

ggplot(df, aes(x=eyeColorLabel, y=count)) +
  geom_point() +
  geom_smooth()

ggplot(df, aes(x=eyeColorLabel, y=count)) + geom_point()

ggplot(df, aes(x=eyeColorLabel, y=count)) + geom_point(alpha=0.3, color="black") 

       