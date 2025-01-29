namespace :db do
  namespace :seed do
    desc 'Reverse database to seeder'
    task reverse: :environment do
      def format_date(date)
        "Date.parse('#{date.strftime('%Y-%m-%d')}')"
      end

      # Helper method to format Time objects as Ruby code
      def format_time(time)
        "Time.parse('#{time.strftime('%Y-%m-%d %H:%M:%S')}', '#{time.zone}')"
      end

      # Helper method to format DateTime objects as Ruby code
      def format_datetime(datetime)
        "DateTime.parse('#{datetime.strftime('%Y-%m-%d %H:%M:%S')}', '#{datetime.zone}')"
      end
      def reverse_seed_model(model_name)
        model = model_name.constantize
        records = model.last(10) # Get the last 10 records, adjust as needed

        records.each do |record|
          record_attributes = record.attributes.except('id')

          # Format various data types as Ruby code
          record_attributes.transform_values! do |value|
            case value
            when Date
              format_date(value)
            when Time
              format_time(value)
            when DateTime
              format_datetime(value)
            else
              value
            end
          end

          puts "#{model_name}.create!(#{record_attributes.except('id').to_h})"
        end
      rescue StandardError => e
        puts e.message
      end

      model_name = ENV['model']
      reverse_seed_model(model_name) if model_name.present?
    end
  end
end
