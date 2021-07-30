class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.inheritance_column = "rails_type"

  class << self
    # Maps a pg enum column as rails enum
    def native_enum(attribute, **options)
      ActiveRecord::Base.transaction(requires_new: true) do
        column = column_for_attribute(attribute)
        query = "SELECT enum_range(NULL::#{column.sql_type})"
        values = PG::TextDecoder::Array.new.decode(connection.execute(query).values[0][0])

        enum attribute.to_sym => Hash[values.zip(values)], **options
      end
    rescue ActiveRecord::StatementInvalid => e
      raise if defined? Rails::Server

      logger.warn "native_enum: Cannot load #{attribute} from #{table_name}\n#{e.message}\n"
    end
  end
end
