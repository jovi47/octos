defmodule Octos.Accounts.ModelsTest do
  use Octos.DataCase

  alias Octos.Accounts.Models

  describe "users" do
    alias Octos.Accounts.Models.User

    import Octos.Accounts.ModelsFixtures

    @invalid_attrs %{hash_password: nil, full_name: nil, email: nil, document: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Models.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Models.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{hash_password: "some hash_password", full_name: "some full_name", email: "some email", document: "some document"}

      assert {:ok, %User{} = user} = Models.create_user(valid_attrs)
      assert user.hash_password == "some hash_password"
      assert user.full_name == "some full_name"
      assert user.email == "some email"
      assert user.document == "some document"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{hash_password: "some updated hash_password", full_name: "some updated full_name", email: "some updated email", document: "some updated document"}

      assert {:ok, %User{} = user} = Models.update_user(user, update_attrs)
      assert user.hash_password == "some updated hash_password"
      assert user.full_name == "some updated full_name"
      assert user.email == "some updated email"
      assert user.document == "some updated document"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_user(user, @invalid_attrs)
      assert user == Models.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Models.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Models.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Models.change_user(user)
    end
  end
end
