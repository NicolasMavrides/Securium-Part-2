# standard_destroyer
StandardDestroyer = Struct.new(:listener) do
  def destroy(record)
    if record.destroy
      listener.success(record)
    else
      listener.failure(record)
    end
  end
end
