.rs.restartR()

library(twitteR) 

# API keys for Twitter
source("C://Users/Taylor/OneDrive/bot_analytics/secret_cpb.R")

options(httr_oauth_cache=F)

setup_twitter_oauth(consumer_key = consumer_key,
                    consumer_secret = consumer_secret,
                    access_token = access_token,
                    access_secret = access_secret)

today <- Sys.Date()
today <- format(today, format="%m%d%y")

tweet("Check out the most frequently-used terms in this week's tweeted articles #R #RStudio", 
      mediaPath = paste0("C://Users/tcurley6/OneDrive/bots/qbp_cloud_" ,today, ".png"))