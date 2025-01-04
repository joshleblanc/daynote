def register_model
  models = ActiveRecord::Base.connection.execute(
    <<~SQL
      SELECT * FROM temp.lembed_models;
    SQL
  )
  unless models.any?
    ActiveRecord::Base.connection.execute(
      <<~SQL
        INSERT INTO temp.lembed_models(name, model) 
        select 'all-MiniLM-L6-v2A', lembed_model_from_file('all-MiniLM-L6-v2.e4ce9877.q8_0.gguf');
      SQL
    )
  end
rescue
  nil
end

Rails.application.config.after_initialize do
  register_model # the first time the app loads, we have to register is _after_ initialization
end

Rails.application.config.to_prepare do
  register_model # however we lose it every time the dev reloader runs, so register it again
end
