class RangeValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    range = options[:min]..options[:max]
    return if value.blank? || range.cover?(value)

    record.errors.add(attribute, :invalid)
  end
end
