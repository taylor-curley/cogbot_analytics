library(wordcloud) ; library(RColorBrewer) ; library(tm) ; library(stringr)
library(twitteR) ; library(httr) ; library(devtools) ; library(base64enc)

today <- Sys.Date()
today <- format(today, format="%m%d%y")

removeList = c("Acta Psychologica",
             "Cognitive Psychology", 
             "Acta Psychologica",
             "Brain and Cognition", 
             "Cognition", 
             "Consciousness and Cognition",
             "Journal of Memory and Language", 
             "Neuropsychologica", 
             "Trends in Cognitive Sciences",                
             "Applied Research in Memory & Cognition",
             "Bulletin of the Psychonomic Society", 
             "Memory & Cognition", 
             "Learning & Behavior", 
             "Visual Cognition", 
             "Cognitive Neuropsychology", 
             "Memory", 
             "Cognitive Neuroscience", 
             "Language, Cognition and Neuroscience", 
             "Journal of Cognitive Psychology", 
             "JEP: Learning, Memory, and Cognition", 
             "Neuropsychology", 
             "Trends in Cognitive Sciences", 
             "Trends in Cognitive Sciences", 
             "Topics in Cognitive Science", 
             "Quarterly Journal of Exp. Psychology",
             "cogpsybot: From ",
             "(f|ht)tp(s?)://(.*)[.][a-z]+",
             "(f|ht)tps(s?)://(.*)[.][a-z]+",
             "https",
             "amp",
             "JEP"
             )

options(httr_oauth_cache=F)

source("C://Users/Taylor/OneDrive/bot_analytics/secret_cpb.R")
setup_twitter_oauth(consumer_key = consumer_key,
                    consumer_secret = consumer_secret,
                    access_token = access_token,
                    access_secret = access_secret)

# Retrieve 
dtsc <- userTimeline("CogPsyBot",n = 200)
dtsc_text <- sapply(dtsc, function(x) x$getText())
for (i in removeList){
  dtsc_text <- gsub(i, "", dtsc_text)
}
dtsc_text <- str_replace_all(dtsc_text,"[^a-zA-Z\\s]", " ")

dtsc_corpus <- Corpus(VectorSource(dtsc_text))
tdm = TermDocumentMatrix(dtsc_corpus,
                         control = list(removePunctuation = TRUE,
                                        stopwords = c("cognitive", stopwords("english")),
                                        removeNumbers = TRUE, tolower = TRUE))

m<-as.matrix(tdm)
word_freqs <- sort(rowSums(m), decreasing = TRUE)
word_freqs<-word_freqs
dm <- data.frame(word = names(word_freqs), freq = word_freqs)

wordcloud(dm$word, dm$freq, random.order = FALSE,scale=c(4,.5), 
          colors = brewer.pal(5, "Dark2"))
dev.copy(png, paste0("C://Users/tcurley6/OneDrive/bot_analytics/images/qbp_cloud_",today,".png"))
dev.off