json.extract! order, :id, :status, :cust_name, :cust_email, :mailing_address, :cc_name, :cc_digit, :cc_expiration, :cc_cvv, :cc_zip, :created_at, :updated_at
json.url order_url(order, format: :json)
