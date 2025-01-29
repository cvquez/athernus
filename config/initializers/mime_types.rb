# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Marcel::MimeType.extend('image/heif', extensions: %w[avif])
