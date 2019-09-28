# Load the gapminder package
library(gapminder)

# Load the dplyr package
library(dplyr)

# Look at the gapminder dataset
gapminder

# Filter the gapminder dataset for the year 1957
gapminder %>%
  filter(year==1957)
  
# Filter for China in 2002
gapminder %>%
  filter(year==2002, country=="China")
  
# Sort in descending order of lifeExp
gapminder %>%
  arrange(lifeExp)

# Filter for the year 1957, then arrange in descending order of population
gapminder %>%
  filter(year==1957) %>%
  arrange(desc(pop))

# Use mutate to change lifeExp to be in months
mutate(gapminder,lifeExp = lifeExp*12)

# Use mutate to create a new column called lifeExpMonths
mutate(gapminder,lifeExpMonths=12*lifeExp)

# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
  filter(year==2007) %>%
  mutate(lifeExpMonths=12 * lifeExp) %>%
  arrange(desc(lifeExpMonths))

# Create gapminder_1952
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()

# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point()

# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + scale_x_log10() +
  geom_point()

# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) + scale_x_log10() + scale_y_log10() +
  geom_point()

# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + scale_x_log10() +
  geom_point()

# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()

# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) + facet_wrap(~ continent) +
  geom_point() + scale_x_log10() 

# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = gdpPercap)) + facet_wrap(~ year) +
  geom_point() + scale_x_log10() 

# Summarize to find the median life expectancy
medianLifeExp <- gapminder %>%
  summarize(median(lifeExp))

# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita in each year
gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder %>%
  filter(year==1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))

# Find median life expectancy and maximum GDP per capita in each continent/year combination
gapminder %>%
  group_by(continent,year) %>%
  summarize(medianLifeExp = median(lifeExp), maxGdpPercap = max(gdpPercap))

by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, aes(x=year,
 y=medianLifeExp)) + expand_limits(y = 0) + geom_point()

# Summarize medianGdpPercap within each continent within each year: by_year_continent

by_year_continent <- gapminder %>%
group_by(continent, year)%>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year_continent, aes(x=year,
 y=medianGdpPercap, color = continent)) + expand_limits(y = 0) + geom_point()

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year==2007) %>%
  group_by(continent)%>%
  summarize(medianGdpPercap = median(gdpPercap), medianLifeExp = median(lifeExp))


# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_continent_2007, aes(x=medianGdpPercap,
 y=medianLifeExp, color = continent))  + geom_point()

# Create a line plot showing the change in medianGdpPercap by continent over time
by_year_continent <- gapminder %>%
  group_by(year, continent)%>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
by_continent <- gapminder %>%
  filter(year==1952)%>%
  group_by(continent)%>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot of gdpPercap by country
oceania_1952 <- gapminder %>%
  filter(year==1952, continent == "Oceania")

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(oceania_1952, aes(x=country ,
 y=gdpPercap, color=gdpPercap))  + geom_col() + expand_limits(y = 0)

# Create a histogram of population (pop)
ggplot(gapminder_1952, aes(x=pop))  + geom_histogram()

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x=pop))  + geom_histogram() + scale_x_log10()

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x=continent, y = gdpPercap))  + geom_boxplot() + scale_y_log10()

# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) + ggtitle("Comparing GDP per capita across continents") +
  geom_boxplot() +
  scale_y_log10()

