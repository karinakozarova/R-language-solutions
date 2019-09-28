# Load readr
library(readr)

# Load dplyr
library(dplyr)

# Load skimr
library(skimr)

# View distinct results
bakeoff %>%
  distinct(result)

# Count the number of rows by series and episode
bakeoff %>%
  count(series, episode)

# Count the number of rows by series and baker
bakers_by_series <- bakeoff %>%
  count(series, baker)
  
ggplot(bakeoff, aes(episode)) + 
    geom_bar() + 
    facet_wrap(~series)

# Find format to parse "17 August 2010" 
parse_date("17 August 2010", format = "%d %B %Y")

# Edit code to fix the parsing error 
desserts <- read_csv("desserts.csv",
                      col_types = cols(
                        uk_airdate = col_date(format = "%d %B %Y"),
                        technical = col_number()
                      ),
                        na = c("", "NA", "N/A") 
                     )

# View parsing problems
problems(desserts)

# Cast result a factor
desserts <- read_csv("desserts.csv", 
                     na = c("", "NA", "N/A"),
                     col_types = cols(
                       uk_airdate = col_date(format = "%d %B %Y"),
                       technical = col_number(),                       
                       result = col_factor(levels = NULL)),
                     )

# Glimpse to view
glimpse(desserts)

# Count rows grouping by nut variable
desserts %>%
	count(nut, sort=TRUE) 

# Create dummy variable: 1 if won, 0 if not
desserts <- desserts %>%
	 mutate(tech_win = recode(technical, `1` = 1, 
                             .default = 0))
         
# Recode channel as factor: "Channel 4" (0) or not (1)
ratings <- ratings %>% 
  mutate(bbc = recode_factor(channel, 
                 `Channel 4` = 0, 
                  .default = 1))

# Move channel to first column
ratings %>% 
  select(channel, everything())

# Glimpse to see variable names
glimpse(messy_ratings)

# Load janitor
library(janitor)

# Select 7-day viewer data by series
viewers_7day <- ratings %>%
	select(series, ends_with("7day"))
	

# Glimpse
glimpse(viewers_7day)

# Adapt code to drop 28-day columns; keep 7-day in front
viewers_7day <- ratings %>% 
    select(viewers_7day_ = ends_with("7day"), 
           everything(), 
           -ends_with("28day"))

# Plot of episode 1 viewers by series
ggplot(ratings, aes(x=series, y=e1)) +      geom_col()

tidy_ratings <- ratings %>%
    # Gather and convert episode to factor
	gather(key = "episode", value = "viewers_7day", -series, 
           factor_key = TRUE, na.rm = TRUE)
           
# Select 7-day viewer ratings
week_ratings <- select(ratings2, series, ends_with("7day"))

week_ratings <- ratings2 %>% 
    select(series, ends_with("7day")) %>% 
    gather(episode, viewers_7day, ends_with("7day"), 
           na.rm = TRUE) %>% 
	# Edit to separate key column and drop extra
    separate(episode, into = "episode", extra = "drop") 

# Print to view
week_ratings

ratings3 <- ratings2 %>% 
	# Unite viewers in millions and decimals together    
	unite(viewers_7day, viewers_millions, viewers_decimal)

# Print to view
ratings3

# Create tidy data with 7- and 28-day viewers
tidy_ratings_all <- ratings2 %>%
	gather(key = episode, value = viewers, ends_with("day"), na.rm = TRUE) %>% 
    separate(episode, into = c("episode", "days")) %>%  
    mutate(episode = parse_number(episode),
           days = parse_number(days))

# Gather viewer columns and remove NA rows
tidy_ratings <- ratings %>%
	gather(key = episode, value = viewers, -series, na.rm = T )

# Spread into three columns
bump_by_series <- first_last %>% 
    spread(episode, viewers)

# Create skills variable with 3 levels
bakers_skill <- bakers %>% 
  mutate(skill = case_when(
    star_baker > technical_winner ~ "super_star",
    star_baker < technical_winner ~ "high_tech",
    TRUE ~ "well_rounded"
  ))

# Edit skill variable to have 4 levels
bakers_skill <- bakers %>% 
  mutate(skill = case_when(
    star_baker == 0 & technical_winner == 0 ~ NA_character_,
    star_baker > technical_winner ~ "super_star",
    star_baker < technical_winner ~ "high_tech",
    TRUE ~ "well_rounded"
  ))

# Cast skill as a factor
bakers <- bakers %>%
  mutate(skill = as.factor(skill))

# Plot counts of bakers by skill, fill by winner
ggplot(bakers, aes(x = skill, fill = series_winner) ) +  geom_bar() 

# Cast last_date_appeared_us as a date
baker_dates_cast <- baker_dates %>% 
  mutate(last_date_appeared_us = dmy(last_date_appeared_us))

# Create interval between first and last UK dates
baker_time <- baker_time %>% 
  mutate(time_on_air = interval(first_date_appeared_uk, last_date_appeared_uk))

# Convert to upper case
bakers <- bakers %>% 
  mutate(position_reached = str_to_upper(position_reached))

# Convert to lower case
bakers <- bakers %>%
  mutate(occupation = str_to_lower(occupation))

