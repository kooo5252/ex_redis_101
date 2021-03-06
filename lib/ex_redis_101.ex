defmodule ExRedis101 do
 
 
#-------------------------------------------------


  def set(conn, key, val) do

    Redix.command(conn, ["SET", key, val])

  end


#-------------------------------------------------


  def get(conn, key) do

      case Redix.command(conn, ["GET", key]) do

        {:ok, val} -> val

      end
  end


#-------------------------------------------------


  defmodule AddWorker do

    def perform(key, val1, val2) do

      case Redix.start_link() do

        {:ok, conn} -> Redix.command(conn, ["SET", key, val1 + val2])
        
      end
    end
  end


#-------------------------------------------------


  defmodule User do

    def next_user_id(conn) do  

      case Redix.command(conn, ["INCR", "index"]) do

        {:ok, id} -> id

      end
    end


#-------------------------------------------------


    def get_username_by_user_id(conn, number) do

      case Redix.command(conn, ["HGET", "user:" <> Kernel.inspect(number), "username"]) do

        {:ok, name} -> name

      end
    end
  end


#-------------------------------------------------


  defmodule Ranking do

    def get_ranking(conn) do
      
      case Redix.command(conn, ["ZREVRANGE", "ranking", 0, -1]) do

        {:ok, rank} -> rank

      end
    end
  end


#-------------------------------------------------

end
