defmodule Words.WordOfTheDayTest do
  use ExUnit.Case

  test "get word of the day" do
    {status, resp} = Words.WordOfTheDay.get_word_of_the_day()

    assert status == :ok
    assert Map.has_key?(resp, "_id") == true
    assert Map.has_key?(resp, "word") == true
  end

  test "get word of the day with parameters" do
    {status, resp} = Words.WordOfTheDay.get_word_of_the_day(date: "2022-08-22")

    assert status == :ok
    assert Map.has_key?(resp, "_id") == true
    assert Map.has_key?(resp, "word") == true
  end

  test "reject word of the day with invalid date format" do
    {status, resp} = Words.WordOfTheDay.get_word_of_the_day(date: "aug 8 2022")

    assert status == :error
    assert resp == "Error: please provide a valid date in 'yyyy-MM-dd' format"
  end

  test "reject word of the day with invalid February date format" do
    {status, resp} = Words.WordOfTheDay.get_word_of_the_day(date: "2022-02-30")

    assert status == :error
    assert resp == "Error: please provide a valid date in 'yyyy-MM-dd' format"
  end

  test "reject word of the day query with invalid params" do
    {status, msg} = Words.WordOfTheDay.get_word_of_the_day([:whoops])

    assert status == :error
    assert msg == "'whoops' not a valid parameter for the 'get_word_of_the_day' function"
  end
end
