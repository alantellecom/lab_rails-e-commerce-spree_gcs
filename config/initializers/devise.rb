Devise.setup do |config|
    # Required so users don't lose their carts when they need to confirm.
    
    config.secret_key = Rails.application.credentials.devise_key
  
    # Fixes the bug where Confirmation errors result in a broken page.
   
  
    # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
  end