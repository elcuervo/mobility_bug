class Comment < ApplicationRecord
  extend Mobility

  belongs_to :post

  translates :text, type: :string

  default_scope { i18n }
end
