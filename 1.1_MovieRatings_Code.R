getwd()
setwd("/Users/jonny_sandler/Documents/data/interim")


movies <- read.csv("Movie-Ratings (2).csv")
movies
tail(movies)
summary(movies)

colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "Budget", "Year")

head(movies)
str(movies)
summary(movies)

factor(movies$Year)

movies$Year <- factor(movies$Year)

summary(movies)
str(movies)


#----------- ** Aesthetics - how your data maps to what oyu want to see **

library(ggplot2)

ggplot(data = movies, aes(x= CriticRating, y = AudienceRating))

# Above creates the plot, below we are going to add the Geometry to the sitaution by adding a + sign to the whole thing
# add a line so it is an easier way to not run everything at once
#^ more convenient to add a new line to run line by line
ggplot(data = movies, aes(x= CriticRating, y = AudienceRating)) + 
  geom_point()

#add more aestehtetics to this- add color!

ggplot(data = movies, aes(x= CriticRating, y = AudienceRating, color = Genre)) + 
  geom_point()

# add size- what is a better way to represent size? Budget? 

ggplot(data = movies, aes(x= CriticRating, y = AudienceRating, color = Genre, size = Budget)) + 
  geom_point()

# -- plotting with layers
# assign the whole line to a letter and create a new object


p <- ggplot(data = movies, aes(x= CriticRating, y = AudienceRating, color = Genre, size = Budget))

# add points to this object which contains everything
p + geom_point()

# do lines instead

p + geom_line()

# multiple layers - add points to lines

p + geom_point() + geom_line()

#changing the order will change how it looks?

p + geom_line() + geom_point() 

# Overriding Aesthetics

q <- ggplot(data = movies, aes(x= CriticRating, y = AudienceRating,
                  
#example 1                                             color = genre, size = Budget)
q + geom_point(aes (size= CriticRating))

#example 2 

q + geom_point(aes (color = BudgetMillions))
q + geom_point()   

# you can override the x and y axes as well-
#Even though they are aesthetics just like color or size

#Example 1 of overriding aesthetics
q + geom_point(aes (size = CriticRating))

#Example 2 - override color

q + geom_point(aes ( color = BudgetMillions))

# what else can we override?

q + geom_point(aes (x=BudgetMillions, y = CriticRating)) +
  xlab("Budget in Millions")

#cool

q + geom_line() + geom_point() 

#Reduce line size

q + geom_line(size = .5) + geom_point() 


# MAPPING V SETTING

r <- ggplot(data=movies, aes(x=CriticRating, y= AudienceRating))

r + geom_point()

#add color
#1. Mapping (what weve done so far)

r + geom_point(aes (color = Genre))

#2 setting

r + geom_point(color = "DarkGreen")

#error:

#r+ geom_point(aes(color= "DarkGreen"))

# if you want to set a color DONT use AES
#BUT if you want to map a color to a variable- USE AES

#color is an aesthetic on your chart

#mapping is harder aka using aes

#1 Mapping

r + geom_point(aes (size= Budget))

#2 Setting

r + geom_point(size= 10)

#error
r+ geom_point(aes(size=10))

#--------HISTOGRAMS + DENSITY CHARTS

s <- ggplot(data = movies, aes (Budget))

s + geom_histogram(binwidth = 10)

#Add Color

s + geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border

s + geom_histogram(binwidth = 10, aes(fill=Genre), color= "Black")

#>>>>>>>>> Chart 3

# density charts
#Illustrate probability density function

s+ geom_density(aes (fill = Genre), position = "stack")


# LAYERING TIPPPPSSS

t <- ggplot (data = movies, aes (x = AudienceRating))

t+ geom_histogram(binwidth = 10,
                  fill= "White", color= "Blue")

#another way to achieve same thing

t<- ggplot(data = movies)

t + geom_histogram(binwidth = 10,aes(x=AudienceRating),
                   fill= "White",
                  color= "Blue")
# 4th chart in presentation 

t + geom_histogram(binwidth = 10, 
                   aes(x= CriticRating),
                   fill= "White",
                   color= "Blue")
# everything that has to do with humnan behavior is ultimately extremely intersteing 

#statistical transformations
#?geom_smooth
#?lm

u <- ggplot (data=movies, aes(x=CriticRating, y = AudienceRating,
                              color= Genre))
u + geom_point() + geom_smooth(fill = NA)

#BOXPLOTS

u <-ggplot (data = movies, aes(x = Genre, y = AudienceRating,
                               color= Genre)) 
u + geom_boxplot()
u + geom_boxplot(size = 1.2) + geom_point()

#lifehack

u + geom_boxplot(size = 1.2) + geom_jitter()

# another way

u + geom_jitter()+ geom_boxplot(size= 1.2, alpha= .5)

#critic Rating

v <-ggplot (data = movies, aes(x = Genre, y = CriticRating,
                               color= Genre)) 
v + geom_boxplot()
v + geom_boxplot(size = 1.2) + geom_point()

#lifehack

v + geom_boxplot(size = 1.2) + geom_jitter()


v + geom_jitter()+ geom_boxplot(size= 1.2, alpha= .5)


#^^^ chart 6

#FACETS 

w <- ggplot (data = movies, aes( x= Budget))

w + geom_histogram(binwidth = 10 , aes (fill= Genre),
                   color= "Black") + 
  facet_grid(Genre~., scales = "free" )

# Facets with scatterplots

xx <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating,
                                color= Genre))
xx + geom_point(size = 3) + 
  facet_grid(Genre~. )

xx + geom_point(size = 3) + 
  facet_grid(.~Year )

xx + geom_point(aes(size=Budget)) +
  geom_smooth() +
  facet_grid(Genre~Year ) 

a <- ggplot(data= movies, aes(x=CriticRating, y = AudienceRating,
                              size = Budget,
                              color = Genre))
a + geom_point() 

a + geom_point()+ 
  xlim(50,100) + 
  ylim(50,100)

#wont work well always

b <- ggplot(data= movies, aes(x=Budget))

b + geom_histogram(binwidth = 10, aes(fill=Genre), 
                   colour = "Black") +
  ylim (0,50)

#instead we should zoom in on this

b + geom_histogram(binwidth = 10, aes(fill=Genre), 
                   colour = "Black") +
  coord_cartesian(ylim= c(0,50))

# IMPROVE #1

xx + geom_point(aes(size=Budget)) +
  geom_smooth() +
  facet_grid(Genre~Year ) +
  coord_cartesian(ylim = c(0,100))

#1 >>>>> still will be improved

ww <- ggplot(data= movies, aes(x = Budget))

www <- ww + geom_histogram(binwidth = 10, aes(fill= Genre), color = "black")


# add axes labels
www + ylab("Number of Movies") + xlab("Money")

# LABEL formatting

www + 
  ylab("Number of Movies") + 
  xlab("Money") + 
  theme (axis.title.x = element_text(color = "Dark Green", size = 30),
         axis.title.y = element_text(color= "Red", size = 30))

#tick mark formatting

www + 
  ylab("Number of Movies") + 
  xlab("Money") + 
  theme (axis.title.x = element_text(color = "Dark Green", size = 30),
         axis.title.y = element_text(color= "Red", size = 30),
         axis.text.x = element_text(size = 20),
         axis.text.y = element_text(size = 20))


?theme

#Legendformatting -- adding titles, change font, size, etc. 

www + 
  ylab("Number of Movies") + 
  xlab("Money") + 
  ggtitle("Movie Budget Distribution")+
  theme (axis.title.x = element_text(color = "Dark Green", size = 30),
         axis.title.y = element_text(color= "Red", size = 30),
         axis.text.x = element_text(size = 20),
         axis.text.y = element_text(size = 20),

         legend.title = element_text(size = 30),
         legend.text = element_text(size = 20),
         legend.position = c(1,1),
         legend.justification = c(1,1),
  
         plot.title = element_text(color = "DarkBlue", 
                                   size = 10,
         
                                   
                                                      family = "Courier") )

