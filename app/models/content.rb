class Content < ApplicationRecord
  validates :body, presence: true

  has_one :kernel_command
  has_one_attached :audio

  belongs_to :category

  def run_kernel_command
    system(kernel_command.body)
  end

  def self.sanitize(content)
    sanitised_content = content.gsub("\n", "")
      content.gsub(";", ",")
      .gsub(/£(\d+)trn/, '\1 trillion pounds')
      .gsub(/$(\d+)trn/, '\1 trillion dollars')
      .gsub(/€(\d+)trn/, '\1 trillion euros')
      .gsub(/\£(\d+)bn/, '\1 billion pounds')
      .gsub(/\$(\d+)bn/, '\1 billion dollars')
      .gsub(/\€(\d+)bn/, '\1 billion euros')
      .gsub(/£(\d+)m/, '\1 million pounds')
      .gsub(/\$(\d+)m/, '\1 million dollars')
      .gsub(/€(\d+)m/, '\1 million euros')
      .gsub(/(\d+)m/, '\1 million')
      .gsub(/(\d+)pm/, '\1PM')
      .gsub(/(\d+)am/, '\1AM')
      .gsub(/(\d+)p/, '\1 pee')

    sanitised_content.strip
  end
end
