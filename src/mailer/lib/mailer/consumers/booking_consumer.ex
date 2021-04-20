defmodule Mailer.Consumers.BookingConsumer do
  use KafkaEx.GenConsumer

  alias KafkaEx.Protocol.Fetch.Message

  require Logger

  # note - messages are delivered in batches
  def handle_message_set(message_set, state) do

    Logger.info(fn -> "received new batch of messages" end)

    for %Message{value: message} <- message_set do

      Logger.info(fn -> "processing message" end)

      with {:ok, payload} <- Jason.decode(message),
            {:ok, body} <- Jason.decode(payload["body"]) do

           Logger.info(fn -> "booking: " <> inspect(payload) end)
           Logger.info(fn -> "booking id: " <> body["id"] end)
           Logger.info(fn -> "booking state: " <> body["state"] end)

      else {:error, err} ->

        Logger.error(fn -> "error parsing" end)

      end

      # Logger.debug(fn -> "message: " <> inspect(message) end)
    end
    {:async_commit, state}
  end
end
