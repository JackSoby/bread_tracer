defmodule BreadTracer.MoneyManagementTest do
  use BreadTracer.DataCase

  alias BreadTracer.MoneyManagement

  describe "years" do
    alias BreadTracer.MoneyManagement.Schema.Year

    @valid_attrs %{active: true, goal: 42, name: "some name"}
    @update_attrs %{active: false, goal: 43, name: "some updated name"}
    @invalid_attrs %{active: nil, goal: nil, name: nil}

    def year_fixture(attrs \\ %{}) do
      {:ok, year} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MoneyManagement.create_year()

      year
    end

    test "list_years/0 returns all years" do
      year = year_fixture()
      assert MoneyManagement.list_years() == [year]
    end

    test "get_year!/1 returns the year with given id" do
      year = year_fixture()
      assert MoneyManagement.get_year!(year.id) == year
    end

    test "create_year/1 with valid data creates a year" do
      assert {:ok, %Year{} = year} = MoneyManagement.create_year(@valid_attrs)
      assert year.active == true
      assert year.goal == 42
      assert year.name == "some name"
    end

    test "create_year/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MoneyManagement.create_year(@invalid_attrs)
    end

    test "update_year/2 with valid data updates the year" do
      year = year_fixture()
      assert {:ok, %Year{} = year} = MoneyManagement.update_year(year, @update_attrs)
      assert year.active == false
      assert year.goal == 43
      assert year.name == "some updated name"
    end

    test "update_year/2 with invalid data returns error changeset" do
      year = year_fixture()
      assert {:error, %Ecto.Changeset{}} = MoneyManagement.update_year(year, @invalid_attrs)
      assert year == MoneyManagement.get_year!(year.id)
    end

    test "delete_year/1 deletes the year" do
      year = year_fixture()
      assert {:ok, %Year{}} = MoneyManagement.delete_year(year)
      assert_raise Ecto.NoResultsError, fn -> MoneyManagement.get_year!(year.id) end
    end

    test "change_year/1 returns a year changeset" do
      year = year_fixture()
      assert %Ecto.Changeset{} = MoneyManagement.change_year(year)
    end
  end

  describe "expenses" do
    alias BreadTracer.MoneyManagement.Expense

    @valid_attrs %{active: true, amount: 42, frequency: "some frequency", name: "some name"}
    @update_attrs %{active: false, amount: 43, frequency: "some updated frequency", name: "some updated name"}
    @invalid_attrs %{active: nil, amount: nil, frequency: nil, name: nil}

    def expense_fixture(attrs \\ %{}) do
      {:ok, expense} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MoneyManagement.create_expense()

      expense
    end

    test "list_expenses/0 returns all expenses" do
      expense = expense_fixture()
      assert MoneyManagement.list_expenses() == [expense]
    end

    test "get_expense!/1 returns the expense with given id" do
      expense = expense_fixture()
      assert MoneyManagement.get_expense!(expense.id) == expense
    end

    test "create_expense/1 with valid data creates a expense" do
      assert {:ok, %Expense{} = expense} = MoneyManagement.create_expense(@valid_attrs)
      assert expense.active == true
      assert expense.amount == 42
      assert expense.frequency == "some frequency"
      assert expense.name == "some name"
    end

    test "create_expense/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MoneyManagement.create_expense(@invalid_attrs)
    end

    test "update_expense/2 with valid data updates the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{} = expense} = MoneyManagement.update_expense(expense, @update_attrs)
      assert expense.active == false
      assert expense.amount == 43
      assert expense.frequency == "some updated frequency"
      assert expense.name == "some updated name"
    end

    test "update_expense/2 with invalid data returns error changeset" do
      expense = expense_fixture()
      assert {:error, %Ecto.Changeset{}} = MoneyManagement.update_expense(expense, @invalid_attrs)
      assert expense == MoneyManagement.get_expense!(expense.id)
    end

    test "delete_expense/1 deletes the expense" do
      expense = expense_fixture()
      assert {:ok, %Expense{}} = MoneyManagement.delete_expense(expense)
      assert_raise Ecto.NoResultsError, fn -> MoneyManagement.get_expense!(expense.id) end
    end

    test "change_expense/1 returns a expense changeset" do
      expense = expense_fixture()
      assert %Ecto.Changeset{} = MoneyManagement.change_expense(expense)
    end
  end
end
