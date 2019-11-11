require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid." do
    visit new_url
    fill_in "word", with: "aaaa"
    click_on "submit"
    assert_text "The word can’t be built out of the original grid"
  end

  # test "You can fill the form with a one-letter consonant word, click play, and get a message it’s not a valid English word" do
  #   visit new_url
  #   fill_in "word", with: "s"
  #   click_on "submit"
  #   assert_text "The word is valid according to the grid, but is not a valid English word"
  # end


  # test "You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a Congratulations message" do
  #   visit "http://localhost:3000/score?word=next&list=%5B%22b%22%2C+%22r%22%2C+%22k%22%2C+%22n%22%2C+%22x%22%2C+%22e%22%2C+%22a%22%2C+%22t%22%2C+%22p%22%2C+%22z%22%5D&submit=Submit"
  #   assert_text "The word is valid according to the grid and is an English word"
  # end
  test "You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a Congratulations message" do
    post score_path, params: {"authenticity_token"=> form_authenticity_token, "word"=>"my", "list"=>"[\"m\", \"v\", \"u\", \"m\", \"a\", \"a\", \"y\", \"l\", \"h\", \"o\"]"}
    assert_text "The word is valid according to the grid and is an English word"
  end
end
