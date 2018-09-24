# In class assignment: 09/24/2018, Name: "Ling Wang".
# Set yout working directory to desktop
Setwd("C:\Users\Ling\Desktop")
# Load the library GEOquery, limma, and affy

library(GEOquery)
library(limma)
library(affy)

# Use following FTP link to download sample micrarray data from GEO database
use the function get GEO and assign the data to object named ges

url <- "ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE1nnn/GSE1000/matrix/GSE1000_series_matrix.txt.gz"
filenm <- "GSE1000_series_matrix.txt.gz"
if(!file.exists(filenm)) download.file(url, destfile=filenm)

gse <- getGEO(filename=filenm)

# check what you have in the gse object
Object can be a class data frame, matrix or a list a vector
class(gse) ##to see what sample you have
head(gse) ## only give you sample's information
head(exprs(gse)) ## to see the expression value in object gse

# Make two objects called treatment and control,
and put first 5 columns of gse in treatmetn and next 5 columns in control

treatment <- exprs(gse[,1:5])## better way because you don't need the columllabels/names
or
treatment <- exprs(gse[,c("GSM15785",  "GSM15786",  "GSM15787",  "GSM15788",  "GSM15789")])

control <- exprs(gse[,6:10])

# take row means of object treatment and control

rowMeans()## function
rowMeans(treatment)
rowMeans(control)

treatment_means <- rowMeans(treatment)

control_means<- rowMeans(control)

# Fold change of treatment_means/control_means and put in object called fold

fold <- treatment_means/control_means

# use if else loop, if the fold change is > 2,
 put genes in new object called up regulation;
and if fold change <-2 put the genes into new object called down regulation

if (fold > 2), {up_regulation <- fold}
else if (fold < -2), {down_regulation <- fold}

# Subsetting in r
up_regulation <- fold[which(fold > 2)]
down_regulation <- fold[which(fold < -2)]

# Write the object onto a file(.txt, .xls, .xlsx, .csv)
write.csv(fold, file="class assignment fold.csv", row.names=FALSE)
