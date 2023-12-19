### Text Mining in R

## Load Libraries

library(tm)
library(wordcloud)


## Load Data

demo_text = read.csv("demo.csv")

demo_corpus = Corpus(VectorSource(demo_text$text))

# Access the First Document in the Corpus
demo_corpus[[1]]$content


## Textual Data Pre-Processing

# Remove Punctuations
demo_corpus = tm_map(demo_corpus, removePunctuation)

demo_corpus[[1]]$content


# Remove Lower-Cases
demo_corpus = tm_map(demo_corpus, tolower)

demo_corpus[[1]]$content


# Remove Stop Words
demo_corpus = tm_map(demo_corpus, removeWords,
                     stopwords('english'))

demo_corpus[[1]]$content


# Remove Specific Words Like "welcome"
# t = tm_map(demo_corpus, removeWords, "welcome")


# Remove Excessive White Spaces
demo_corpus = tm_map(demo_corpus, stripWhitespace)

demo_corpus[[1]]$content


# Word Stemming
demo_corpus = tm_map(demo_corpus, stemDocument)

demo_corpus[[1]]$content


## Term-Document Matrix (Frequency Matrix)

dtm = DocumentTermMatrix(demo_corpus)

dtm_matrix = as.matrix(dtm)


## Binary Matrix

dtm_bin = weightBin(dtm)

dtmb_matrix = as.matrix(dtm_bin)


## TF-IDF Matrix

dtm_tfidf = weightTfIdf(dtm)

dtmtfidf_matrix = as.matrix(dtm_tfidf)


## Text Descriptives

# Get the Top 3 Most Frequent Word
word_freq = colSums(as.matrix(dtm))

word_freq_sorted = sort(word_freq, decreasing = TRUE)

word_freq_sorted[1:3]


## Plot WordCloud

wordcloud(words = names(word_freq_sorted),
          freq = word_freq_sorted, min.freq = 0)

wordcloud(words = names(word_freq_sorted),
          freq = word_freq_sorted,
          min.freq = 0,
          # The size of the Words to Display
          scale = c(2, 0.25),
          # How Many Words to Display
          max.words = 5)