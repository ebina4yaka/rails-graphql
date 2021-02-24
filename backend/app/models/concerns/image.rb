module Image
  extend ActiveSupport::Concern

  def attach_from_base64(image_base64, attach_object)
    if image_base64.present?
      content_type = create_extension(image_base64)
      contents = image_base64.sub %r/data:((image|application)\/.{3,}),/, ''
      decoded_data = Base64.decode64(contents)
      filename = get_filename(content_type)
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
        f.write(decoded_data)
      end
      attach_image(filename, attach_object)
    end
  end

  private

  def get_filename(content_type)
    "#{Time.zone.now.to_s}.#{content_type}"
  end

  def create_extension(image_base64)
    content_type = rex_image(image_base64)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image_base64)
    image_base64[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  def attach_image(filename, attach_object)
    attach_object.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
