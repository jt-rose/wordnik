defmodule Wordnik do
  def get_audio(word, api_key, params \\ []), do: Word.Audio.get_audio(word, api_key, params)

  def get_definitions(word, api_key, params \\ []),
    do: Word.Definitions.get_definitions(word, api_key, params)

  def get_etymologies(word, api_key, params \\ []),
    do: Word.Etymologies.get_etymologies(word, api_key, params)

  def get_examples(word, api_key, params \\ []),
    do: Word.Examples.get_examples(word, api_key, params)

  def get_frequency(word, api_key, params \\ []),
    do: Word.Frequency.get_frequency(word, api_key, params)

  def get_hyphenation(word, api_key, params \\ []),
    do: Word.Hyphenation.get_hyphenation(word, api_key, params)

  def get_phrases(word, api_key, params \\ []),
    do: Word.Phrases.get_phrases(word, api_key, params)

  def get_pronunciations(word, api_key, params \\ []),
    do: Word.Pronunciations.get_pronunciations(word, api_key, params)

  def get_related_words(word, api_key, params \\ []),
    do: Word.RelatedWords.get_related_words(word, api_key, params)

  def get_scrabble_score(word, api_key),
    do: Word.ScrabbleScore.get_scrabble_score(word, api_key)

  def get_top_example(word, api_key, params \\ []),
    do: Word.TopExample.get_top_example(word, api_key, params)

  def get_random_word(api_key, params \\ []),
    do: Words.RandomWord.get_random_word(api_key, params)

  def get_random_words(api_key, params \\ []),
    do: Words.RandomWords.get_random_words(api_key, params)

  def get_word_of_the_day(api_key, params),
    do: Words.WordOfTheDay.get_word_of_the_day(api_key, params)
end
