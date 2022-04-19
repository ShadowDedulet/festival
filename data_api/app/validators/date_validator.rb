class DateValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :date_start, "Start of festival must be later than now" if record.date_start < DateTime.now
    record.errors.add :date_end, "End of festival must be later than date start" if record.date_start > record.date_end
  end
end
