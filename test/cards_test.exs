defmodule CardsTest do
  use ExUnit.Case
  doctest Cards



  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it with assert" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end

  test "shuffling a dek randomizes it with refute" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end



end
