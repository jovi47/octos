defmodule Octos.Accounts.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type document_types :: :cpf | :cnpj | :rg | :passport
  @type t :: %__MODULE__{
          id: Ecto.UUID.t() | nil,
          full_name: String.t() | nil,
          email: String.t() | nil,
          document: String.t() | nil,
          document_type: document_types() | nil,
          is_active: boolean() | nil,
          hash_password: String.t() | nil,
          inserted_at: NaiveDateTime.t() | nil,
          updated_at: NaiveDateTime.t() | nil
        }

  @castable_fields ~w(full_name email document document_type hash_password)a

  @required_fields ~w(full_name email document document_type hash_password)a

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "users" do
    field :full_name, :string
    field :email, :string
    field :document, :string
    field :document_type, Ecto.Enum, values: [:cpf, :cnpj, :rg, :passport]
    field :hash_password, :string
    field :is_active, :boolean, default: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @castable_fields)
    |> validate_required(@required_fields)
    |> validate_length(:hash_password, min: 8, max: 24)
    |> unique_constraint(:email)
    |> unique_constraint([:document, :document_type])
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset
       ) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end

  defp put_password_hash(changeset), do: changeset
end
