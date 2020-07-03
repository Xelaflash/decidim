# frozen_string_literal: true

module Decidim
  module Debates
    # This class holds a Form to close debates from Decidim's public views.
    class CloseDebateForm < Decidim::Form
      mimic :debate

      attribute :conclusions, String
      attribute :debate, Debate

      validates :debate, presence: true
      validates :conclusions, presence: true, length: { minimum: 10, maximum: 10_000 }
      validate :user_can_close_debate

      def closed_at
        Time.current
      end

      private

      def user_can_close_debate
        errors.add(:debate, :invalid) unless debate.closeable_by?(current_user)
      end
    end
  end
end
