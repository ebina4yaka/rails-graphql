class AuthorValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :unactivated) unless record.author.activated
  end
end
