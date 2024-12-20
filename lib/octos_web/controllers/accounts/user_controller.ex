defmodule OctosWeb.Accounts.UserController do
  use OctosWeb, :controller

  alias Octos.Accounts.Models.User
  alias Octos.Accounts.Repositories.User, as: UserRepository

  action_fallback OctosWeb.FallbackController

  def index(conn, _params) do
    users = UserRepository.list_all()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => params}) do
    with {:ok, %User{} = user} <- UserRepository.create(params),
         {:ok, token, _full_claims} <- Guardian.encode_and_sign(user, %{}) do
      conn
      |> put_status(:created)
      |> put_view(OctosWeb.Accounts.UserView)
      |> render("user_token.json", %{user: user, token: token})
    end
  end

  def show(conn, %{"id" => id}) do
    user = UserRepository.get!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = UserRepository.get!(id)

    with {:ok, %User{} = user} <- UserRepository.update(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = UserRepository.get!(id)

    with {:ok, %User{}} <- UserRepository.delete(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
