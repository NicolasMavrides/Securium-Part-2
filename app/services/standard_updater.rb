# standard_updater
StandardUpdater = Struct.new(:listener) do
  def update(record, params)
    record.assign_attributes params
    if record.save
      listener.success(record)
    else
      listener.failure(record)
    end
  end
end
