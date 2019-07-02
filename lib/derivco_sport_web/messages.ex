defmodule DerivcoSportWeb.Messages do
  use Protobuf, """
    message Msg {
      message SubMsg {
        required uint32 value = 1;
      }

      enum Version {
        V1 = 1;
        V2 = 2;
      }

      required Version version = 2;
      optional SubMsg sub = 1;
    }
  """
end
