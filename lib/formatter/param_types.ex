defmodule Formatter.ParamTypes do
  @type use_canonical :: :use_canonical | {:use_canonical, boolean()}
  @type include_related :: :include_related | {:include_related, boolean()}
  @type include_tags :: :include_tags | {:include_tags, boolean()}
  @type include_duplicates :: :include_duplicates | {:include_duplicates, boolean()}

  @type limit :: {:limit, integer}
  @type skip :: {:skip, integer}

  @type start_year :: {:start_year, integer}
  @type end_year :: {:end_year, integer}

  @type wlmi :: {:wlmi, integer}

  @type part_of_speech :: {:part_of_speech, String.t()}
  @type source_dict :: {:source_dict, String.t()}
  @type source_dictionaries :: {:source_dictionaries, String.t()}
  @type type_format :: {:type_format, String.t()}
  @type relationship_types :: {:relationship_types, String.t()}
end
