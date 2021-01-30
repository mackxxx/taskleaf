class Task < ApplicationRecord
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransacklable_associations(auth_object = nil)
    []    
  end
  
  before_validation :set_nameless_name
  validates :name, presence: true, length: {maximum: 30}
  validate :validate_name_not_including_commma

  belongs_to :user
  scope :recent, -> {order(created_at: :desc)}

  private
  
  def set_nameless_name
    self.name = '名前なし' if name.blank?
  end
  
  def validate_name_not_including_commma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
