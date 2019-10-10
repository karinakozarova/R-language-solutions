---
title: "R Notebook"
output:
  html_document:
    df_print: paged
---
Start with your name and student number

**************************

Name: 
 Studentnumber:
 Class:
 Date: 

********************

```{r include=FALSE}
library(gapminder)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(readr)
library(skimr)

# using the include=FALSE will allow us to run the chunk without showing it in the knitted HTML file. 

```

After we have these packages enabled, we will look at our first Dataset. For this mock we start with the set mtcars,

```{r}
str(mtcars)
```
This set describes different cars and their performances. 


1) Make a scatterplot with the mpg on the x-axis and the wt on the y-axis. 

```{r}
ggplot(mtcars, aes(x = mpg, y = wt)) + geom_point()
```

2) The second step will be to map the different cylinders in a different colour. You can use the aes() function for this. 

```{r}
ggplot(mtcars, aes(x = mpg, y = wt, color = cyl)) + geom_point()

```

3) Add a smooth line to the graph, using the correct function:

```{r}
ggplot(mtcars, aes(x = mpg, y = wt, color = cyl)) + geom_point() + geom_smooth()
```

4) Remove the error shading from the smooth line by changing the setting of se to FALSE

```{r}
ggplot(mtcars, aes(x = mpg, y = wt, color = cyl)) + geom_point() + geom_smooth(se = FALSE)

```

5) make the points 60% transparent or 40% visible by setting the alpha to 0.4

```{r}
ggplot(mtcars, aes(x = mpg, y = wt, color = cyl)) + geom_point() + geom_smooth(se = FALSE, alpha = 0.4)

```

6) lastly set the method to lm, to make this a linear line and set the linetype to 2 for a dotted line.

```{r}
ggplot(mtcars, aes(x = mpg, y = wt, color = cyl)) + geom_point() + geom_smooth(method = "lm", linetype = 2,se = FALSE, alpha = 0.4)

```

*********************
Second Part

In this part we will upload a CSV file. 
In your workfolder you will find the file bakeoff.csv, this is the file we will work with. 

1) use the function read_csv() to load bakeoff into the object bakeoff.

```{r}
bakeoff <- read_csv("bakeoff.csv")

```

2) as this file has some empty cells, use the filter() command to see which cells of the column showstopper are empty, or "NA" 

```{r}
bakeoff %>% filter(showstopper != "" && showstopper != "NA")
```

unfortunatily we could not find any results that were usefull.

The read_csv() function also has an na argument, which allows you to specify value(s) that represent missing values in your data. The default values for the na argument are c("", "NA"), so both are recoded as missing (NA) in R. When you read in data, you can add additional values like the string "UNKNOWN" to a vector of missing values using the c() function to combine multiple values into a single vector.

3) under the column showstopper there are some empty cells. These empty fields are not a problem, though we have to fill them correctly with an na. To the previous chunk add the command na = c("", "NA", "UNKNOWN")) after the declaration of the file you want to upload. 

```{r}
bakeoff <- read_csv("bakeoff.csv", na = c("", "NA", "UNKNOWN"))
```


The is.na() function is also helpful for identifying rows with missing values for a variable.


4) use the is.na() function within the filter() command to find the empty fields in the showstopper column

```{r}
bakeoff %>% filter(showstopper != is.na(c("", "NA")))

```

This gives us the result of all items without the showstopper. 

*************

Let's work with the gapminder dataset:

1) In this scenario we want to have the following subset:
Only observations in 2002.
the life expectancy in months (12 * lifeExp)
the list descending on life expectancy:

```{r}
gapminder
gapminder %>% filter(year == 2002) %>% mutate(lifeExp = 12 * lifeExp) %>% arrange(lifeExp)

```


2) Make a scatter plot, comparing gdpPercap and lifeExp. Add color representing continent and size representing population. Make it be faceted by year. 

```{r}

MijnDataset <- gapminder %>%
  select(year, continent, lifeExp, gdpPercap) %>%
  group_by(year)
MijnDataset
ggplot(MijnDataset, aes(x=lifeExp, y=gdpPercap, color = continent,size)) + geom_point() + facet_wrap(facets = vars(year))

```

***********

 End of Mock Exam 

Make sure each chunk runs properly, without errors. 
to complete your submission you can use the knit to html function. this is either under the "knit" or the "preview" drop down field. 
In your submission file you can upload your html file, the notebook you worked in, and the .csv files. 


************

 
 Mock v1.0
