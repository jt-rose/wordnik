defmodule Formatter.Enums do
  @moduledoc """
  custom string types with documentation on accepted values
  """

  @typedoc """
  part of speech

  allowable values are:
      "noun",
      "adjective",
      "verb",
      "adverb",
      "interjection",
      "pronoun",
      "preposition",
      "abbreviation",
      "affix",
      "article",
      "auxiliary-verb",
      "conjunction",
      "definite-article",
      "family-name",
      "given-name",
      "idiom",
      "imperative",
      "noun-plural",
      "noun-posessive",
      "past-participle",
      "phrasal-prefix",
      "proper-noun",
      "proper-noun-plural",
      "proper-noun-posessive",
      "suffix",
      "verb-intransitive",
      "verb-transitive"
  """
  @type part_of_speech :: String.t()

  @typedoc """
  Source dictionary to return definitions from.

  allowed values are:
      "ahd-5",
      "century",
      "wiktionary",
      "webster",
      "wordnet"
  """
  @type source_dict :: String.t()

  @typedoc """
  Source dictionary to return definitions from. If 'all' is received,
  results are returned from all sources. If multiple values are received
  (e.g. 'century,wiktionary'), results are returned
  from the first specified dictionary that has definitions.
  If left blank, results are returned from the first dictionary
  that has definitions. By default, dictionaries are searched in
  this order: ahd-5, wiktionary, webster, century, wordnet

  allowed values are:
      "all",
      "ahd-5",
      "century",
      "wiktionary",
      "webster",
      "wordnet"
  """
  @type source_dictionaries :: String.t()

  @typedoc """
  type format values

  allowable values are:
      "ahd-5",
      "arpabet",
      "gcide-diacritical",
      "IPA"
  """
  @type type_format :: String.t()

  @typedoc """
  relationship type values

  allowable values are:
      "synonym",
      "antonym",
      "variant",
      "equivalent",
      "cross-reference",
      "related-word",
      "rhyme",
      "form",
      "etymologically-related-term",
      "hypernym",
      "hyponym",
      "inflected-form",
      "primary",
      "same-context",
      "verb-form",
      "verb-stem",
      "has-topic"
  """
  @type relationship_types :: String.t()

  @typedoc """
  CSV part-of-speech values to include

  allowable values are:
      "noun",
      "adjective",
      "verb",
      "adverb",
      "interjection",
      "pronoun",
      "preposition",
      "abbreviation",
      "affix",
      "article",
      "auxiliary-verb",
      "conjunction",
      "definite-article",
      "family-name",
      "given-name",
      "idiom",
      "imperative",
      "noun-plural",
      "noun-posessive",
      "past-participle",
      "phrasal-prefix",
      "proper-noun",
      "proper-noun-plural",
      "proper-noun-posessive",
      "suffix",
      "verb-intransitive",
      "verb-transitive"
  """
  @type include_part_of_speech :: String.t()

  @typedoc """
  CSV part-of-speech values to exclude

  allowable values are:
      "noun",
      "adjective",
      "verb",
      "adverb",
      "interjection",
      "pronoun",
      "preposition",
      "abbreviation",
      "affix",
      "article",
      "auxiliary-verb",
      "conjunction",
      "definite-article",
      "family-name",
      "given-name",
      "idiom",
      "imperative",
      "noun-plural",
      "noun-posessive",
      "past-participle",
      "phrasal-prefix",
      "proper-noun",
      "proper-noun-plural",
      "proper-noun-posessive",
      "suffix",
      "verb-intransitive",
      "verb-transitive"
  """
  @type exclude_part_of_speech :: String.t()

  @typedoc """
  Date format in yyyy-MM-dd format, ex: 2023-12-31
  """
  @type date :: String.t()

  @typedoc """
  setting to sort by alphabetical or total count

  allowable values:
      "alpha",
      "count"
  """
  @type sort_by :: String.t()

  @typedoc """
  setting to order by ascending or descending

  allowable values:
      "asc",
      "desc"
  """
  @type sort_order :: String.t()
end
