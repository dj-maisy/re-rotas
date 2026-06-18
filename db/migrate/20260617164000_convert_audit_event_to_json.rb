class ConvertAuditEventToJson < ActiveRecord::Migration[7.2]
  def up
    # Read existing data while column is still text
    # The data is currently YAML-serialized by Rails 6.1's serialize :event, Hash
    AuditEvent.find_each do |record|
      # Read raw text to avoid Rails trying to deserialize it
      raw_event = connection.execute(
        "SELECT event FROM audit_events WHERE id = #{record.id}"
      ).first["event"]

      next if raw_event.nil? || raw_event.empty?

      # Deserialise from YAML (old format)
      event_hash = YAML.load(raw_event)

      # Serialise as JSON (new format)
      json_event = JSON.generate(event_hash)

      # Write back as JSON
      connection.execute(
        "UPDATE audit_events SET event = '#{json_event.gsub("'", "''")}' WHERE id = #{record.id}"
      )
    end

    # Now change the column type
    change_column :audit_events, :event, :json
  end

  def down
    change_column :audit_events, :event, :text
  end
end
