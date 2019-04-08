class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  @@cart << @@items 

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    
    if @@cart.empty?
      resp.write "Your cart is empty"
    else 
      @@cart.select {|items| resp.write "#{items}\n"}
    end

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
      resp.write "added Figs"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
