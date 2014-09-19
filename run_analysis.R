#-----------------------------------------------------------------------------------------------------
        ##### I) Downloading datasets and loading libraries
#-----------------------------------------------------------------------------------------------------

# downloading and storing datasets directly from the internet
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "getdata-projectfiles-UCI HAR Dataset.zip", mode="wb")
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

# loading plyr library
suppressMessages(library(plyr))

#------------------------------------------------------------------------------------------------------
        ##### II) One function to find them, One function to load them all
#------------------------------------------------------------------------------------------------------

# The following function intitled `readdata` finds all relevant documents, transforms them in a usable format and stores them
# Please read the readme file for more details on `readdata` function

readdata <- function(dataname){
                
        if(grepl(".txt", dataname)==TRUE & file.exists(paste("./UCI HAR Dataset/",dataname,sep=""))){
                        
                path <- paste("./UCI HAR Dataset/",dataname,sep="")
                data <- read.table(path, header=FALSE)
                names(data) <- c("num","labels")
                        
                cat("Here are some observations on ",dataname," dataset:\n")
                        
                cat("\n","First an idea on the sturture of ",dataname," dataset.","\n")
                str(data)
                        
                c <- sum(is.na(data))
                cat("\n","There are exactly",c,"NAs throughout the ",dataname," dataset.","\n")
                        
                        
                if(all(length(unique(data$label))==nrow(data))==TRUE)
                {cat("\n","There doesn't seem to be any repeat values for `labels` variable in ", dataname ," dataset.","\n")}
                        
                else{
                        z <- data.frame(table(data$labels, useNA = "ifany"))
                        y <- subset(z, z$Freq != 1)
                        f <- nrow(y)
                                
                        cat("\n",f," values for variable `labels` seem to be repeated.","\n") 
                        cat("\n","The following table shows which values are repeated and","\n") 
                        cat("at which frequency in ",dataname," dataset for `labels` variable:","\n")
                        cat("\n")
                        print(y)
                }
                        

        }
                else if(file.exists(paste("./UCI HAR Dataset/",dataname,sep=""))){
                        
                        path <- paste("./UCI HAR Dataset/",dataname,sep="")
                        filenames <- list.files(path, pattern="*.txt", full.names=TRUE)
                        
                        for(i in 1:length(filenames)){
                                assign(paste("a", i, sep = ""), read.table(filenames[[i]],header=FALSE))
                        }
                        data <- cbind(a1,a2,a3)
     
                }
                
        else {stop("No such file or directory.")}
                
        name <- paste(dataname,"data.csv",sep="_")
        path <- paste("./UCI Results/",name,sep="")
        if(file.exists("./UCI Results")==TRUE){write.csv(data,path)}
        else { dir.create("UCI Results")
                       write.csv(data,path)}
        
}
#-----------------------------------------------------------------------------------------------------------------
        ##### III) and in the machine bind them  
#-----------------------------------------------------------------------------------------------------------------

# The following function intitled `collage` loads datasets created by previous `readdate` function and merges them
# in a way that answers to questions of the project assignment
# Please read the readme file for more details on `collage` function

collage <- function(all){
        
        
        if(all=="all"){
                if((file.exists("./UCI Results/activity_labels.txt_data.csv") & file.exists("./UCI Results/features.txt_data.csv") & file.exists("./UCI Results/test_data.csv") & file.exists("./UCI Results/train_data.csv")) ==TRUE){
                        rm(list = ls())
                                
                        one <- read.csv("./UCI Results/activity_labels.txt_data.csv")
                        two <- read.csv("./UCI Results/features.txt_data.csv")
                        three <- read.csv("./UCI Results/test_data.csv")
                        four <- read.csv("./UCI Results/train_data.csv")
                        one[1] <- NULL
                        two[1] <- NULL
                        three[1] <- NULL
                        four[1] <- NULL
                                
                        pi <- data.frame(cbind("id","id"))
                        po <- data.frame(cbind("activity","activity"))
                        names(po)<-c("num","labels")
                        names(pi)<-c("num","labels")
                        suppressWarnings(two <- rbind(pi,two,po))
                                
                        colnames(three) <- two$labels
                        colnames(four) <- two$labels
                        rbinded <- data.frame(rbind(three, four)) # Question I
                        write.csv(rbinded,"./UCI Results/1)rbinded.csv")
                                
                        extract <- rbinded[,c(grep("^id$", colnames(rbinded)), grep("^activity$", colnames(rbinded)), grep("std", colnames(rbinded)), grep("mean", colnames(rbinded)))] # Question II
                        write.csv(extract,"./UCI Results/2)extract.csv")
                                
                        extract$activity <- factor(extract$activity, levels=one$num, labels=one$labels) # Question III & IV
                        write.csv(extract,"./UCI Results/3)and4)labeled.csv")
                                
                        tidy <- ddply(extract, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
                        colnames(tidy)[-c(1:2)] <- paste(colnames(tidy)[-c(1:2)], "_mean", sep="")
                        write.csv(tidy,"./UCI Results/5)tidy.csv",row.names=FALSE)
                        
                }
                else {print("Please readdata all files: `activity_labels.txt`, `features.txt`, `test` and `train`.")}
        }
        else {stop("Please enter valid command : collage(all)")}
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------
        ##### IV) One function to solve them all,
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------

# This part use readdata function to read all necessary files or folders to get necessary data to construct final dataset

readdata("features.txt")
readdata("activity_labels.txt")
readdata("test")
readdata("train")

# Then uses collage function to bind all datasets together to form tidy dataset needed for assignment
# but also some intermediary datasets

collage("all")

# The following message is printed at the end of the process.

cat("\n","\n","All done. You will find in your current working directory a ")
cat("\n","compressed file called getdata-projectfiles-UCI HAR Dataset.zip ")
cat("\n", "which is the original downloaded file, and a file UCI HAR Dataset ")
cat("\n", "its unzipped (uncompressed) counterpart containing all relevant ")
cat("\n", "datasets. Additionally, in file UCI Results you will find datasets ")
cat("\n", "built by the current R script. Those labeled 1 to 5 are datasets ")
cat("\n", "built in answer to questions of corresponding number of the project ")
cat("\n", "as for the rest they are transitionary datasets not of interest here.")
rm(list=ls(all=TRUE))
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------