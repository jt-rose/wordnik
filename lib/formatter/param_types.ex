defmodule Formatter.ParamTypes do
  alias Formatter.Enums

  @type use_canonical :: :use_canonical | {:use_canonical, boolean()}
  @type include_related :: :include_related | {:include_related, boolean()}
  @type include_tags :: :include_tags | {:include_tags, boolean()}
  @type include_duplicates :: :include_duplicates | {:include_duplicates, boolean()}
  @type has_dictionary_def :: :has_dictionary_def | {:has_dictionary_def, boolean()}

  @type limit :: {:limit, integer}
  @type skip :: {:skip, integer}
  @type min_corpus_count :: {:min_corpus_count, integer}
  @type max_corpus_count :: {:max_corpus_count, integer}
  @type min_dictionary_count :: {:min_dictionary_count, integer}
  @type max_dictionary_count :: {:max_dictionary_count, integer}
  @type min_length :: {:min_length, integer}
  @type max_length :: {:max_length, integer}

  @type start_year :: {:start_year, integer}
  @type end_year :: {:end_year, integer}

  @type wlmi :: {:wlmi, integer}

  @type part_of_speech :: {:part_of_speech, Enums.part_of_speech()}
  @type source_dict :: {:source_dict, Enums.source_dict()}
  @type source_dictionaries :: {:source_dictionaries, Enums.source_dictionaries()}
  @type type_format :: {:type_format, Enums.type_format()}
  @type relationship_types :: {:relationship_types, Enums.relationship_types()}
  @type include_part_of_speech :: {:include_part_of_speech, Enums.include_part_of_speech()}
  @type exclude_part_of_speech :: {:exclude_part_of_speech, Enums.exclude_part_of_speech()}

  @type date :: {:date, Enums.date()}
  @type sort_by :: {:sort_by, Enums.sort_by()}
  @type sort_order :: {:sort_order, Enums.sort_order()}
end
