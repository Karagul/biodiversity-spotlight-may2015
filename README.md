We're going to need a little help installing iDigBio's R library, so lets start there:

```{r, eval=FALSE}
install.packages("devtools")
library(devtools)
```

Now we can use the function install_github to install iDigBio's R library and then load it into memory:

```{r, eval=FALSE}
install_github("idigbio/ridigbio")
library(ridigbio)
```
```{r, echo=FALSE}
library(ridigbio)
```


Let's take a look at this month's biodiversity spotlight, the fathead minnow, "pimephales promelas", in iDigBio by creating a dataframe using the function idig_search_records:

```{r}
fatheadData <- idig_search_records(rq=list(scientificname="pimephales promelas"))
str(fatheadData)
```


We can see that the data returned by the iDigBio search API contains these columns:

```{r}
colnames(fatheadData)
```

For some sanity checking of the data, we can create a plot of the latitude and longitude of these records:

```{r}
plot(fatheadData$geopoint.lat,fatheadData$geopoint.lon)
```
![alt text](https://www.idigbio.org/sites/default/files/sites/default/files/spotlight/coding-examples/data-exploration.png "Figure 1")




And see what data is present in the "country" and "stateprovince" columns:

```{r}
unique(fatheadData$country)
unique(fatheadData$stateprovince)
```

Looks like we have an outlier, lets take a closer look:

```{r}
outlier <- fatheadData[which(fatheadData$geopoint.lon >0),]
outlier$country
```

Since we know that this outlier is an error in the data, we will create a new dataframe with this outlier omitted

```{r}
cleanedData <- fatheadData[which(fatheadData$uuid != outlier$uuid),]
```

Now let's output this data to a CSV file so we can work with it in other applications

```{r eval=FALSE}
write.csv(cleanedData, file="idigbio-fathead-data-yyyymmdd.csv",row.names=FALSE)
```

As an excercise for the reader, can you recreate the following map with the concepts presented above?

![alt text](https://www.idigbio.org/sites/default/files/sites/default/files/spotlight/coding-examples/idigbio-pimephales-promelas-dist-map.png "Figure 2")





