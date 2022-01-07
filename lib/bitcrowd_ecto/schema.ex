# SPDX-License-Identifier: Apache-2.0

defmodule BitcrowdEcto.Schema do
  @moduledoc """
  An opinionated set of defaults for Ecto schemas.

  * Uses `Ecto.Schema` and imports `Ecto.Changeset` and `BitcrowdEcto.Changeset`
  * Configures an autogenerated PK of type `binary_id`
  * Configures FKs to be of type `binary_id`
  * Sets timestamp type to `utc_datetime_usec`
  * Defines a type `t` as a struct of the schema module.
  * Defines an `id` type

  ## Usage

      defmodule MyApp.MySchema do
        use BitcrowdEcto.Schema
      end

  Or if you table lives in a different Postgres schema:

      defmodule MyApp.MySchema do
        use BitcrowdEcto.Schema, prefix: "foo"
      end
  """

  @moduledoc since: "0.1.0"

  defmacro __using__(opts) do
    schema_prefix =
      if prefix = Keyword.get(opts, :prefix) do
        quote do
          @schema_prefix unquote(prefix)
        end
      end

    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import BitcrowdEcto.Changeset

      unquote(schema_prefix)

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [type: :utc_datetime_usec]

      @type t :: %__MODULE__{}
      @type id :: binary()
    end
  end
end
