# frozen_string_literal: true

class Ad < ApplicationRecord
  validates :title, :description, :city, :user_id, presence: true
end
