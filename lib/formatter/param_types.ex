defmodule Formatter.ParamTypes do
  @type use_canonical :: :use_canonical | {:use_canonical, boolean()}
  @type include_related :: :include_related | {:include_related, boolean()}
  @type include_tags :: :include_tags | {:include_tags, boolean()}

  @type limit :: {:limit, integer}
  @type skip :: {:skip, integer}
end
