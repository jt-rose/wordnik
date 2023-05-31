defmodule Wordnik.Helpers do
  @moduledoc """
  helper functions to provide enum-like list of valid strings
  used in parameters of different queries
  """
  def get_dictionaries do
    [
      "ahd-5",
      "century",
      "wiktionary",
      "webster",
      "wordnet"
    ]
  end

  def get_relationship_types do
    [
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
    ]
  end

  def get_type_formats do
    [
      "ahd-5",
      "arpabet",
      "gcide-diacritical",
      "IPA"
    ]
  end

  def get_parts_of_speech do
    [
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
    ]
  end

  def get_sort_by_options do
    [
      "alpha",
      "count"
    ]
  end

  def get_sort_order_options do
    [
      "asc",
      "desc"
    ]
  end
end
