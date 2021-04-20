defmodule MailerWeb.DefaultController do

  use MailerWeb, :controller

  def index(conn, _params) do
    text conn, "Test"
  end


end
