defmodule Cards do

  #creo la cocumentazione
  @moduledoc """
  Documentation for `Cards`.
  Provides methods for creating and   handling a deck of cards.

  Fornisce metodi per creare e gestire un mazzo di carte.
  """




  @doc """
  Creates a new deck of cards with the specified number of suits (default is 4) and ranks (default is 13).
  """
  def create_deck do

    values = ["Ace", "Two", "Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King"];

    suits = ["Spades","Clubs","Hearts","Diamonds"]

      #in questo modo abbiamo una lista di liste
      for suit <- suits, value <- values do
        "#{value} of #{suit}"
      end

  end

  # il metodo di Enum.shuffle mischia i valori

  @doc """
  Shuffles the deck of cards using the Fisher-Yates algorithm.

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  #questo contains? sta per sapere se c'è una determinata carta nel mazzo

  @doc """
  Checks if a card exists in the deck. Returns true or false.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
      Enum.member?(deck, card)
  end

  #Usando la proprietà di Enum.split possiamo creare due liste separate
  #la prima con le carte che voglio rimuovere e la seconda con quelle che non lo sono

  @doc """
    Divides a deck into hand and the remainder of the deck.
    The 'hand_size' argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  #chiamo la libreria di erlang per salvare il deck
  #:erlang è un oggetto con cui costruiremo numerori methods

  @doc """
  Saves the deck to disk as an Erlang term file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    #dopo averlo passato per un oggetto ("binary") lo convertiamo effettivamente in binario e passiamo il deck come argomento da salvare, possiamo finalmente salvare il file chiamando File.write()
    File.write(filename, binary)
  end

  #Questo è il giusto modo di salvare, però creeremo un altro metodo con un eccezione
  #def load(filename) do
  #  {_status, binary} = File.read(filename)
  #  :erlang.binary_to_term binary
  #end
  #def load(filename) do
  #  {status , binary} = File.read (filename)
  #  #do un istruzione case (mix di istruzione e pattern) per gestire un eccezzione
  #  case status do
  #    :ok ->
  #       :erlang.binary_to_term binary
  #    :error ->
  #      "That file does not exist"
  #  end
  #end
  #Possiamo fare la stessa cosa in modo diverso e con due operazioni separate

  @doc """
  Loads a saved deck from disk. If the file doesn’t exist it returns nil.
  """
  def load(filename) do
     case File.read(filename) do
       {:ok, binary} -> :erlang.binary_to_term binary
       {:error, _reason} -> "That file does not exist"
     end
  end

  #Cosi è come vengono chiamati tutte le funzioni         senza Pipe Operetor
  #def create_hand(hand_size) do
   # deck = Cards.create_deck
    #deck = Cards.shuffle(deck)                      passando la variabile deck nei metodi
    #_hand = Cards.deal(deck, hand_size)
  #end

  #Con il Pipe Operator non bisogna più eseguire nessun assengnazione temporanea alla variabile del deck. Il risultato di ciascun metodo viene passato al metodo successivo a catena

  @doc """
  Creates and shuffles a new deck of cards.
  """
  def create_hand(hand_size) do
    Cards.create_deck       #Elixir prenderà il mazzo creato e lo passerò a shufle
    |> Cards.shuffle        # creerà un nuovo mazzo e lo passerà a deal
    |> Cards.deal(hand_size)# prenderà il risultato di ritorno e lo passerò come primo elemnto o primo argomento
  end






end
