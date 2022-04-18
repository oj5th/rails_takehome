module Noteable
  extend ActiveSupport::Concern

  included do
    has_many :notes, as: :noteable, dependent: :destroy
  end

  def has_simple_notes?
    notes.not_reminders_or_todos.any?
  end

  def has_to_do_notes?
    notes.to_dos.any?
  end

  def has_reminder_notes?
    notes.reminders.any?
  end
end
