# frozen_string_literal: true

# AdminUtils
module AdminUtils
  class << self
    # Generates the URL for the user's avatar using the user's name.
    #
    # Parameters:
    #   - user: The user object containing the user's name.
    #
    # Returns:
    #   - The URL of the user's avatar.
    def avatar_for(user)
      bg = bg_color(user.username + user.email)
      fg = contrast_color(bg)
      "https://ui-avatars.com/api/?name=#{CGI.escape(user.username)}&background=#{bg}&color=#{fg}" #&background=random"
    end

    def avatar_from(name, email = '')
      bg = bg_color(name + email)
      fg = contrast_color(bg)
      "https://ui-avatars.com/api/?name=#{CGI.escape(name)}&background=#{bg}&color=#{fg}"
    end

    def filter_recursive(data)
      case data
      when Array
        data.map { |item| filter_recursive(item) }
      when Hash
        data.each do |key, value|
          data[key] = key_filtered?(key) ? '[FILTERED]' : filter_recursive(value)
        end
      else
        data
      end
    end

    private

    # Generates a background color based on the given text.
    #
    # Parameters:
    # - `text`: The text to generate the background color from.
    #
    # Returns:
    # The generated background color as a string.
    def bg_color(text)
      Digest::MD5.hexdigest(text.to_s)[0...6]&.ljust(6, '0')
    end

    # Calculates the contrast color of a given hex color.
    #
    # Parameters:
    # - hex_color (str): The hex color code to calculate the contrast color for.
    #
    # Returns:
    # - str: The contrast color as a hex color code.
    def contrast_color(hex_color)
      r, g, b = hex_color.scan(/../).map(&:hex)
      (0.299 * r + 0.587 * g + 0.114 * b) >= 128 ? '000000' : 'FFFFFF'
    end

    def key_filtered?(key)
      filter_keys = Rails.configuration.filter_parameters
      filter_keys.any? do |filter_key|
        case key
        when Symbol, String
          key.to_s.include?(filter_key.to_s)
        else
          false
        end
      end
    end
  end
end
