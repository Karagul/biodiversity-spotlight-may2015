#We're going to need a little help installing iDigBio's R library, so lets start there:
install.packages("devtools")
library(devtools)

# Now we can use the function install_github to install iDigBio's R library and then load it into memory:
install_github("idigbio/ridigbio")
library(ridigbio)

# Let's take a look at this month's biodiversity spotlight, the fathead minnow, "pimephales promelas", 
# records in iDigBio by creating a dataframe using the function idig_search_records:
fatheadData <- idig_search_records(rq=list(scientificname="pimephales promelas"))
str(fatheadData)

# We can see that the data returned by the iDigBio search API contains these columns:
# "uuid","occurrenceid","catalognumber","family","genus","scientificname","country",
# "stateprovince","geopoint.lat","geopoint.lon","datecollected","collector" 
colnames(fatheadData)

#For some sanity checking of the data, we can create a plot of the latitude and longitude of these records:
plot(fatheadData$geopoint.lat,fatheadData$geopoint.lon)

# And see what data is present in the "country" and "stateprovince" columns:
unique(fatheadData$country)
unique(fatheadData$stateprovince)


#Looks like we have an outlier, lets take a closer look:
outlier <- fatheadData[which(fatheadData$geopoint.lon >0),]
outlier$country

#Since we know that this outlier is an error in the data, 
# we will create a new dataframe with this outlier omitted
cleanedData <- fatheadData[which(fatheadData$uuid != outlier$uuid),]

#Now we can output this data to a CSV file so we can 
# work with it in other applications:
write.csv(cleanedData, file="idigbio-fathead-data.csv",row.names=FALSE)



